;*******************************************************************************
;	File:	m8_LCD_4bit.asm
;      Title:	ATmega8 driver for LCD in 4-bit mode (HD44780)
;  Assembler:	AVR assembler/AVR Studio
;    Version:	1.0
;    Created:	April 5th, 2004
;     Target:	ATmega8
; Christoph Redecker, http://www.avrbeginners.net
;*******************************************************************************

; Some notes on the hardware:
;ATmega8 (clock frequency doesn't matter, tested with 1 MHz to 8 MHz)
; porta.1 -> LCD RS (register select)
; porta.2 -> LCD RW (read/write)
; porta.3 -> LCd E (Enable)
; porta.4 ... porta.7 -> LCD data.4 ... data.7
; the other LCd data lines can be left open or tied to ground.


.equ	LCD_RS	= 1
.equ	LCD_RW	= 2
.equ	LCD_E	= 3

.def	temp	= r16
.def	argument= r17		;argument for calling subroutines
.def	return	= r18		;return value from subroutines

rjmp reset

reset:

rjmp start;

lcd_command8:	;used for init (we need some 8-bit commands to switch to 4-bit mode!)
	in	temp, ddra		;we need to set the high nibble of ddra while leaving
					;the other bits untouched. Using temp for that.
	sbr	temp, 0b11110000	;set high nibble in temp
	out	ddra, temp		;write value to ddra again
	in	temp, porta		;then get the port value
	cbr	temp, 0b11110000	;and clear the data bits
	cbr	argument, 0b00001111	;then clear the low nibble of the argument
					;so that no control line bits are overwritten
	or	temp, argument		;then set the data bits (from the argument) in the
					;Port value
	out	porta, temp		;and write the port value.
	sbi	porta, LCD_E		;now strobe E
	nop
	nop
	nop
	cbi	porta, LCD_E
	in	temp, ddra		;get ddra to make the data lines input again
	cbr	temp, 0b11110000	;clear data line direction bits
	out	ddra, temp		;and write to ddra
ret

lcd_putchar:
	push	argument		;save the argmuent (it's destroyed in between)
	in	temp, ddra		;get data direction bits
	sbr	temp, 0b11110000	;set the data lines to output
	out	ddra, temp		;write value to ddra
	in	temp, porta		;then get the data from porta
	cbr	temp, 0b11111110	;clear ALL LCD lines (data and control!)
	cbr	argument, 0b00001111	;we have to write the high nibble of our argument first
					;so mask off the low nibble
	or	temp, argument		;now set the argument bits in the Port value
	out	porta, temp		;and write the port value
	sbi	porta, LCD_RS		;now take RS high for LCD char data register access
	sbi	porta, LCD_E		;strobe Enable
	nop
	nop
	nop
	cbi	porta, LCD_E
	pop	argument		;restore the argument, we need the low nibble now...
	cbr	temp, 0b11110000	;clear the data bits of our port value
	swap	argument		;we want to write the LOW nibble of the argument to
					;the LCD data lines, which are the HIGH port nibble!
	cbr	argument, 0b00001111	;clear unused bits in argument
	or	temp, argument		;and set the required argument bits in the port value
	out	porta, temp		;write data to port
	sbi	porta, LCD_RS		;again, set RS
	sbi	porta, LCD_E		;strobe Enable
	nop
	nop
	nop
	cbi	porta, LCD_E
	cbi	porta, LCD_RS
	in	temp, ddra
	cbr	temp, 0b11110000	;data lines are input again
	out	ddra, temp
ret

lcd_command:	;same as LCD_putchar, but with RS low!
	push	argument
	in	temp, ddra
	sbr	temp, 0b11110000
	out	ddra, temp
	in	temp, porta
	cbr	temp, 0b11111110
	cbr	argument, 0b00001111
	or	temp, argument

	out	porta, temp
	sbi	porta, LCD_E
	nop
	nop
	nop
	cbi	porta, LCD_E
	pop	argument
	cbr	temp, 0b11110000
	swap	argument
	cbr	argument, 0b00001111
	or	temp, argument
	out	porta, temp
	sbi	porta, LCD_E
	nop
	nop
	nop
	cbi	porta, LCD_E
	in	temp, ddra
	cbr	temp, 0b11110000
	out	ddra, temp
ret

LCD_getchar:
	in	temp, ddra		;make sure the data lines are inputs
	andi	temp, 0b00001111	;so clear their DDR bits
	out	ddra, temp
	sbi	porta, LCD_RS		;we want to access the char data register, so RS high
	sbi	porta, LCD_RW		;we also want to read from the LCD -> RW high
	sbi	porta, LCD_E		;while E is high
	nop
	in	temp, pina		;we need to fetch the HIGH nibble
	andi	temp, 0b11110000	;mask off the control line data
	mov	return, temp		;and copy the HIGH nibble to return
	cbi	porta, LCD_E		;now take E low again
	nop				;wait a bit before strobing E again
	nop
	sbi	porta, LCD_E		;same as above, now we're reading the low nibble
	nop
	in	temp, pina		;get the data
	andi	temp, 0b11110000	;and again mask off the control line bits
	swap	temp			;temp HIGH nibble contains data LOW nibble! so swap
	or	return, temp		;and combine with previously read high nibble
	cbi	porta, LCD_E		;take all control lines low again
	cbi	porta, LCD_RS
	cbi	porta, LCD_RW
ret					;the character read from the LCD is now in return

LCD_getaddr:	;works just like LCD_getchar, but with RS low, return.7 is the busy flag
	in	temp, ddra
	andi	temp, 0b00001111
	out	ddra, temp
	cbi	porta, LCD_RS
	sbi	porta, LCD_RW
	sbi	porta, LCD_E
	nop
	in	temp, pina
	andi	temp, 0b11110000
	mov	return, temp
	cbi	porta, LCD_E
	nop
	nop
	sbi	porta, LCD_E
	nop
	in	temp, pina
	andi	temp, 0b11110000
	swap	temp
	or	return, temp
	cbi	porta, LCD_E
	cbi	porta, LCD_RW
ret

LCD_wait:				;read address and busy flag until busy flag cleared
	rcall	LCD_getaddr
	andi	return, 0x80
	brne	LCD_wait
	ret


LCD_delay:
	clr	r2
	LCD_delay_outer:
	clr	r3
		LCD_delay_inner:
		dec	r3
		brne	LCD_delay_inner
	dec	r2
	brne	LCD_delay_outer
ret

LCD_init:

	ldi	temp, 0b00001110	;control lines are output, rest is input
	out	ddra, temp

	rcall	LCD_delay		;first, we'll tell the LCD that we want to use it
	ldi	argument, 0x20		;in 4-bit mode.
	rcall	LCD_command8		;LCD is still in 8-BIT MODE while writing this command!!!

	rcall	LCD_wait
	ldi	argument, 0x28		;NOW: 2 lines, 5*7 font, 4-BIT MODE!
	rcall	LCD_command		;

	rcall	LCD_wait
	ldi	argument, 0x0F		;now proceed as usual: Display on, cursor on, blinking
	rcall	LCD_command

	rcall	LCD_wait
	ldi	argument, 0x01		;clear display, cursor -> home
	rcall	LCD_command

	rcall	LCD_wait
	ldi	argument, 0x06		;auto-inc cursor
	rcall	LCD_command
ret
