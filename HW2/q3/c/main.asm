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
Delay:
      ldi r18, 0x02
delay_loop_1:
      ldi r16, 0xD0
delay_loop_2:
      ldi r17, 0xE0
delay_loop_3:
      nop       ; 1 clock
      dec r17   ; 1 clock
      cpi r17, 0x00  ; 1 clock
      brne delay_loop_3
      dec r16
      cpi r16, 0x00
      brne delay_loop_2
      dec r18
      cpi r18, 0x00
      brne delay_loop_1
      ret
Blink:
      ldi r19, 0x0A
BlinkLoop:
      rcall Delay
      sbi PORTD, PORTD4
      rcall Delay
      cbi PORTD, PORTD4
      dec r19
      cpi r19, 0x00
      brne BlinkLoop
      ret
Start:
      ; Write your code here
      cbi DDRD, DDD6
      sbi DDRD, DDD4
Loop:
      sbis PIND, PIND6
      rcall Blink
      rjmp  Loop

;====================================================================

