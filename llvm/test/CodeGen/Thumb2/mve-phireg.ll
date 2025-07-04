; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc -O3 -mtriple=thumbv8.1m.main-none-none-eabi -mattr=+mve.fp --arm-memtransfer-tploop=allow -enable-arm-maskedgatscat=false -verify-machineinstrs %s -o - | FileCheck %s

; verify-machineinstrs previously caught the incorrect use of QPR in the stack reloads.

define arm_aapcs_vfpcc void @k() {
; CHECK-LABEL: k:
; CHECK:       @ %bb.0: @ %entry
; CHECK-NEXT:    .save {r4, r5, r6, lr}
; CHECK-NEXT:    push {r4, r5, r6, lr}
; CHECK-NEXT:    .vsave {d8, d9, d10, d11, d12, d13, d14}
; CHECK-NEXT:    vpush {d8, d9, d10, d11, d12, d13, d14}
; CHECK-NEXT:    .pad #32
; CHECK-NEXT:    sub sp, #32
; CHECK-NEXT:    adr r5, .LCPI0_0
; CHECK-NEXT:    adr r4, .LCPI0_1
; CHECK-NEXT:    vldrw.u32 q5, [r5]
; CHECK-NEXT:    vldrw.u32 q6, [r4]
; CHECK-NEXT:    add r0, sp, #16
; CHECK-NEXT:    vmov.i32 q0, #0x1
; CHECK-NEXT:    vmov.i8 q1, #0x0
; CHECK-NEXT:    vmov.i8 q2, #0xff
; CHECK-NEXT:    vmov.i16 q3, #0x6
; CHECK-NEXT:    vmov.i16 q4, #0x3
; CHECK-NEXT:    movs r1, #0
; CHECK-NEXT:  .LBB0_1: @ %vector.body
; CHECK-NEXT:    @ =>This Inner Loop Header: Depth=1
; CHECK-NEXT:    vand q6, q6, q0
; CHECK-NEXT:    vand q5, q5, q0
; CHECK-NEXT:    vcmp.i32 eq, q6, zr
; CHECK-NEXT:    vpsel q6, q2, q1
; CHECK-NEXT:    vcmp.i32 eq, q5, zr
; CHECK-NEXT:    vpsel q5, q2, q1
; CHECK-NEXT:    vstrh.32 q6, [r0]
; CHECK-NEXT:    vstrh.32 q5, [r0, #8]
; CHECK-NEXT:    vldrw.u32 q5, [r0]
; CHECK-NEXT:    vcmp.i16 ne, q5, zr
; CHECK-NEXT:    vmov.i32 q5, #0x0
; CHECK-NEXT:    vpsel q6, q4, q3
; CHECK-NEXT:    vstrh.16 q6, [r0]
; CHECK-NEXT:    vmov q6, q5
; CHECK-NEXT:    cbz r1, .LBB0_2
; CHECK-NEXT:    le .LBB0_1
; CHECK-NEXT:  .LBB0_2: @ %for.cond4.preheader
; CHECK-NEXT:    movs r6, #0
; CHECK-NEXT:    cbnz r6, .LBB0_5
; CHECK-NEXT:  .LBB0_3: @ %for.body10
; CHECK-NEXT:    @ =>This Inner Loop Header: Depth=1
; CHECK-NEXT:    cbnz r6, .LBB0_4
; CHECK-NEXT:    le .LBB0_3
; CHECK-NEXT:  .LBB0_4: @ %for.cond4.loopexit
; CHECK-NEXT:    bl l
; CHECK-NEXT:  .LBB0_5: @ %vector.body105.preheader
; CHECK-NEXT:    vldrw.u32 q0, [r5]
; CHECK-NEXT:    vldrw.u32 q1, [r4]
; CHECK-NEXT:    movs r0, #8
; CHECK-NEXT:  .LBB0_6: @ %vector.body105
; CHECK-NEXT:    @ =>This Inner Loop Header: Depth=1
; CHECK-NEXT:    vadd.i32 q1, q1, r0
; CHECK-NEXT:    vadd.i32 q0, q0, r0
; CHECK-NEXT:    cbz r6, .LBB0_7
; CHECK-NEXT:    le .LBB0_6
; CHECK-NEXT:  .LBB0_7: @ %vector.body115.ph
; CHECK-NEXT:    vldrw.u32 q0, [r4]
; CHECK-NEXT:    movs r0, #4
; CHECK-NEXT:    vstrw.32 q0, [sp] @ 16-byte Spill
; CHECK-NEXT:    @APP
; CHECK-NEXT:    nop
; CHECK-NEXT:    @NO_APP
; CHECK-NEXT:    vldrw.u32 q0, [sp] @ 16-byte Reload
; CHECK-NEXT:  .LBB0_8: @ %vector.body115
; CHECK-NEXT:    @ =>This Inner Loop Header: Depth=1
; CHECK-NEXT:    vadd.i32 q0, q0, r0
; CHECK-NEXT:    b .LBB0_8
; CHECK-NEXT:    .p2align 4
; CHECK-NEXT:  @ %bb.9:
; CHECK-NEXT:  .LCPI0_0:
; CHECK-NEXT:    .long 4 @ 0x4
; CHECK-NEXT:    .long 5 @ 0x5
; CHECK-NEXT:    .long 6 @ 0x6
; CHECK-NEXT:    .long 7 @ 0x7
; CHECK-NEXT:  .LCPI0_1:
; CHECK-NEXT:    .long 0 @ 0x0
; CHECK-NEXT:    .long 1 @ 0x1
; CHECK-NEXT:    .long 2 @ 0x2
; CHECK-NEXT:    .long 3 @ 0x3
entry:
  br label %vector.body

vector.body:                                      ; preds = %vector.body, %entry
  %vec.ind = phi <8 x i32> [ <i32 0, i32 1, i32 2, i32 3, i32 4, i32 5, i32 6, i32 7>, %entry ], [ zeroinitializer, %vector.body ]
  %0 = and <8 x i32> %vec.ind, <i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1>
  %1 = icmp eq <8 x i32> %0, zeroinitializer
  %2 = select <8 x i1> %1, <8 x i16> <i16 3, i16 3, i16 3, i16 3, i16 3, i16 3, i16 3, i16 3>, <8 x i16> <i16 6, i16 6, i16 6, i16 6, i16 6, i16 6, i16 6, i16 6>
  %3 = bitcast ptr undef to ptr
  store <8 x i16> %2, ptr %3, align 2
  %4 = icmp eq i32 undef, 128
  br i1 %4, label %for.cond4.preheader, label %vector.body

for.cond4.preheader:                              ; preds = %vector.body
  br i1 undef, label %vector.body105, label %for.body10

for.cond4.loopexit:                               ; preds = %for.body10
  %call5 = call arm_aapcs_vfpcc i32 @l()
  br label %vector.body105

for.body10:                                       ; preds = %for.body10, %for.cond4.preheader
  %exitcond88 = icmp eq i32 undef, 7
  br i1 %exitcond88, label %for.cond4.loopexit, label %for.body10

vector.body105:                                   ; preds = %vector.body105, %for.cond4.loopexit, %for.cond4.preheader
  %vec.ind113 = phi <8 x i32> [ %vec.ind.next114, %vector.body105 ], [ <i32 0, i32 1, i32 2, i32 3, i32 4, i32 5, i32 6, i32 7>, %for.cond4.loopexit ], [ <i32 0, i32 1, i32 2, i32 3, i32 4, i32 5, i32 6, i32 7>, %for.cond4.preheader ]
  %5 = and <8 x i32> %vec.ind113, <i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1>
  %vec.ind.next114 = add <8 x i32> %vec.ind113, <i32 8, i32 8, i32 8, i32 8, i32 8, i32 8, i32 8, i32 8>
  %6 = icmp eq i32 undef, 256
  br i1 %6, label %vector.body115.ph, label %vector.body105

vector.body115.ph:                                ; preds = %vector.body105
  tail call void asm sideeffect "nop", "~{s0},~{s4},~{s8},~{s12},~{s16},~{s20},~{s24},~{s28},~{memory}"()
  br label %vector.body115

vector.body115:                                   ; preds = %vector.body115, %vector.body115.ph
  %vec.ind123 = phi <4 x i32> [ %vec.ind.next124, %vector.body115 ], [ <i32 0, i32 1, i32 2, i32 3>, %vector.body115.ph ]
  %7 = icmp eq <4 x i32> %vec.ind123, zeroinitializer
  %vec.ind.next124 = add <4 x i32> %vec.ind123, <i32 4, i32 4, i32 4, i32 4>
  br label %vector.body115
}


@a = external dso_local global i32, align 4
@b = dso_local local_unnamed_addr global i32 ptrtoint (ptr @a to i32), align 4
@c = dso_local global i32 2, align 4
@d = dso_local global i32 2, align 4

define dso_local i32 @e() #0 {
; CHECK-LABEL: e:
; CHECK:       @ %bb.0: @ %entry
; CHECK-NEXT:    .save {r4, r5, r6, r7, r8, r9, r10, lr}
; CHECK-NEXT:    push.w {r4, r5, r6, r7, r8, r9, r10, lr}
; CHECK-NEXT:    .vsave {d8, d9, d10, d11, d12, d13, d14, d15}
; CHECK-NEXT:    vpush {d8, d9, d10, d11, d12, d13, d14, d15}
; CHECK-NEXT:    .pad #408
; CHECK-NEXT:    sub sp, #408
; CHECK-NEXT:    movw r7, :lower16:.L_MergedGlobals
; CHECK-NEXT:    vldr s15, .LCPI1_1
; CHECK-NEXT:    movt r7, :upper16:.L_MergedGlobals
; CHECK-NEXT:    movw r2, :lower16:e
; CHECK-NEXT:    mov r4, r7
; CHECK-NEXT:    mov r3, r7
; CHECK-NEXT:    ldr r6, [r4, #8]!
; CHECK-NEXT:    vmov.i32 q0, #0x0
; CHECK-NEXT:    ldr r0, [r3, #4]!
; CHECK-NEXT:    vstrw.32 q0, [sp] @ 16-byte Spill
; CHECK-NEXT:    movt r2, :upper16:e
; CHECK-NEXT:    vmov r5, s15
; CHECK-NEXT:    vmov q0[2], q0[0], r4, r4
; CHECK-NEXT:    vmov s13, r3
; CHECK-NEXT:    vldr s12, .LCPI1_0
; CHECK-NEXT:    vmov q0[3], q0[1], r5, r2
; CHECK-NEXT:    vdup.32 q7, r3
; CHECK-NEXT:    vmov q6[2], q6[0], r3, r5
; CHECK-NEXT:    vstrw.32 q0, [sp, #92]
; CHECK-NEXT:    vmov q0, q7
; CHECK-NEXT:    vmov q6[3], q6[1], r3, r2
; CHECK-NEXT:    vmov q4, q7
; CHECK-NEXT:    vmov.32 q0[0], r2
; CHECK-NEXT:    vmov.32 q7[1], r2
; CHECK-NEXT:    vmov s21, r2
; CHECK-NEXT:    movs r1, #64
; CHECK-NEXT:    vmov.f32 s20, s12
; CHECK-NEXT:    str r0, [sp, #40]
; CHECK-NEXT:    vmov.f32 s22, s13
; CHECK-NEXT:    str r6, [r0]
; CHECK-NEXT:    vmov.f32 s23, s15
; CHECK-NEXT:    str r0, [r0]
; CHECK-NEXT:    vstrw.32 q5, [r0]
; CHECK-NEXT:    vstrw.32 q7, [r0]
; CHECK-NEXT:    vstrw.32 q0, [r0]
; CHECK-NEXT:    vstrw.32 q6, [r0]
; CHECK-NEXT:    mov.w r8, #0
; CHECK-NEXT:    vmov q1[2], q1[0], r4, r3
; CHECK-NEXT:    vmov q2[2], q2[0], r3, r3
; CHECK-NEXT:    mov.w r12, #4
; CHECK-NEXT:    vmov q1[3], q1[1], r2, r4
; CHECK-NEXT:    vmov.f32 s14, s13
; CHECK-NEXT:    vmov q2[3], q2[1], r4, r5
; CHECK-NEXT:    vmov.32 q4[0], r8
; CHECK-NEXT:    @ implicit-def: $r2
; CHECK-NEXT:    str.w r8, [sp, #44]
; CHECK-NEXT:    vstrw.32 q3, [sp, #60]
; CHECK-NEXT:    strh.w r12, [sp, #406]
; CHECK-NEXT:    wlstp.8 lr, r1, .LBB1_2
; CHECK-NEXT:  .LBB1_1: @ =>This Inner Loop Header: Depth=1
; CHECK-NEXT:    vldrw.u32 q0, [sp] @ 16-byte Reload
; CHECK-NEXT:    vstrb.8 q0, [r2], #16
; CHECK-NEXT:    letp lr, .LBB1_1
; CHECK-NEXT:  .LBB1_2: @ %entry
; CHECK-NEXT:    vstrw.32 q1, [r0]
; CHECK-NEXT:    str.w r8, [r7]
; CHECK-NEXT:    vstrw.32 q4, [r0]
; CHECK-NEXT:    vstrw.32 q2, [r0]
; CHECK-NEXT:    str.w r12, [sp, #324]
; CHECK-NEXT:  .LBB1_3: @ %for.cond
; CHECK-NEXT:    @ =>This Inner Loop Header: Depth=1
; CHECK-NEXT:    b .LBB1_3
; CHECK-NEXT:    .p2align 2
; CHECK-NEXT:  @ %bb.4:
; CHECK-NEXT:  .LCPI1_0:
; CHECK-NEXT:    .long 0x00000004 @ float 5.60519386E-45
; CHECK-NEXT:  .LCPI1_1:
; CHECK-NEXT:    .long 0x00000000 @ float 0
entry:
  %f = alloca i16, align 2
  %g = alloca [3 x [8 x [4 x ptr]]], align 4
  store i16 4, ptr %f, align 2
  %0 = load i32, ptr @c, align 4
  %1 = load i32, ptr @d, align 4
  %arrayinit.element7 = getelementptr inbounds [3 x [8 x [4 x ptr]]], ptr %g, i32 0, i32 0, i32 1, i32 1
  %2 = bitcast ptr %arrayinit.element7 to ptr
  store i32 %0, ptr %2, align 4
  %arrayinit.element8 = getelementptr inbounds [3 x [8 x [4 x ptr]]], ptr %g, i32 0, i32 0, i32 1, i32 2
  store ptr null, ptr %arrayinit.element8, align 4
  %3 = bitcast ptr undef to ptr
  store i32 %1, ptr %3, align 4
  %4 = bitcast ptr undef to ptr
  store i32 %0, ptr %4, align 4
  %arrayinit.element13 = getelementptr inbounds [3 x [8 x [4 x ptr]]], ptr %g, i32 0, i32 0, i32 2, i32 2
  %5 = bitcast ptr %arrayinit.element13 to ptr
  store <4 x ptr> <ptr inttoptr (i32 4 to ptr), ptr @c, ptr @c, ptr null>, ptr %5, align 4
  %arrayinit.element24 = getelementptr inbounds [3 x [8 x [4 x ptr]]], ptr %g, i32 0, i32 0, i32 4, i32 2
  %6 = bitcast ptr %arrayinit.element24 to ptr
  store <4 x ptr> <ptr @d, ptr null, ptr @d, ptr @e>, ptr %6, align 4
  %7 = bitcast ptr undef to ptr
  store <4 x ptr> <ptr inttoptr (i32 4 to ptr), ptr @e, ptr @c, ptr null>, ptr %7, align 4
  %8 = bitcast ptr undef to ptr
  store <4 x ptr> <ptr @c, ptr @e, ptr @c, ptr @c>, ptr %8, align 4
  %9 = bitcast ptr undef to ptr
  store <4 x ptr> <ptr @e, ptr @c, ptr @c, ptr @c>, ptr %9, align 4
  %10 = bitcast ptr undef to ptr
  store <4 x ptr> <ptr @c, ptr @c, ptr null, ptr @e>, ptr %10, align 4
  call void @llvm.memset.p0.i32(ptr nonnull align 4 dereferenceable(64) undef, i8 0, i32 64, i1 false)
  %11 = bitcast ptr undef to ptr
  store <4 x ptr> <ptr @d, ptr @e, ptr @c, ptr @d>, ptr %11, align 4
  %12 = bitcast ptr undef to ptr
  store <4 x ptr> <ptr null, ptr @c, ptr @c, ptr @c>, ptr %12, align 4
  %13 = bitcast ptr undef to ptr
  store <4 x ptr> <ptr @c, ptr @d, ptr @c, ptr null>, ptr %13, align 4
  %arrayinit.begin78 = getelementptr inbounds [3 x [8 x [4 x ptr]]], ptr %g, i32 0, i32 2, i32 3, i32 0
  store ptr inttoptr (i32 4 to ptr), ptr %arrayinit.begin78, align 4
  store i32 0, ptr @b, align 4
  br label %for.cond

for.cond:                                         ; preds = %for.cond, %entry
  br label %for.cond
}

; Function Attrs: argmemonly nounwind willreturn
declare void @llvm.memset.p0.i32(ptr nocapture writeonly, i8, i32, i1 immarg) #1

; Function Attrs: argmemonly nounwind willreturn
declare void @llvm.memset.p0.i64(ptr nocapture writeonly, i8, i64, i1 immarg) #1


declare arm_aapcs_vfpcc i32 @l(...)
