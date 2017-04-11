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
      cbi DDRD, DDD3
      sbi DDRD, DDD5
      cbi PORTD, PORTD5
      sbi PIND, PIND3
      rjmp  Start

;====================================================================
; CODE SEGMENT
;====================================================================

Start:
      ; Write your code here
Loop:
      sbic PIND, PIND3
      cbi PORTD, PORTD5
      sbis PIND, PIND3
      sbi PORTD, PORTD5
      rjmp  Loop

;====================================================================

