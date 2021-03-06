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
      cli
      in r16, WDTCR
      ori r16, (1 << WDP2) | (1 << WDP1) | (1 << WDP0) | (1 << WDE)
      out WDTCR, r16
      sei
      sbi DDRD, DDD5
      sbi DDRD, DDD4
      cbi DDRD, DDD6
      cbi DDRD, DDD3
      cbi PORTD, PORTD5
      sbi PIND, PIND6
      sbi PIND, PIND3
      rjmp  Start

;====================================================================
; CODE SEGMENT
;====================================================================

Start:


Loop:
      sbis PIND, PIND3
      sbi PORTD, PORTD5
      sbis PIND, PIND6
      WDR
      rjmp  Loop

;====================================================================

