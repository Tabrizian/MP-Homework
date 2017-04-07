;====================================================================
; Main.asm file generated by New Project wizard
;
; Created:   Fri Apr 7 2017
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

Start:
      ; Write your code here
      ldi R16, 0x0A ; I didn't use R10 because it gives me compile error
      ldi R17, 0x00
      ldi R20, 0x00
      ldi R21, 0x00
      ldi R18, 0x05 ; Pace
Multiply:
      cp R16, R17
      breq Loop
      brlo Loop
      add R17, R18
      mul R17, R17
      add R21, R1
      adc R20, R0
      rjmp Multiply


Loop:
      rjmp  Loop

;====================================================================

