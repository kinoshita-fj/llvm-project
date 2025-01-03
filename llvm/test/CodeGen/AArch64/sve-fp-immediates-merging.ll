; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc < %s | FileCheck %s
; RUN: llc -use-constant-fp-for-scalable-splat < %s | FileCheck %s

target triple = "aarch64-unknown-linux-gnu"

;
; FADD
;

define <vscale x 8 x half> @fadd_h_immhalf(<vscale x 8 x half> %a) #0 {
; CHECK-LABEL: fadd_h_immhalf:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ptrue p0.h
; CHECK-NEXT:    fadd z0.h, p0/m, z0.h, #0.5
; CHECK-NEXT:    ret
  %out = fadd <vscale x 8 x half> %a, splat(half 0.500000e+00)
  ret <vscale x 8 x half> %out
}

define <vscale x 8 x half> @fadd_h_immone(<vscale x 8 x half> %a) #0 {
; CHECK-LABEL: fadd_h_immone:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ptrue p0.h
; CHECK-NEXT:    fadd z0.h, p0/m, z0.h, #1.0
; CHECK-NEXT:    ret
  %out = fadd <vscale x 8 x half> %a, splat(half 1.000000e+00)
  ret <vscale x 8 x half> %out
}

define <vscale x 4 x half> @fadd_4h_immhalf(<vscale x 4 x half> %a) #0 {
; CHECK-LABEL: fadd_4h_immhalf:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ptrue p0.s
; CHECK-NEXT:    fadd z0.h, p0/m, z0.h, #0.5
; CHECK-NEXT:    ret
  %out = fadd <vscale x 4 x half> %a, splat(half 0.500000e+00)
  ret <vscale x 4 x half> %out
}

define <vscale x 4 x half> @fadd_4h_immone(<vscale x 4 x half> %a) #0 {
; CHECK-LABEL: fadd_4h_immone:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ptrue p0.s
; CHECK-NEXT:    fadd z0.h, p0/m, z0.h, #1.0
; CHECK-NEXT:    ret
  %out = fadd <vscale x 4 x half> %a, splat(half 1.000000e+00)
  ret <vscale x 4 x half> %out
}

define <vscale x 2 x half> @fadd_2h_immhalf(<vscale x 2 x half> %a) #0 {
; CHECK-LABEL: fadd_2h_immhalf:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ptrue p0.d
; CHECK-NEXT:    fadd z0.h, p0/m, z0.h, #0.5
; CHECK-NEXT:    ret
  %out = fadd <vscale x 2 x half> %a, splat(half 0.500000e+00)
  ret <vscale x 2 x half> %out
}

define <vscale x 2 x half> @fadd_2h_immone(<vscale x 2 x half> %a) #0 {
; CHECK-LABEL: fadd_2h_immone:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ptrue p0.d
; CHECK-NEXT:    fadd z0.h, p0/m, z0.h, #1.0
; CHECK-NEXT:    ret
  %out = fadd <vscale x 2 x half> %a, splat(half 1.000000e+00)
  ret <vscale x 2 x half> %out
}

define <vscale x 4 x float> @fadd_s_immhalf(<vscale x 4 x float> %a) #0 {
; CHECK-LABEL: fadd_s_immhalf:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ptrue p0.s
; CHECK-NEXT:    fadd z0.s, p0/m, z0.s, #0.5
; CHECK-NEXT:    ret
  %out = fadd <vscale x 4 x float> %a, splat(float 0.500000e+00)
  ret <vscale x 4 x float> %out
}

define <vscale x 4 x float> @fadd_s_immone(<vscale x 4 x float> %a) #0 {
; CHECK-LABEL: fadd_s_immone:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ptrue p0.s
; CHECK-NEXT:    fadd z0.s, p0/m, z0.s, #1.0
; CHECK-NEXT:    ret
  %out = fadd <vscale x 4 x float> %a, splat(float 1.000000e+00)
  ret <vscale x 4 x float> %out
}

define <vscale x 2 x float> @fadd_2s_immhalf(<vscale x 2 x float> %a) #0 {
; CHECK-LABEL: fadd_2s_immhalf:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ptrue p0.d
; CHECK-NEXT:    fadd z0.s, p0/m, z0.s, #0.5
; CHECK-NEXT:    ret
  %out = fadd <vscale x 2 x float> %a, splat(float 0.500000e+00)
  ret <vscale x 2 x float> %out
}

define <vscale x 2 x float> @fadd_2s_immone(<vscale x 2 x float> %a) #0 {
; CHECK-LABEL: fadd_2s_immone:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ptrue p0.d
; CHECK-NEXT:    fadd z0.s, p0/m, z0.s, #1.0
; CHECK-NEXT:    ret
  %out = fadd <vscale x 2 x float> %a, splat(float 1.000000e+00)
  ret <vscale x 2 x float> %out
}


define <vscale x 2 x double> @fadd_d_immhalf(<vscale x 2 x double> %a) #0 {
; CHECK-LABEL: fadd_d_immhalf:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ptrue p0.d
; CHECK-NEXT:    fadd z0.d, p0/m, z0.d, #0.5
; CHECK-NEXT:    ret
  %out = fadd <vscale x 2 x double> %a, splat(double 0.500000e+00)
  ret <vscale x 2 x double> %out
}

define <vscale x 2 x double> @fadd_d_immone(<vscale x 2 x double> %a) #0 {
; CHECK-LABEL: fadd_d_immone:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ptrue p0.d
; CHECK-NEXT:    fadd z0.d, p0/m, z0.d, #1.0
; CHECK-NEXT:    ret
  %out = fadd <vscale x 2 x double> %a, splat(double 1.000000e+00)
  ret <vscale x 2 x double> %out
}

;
; FMAX
;

define <vscale x 8 x half> @fmax_h_immzero(<vscale x 8 x half> %a) #0 {
; CHECK-LABEL: fmax_h_immzero:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ptrue p0.h
; CHECK-NEXT:    fmax z0.h, p0/m, z0.h, #0.0
; CHECK-NEXT:    ret
  %out = call <vscale x 8 x half> @llvm.maximum.nxv8f16(<vscale x 8 x half> %a, <vscale x 8 x half> zeroinitializer)
  ret <vscale x 8 x half> %out
}

define <vscale x 8 x half> @fmax_h_immone(<vscale x 8 x half> %a) #0 {
; CHECK-LABEL: fmax_h_immone:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ptrue p0.h
; CHECK-NEXT:    fmax z0.h, p0/m, z0.h, #1.0
; CHECK-NEXT:    ret
  %out = call <vscale x 8 x half> @llvm.maximum.nxv8f16(<vscale x 8 x half> %a, <vscale x 8 x half> splat(half 1.000000e+00))
  ret <vscale x 8 x half> %out
}

define <vscale x 4 x half> @fmax_4h_immzero(<vscale x 4 x half> %a) #0 {
; CHECK-LABEL: fmax_4h_immzero:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ptrue p0.s
; CHECK-NEXT:    fmax z0.h, p0/m, z0.h, #0.0
; CHECK-NEXT:    ret
  %out = call <vscale x 4 x half> @llvm.maximum.nxv4f16(<vscale x 4 x half> %a, <vscale x 4 x half> zeroinitializer)
  ret <vscale x 4 x half> %out
}

define <vscale x 4 x half> @fmax_4h_immone(<vscale x 4 x half> %a) #0 {
; CHECK-LABEL: fmax_4h_immone:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ptrue p0.s
; CHECK-NEXT:    fmax z0.h, p0/m, z0.h, #1.0
; CHECK-NEXT:    ret
  %out = call <vscale x 4 x half> @llvm.maximum.nxv4f16(<vscale x 4 x half> %a, <vscale x 4 x half> splat(half 1.000000e+00))
  ret <vscale x 4 x half> %out
}

define <vscale x 2 x half> @fmax_2h_immzero(<vscale x 2 x half> %a) #0 {
; CHECK-LABEL: fmax_2h_immzero:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ptrue p0.d
; CHECK-NEXT:    fmax z0.h, p0/m, z0.h, #0.0
; CHECK-NEXT:    ret
  %out = call <vscale x 2 x half> @llvm.maximum.nxv2f16(<vscale x 2 x half> %a, <vscale x 2 x half> zeroinitializer)
  ret <vscale x 2 x half> %out
}

define <vscale x 2 x half> @fmax_2h_immone(<vscale x 2 x half> %a) #0 {
; CHECK-LABEL: fmax_2h_immone:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ptrue p0.d
; CHECK-NEXT:    fmax z0.h, p0/m, z0.h, #1.0
; CHECK-NEXT:    ret
  %out = call <vscale x 2 x half> @llvm.maximum.nxv2f16(<vscale x 2 x half> %a, <vscale x 2 x half> splat(half 1.000000e+00))
  ret <vscale x 2 x half> %out
}

define <vscale x 4 x float> @fmax_s_immzero(<vscale x 4 x float> %a) #0 {
; CHECK-LABEL: fmax_s_immzero:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ptrue p0.s
; CHECK-NEXT:    fmax z0.s, p0/m, z0.s, #0.0
; CHECK-NEXT:    ret
  %out = call <vscale x 4 x float> @llvm.maximum.nxv4f32(<vscale x 4 x float> %a, <vscale x 4 x float> zeroinitializer)
  ret <vscale x 4 x float> %out
}

define <vscale x 4 x float> @fmax_s_immone(<vscale x 4 x float> %a) #0 {
; CHECK-LABEL: fmax_s_immone:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ptrue p0.s
; CHECK-NEXT:    fmax z0.s, p0/m, z0.s, #1.0
; CHECK-NEXT:    ret
  %out = call <vscale x 4 x float> @llvm.maximum.nxv4f32(<vscale x 4 x float> %a, <vscale x 4 x float> splat(float 1.000000e+00))
  ret <vscale x 4 x float> %out
}

define <vscale x 2 x float> @fmax_2s_immzero(<vscale x 2 x float> %a) #0 {
; CHECK-LABEL: fmax_2s_immzero:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ptrue p0.d
; CHECK-NEXT:    fmax z0.s, p0/m, z0.s, #0.0
; CHECK-NEXT:    ret
  %out = call <vscale x 2 x float> @llvm.maximum.nxv2f32(<vscale x 2 x float> %a, <vscale x 2 x float> zeroinitializer)
  ret <vscale x 2 x float> %out
}

define <vscale x 2 x float> @fmax_2s_immone(<vscale x 2 x float> %a) #0 {
; CHECK-LABEL: fmax_2s_immone:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ptrue p0.d
; CHECK-NEXT:    fmax z0.s, p0/m, z0.s, #1.0
; CHECK-NEXT:    ret
  %out = call <vscale x 2 x float> @llvm.maximum.nxv2f32(<vscale x 2 x float> %a, <vscale x 2 x float> splat(float 1.000000e+00))
  ret <vscale x 2 x float> %out
}

define <vscale x 2 x double> @fmax_d_immzero(<vscale x 2 x double> %a) #0 {
; CHECK-LABEL: fmax_d_immzero:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ptrue p0.d
; CHECK-NEXT:    fmax z0.d, p0/m, z0.d, #0.0
; CHECK-NEXT:    ret
  %out = call <vscale x 2 x double> @llvm.maximum.nxv2f64(<vscale x 2 x double> %a, <vscale x 2 x double> zeroinitializer)
  ret <vscale x 2 x double> %out
}

define <vscale x 2 x double> @fmax_d_immone(<vscale x 2 x double> %a) #0 {
; CHECK-LABEL: fmax_d_immone:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ptrue p0.d
; CHECK-NEXT:    fmax z0.d, p0/m, z0.d, #1.0
; CHECK-NEXT:    ret
  %out = call <vscale x 2 x double> @llvm.maximum.nxv2f64(<vscale x 2 x double> %a, <vscale x 2 x double> splat(double 1.000000e+00))
  ret <vscale x 2 x double> %out
}

;
; FMAXNM
;

define <vscale x 8 x half> @fmaxnm_h_immzero(<vscale x 8 x half> %a) #0 {
; CHECK-LABEL: fmaxnm_h_immzero:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ptrue p0.h
; CHECK-NEXT:    fmaxnm z0.h, p0/m, z0.h, #0.0
; CHECK-NEXT:    ret
  %out = call <vscale x 8 x half> @llvm.maxnum.nxv8f16(<vscale x 8 x half> %a, <vscale x 8 x half> zeroinitializer)
  ret <vscale x 8 x half> %out
}

define <vscale x 8 x half> @fmaxnm_h_immone(<vscale x 8 x half> %a) #0 {
; CHECK-LABEL: fmaxnm_h_immone:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ptrue p0.h
; CHECK-NEXT:    fmaxnm z0.h, p0/m, z0.h, #1.0
; CHECK-NEXT:    ret
  %out = call <vscale x 8 x half> @llvm.maxnum.nxv8f16(<vscale x 8 x half> %a, <vscale x 8 x half> splat(half 1.000000e+00))
  ret <vscale x 8 x half> %out
}

define <vscale x 4 x half> @fmaxnm_4h_immzero(<vscale x 4 x half> %a) #0 {
; CHECK-LABEL: fmaxnm_4h_immzero:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ptrue p0.s
; CHECK-NEXT:    fmaxnm z0.h, p0/m, z0.h, #0.0
; CHECK-NEXT:    ret
  %out = call <vscale x 4 x half> @llvm.maxnum.nxv4f16(<vscale x 4 x half> %a, <vscale x 4 x half> zeroinitializer)
  ret <vscale x 4 x half> %out
}

define <vscale x 4 x half> @fmaxnm_4h_immone(<vscale x 4 x half> %a) #0 {
; CHECK-LABEL: fmaxnm_4h_immone:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ptrue p0.s
; CHECK-NEXT:    fmaxnm z0.h, p0/m, z0.h, #1.0
; CHECK-NEXT:    ret
  %out = call <vscale x 4 x half> @llvm.maxnum.nxv4f16(<vscale x 4 x half> %a, <vscale x 4 x half> splat(half 1.000000e+00))
  ret <vscale x 4 x half> %out
}

define <vscale x 2 x half> @fmaxnm_2h_immzero(<vscale x 2 x half> %a) #0 {
; CHECK-LABEL: fmaxnm_2h_immzero:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ptrue p0.d
; CHECK-NEXT:    fmaxnm z0.h, p0/m, z0.h, #0.0
; CHECK-NEXT:    ret
  %out = call <vscale x 2 x half> @llvm.maxnum.nxv2f16(<vscale x 2 x half> %a, <vscale x 2 x half> zeroinitializer)
  ret <vscale x 2 x half> %out
}

define <vscale x 2 x half> @fmaxnm_2h_immone(<vscale x 2 x half> %a) #0 {
; CHECK-LABEL: fmaxnm_2h_immone:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ptrue p0.d
; CHECK-NEXT:    fmaxnm z0.h, p0/m, z0.h, #1.0
; CHECK-NEXT:    ret
  %out = call <vscale x 2 x half> @llvm.maxnum.nxv2f16(<vscale x 2 x half> %a, <vscale x 2 x half> splat(half 1.000000e+00))
  ret <vscale x 2 x half> %out
}

define <vscale x 4 x float> @fmaxnm_s_immzero(<vscale x 4 x float> %a) #0 {
; CHECK-LABEL: fmaxnm_s_immzero:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ptrue p0.s
; CHECK-NEXT:    fmaxnm z0.s, p0/m, z0.s, #0.0
; CHECK-NEXT:    ret
  %out = call <vscale x 4 x float> @llvm.maxnum.nxv4f32(<vscale x 4 x float> %a, <vscale x 4 x float> zeroinitializer)
  ret <vscale x 4 x float> %out
}

define <vscale x 4 x float> @fmaxnm_s_immone(<vscale x 4 x float> %a) #0 {
; CHECK-LABEL: fmaxnm_s_immone:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ptrue p0.s
; CHECK-NEXT:    fmaxnm z0.s, p0/m, z0.s, #1.0
; CHECK-NEXT:    ret
  %out = call <vscale x 4 x float> @llvm.maxnum.nxv4f32(<vscale x 4 x float> %a, <vscale x 4 x float> splat(float 1.000000e+00))
  ret <vscale x 4 x float> %out
}

define <vscale x 2 x float> @fmaxnm_2s_immzero(<vscale x 2 x float> %a) #0 {
; CHECK-LABEL: fmaxnm_2s_immzero:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ptrue p0.d
; CHECK-NEXT:    fmaxnm z0.s, p0/m, z0.s, #0.0
; CHECK-NEXT:    ret
  %out = call <vscale x 2 x float> @llvm.maxnum.nxv2f32(<vscale x 2 x float> %a, <vscale x 2 x float> zeroinitializer)
  ret <vscale x 2 x float> %out
}

define <vscale x 2 x float> @fmaxnm_2s_immone(<vscale x 2 x float> %a) #0 {
; CHECK-LABEL: fmaxnm_2s_immone:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ptrue p0.d
; CHECK-NEXT:    fmaxnm z0.s, p0/m, z0.s, #1.0
; CHECK-NEXT:    ret
  %out = call <vscale x 2 x float> @llvm.maxnum.nxv2f32(<vscale x 2 x float> %a, <vscale x 2 x float> splat(float 1.000000e+00))
  ret <vscale x 2 x float> %out
}

define <vscale x 2 x double> @fmaxnm_d_immzero(<vscale x 2 x double> %a) #0 {
; CHECK-LABEL: fmaxnm_d_immzero:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ptrue p0.d
; CHECK-NEXT:    fmaxnm z0.d, p0/m, z0.d, #0.0
; CHECK-NEXT:    ret
  %out = call <vscale x 2 x double> @llvm.maxnum.nxv2f64(<vscale x 2 x double> %a, <vscale x 2 x double> zeroinitializer)
  ret <vscale x 2 x double> %out
}

define <vscale x 2 x double> @fmaxnm_d_immone(<vscale x 2 x double> %a) #0 {
; CHECK-LABEL: fmaxnm_d_immone:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ptrue p0.d
; CHECK-NEXT:    fmaxnm z0.d, p0/m, z0.d, #1.0
; CHECK-NEXT:    ret
  %out = call <vscale x 2 x double> @llvm.maxnum.nxv2f64(<vscale x 2 x double> %a, <vscale x 2 x double> splat(double 1.000000e+00))
  ret <vscale x 2 x double> %out
}

;
; FMIN
;

define <vscale x 8 x half> @fmin_h_immzero(<vscale x 8 x half> %a) #0 {
; CHECK-LABEL: fmin_h_immzero:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ptrue p0.h
; CHECK-NEXT:    fmin z0.h, p0/m, z0.h, #0.0
; CHECK-NEXT:    ret
  %out = call <vscale x 8 x half> @llvm.minimum.nxv8f16(<vscale x 8 x half> %a, <vscale x 8 x half> zeroinitializer)
  ret <vscale x 8 x half> %out
}

define <vscale x 8 x half> @fmin_h_immone(<vscale x 8 x half> %a) #0 {
; CHECK-LABEL: fmin_h_immone:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ptrue p0.h
; CHECK-NEXT:    fmin z0.h, p0/m, z0.h, #1.0
; CHECK-NEXT:    ret
  %out = call <vscale x 8 x half> @llvm.minimum.nxv8f16(<vscale x 8 x half> %a, <vscale x 8 x half> splat(half 1.000000e+00))
  ret <vscale x 8 x half> %out
}

define <vscale x 4 x half> @fmin_4h_immzero(<vscale x 4 x half> %a) #0 {
; CHECK-LABEL: fmin_4h_immzero:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ptrue p0.s
; CHECK-NEXT:    fmin z0.h, p0/m, z0.h, #0.0
; CHECK-NEXT:    ret
  %out = call <vscale x 4 x half> @llvm.minimum.nxv4f16(<vscale x 4 x half> %a, <vscale x 4 x half> zeroinitializer)
  ret <vscale x 4 x half> %out
}

define <vscale x 4 x half> @fmin_4h_immone(<vscale x 4 x half> %a) #0 {
; CHECK-LABEL: fmin_4h_immone:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ptrue p0.s
; CHECK-NEXT:    fmin z0.h, p0/m, z0.h, #1.0
; CHECK-NEXT:    ret
  %out = call <vscale x 4 x half> @llvm.minimum.nxv4f16(<vscale x 4 x half> %a, <vscale x 4 x half> splat(half 1.000000e+00))
  ret <vscale x 4 x half> %out
}

define <vscale x 2 x half> @fmin_2h_immzero(<vscale x 2 x half> %a) #0 {
; CHECK-LABEL: fmin_2h_immzero:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ptrue p0.d
; CHECK-NEXT:    fmin z0.h, p0/m, z0.h, #0.0
; CHECK-NEXT:    ret
  %out = call <vscale x 2 x half> @llvm.minimum.nxv2f16(<vscale x 2 x half> %a, <vscale x 2 x half> zeroinitializer)
  ret <vscale x 2 x half> %out
}

define <vscale x 2 x half> @fmin_2h_immone(<vscale x 2 x half> %a) #0 {
; CHECK-LABEL: fmin_2h_immone:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ptrue p0.d
; CHECK-NEXT:    fmin z0.h, p0/m, z0.h, #1.0
; CHECK-NEXT:    ret
  %out = call <vscale x 2 x half> @llvm.minimum.nxv2f16(<vscale x 2 x half> %a, <vscale x 2 x half> splat(half 1.000000e+00))
  ret <vscale x 2 x half> %out
}

define <vscale x 4 x float> @fmin_s_immzero(<vscale x 4 x float> %a) #0 {
; CHECK-LABEL: fmin_s_immzero:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ptrue p0.s
; CHECK-NEXT:    fmin z0.s, p0/m, z0.s, #0.0
; CHECK-NEXT:    ret
  %out = call <vscale x 4 x float> @llvm.minimum.nxv4f32(<vscale x 4 x float> %a, <vscale x 4 x float> zeroinitializer)
  ret <vscale x 4 x float> %out
}

define <vscale x 4 x float> @fmin_s_immone(<vscale x 4 x float> %a) #0 {
; CHECK-LABEL: fmin_s_immone:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ptrue p0.s
; CHECK-NEXT:    fmin z0.s, p0/m, z0.s, #1.0
; CHECK-NEXT:    ret
  %out = call <vscale x 4 x float> @llvm.minimum.nxv4f32(<vscale x 4 x float> %a, <vscale x 4 x float> splat(float 1.000000e+00))
  ret <vscale x 4 x float> %out
}

define <vscale x 2 x float> @fmin_2s_immzero(<vscale x 2 x float> %a) #0 {
; CHECK-LABEL: fmin_2s_immzero:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ptrue p0.d
; CHECK-NEXT:    fmin z0.s, p0/m, z0.s, #0.0
; CHECK-NEXT:    ret
  %out = call <vscale x 2 x float> @llvm.minimum.nxv2f32(<vscale x 2 x float> %a, <vscale x 2 x float> zeroinitializer)
  ret <vscale x 2 x float> %out
}

define <vscale x 2 x float> @fmin_2s_immone(<vscale x 2 x float> %a) #0 {
; CHECK-LABEL: fmin_2s_immone:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ptrue p0.d
; CHECK-NEXT:    fmin z0.s, p0/m, z0.s, #1.0
; CHECK-NEXT:    ret
  %out = call <vscale x 2 x float> @llvm.minimum.nxv2f32(<vscale x 2 x float> %a, <vscale x 2 x float> splat(float 1.000000e+00))
  ret <vscale x 2 x float> %out
}

define <vscale x 2 x double> @fmin_d_immzero(<vscale x 2 x double> %a) #0 {
; CHECK-LABEL: fmin_d_immzero:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ptrue p0.d
; CHECK-NEXT:    fmin z0.d, p0/m, z0.d, #0.0
; CHECK-NEXT:    ret
  %out = call <vscale x 2 x double> @llvm.minimum.nxv2f64(<vscale x 2 x double> %a, <vscale x 2 x double> zeroinitializer)
  ret <vscale x 2 x double> %out
}

define <vscale x 2 x double> @fmin_d_immone(<vscale x 2 x double> %a) #0 {
; CHECK-LABEL: fmin_d_immone:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ptrue p0.d
; CHECK-NEXT:    fmin z0.d, p0/m, z0.d, #1.0
; CHECK-NEXT:    ret
  %out = call <vscale x 2 x double> @llvm.minimum.nxv2f64(<vscale x 2 x double> %a, <vscale x 2 x double> splat(double 1.000000e+00))
  ret <vscale x 2 x double> %out
}

;
; FMINNM
;

define <vscale x 8 x half> @fminnm_h_immzero(<vscale x 8 x half> %a) #0 {
; CHECK-LABEL: fminnm_h_immzero:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ptrue p0.h
; CHECK-NEXT:    fminnm z0.h, p0/m, z0.h, #0.0
; CHECK-NEXT:    ret
  %out = call <vscale x 8 x half> @llvm.minnum.nxv8f16(<vscale x 8 x half> %a, <vscale x 8 x half> zeroinitializer)
  ret <vscale x 8 x half> %out
}

define <vscale x 8 x half> @fminnm_h_immone(<vscale x 8 x half> %a) #0 {
; CHECK-LABEL: fminnm_h_immone:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ptrue p0.h
; CHECK-NEXT:    fminnm z0.h, p0/m, z0.h, #1.0
; CHECK-NEXT:    ret
  %out = call <vscale x 8 x half> @llvm.minnum.nxv8f16(<vscale x 8 x half> %a, <vscale x 8 x half> splat(half 1.000000e+00))
  ret <vscale x 8 x half> %out
}

define <vscale x 4 x half> @fminnm_4h_immzero(<vscale x 4 x half> %a) #0 {
; CHECK-LABEL: fminnm_4h_immzero:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ptrue p0.s
; CHECK-NEXT:    fminnm z0.h, p0/m, z0.h, #0.0
; CHECK-NEXT:    ret
  %out = call <vscale x 4 x half> @llvm.minnum.nxv4f16(<vscale x 4 x half> %a, <vscale x 4 x half> zeroinitializer)
  ret <vscale x 4 x half> %out
}

define <vscale x 4 x half> @fminnm_4h_immone(<vscale x 4 x half> %a) #0 {
; CHECK-LABEL: fminnm_4h_immone:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ptrue p0.s
; CHECK-NEXT:    fminnm z0.h, p0/m, z0.h, #1.0
; CHECK-NEXT:    ret
  %out = call <vscale x 4 x half> @llvm.minnum.nxv4f16(<vscale x 4 x half> %a, <vscale x 4 x half> splat(half 1.000000e+00))
  ret <vscale x 4 x half> %out
}

define <vscale x 2 x half> @fminnm_2h_immzero(<vscale x 2 x half> %a) #0 {
; CHECK-LABEL: fminnm_2h_immzero:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ptrue p0.d
; CHECK-NEXT:    fminnm z0.h, p0/m, z0.h, #0.0
; CHECK-NEXT:    ret
  %out = call <vscale x 2 x half> @llvm.minnum.nxv2f16(<vscale x 2 x half> %a, <vscale x 2 x half> zeroinitializer)
  ret <vscale x 2 x half> %out
}

define <vscale x 2 x half> @fminnm_2h_immone(<vscale x 2 x half> %a) #0 {
; CHECK-LABEL: fminnm_2h_immone:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ptrue p0.d
; CHECK-NEXT:    fminnm z0.h, p0/m, z0.h, #1.0
; CHECK-NEXT:    ret
  %out = call <vscale x 2 x half> @llvm.minnum.nxv2f16(<vscale x 2 x half> %a, <vscale x 2 x half> splat(half 1.000000e+00))
  ret <vscale x 2 x half> %out
}

define <vscale x 4 x float> @fminnm_s_immzero(<vscale x 4 x float> %a) #0 {
; CHECK-LABEL: fminnm_s_immzero:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ptrue p0.s
; CHECK-NEXT:    fminnm z0.s, p0/m, z0.s, #0.0
; CHECK-NEXT:    ret
  %out = call <vscale x 4 x float> @llvm.minnum.nxv4f32(<vscale x 4 x float> %a, <vscale x 4 x float> zeroinitializer)
  ret <vscale x 4 x float> %out
}

define <vscale x 4 x float> @fminnm_s_immone(<vscale x 4 x float> %a) #0 {
; CHECK-LABEL: fminnm_s_immone:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ptrue p0.s
; CHECK-NEXT:    fminnm z0.s, p0/m, z0.s, #1.0
; CHECK-NEXT:    ret
  %out = call <vscale x 4 x float> @llvm.minnum.nxv4f32(<vscale x 4 x float> %a, <vscale x 4 x float> splat(float 1.000000e+00))
  ret <vscale x 4 x float> %out
}

define <vscale x 2 x float> @fminnm_2s_immzero(<vscale x 2 x float> %a) #0 {
; CHECK-LABEL: fminnm_2s_immzero:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ptrue p0.d
; CHECK-NEXT:    fminnm z0.s, p0/m, z0.s, #0.0
; CHECK-NEXT:    ret
  %out = call <vscale x 2 x float> @llvm.minnum.nxv2f32(<vscale x 2 x float> %a, <vscale x 2 x float> zeroinitializer)
  ret <vscale x 2 x float> %out
}

define <vscale x 2 x float> @fminnm_2s_immone(<vscale x 2 x float> %a) #0 {
; CHECK-LABEL: fminnm_2s_immone:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ptrue p0.d
; CHECK-NEXT:    fminnm z0.s, p0/m, z0.s, #1.0
; CHECK-NEXT:    ret
  %out = call <vscale x 2 x float> @llvm.minnum.nxv2f32(<vscale x 2 x float> %a, <vscale x 2 x float> splat(float 1.000000e+00))
  ret <vscale x 2 x float> %out
}

define <vscale x 2 x double> @fminnm_d_immzero(<vscale x 2 x double> %a) #0 {
; CHECK-LABEL: fminnm_d_immzero:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ptrue p0.d
; CHECK-NEXT:    fminnm z0.d, p0/m, z0.d, #0.0
; CHECK-NEXT:    ret
  %out = call <vscale x 2 x double> @llvm.minnum.nxv2f64(<vscale x 2 x double> %a, <vscale x 2 x double> zeroinitializer)
  ret <vscale x 2 x double> %out
}

define <vscale x 2 x double> @fminnm_d_immone(<vscale x 2 x double> %a) #0 {
; CHECK-LABEL: fminnm_d_immone:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ptrue p0.d
; CHECK-NEXT:    fminnm z0.d, p0/m, z0.d, #1.0
; CHECK-NEXT:    ret
  %out = call <vscale x 2 x double> @llvm.minnum.nxv2f64(<vscale x 2 x double> %a, <vscale x 2 x double> splat(double 1.000000e+00))
  ret <vscale x 2 x double> %out
}

;
; FMUL
;

define <vscale x 8 x half> @fmul_h_immhalf(<vscale x 8 x half> %a) #0 {
; CHECK-LABEL: fmul_h_immhalf:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ptrue p0.h
; CHECK-NEXT:    fmul z0.h, p0/m, z0.h, #0.5
; CHECK-NEXT:    ret
  %out = fmul <vscale x 8 x half> %a, splat(half 0.500000e+00)
  ret <vscale x 8 x half> %out
}

define <vscale x 8 x half> @fmul_h_immtwo(<vscale x 8 x half> %a) #0 {
; CHECK-LABEL: fmul_h_immtwo:
; CHECK:       // %bb.0:
; CHECK-NEXT:    fadd z0.h, z0.h, z0.h
; CHECK-NEXT:    ret
  %out = fmul <vscale x 8 x half> %a, splat(half 2.000000e+00)
  ret <vscale x 8 x half> %out
}

define <vscale x 4 x half> @fmul_4h_immhalf(<vscale x 4 x half> %a) #0 {
; CHECK-LABEL: fmul_4h_immhalf:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ptrue p0.s
; CHECK-NEXT:    fmul z0.h, p0/m, z0.h, #0.5
; CHECK-NEXT:    ret
  %out = fmul <vscale x 4 x half> %a, splat(half 0.500000e+00)
  ret <vscale x 4 x half> %out
}

define <vscale x 4 x half> @fmul_4h_immtwo(<vscale x 4 x half> %a) #0 {
; CHECK-LABEL: fmul_4h_immtwo:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ptrue p0.s
; CHECK-NEXT:    fadd z0.h, p0/m, z0.h, z0.h
; CHECK-NEXT:    ret
  %out = fmul <vscale x 4 x half> %a, splat(half 2.000000e+00)
  ret <vscale x 4 x half> %out
}

define <vscale x 2 x half> @fmul_2h_immhalf(<vscale x 2 x half> %a) #0 {
; CHECK-LABEL: fmul_2h_immhalf:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ptrue p0.d
; CHECK-NEXT:    fmul z0.h, p0/m, z0.h, #0.5
; CHECK-NEXT:    ret
  %out = fmul <vscale x 2 x half> %a, splat(half 0.500000e+00)
  ret <vscale x 2 x half> %out
}

define <vscale x 2 x half> @fmul_2h_immtwo(<vscale x 2 x half> %a) #0 {
; CHECK-LABEL: fmul_2h_immtwo:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ptrue p0.d
; CHECK-NEXT:    fadd z0.h, p0/m, z0.h, z0.h
; CHECK-NEXT:    ret
  %out = fmul <vscale x 2 x half> %a, splat(half 2.000000e+00)
  ret <vscale x 2 x half> %out
}

define <vscale x 4 x float> @fmul_s_immhalf(<vscale x 4 x float> %a) #0 {
; CHECK-LABEL: fmul_s_immhalf:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ptrue p0.s
; CHECK-NEXT:    fmul z0.s, p0/m, z0.s, #0.5
; CHECK-NEXT:    ret
  %out = fmul <vscale x 4 x float> %a, splat(float 0.500000e+00)
  ret <vscale x 4 x float> %out
}

define <vscale x 4 x float> @fmul_s_immtwo(<vscale x 4 x float> %a) #0 {
; CHECK-LABEL: fmul_s_immtwo:
; CHECK:       // %bb.0:
; CHECK-NEXT:    fadd z0.s, z0.s, z0.s
; CHECK-NEXT:    ret
  %out = fmul <vscale x 4 x float> %a, splat(float 2.000000e+00)
  ret <vscale x 4 x float> %out
}

define <vscale x 2 x float> @fmul_2s_immhalf(<vscale x 2 x float> %a) #0 {
; CHECK-LABEL: fmul_2s_immhalf:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ptrue p0.d
; CHECK-NEXT:    fmul z0.s, p0/m, z0.s, #0.5
; CHECK-NEXT:    ret
  %out = fmul <vscale x 2 x float> %a, splat(float 0.500000e+00)
  ret <vscale x 2 x float> %out
}

define <vscale x 2 x float> @fmul_2s_immtwo(<vscale x 2 x float> %a) #0 {
; CHECK-LABEL: fmul_2s_immtwo:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ptrue p0.d
; CHECK-NEXT:    fadd z0.s, p0/m, z0.s, z0.s
; CHECK-NEXT:    ret
  %out = fmul <vscale x 2 x float> %a, splat(float 2.000000e+00)
  ret <vscale x 2 x float> %out
}

define <vscale x 2 x double> @fmul_d_immhalf(<vscale x 2 x double> %a) #0 {
; CHECK-LABEL: fmul_d_immhalf:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ptrue p0.d
; CHECK-NEXT:    fmul z0.d, p0/m, z0.d, #0.5
; CHECK-NEXT:    ret
  %out = fmul <vscale x 2 x double> %a, splat(double 0.500000e+00)
  ret <vscale x 2 x double> %out
}

define <vscale x 2 x double> @fmul_d_immtwo(<vscale x 2 x double> %a) #0 {
; CHECK-LABEL: fmul_d_immtwo:
; CHECK:       // %bb.0:
; CHECK-NEXT:    fadd z0.d, z0.d, z0.d
; CHECK-NEXT:    ret
  %out = fmul <vscale x 2 x double> %a, splat(double 2.000000e+00)
  ret <vscale x 2 x double> %out
}

;
; FSUB
;

define <vscale x 8 x half> @fsub_h_immhalf(<vscale x 8 x half> %a) #0 {
; CHECK-LABEL: fsub_h_immhalf:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ptrue p0.h
; CHECK-NEXT:    fsub z0.h, p0/m, z0.h, #0.5
; CHECK-NEXT:    ret
  %out = fsub <vscale x 8 x half> %a, splat(half 0.500000e+00)
  ret <vscale x 8 x half> %out
}

define <vscale x 8 x half> @fsub_h_immone(<vscale x 8 x half> %a) #0 {
; CHECK-LABEL: fsub_h_immone:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ptrue p0.h
; CHECK-NEXT:    fsub z0.h, p0/m, z0.h, #1.0
; CHECK-NEXT:    ret
  %out = fsub <vscale x 8 x half> %a, splat(half 1.000000e+00)
  ret <vscale x 8 x half> %out
}

define <vscale x 4 x half> @fsub_4h_immhalf(<vscale x 4 x half> %a) #0 {
; CHECK-LABEL: fsub_4h_immhalf:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ptrue p0.s
; CHECK-NEXT:    fsub z0.h, p0/m, z0.h, #0.5
; CHECK-NEXT:    ret
  %out = fsub <vscale x 4 x half> %a, splat(half 0.500000e+00)
  ret <vscale x 4 x half> %out
}

define <vscale x 4 x half> @fsub_4h_immone(<vscale x 4 x half> %a) #0 {
; CHECK-LABEL: fsub_4h_immone:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ptrue p0.s
; CHECK-NEXT:    fsub z0.h, p0/m, z0.h, #1.0
; CHECK-NEXT:    ret
  %out = fsub <vscale x 4 x half> %a, splat(half 1.000000e+00)
  ret <vscale x 4 x half> %out
}

define <vscale x 2 x half> @fsub_2h_immhalf(<vscale x 2 x half> %a) #0 {
; CHECK-LABEL: fsub_2h_immhalf:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ptrue p0.d
; CHECK-NEXT:    fsub z0.h, p0/m, z0.h, #0.5
; CHECK-NEXT:    ret
  %out = fsub <vscale x 2 x half> %a, splat(half 0.500000e+00)
  ret <vscale x 2 x half> %out
}

define <vscale x 2 x half> @fsub_2h_immone(<vscale x 2 x half> %a) #0 {
; CHECK-LABEL: fsub_2h_immone:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ptrue p0.d
; CHECK-NEXT:    fsub z0.h, p0/m, z0.h, #1.0
; CHECK-NEXT:    ret
  %out = fsub <vscale x 2 x half> %a, splat(half 1.000000e+00)
  ret <vscale x 2 x half> %out
}

define <vscale x 4 x float> @fsub_s_immhalf(<vscale x 4 x float> %a) #0 {
; CHECK-LABEL: fsub_s_immhalf:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ptrue p0.s
; CHECK-NEXT:    fsub z0.s, p0/m, z0.s, #0.5
; CHECK-NEXT:    ret
  %out = fsub <vscale x 4 x float> %a, splat(float 0.500000e+00)
  ret <vscale x 4 x float> %out
}

define <vscale x 4 x float> @fsub_s_immone(<vscale x 4 x float> %a) #0 {
; CHECK-LABEL: fsub_s_immone:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ptrue p0.s
; CHECK-NEXT:    fsub z0.s, p0/m, z0.s, #1.0
; CHECK-NEXT:    ret
  %out = fsub <vscale x 4 x float> %a, splat(float 1.000000e+00)
  ret <vscale x 4 x float> %out
}

define <vscale x 2 x float> @fsub_2s_immhalf(<vscale x 2 x float> %a) #0 {
; CHECK-LABEL: fsub_2s_immhalf:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ptrue p0.d
; CHECK-NEXT:    fsub z0.s, p0/m, z0.s, #0.5
; CHECK-NEXT:    ret
  %out = fsub <vscale x 2 x float> %a, splat(float 0.500000e+00)
  ret <vscale x 2 x float> %out
}

define <vscale x 2 x float> @fsub_2s_immone(<vscale x 2 x float> %a) #0 {
; CHECK-LABEL: fsub_2s_immone:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ptrue p0.d
; CHECK-NEXT:    fsub z0.s, p0/m, z0.s, #1.0
; CHECK-NEXT:    ret
  %out = fsub <vscale x 2 x float> %a, splat(float 1.000000e+00)
  ret <vscale x 2 x float> %out
}

define <vscale x 2 x double> @fsub_d_immhalf(<vscale x 2 x double> %a) #0 {
; CHECK-LABEL: fsub_d_immhalf:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ptrue p0.d
; CHECK-NEXT:    fsub z0.d, p0/m, z0.d, #0.5
; CHECK-NEXT:    ret
  %out = fsub <vscale x 2 x double> %a, splat(double 0.500000e+00)
  ret <vscale x 2 x double> %out
}

define <vscale x 2 x double> @fsub_d_immone(<vscale x 2 x double> %a) #0 {
; CHECK-LABEL: fsub_d_immone:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ptrue p0.d
; CHECK-NEXT:    fsub z0.d, p0/m, z0.d, #1.0
; CHECK-NEXT:    ret
  %out = fsub <vscale x 2 x double> %a, splat(double 1.000000e+00)
  ret <vscale x 2 x double> %out
}

;
; FSUBR
;

define <vscale x 8 x half> @fsubr_h_immhalf(<vscale x 8 x half> %a) #0 {
; CHECK-LABEL: fsubr_h_immhalf:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ptrue p0.h
; CHECK-NEXT:    fsubr z0.h, p0/m, z0.h, #0.5
; CHECK-NEXT:    ret
  %out = fsub <vscale x 8 x half> splat(half 0.500000e+00), %a
  ret <vscale x 8 x half> %out
}

define <vscale x 8 x half> @fsubr_h_immone(<vscale x 8 x half> %a) #0 {
; CHECK-LABEL: fsubr_h_immone:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ptrue p0.h
; CHECK-NEXT:    fsubr z0.h, p0/m, z0.h, #1.0
; CHECK-NEXT:    ret
  %out = fsub <vscale x 8 x half> splat(half 1.000000e+00), %a
  ret <vscale x 8 x half> %out
}

define <vscale x 4 x half> @fsubr_4h_immhalf(<vscale x 4 x half> %a) #0 {
; CHECK-LABEL: fsubr_4h_immhalf:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ptrue p0.s
; CHECK-NEXT:    fsubr z0.h, p0/m, z0.h, #0.5
; CHECK-NEXT:    ret
  %out = fsub <vscale x 4 x half> splat(half 0.500000e+00), %a
  ret <vscale x 4 x half> %out
}

define <vscale x 4 x half> @fsubr_4h_immone(<vscale x 4 x half> %a) #0 {
; CHECK-LABEL: fsubr_4h_immone:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ptrue p0.s
; CHECK-NEXT:    fsubr z0.h, p0/m, z0.h, #1.0
; CHECK-NEXT:    ret
  %out = fsub <vscale x 4 x half> splat(half 1.000000e+00), %a
  ret <vscale x 4 x half> %out
}

define <vscale x 2 x half> @fsubr_2h_immhalf(<vscale x 2 x half> %a) #0 {
; CHECK-LABEL: fsubr_2h_immhalf:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ptrue p0.d
; CHECK-NEXT:    fsubr z0.h, p0/m, z0.h, #0.5
; CHECK-NEXT:    ret
  %out = fsub <vscale x 2 x half> splat(half 0.500000e+00), %a
  ret <vscale x 2 x half> %out
}

define <vscale x 2 x half> @fsubr_2h_immone(<vscale x 2 x half> %a) #0 {
; CHECK-LABEL: fsubr_2h_immone:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ptrue p0.d
; CHECK-NEXT:    fsubr z0.h, p0/m, z0.h, #1.0
; CHECK-NEXT:    ret
  %out = fsub <vscale x 2 x half> splat(half 1.000000e+00), %a
  ret <vscale x 2 x half> %out
}

define <vscale x 4 x float> @fsubr_s_immhalf(<vscale x 4 x float> %a) #0 {
; CHECK-LABEL: fsubr_s_immhalf:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ptrue p0.s
; CHECK-NEXT:    fsubr z0.s, p0/m, z0.s, #0.5
; CHECK-NEXT:    ret
  %out = fsub <vscale x 4 x float> splat(float 0.500000e+00), %a
  ret <vscale x 4 x float> %out
}

define <vscale x 4 x float> @fsubr_s_immone(<vscale x 4 x float> %a) #0 {
; CHECK-LABEL: fsubr_s_immone:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ptrue p0.s
; CHECK-NEXT:    fsubr z0.s, p0/m, z0.s, #1.0
; CHECK-NEXT:    ret
  %out = fsub <vscale x 4 x float> splat(float 1.000000e+00), %a
  ret <vscale x 4 x float> %out
}

define <vscale x 2 x float> @fsubr_2s_immhalf(<vscale x 2 x float> %a) #0 {
; CHECK-LABEL: fsubr_2s_immhalf:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ptrue p0.d
; CHECK-NEXT:    fsubr z0.s, p0/m, z0.s, #0.5
; CHECK-NEXT:    ret
  %out = fsub <vscale x 2 x float> splat(float 0.500000e+00), %a
  ret <vscale x 2 x float> %out
}

define <vscale x 2 x float> @fsubr_2s_immone(<vscale x 2 x float> %a) #0 {
; CHECK-LABEL: fsubr_2s_immone:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ptrue p0.d
; CHECK-NEXT:    fsubr z0.s, p0/m, z0.s, #1.0
; CHECK-NEXT:    ret
  %out = fsub <vscale x 2 x float> splat(float 1.000000e+00), %a
  ret <vscale x 2 x float> %out
}

define <vscale x 2 x double> @fsubr_d_immhalf(<vscale x 2 x double> %a) #0 {
; CHECK-LABEL: fsubr_d_immhalf:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ptrue p0.d
; CHECK-NEXT:    fsubr z0.d, p0/m, z0.d, #0.5
; CHECK-NEXT:    ret
  %out = fsub <vscale x 2 x double> splat(double 0.500000e+00), %a
  ret <vscale x 2 x double> %out
}

define <vscale x 2 x double> @fsubr_d_immone(<vscale x 2 x double> %a) #0 {
; CHECK-LABEL: fsubr_d_immone:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ptrue p0.d
; CHECK-NEXT:    fsubr z0.d, p0/m, z0.d, #1.0
; CHECK-NEXT:    ret
  %out = fsub <vscale x 2 x double> splat(double 1.000000e+00), %a
  ret <vscale x 2 x double> %out
}

declare <vscale x 8 x half> @llvm.maximum.nxv8f16(<vscale x 8 x half>, <vscale x 8 x half>)
declare <vscale x 4 x half> @llvm.maximum.nxv4f16(<vscale x 4 x half>, <vscale x 4 x half>)
declare <vscale x 2 x half> @llvm.maximum.nxv2f16(<vscale x 2 x half>, <vscale x 2 x half>)
declare <vscale x 4 x float> @llvm.maximum.nxv4f32(<vscale x 4 x float>, <vscale x 4 x float>)
declare <vscale x 2 x float> @llvm.maximum.nxv2f32(<vscale x 2 x float>, <vscale x 2 x float>)
declare <vscale x 2 x double> @llvm.maximum.nxv2f64(<vscale x 2 x double>, <vscale x 2 x double>)

declare <vscale x 8 x half> @llvm.maxnum.nxv8f16(<vscale x 8 x half>, <vscale x 8 x half>)
declare <vscale x 4 x half> @llvm.maxnum.nxv4f16(<vscale x 4 x half>, <vscale x 4 x half>)
declare <vscale x 2 x half> @llvm.maxnum.nxv2f16(<vscale x 2 x half>, <vscale x 2 x half>)
declare <vscale x 4 x float> @llvm.maxnum.nxv4f32(<vscale x 4 x float>, <vscale x 4 x float>)
declare <vscale x 2 x float> @llvm.maxnum.nxv2f32(<vscale x 2 x float>, <vscale x 2 x float>)
declare <vscale x 2 x double> @llvm.maxnum.nxv2f64(<vscale x 2 x double>, <vscale x 2 x double>)

declare <vscale x 8 x half> @llvm.minimum.nxv8f16(<vscale x 8 x half>, <vscale x 8 x half>)
declare <vscale x 4 x half> @llvm.minimum.nxv4f16(<vscale x 4 x half>, <vscale x 4 x half>)
declare <vscale x 2 x half> @llvm.minimum.nxv2f16(<vscale x 2 x half>, <vscale x 2 x half>)
declare <vscale x 4 x float> @llvm.minimum.nxv4f32(<vscale x 4 x float>, <vscale x 4 x float>)
declare <vscale x 2 x float> @llvm.minimum.nxv2f32(<vscale x 2 x float>, <vscale x 2 x float>)
declare <vscale x 2 x double> @llvm.minimum.nxv2f64(<vscale x 2 x double>, <vscale x 2 x double>)

declare <vscale x 8 x half> @llvm.minnum.nxv8f16(<vscale x 8 x half>, <vscale x 8 x half>)
declare <vscale x 4 x half> @llvm.minnum.nxv4f16(<vscale x 4 x half>, <vscale x 4 x half>)
declare <vscale x 2 x half> @llvm.minnum.nxv2f16(<vscale x 2 x half>, <vscale x 2 x half>)
declare <vscale x 4 x float> @llvm.minnum.nxv4f32(<vscale x 4 x float>, <vscale x 4 x float>)
declare <vscale x 2 x float> @llvm.minnum.nxv2f32(<vscale x 2 x float>, <vscale x 2 x float>)
declare <vscale x 2 x double> @llvm.minnum.nxv2f64(<vscale x 2 x double>, <vscale x 2 x double>)

attributes #0 = { "target-features"="+sve" }
attributes #1 = { "target-features"="+sve,+use-experimental-zeroing-pseudos" }
