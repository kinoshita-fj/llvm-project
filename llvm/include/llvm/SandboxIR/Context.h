//===- Context.h ------------------------------------------------*- C++ -*-===//
//
// Part of the LLVM Project, under the Apache License v2.0 with LLVM Exceptions.
// See https://llvm.org/LICENSE.txt for license information.
// SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
//
//===----------------------------------------------------------------------===//

#ifndef LLVM_SANDBOXIR_CONTEXT_H
#define LLVM_SANDBOXIR_CONTEXT_H

#include "llvm/ADT/DenseMap.h"
#include "llvm/ADT/MapVector.h"
#include "llvm/ADT/SmallVector.h"
#include "llvm/IR/LLVMContext.h"
#include "llvm/SandboxIR/Tracker.h"
#include "llvm/SandboxIR/Type.h"

#include <cstdint>

namespace llvm {
namespace sandboxir {

class Argument;
class BBIterator;
class Constant;
class Module;
class Region;
class Value;
class Use;

class Context {
public:
  // A EraseInstrCallback receives the instruction about to be erased.
  using EraseInstrCallback = std::function<void(Instruction *)>;
  // A CreateInstrCallback receives the instruction about to be created.
  using CreateInstrCallback = std::function<void(Instruction *)>;
  // A MoveInstrCallback receives the instruction about to be moved, the
  // destination BB and an iterator pointing to the insertion position.
  using MoveInstrCallback =
      std::function<void(Instruction *, const BBIterator &)>;
  // A SetUseCallback receives the Use that is about to get its source set.
  using SetUseCallback = std::function<void(const Use &, Value *)>;

  /// An ID for a registered callback. Used for deregistration. A dedicated type
  /// is employed so as to keep IDs opaque to the end user; only Context should
  /// deal with its underlying representation.
  class CallbackID {
  public:
    // Uses a 64-bit integer so we don't have to worry about the unlikely case
    // of overflowing a 32-bit counter.
    using ValTy = uint64_t;
    static constexpr const ValTy InvalidVal = 0;

  private:
    // Default initialization results in an invalid ID.
    ValTy Val = InvalidVal;
    explicit CallbackID(ValTy Val) : Val{Val} {
      assert(Val != InvalidVal && "newly-created ID is invalid!");
    }

  public:
    CallbackID() = default;
    friend class Context;
    friend struct DenseMapInfo<CallbackID>;
  };

protected:
  LLVMContext &LLVMCtx;
  friend class Type;              // For LLVMCtx.
  friend class PointerType;       // For LLVMCtx.
  friend class IntegerType;       // For LLVMCtx.
  friend class StructType;        // For LLVMCtx.
  friend class Region;            // For LLVMCtx.
  friend class IRSnapshotChecker; // To snapshot LLVMModuleToModuleMap.

  Tracker IRTracker;

  /// Maps LLVM Value to the corresponding sandboxir::Value. Owns all
  /// SandboxIR objects.
  DenseMap<llvm::Value *, std::unique_ptr<Value>> LLVMValueToValueMap;

  /// Maps an LLVM Module to the corresponding sandboxir::Module.
  DenseMap<llvm::Module *, std::unique_ptr<Module>> LLVMModuleToModuleMap;

  /// Type has a protected destructor to prohibit the user from managing the
  /// lifetime of the Type objects. Context is friend of Type, and this custom
  /// deleter can destroy Type.
  struct TypeDeleter {
    void operator()(Type *Ty) { delete Ty; }
  };
  /// Maps LLVM Type to the corresonding sandboxir::Type. Owns all Sandbox IR
  /// Type objects.
  DenseMap<llvm::Type *, std::unique_ptr<Type, TypeDeleter>> LLVMTypeToTypeMap;

  /// Callbacks called when an IR instruction is about to get erased. Keys are
  /// used as IDs for deregistration.
  MapVector<CallbackID, EraseInstrCallback> EraseInstrCallbacks;
  /// Callbacks called when an IR instruction is about to get created. Keys are
  /// used as IDs for deregistration.
  MapVector<CallbackID, CreateInstrCallback> CreateInstrCallbacks;
  /// Callbacks called when an IR instruction is about to get moved. Keys are
  /// used as IDs for deregistration.
  MapVector<CallbackID, MoveInstrCallback> MoveInstrCallbacks;
  /// Callbacks called when a Use gets its source set. Keys are used as IDs for
  /// deregistration.
  MapVector<CallbackID, SetUseCallback> SetUseCallbacks;

  /// A counter used for assigning callback IDs during registration. The same
  /// counter is used for all kinds of callbacks so we can detect mismatched
  /// registration/deregistration.
  CallbackID::ValTy NextCallbackID = 1;

  /// Remove \p V from the maps and returns the unique_ptr.
  std::unique_ptr<Value> detachLLVMValue(llvm::Value *V);
  /// Remove \p SBV from all SandboxIR maps and stop owning it. This effectively
  /// detaches \p V from the underlying IR.
  std::unique_ptr<Value> detach(Value *V);
  friend class Instruction; // For detach().
  /// Take ownership of VPtr and store it in `LLVMValueToValueMap`.
  Value *registerValue(std::unique_ptr<Value> &&VPtr);
  friend class EraseFromParent; // For registerValue().
  /// This is the actual function that creates sandboxir values for \p V,
  /// and among others handles all instruction types.
  Value *getOrCreateValueInternal(llvm::Value *V, llvm::User *U = nullptr);
  /// Get or create a sandboxir::Argument for an existing LLVM IR \p LLVMArg.
  Argument *getOrCreateArgument(llvm::Argument *LLVMArg);
  /// Get or create a sandboxir::Value for an existing LLVM IR \p LLVMV.
  Value *getOrCreateValue(llvm::Value *LLVMV) {
    return getOrCreateValueInternal(LLVMV, 0);
  }
  /// Get or create a sandboxir::Constant from an existing LLVM IR \p LLVMC.
  Constant *getOrCreateConstant(llvm::Constant *LLVMC);
  friend class ConstantDataSequential; // For getOrCreateConstant().
  friend class Utils; // For getMemoryBase

  void runEraseInstrCallbacks(Instruction *I);
  void runCreateInstrCallbacks(Instruction *I);
  void runMoveInstrCallbacks(Instruction *I, const BBIterator &Where);
  void runSetUseCallbacks(const Use &U, Value *NewSrc);

  friend class User;  // For runSetUseCallbacks().
  friend class Value; // For runSetUseCallbacks().

  // Friends for getOrCreateConstant().
#define DEF_CONST(ID, CLASS) friend class CLASS;
#include "llvm/SandboxIR/Values.def"

  /// Create a sandboxir::BasicBlock for an existing LLVM IR \p BB. This will
  /// also create all contents of the block.
  BasicBlock *createBasicBlock(llvm::BasicBlock *BB);
  friend class BasicBlock; // For getOrCreateValue().

  IRBuilder<ConstantFolder> LLVMIRBuilder;
  auto &getLLVMIRBuilder() { return LLVMIRBuilder; }

  VAArgInst *createVAArgInst(llvm::VAArgInst *SI);
  friend VAArgInst; // For createVAArgInst()
  FreezeInst *createFreezeInst(llvm::FreezeInst *SI);
  friend FreezeInst; // For createFreezeInst()
  FenceInst *createFenceInst(llvm::FenceInst *SI);
  friend FenceInst; // For createFenceInst()
  SelectInst *createSelectInst(llvm::SelectInst *SI);
  friend SelectInst; // For createSelectInst()
  InsertElementInst *createInsertElementInst(llvm::InsertElementInst *IEI);
  friend InsertElementInst; // For createInsertElementInst()
  ExtractElementInst *createExtractElementInst(llvm::ExtractElementInst *EEI);
  friend ExtractElementInst; // For createExtractElementInst()
  ShuffleVectorInst *createShuffleVectorInst(llvm::ShuffleVectorInst *SVI);
  friend ShuffleVectorInst; // For createShuffleVectorInst()
  ExtractValueInst *createExtractValueInst(llvm::ExtractValueInst *IVI);
  friend ExtractValueInst; // For createExtractValueInst()
  InsertValueInst *createInsertValueInst(llvm::InsertValueInst *IVI);
  friend InsertValueInst; // For createInsertValueInst()
  BranchInst *createBranchInst(llvm::BranchInst *I);
  friend BranchInst; // For createBranchInst()
  LoadInst *createLoadInst(llvm::LoadInst *LI);
  friend LoadInst; // For createLoadInst()
  StoreInst *createStoreInst(llvm::StoreInst *SI);
  friend StoreInst; // For createStoreInst()
  ReturnInst *createReturnInst(llvm::ReturnInst *I);
  friend ReturnInst; // For createReturnInst()
  CallInst *createCallInst(llvm::CallInst *I);
  friend CallInst; // For createCallInst()
  InvokeInst *createInvokeInst(llvm::InvokeInst *I);
  friend InvokeInst; // For createInvokeInst()
  CallBrInst *createCallBrInst(llvm::CallBrInst *I);
  friend CallBrInst; // For createCallBrInst()
  LandingPadInst *createLandingPadInst(llvm::LandingPadInst *I);
  friend LandingPadInst; // For createLandingPadInst()
  CatchPadInst *createCatchPadInst(llvm::CatchPadInst *I);
  friend CatchPadInst; // For createCatchPadInst()
  CleanupPadInst *createCleanupPadInst(llvm::CleanupPadInst *I);
  friend CleanupPadInst; // For createCleanupPadInst()
  CatchReturnInst *createCatchReturnInst(llvm::CatchReturnInst *I);
  friend CatchReturnInst; // For createCatchReturnInst()
  CleanupReturnInst *createCleanupReturnInst(llvm::CleanupReturnInst *I);
  friend CleanupReturnInst; // For createCleanupReturnInst()
  GetElementPtrInst *createGetElementPtrInst(llvm::GetElementPtrInst *I);
  friend GetElementPtrInst; // For createGetElementPtrInst()
  CatchSwitchInst *createCatchSwitchInst(llvm::CatchSwitchInst *I);
  friend CatchSwitchInst; // For createCatchSwitchInst()
  ResumeInst *createResumeInst(llvm::ResumeInst *I);
  friend ResumeInst; // For createResumeInst()
  SwitchInst *createSwitchInst(llvm::SwitchInst *I);
  friend SwitchInst; // For createSwitchInst()
  UnaryOperator *createUnaryOperator(llvm::UnaryOperator *I);
  friend UnaryOperator; // For createUnaryOperator()
  BinaryOperator *createBinaryOperator(llvm::BinaryOperator *I);
  friend BinaryOperator; // For createBinaryOperator()
  AtomicRMWInst *createAtomicRMWInst(llvm::AtomicRMWInst *I);
  friend AtomicRMWInst; // For createAtomicRMWInst()
  AtomicCmpXchgInst *createAtomicCmpXchgInst(llvm::AtomicCmpXchgInst *I);
  friend AtomicCmpXchgInst; // For createAtomicCmpXchgInst()
  AllocaInst *createAllocaInst(llvm::AllocaInst *I);
  friend AllocaInst; // For createAllocaInst()
  CastInst *createCastInst(llvm::CastInst *I);
  friend CastInst; // For createCastInst()
  PHINode *createPHINode(llvm::PHINode *I);
  friend PHINode; // For createPHINode()
  UnreachableInst *createUnreachableInst(llvm::UnreachableInst *UI);
  friend UnreachableInst; // For createUnreachableInst()
  CmpInst *createCmpInst(llvm::CmpInst *I);
  friend CmpInst; // For createCmpInst()
  ICmpInst *createICmpInst(llvm::ICmpInst *I);
  friend ICmpInst; // For createICmpInst()
  FCmpInst *createFCmpInst(llvm::FCmpInst *I);
  friend FCmpInst; // For createFCmpInst()

public:
  Context(LLVMContext &LLVMCtx);
  ~Context();
  /// Clears function-level state.
  void clear();

  Tracker &getTracker() { return IRTracker; }
  /// Convenience function for `getTracker().save()`
  void save() { IRTracker.save(); }
  /// Convenience function for `getTracker().revert()`
  void revert() { IRTracker.revert(); }
  /// Convenience function for `getTracker().accept()`
  void accept() { IRTracker.accept(); }

  sandboxir::Value *getValue(llvm::Value *V) const;
  const sandboxir::Value *getValue(const llvm::Value *V) const {
    return getValue(const_cast<llvm::Value *>(V));
  }

  Module *getModule(llvm::Module *LLVMM) const;

  Module *getOrCreateModule(llvm::Module *LLVMM);

  Type *getType(llvm::Type *LLVMTy) {
    if (LLVMTy == nullptr)
      return nullptr;
    auto Pair = LLVMTypeToTypeMap.try_emplace(LLVMTy);
    auto It = Pair.first;
    if (Pair.second)
      It->second = std::unique_ptr<Type, TypeDeleter>(new Type(LLVMTy, *this));
    return It->second.get();
  }

  /// Create a sandboxir::Function for an existing LLVM IR \p F, including all
  /// blocks and instructions.
  /// This is the main API function for creating Sandbox IR.
  /// Note: this will not fully populate its parent module. The only globals
  /// that will be available are those used within the function.
  Function *createFunction(llvm::Function *F);

  /// Create a sandboxir::Module corresponding to \p LLVMM.
  Module *createModule(llvm::Module *LLVMM);

  /// \Returns the number of values registered with Context.
  size_t getNumValues() const { return LLVMValueToValueMap.size(); }

  /// Register a callback that gets called when a SandboxIR instruction is about
  /// to be removed from its parent. Note that this will also be called when
  /// reverting the creation of an instruction.
  /// \Returns a callback ID for later deregistration.
  CallbackID registerEraseInstrCallback(EraseInstrCallback CB);
  void unregisterEraseInstrCallback(CallbackID ID);

  /// Register a callback that gets called right after a SandboxIR instruction
  /// is created. Note that this will also be called when reverting the removal
  /// of an instruction.
  /// \Returns a callback ID for later deregistration.
  CallbackID registerCreateInstrCallback(CreateInstrCallback CB);
  void unregisterCreateInstrCallback(CallbackID ID);

  /// Register a callback that gets called when a SandboxIR instruction is about
  /// to be moved. Note that this will also be called when reverting a move.
  /// \Returns a callback ID for later deregistration.
  CallbackID registerMoveInstrCallback(MoveInstrCallback CB);
  void unregisterMoveInstrCallback(CallbackID ID);

  /// Register a callback that gets called when a Use gets set.
  /// \Returns a callback ID for later deregistration.
  CallbackID registerSetUseCallback(SetUseCallback CB);
  void unregisterSetUseCallback(CallbackID ID);
};

} // namespace sandboxir

// DenseMap info for CallbackIDs
template <> struct DenseMapInfo<sandboxir::Context::CallbackID> {
  using CallbackID = sandboxir::Context::CallbackID;
  using ReprInfo = DenseMapInfo<CallbackID::ValTy>;

  static CallbackID getEmptyKey() {
    return CallbackID{ReprInfo::getEmptyKey()};
  }
  static CallbackID getTombstoneKey() {
    return CallbackID{ReprInfo::getTombstoneKey()};
  }
  static unsigned getHashValue(const CallbackID &ID) {
    return ReprInfo::getHashValue(ID.Val);
  }
  static bool isEqual(const CallbackID &LHS, const CallbackID &RHS) {
    return ReprInfo::isEqual(LHS.Val, RHS.Val);
  }
};

} // namespace llvm

#endif // LLVM_SANDBOXIR_CONTEXT_H
