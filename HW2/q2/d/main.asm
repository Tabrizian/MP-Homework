;====================================================================
; Main.asm file generated by New Project wizard
;
; Created:   Tue Apr 11 2017
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
      cli
      in r16, WDTCR
      ori r16, (1 << WDP2) | (1 << WDP1) | (1 << WDP0) | (1 << WDE)
      out WDTCR, r16
      sei



;====================================================================
Loop:
      rjmp Loop

