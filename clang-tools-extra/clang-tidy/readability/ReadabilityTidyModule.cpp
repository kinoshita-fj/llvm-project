//===--- ReadabilityTidyModule.cpp - clang-tidy ---------------------------===//
//
// Part of the LLVM Project, under the Apache License v2.0 with LLVM Exceptions.
// See https://llvm.org/LICENSE.txt for license information.
// SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
//
//===----------------------------------------------------------------------===//

#include "../ClangTidy.h"
#include "../ClangTidyModule.h"
#include "../ClangTidyModuleRegistry.h"
#include "AmbiguousSmartptrResetCallCheck.h"
#include "AvoidConstParamsInDecls.h"
#include "AvoidNestedConditionalOperatorCheck.h"
#include "AvoidReturnWithVoidValueCheck.h"
#include "AvoidUnconditionalPreprocessorIfCheck.h"
#include "BracesAroundStatementsCheck.h"
#include "ConstReturnTypeCheck.h"
#include "ContainerContainsCheck.h"
#include "ContainerDataPointerCheck.h"
#include "ContainerSizeEmptyCheck.h"
#include "ConvertMemberFunctionsToStatic.h"
#include "DeleteNullPointerCheck.h"
#include "DuplicateIncludeCheck.h"
#include "ElseAfterReturnCheck.h"
#include "EnumInitialValueCheck.h"
#include "FunctionCognitiveComplexityCheck.h"
#include "FunctionSizeCheck.h"
#include "IdentifierLengthCheck.h"
#include "IdentifierNamingCheck.h"
#include "ImplicitBoolConversionCheck.h"
#include "InconsistentDeclarationParameterNameCheck.h"
#include "IsolateDeclarationCheck.h"
#include "MagicNumbersCheck.h"
#include "MakeMemberFunctionConstCheck.h"
#include "MathMissingParenthesesCheck.h"
#include "MisleadingIndentationCheck.h"
#include "MisplacedArrayIndexCheck.h"
#include "NamedParameterCheck.h"
#include "NonConstParameterCheck.h"
#include "OperatorsRepresentationCheck.h"
#include "QualifiedAutoCheck.h"
#include "RedundantAccessSpecifiersCheck.h"
#include "RedundantCastingCheck.h"
#include "RedundantControlFlowCheck.h"
#include "RedundantDeclarationCheck.h"
#include "RedundantFunctionPtrDereferenceCheck.h"
#include "RedundantInlineSpecifierCheck.h"
#include "RedundantMemberInitCheck.h"
#include "RedundantPreprocessorCheck.h"
#include "RedundantSmartptrGetCheck.h"
#include "RedundantStringCStrCheck.h"
#include "RedundantStringInitCheck.h"
#include "ReferenceToConstructedTemporaryCheck.h"
#include "SimplifyBooleanExprCheck.h"
#include "SimplifySubscriptExprCheck.h"
#include "StaticAccessedThroughInstanceCheck.h"
#include "StaticDefinitionInAnonymousNamespaceCheck.h"
#include "StringCompareCheck.h"
#include "SuspiciousCallArgumentCheck.h"
#include "UniqueptrDeleteReleaseCheck.h"
#include "UppercaseLiteralSuffixCheck.h"
#include "UseAnyOfAllOfCheck.h"
#include "UseConcisePreprocessorDirectivesCheck.h"
#include "UseStdMinMaxCheck.h"

namespace clang::tidy {
namespace readability {

class ReadabilityModule : public ClangTidyModule {
public:
  void addCheckFactories(ClangTidyCheckFactories &CheckFactories) override {
    CheckFactories.registerCheck<AmbiguousSmartptrResetCallCheck>(
        "readability-ambiguous-smartptr-reset-call");
    CheckFactories.registerCheck<AvoidConstParamsInDecls>(
        "readability-avoid-const-params-in-decls");
    CheckFactories.registerCheck<AvoidNestedConditionalOperatorCheck>(
        "readability-avoid-nested-conditional-operator");
    CheckFactories.registerCheck<AvoidReturnWithVoidValueCheck>(
        "readability-avoid-return-with-void-value");
    CheckFactories.registerCheck<AvoidUnconditionalPreprocessorIfCheck>(
        "readability-avoid-unconditional-preprocessor-if");
    CheckFactories.registerCheck<BracesAroundStatementsCheck>(
        "readability-braces-around-statements");
    CheckFactories.registerCheck<ConstReturnTypeCheck>(
        "readability-const-return-type");
    CheckFactories.registerCheck<ContainerContainsCheck>(
        "readability-container-contains");
    CheckFactories.registerCheck<ContainerDataPointerCheck>(
        "readability-container-data-pointer");
    CheckFactories.registerCheck<ContainerSizeEmptyCheck>(
        "readability-container-size-empty");
    CheckFactories.registerCheck<ConvertMemberFunctionsToStatic>(
        "readability-convert-member-functions-to-static");
    CheckFactories.registerCheck<DeleteNullPointerCheck>(
        "readability-delete-null-pointer");
    CheckFactories.registerCheck<DuplicateIncludeCheck>(
        "readability-duplicate-include");
    CheckFactories.registerCheck<ElseAfterReturnCheck>(
        "readability-else-after-return");
    CheckFactories.registerCheck<EnumInitialValueCheck>(
        "readability-enum-initial-value");
    CheckFactories.registerCheck<FunctionCognitiveComplexityCheck>(
        "readability-function-cognitive-complexity");
    CheckFactories.registerCheck<FunctionSizeCheck>(
        "readability-function-size");
    CheckFactories.registerCheck<IdentifierLengthCheck>(
        "readability-identifier-length");
    CheckFactories.registerCheck<IdentifierNamingCheck>(
        "readability-identifier-naming");
    CheckFactories.registerCheck<ImplicitBoolConversionCheck>(
        "readability-implicit-bool-conversion");
    CheckFactories.registerCheck<MathMissingParenthesesCheck>(
        "readability-math-missing-parentheses");
    CheckFactories.registerCheck<RedundantInlineSpecifierCheck>(
        "readability-redundant-inline-specifier");
    CheckFactories.registerCheck<InconsistentDeclarationParameterNameCheck>(
        "readability-inconsistent-declaration-parameter-name");
    CheckFactories.registerCheck<IsolateDeclarationCheck>(
        "readability-isolate-declaration");
    CheckFactories.registerCheck<MagicNumbersCheck>(
        "readability-magic-numbers");
    CheckFactories.registerCheck<MakeMemberFunctionConstCheck>(
        "readability-make-member-function-const");
    CheckFactories.registerCheck<MisleadingIndentationCheck>(
        "readability-misleading-indentation");
    CheckFactories.registerCheck<MisplacedArrayIndexCheck>(
        "readability-misplaced-array-index");
    CheckFactories.registerCheck<OperatorsRepresentationCheck>(
        "readability-operators-representation");
    CheckFactories.registerCheck<QualifiedAutoCheck>(
        "readability-qualified-auto");
    CheckFactories.registerCheck<RedundantAccessSpecifiersCheck>(
        "readability-redundant-access-specifiers");
    CheckFactories.registerCheck<RedundantCastingCheck>(
        "readability-redundant-casting");
    CheckFactories.registerCheck<RedundantFunctionPtrDereferenceCheck>(
        "readability-redundant-function-ptr-dereference");
    CheckFactories.registerCheck<RedundantMemberInitCheck>(
        "readability-redundant-member-init");
    CheckFactories.registerCheck<RedundantPreprocessorCheck>(
        "readability-redundant-preprocessor");
    CheckFactories.registerCheck<ReferenceToConstructedTemporaryCheck>(
        "readability-reference-to-constructed-temporary");
    CheckFactories.registerCheck<SimplifySubscriptExprCheck>(
        "readability-simplify-subscript-expr");
    CheckFactories.registerCheck<StaticAccessedThroughInstanceCheck>(
        "readability-static-accessed-through-instance");
    CheckFactories.registerCheck<StaticDefinitionInAnonymousNamespaceCheck>(
        "readability-static-definition-in-anonymous-namespace");
    CheckFactories.registerCheck<StringCompareCheck>(
        "readability-string-compare");
    CheckFactories.registerCheck<readability::NamedParameterCheck>(
        "readability-named-parameter");
    CheckFactories.registerCheck<NonConstParameterCheck>(
        "readability-non-const-parameter");
    CheckFactories.registerCheck<RedundantControlFlowCheck>(
        "readability-redundant-control-flow");
    CheckFactories.registerCheck<RedundantDeclarationCheck>(
        "readability-redundant-declaration");
    CheckFactories.registerCheck<RedundantSmartptrGetCheck>(
        "readability-redundant-smartptr-get");
    CheckFactories.registerCheck<RedundantStringCStrCheck>(
        "readability-redundant-string-cstr");
    CheckFactories.registerCheck<RedundantStringInitCheck>(
        "readability-redundant-string-init");
    CheckFactories.registerCheck<SimplifyBooleanExprCheck>(
        "readability-simplify-boolean-expr");
    CheckFactories.registerCheck<SuspiciousCallArgumentCheck>(
        "readability-suspicious-call-argument");
    CheckFactories.registerCheck<UniqueptrDeleteReleaseCheck>(
        "readability-uniqueptr-delete-release");
    CheckFactories.registerCheck<UppercaseLiteralSuffixCheck>(
        "readability-uppercase-literal-suffix");
    CheckFactories.registerCheck<UseAnyOfAllOfCheck>(
        "readability-use-anyofallof");
    CheckFactories.registerCheck<UseConcisePreprocessorDirectivesCheck>(
        "readability-use-concise-preprocessor-directives");
    CheckFactories.registerCheck<UseStdMinMaxCheck>(
        "readability-use-std-min-max");
  }
};

// Register the ReadabilityModule using this statically initialized variable.
static ClangTidyModuleRegistry::Add<ReadabilityModule>
    X("readability-module", "Adds readability-related checks.");

} // namespace readability

// This anchor is used to force the linker to link in the generated object file
// and thus register the ReadabilityModule.
// NOLINTNEXTLINE(misc-use-internal-linkage)
volatile int ReadabilityModuleAnchorSource = 0;

} // namespace clang::tidy
