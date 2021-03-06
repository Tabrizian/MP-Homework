;====================================================================
; Main.asm file generated by New Project wizard
;
; Created:   Thu Apr 6 2017
; Processor: ATmega16
; Compiler:  AVRASM (Proteus)
;====================================================================

;====================================================================
; DEFINITIONS
;====================================================================

;====================================================================
; VARIABLES
;====================================================================

;====================================================================
; RESET and INTERRUPT VECTORS
;====================================================================

      ; Reset Vector
      ldi zl, 0x80
      ldi zh, 0
      in R16, 0x25
      swap R16
      cbr R16, 0x04
      sbrc R16, $04
      rjmp equals_1
      rjmp equals_0

equals_1:
      std Z+0x10, R16
      rjmp Start
equals_0:
      asr R16
      ldi R17, 0x05
      mul R16, R17
      push R0
      push R1
      rjmp  Start

;====================================================================
; CODE SEGMENT
;====================================================================

Start:
      ; Write your code here
Loop:
      rjmp  Loop

;====================================================================

