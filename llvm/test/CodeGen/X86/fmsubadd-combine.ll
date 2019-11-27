; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc < %s -mtriple=x86_64-unknown-linux-gnu -mattr=+fma | FileCheck -check-prefix=FMA3 -check-prefix=FMA3_256 %s
; RUN: llc < %s -mtriple=x86_64-unknown-linux-gnu -mattr=+fma,+avx512f | FileCheck -check-prefix=FMA3 -check-prefix=FMA3_512 %s
; RUN: llc < %s -mtriple=x86_64-unknown-linux-gnu -mattr=+fma4 | FileCheck -check-prefix=FMA4 %s

; This test checks the fusing of MUL + SUB/ADD to FMSUBADD.

define <2 x double> @mul_subadd_pd128(<2 x double> %A, <2 x double> %B, <2 x double> %C) #0 {
; FMA3_256-LABEL: mul_subadd_pd128:
; FMA3_256:       # %bb.0: # %entry
; FMA3_256-NEXT:    vfmsubadd213pd %xmm2, %xmm1, %xmm0
; FMA3_256-NEXT:    retq
;
; FMA3_512-LABEL: mul_subadd_pd128:
; FMA3_512:       # %bb.0: # %entry
; FMA3_512-NEXT:    vfmsubadd213pd %xmm2, %xmm1, %xmm0
; FMA3_512-NEXT:    retq
;
; FMA4-LABEL: mul_subadd_pd128:
; FMA4:       # %bb.0: # %entry
; FMA4-NEXT:    vfmsubaddpd %xmm2, %xmm1, %xmm0, %xmm0
; FMA4-NEXT:    retq
entry:
  %AB = fmul <2 x double> %A, %B
  %Sub = fsub <2 x double> %AB, %C
  %Add = fadd <2 x double> %AB, %C
  %subadd = shufflevector <2 x double> %Add, <2 x double> %Sub, <2 x i32> <i32 0, i32 3>
  ret <2 x double> %subadd
}

define <4 x float> @mul_subadd_ps128(<4 x float> %A, <4 x float> %B, <4 x float> %C) #0 {
; FMA3-LABEL: mul_subadd_ps128:
; FMA3:       # %bb.0: # %entry
; FMA3-NEXT:    vfmsubadd213ps  %xmm2, %xmm1, %xmm0
; FMA3-NEXT:    retq
;
; FMA4-LABEL: mul_subadd_ps128:
; FMA4:       # %bb.0: # %entry
; FMA4-NEXT:    vfmsubaddps %xmm2, %xmm1, %xmm0, %xmm0
; FMA4-NEXT:    retq
entry:
  %AB = fmul <4 x float> %A, %B
  %Sub = fsub <4 x float> %AB, %C
  %Add = fadd <4 x float> %AB, %C
  %subadd = shufflevector <4 x float> %Add, <4 x float> %Sub, <4 x i32> <i32 0, i32 5, i32 2, i32 7>
  ret <4 x float> %subadd
}

define <4 x double> @mul_subadd_pd256(<4 x double> %A, <4 x double> %B, <4 x double> %C) #0 {
; FMA3-LABEL: mul_subadd_pd256:
; FMA3:       # %bb.0: # %entry
; FMA3-NEXT:    vfmsubadd213pd  %ymm2, %ymm1, %ymm0
; FMA3-NEXT:    retq
;
; FMA4-LABEL: mul_subadd_pd256:
; FMA4:       # %bb.0: # %entry
; FMA4-NEXT:    vfmsubaddpd %ymm2, %ymm1, %ymm0, %ymm0
; FMA4-NEXT:    retq
entry:
  %AB = fmul <4 x double> %A, %B
  %Sub = fsub <4 x double> %AB, %C
  %Add = fadd <4 x double> %AB, %C
  %subadd = shufflevector <4 x double> %Add, <4 x double> %Sub, <4 x i32> <i32 0, i32 5, i32 2, i32 7>
  ret <4 x double> %subadd
}

define <8 x float> @mul_subadd_ps256(<8 x float> %A, <8 x float> %B, <8 x float> %C) #0 {
; FMA3-LABEL: mul_subadd_ps256:
; FMA3:       # %bb.0: # %entry
; FMA3-NEXT:    vfmsubadd213ps  %ymm2, %ymm1, %ymm0
; FMA3-NEXT:    retq
;
; FMA4-LABEL: mul_subadd_ps256:
; FMA4:       # %bb.0: # %entry
; FMA4-NEXT:    vfmsubaddps %ymm2, %ymm1, %ymm0, %ymm0
; FMA4-NEXT:    retq
entry:
  %AB = fmul <8 x float> %A, %B
  %Sub = fsub <8 x float> %AB, %C
  %Add = fadd <8 x float> %AB, %C
  %subadd = shufflevector <8 x float> %Add, <8 x float> %Sub, <8 x i32> <i32 0, i32 9, i32 2, i32 11, i32 4, i32 13, i32 6, i32 15>
  ret <8 x float> %subadd
}

define <8 x double> @mul_subadd_pd512(<8 x double> %A, <8 x double> %B, <8 x double> %C) #0 {
; FMA3_256-LABEL: mul_subadd_pd512:
; FMA3_256:       # %bb.0: # %entry
; FMA3_256-NEXT:    vfmsubadd213pd  %ymm4, %ymm2, %ymm0
; FMA3_256-NEXT:    vfmsubadd213pd  %ymm5, %ymm3, %ymm1
; FMA3_256-NEXT:    retq
;
; FMA3_512-LABEL: mul_subadd_pd512:
; FMA3_512:       # %bb.0: # %entry
; FMA3_512-NEXT:    vfmsubadd213pd  %zmm2, %zmm1, %zmm0
; FMA3_512-NEXT:    retq
;
; FMA4-LABEL: mul_subadd_pd512:
; FMA4:       # %bb.0: # %entry
; FMA4-NEXT:    vfmsubaddpd %ymm4, %ymm2, %ymm0, %ymm0
; FMA4-NEXT:    vfmsubaddpd %ymm5, %ymm3, %ymm1, %ymm1
; FMA4-NEXT:    retq
entry:
  %AB = fmul <8 x double> %A, %B
  %Sub = fsub <8 x double> %AB, %C
  %Add = fadd <8 x double> %AB, %C
  %subadd = shufflevector <8 x double> %Add, <8 x double> %Sub, <8 x i32> <i32 0, i32 9, i32 2, i32 11, i32 4, i32 13, i32 6, i32 15>
  ret <8 x double> %subadd
}

define <16 x float> @mul_subadd_ps512(<16 x float> %A, <16 x float> %B, <16 x float> %C) #0 {
; FMA3_256-LABEL: mul_subadd_ps512:
; FMA3_256:       # %bb.0: # %entry
; FMA3_256-NEXT:    vfmsubadd213ps  %ymm4, %ymm2, %ymm0
; FMA3_256-NEXT:    vfmsubadd213ps  %ymm5, %ymm3, %ymm1
; FMA3_256-NEXT:    retq
;
; FMA3_512-LABEL: mul_subadd_ps512:
; FMA3_512:       # %bb.0: # %entry
; FMA3_512-NEXT:    vfmsubadd213ps  %zmm2, %zmm1, %zmm0
; FMA3_512-NEXT:    retq
;
; FMA4-LABEL: mul_subadd_ps512:
; FMA4:       # %bb.0: # %entry
; FMA4-NEXT:    vfmsubaddps %ymm4, %ymm2, %ymm0, %ymm0
; FMA4-NEXT:    vfmsubaddps %ymm5, %ymm3, %ymm1, %ymm1
; FMA4-NEXT:    retq
entry:
  %AB = fmul <16 x float> %A, %B
  %Sub = fsub <16 x float> %AB, %C
  %Add = fadd <16 x float> %AB, %C
  %subadd = shufflevector <16 x float> %Add, <16 x float> %Sub, <16 x i32> <i32 0, i32 17, i32 2, i32 19, i32 4, i32 21, i32 6, i32 23, i32 8, i32 25, i32 10, i32 27, i32 12, i32 29, i32 14, i32 31>
  ret <16 x float> %subadd
}

attributes #0 = { nounwind "unsafe-fp-math"="true" }
