;====================================================================
; Main.asm file generated by New Project wizard
;
; Created:   Tue Apr 4 2017
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
      rjmp  Start

;====================================================================
; CODE SEGMENT
;====================================================================
.cseg
BCD_to_7_seg: .DB 0x3f, 0x06, 0x5b, 0x4f, 0x66, 0x6b, 0x7d, 0x07, 0x7f, 0x6f

Start:
      ldi r16, 0x7f
      ldi r17, 0xff
      out DDRA, r17
      out PORTA, r16

      ; Write your code here
Loop:
      rjmp  Loop

;====================================================================

