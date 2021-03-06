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
.def no_of_bytes=R16
.def current_max=R19
.def current_number=R20
.def current_index=R21
.def current_max_index=R22
.def temp=R23
.def count=R24
.def temp_2=R25

;====================================================================
; VARIABLES
;====================================================================

.cseg
ARRAY:
.db 0x01, 0x02, 0x03, 0x04, 0x05, 0x06
;====================================================================
; RESET and INTERRUPT VECTORS
;====================================================================

      ; Reset Vector
      ldi zh, high(ARRAY)
      ldi zl, low(ARRAY)
      rjmp  Start

;====================================================================
; CODE SEGMENT
;====================================================================
Max:
      mov current_index, zl
      ldi temp, 0x00
MaxLoop:
      mov zl, current_index
      ld current_number, Z
      cp current_number, current_max
      brlo skip
      mov current_max, current_number
      mov current_max_index, current_index
skip:
      inc current_index
      inc temp
      cp temp, no_of_bytes
      brlo MaxLoop
ret

Start:
      ldi no_of_bytes, 100 ; No of bytes to sort
      ldi count, 0
      mov temp, no_of_bytes


      ldi zh, 0x00
      ldi zl, low(ARRAY)
      ldi xh, 0x01
      ldi xl, low(ARRAY)
Begin:
      lpm temp_2, z
      st x, temp_2
      dec temp
      inc zl
      inc xl
      cpi temp, 0
      brne Begin


      ldi zh, 0x01
      ldi zl, low(ARRAY)
      ldi xh, 0x01
Sort:
      ldi current_max, 0x00 ; Assumed Max index

      movw x, z
      rcall max
      movw z, x
      ld temp, z
      st z, current_max

      mov xl, current_max_index
      st x, temp
      inc zl
      inc count
      cp count, no_of_bytes
      brlo Sort

      ; Write your code here
Loop:
      rjmp  Loop

;====================================================================

