;.nolist
.include "/usr/share/avra/m16def.inc"
;.list

;.org OC1Aaddr

;ldi r16, (1 << 2)
;out DDRB, r16
;out PORTB, r16
;eeprom_write:
;    sbic EECR, EEWE
;    rjmp eeprom_write
;    ldi r18, 0
;    ldi r17, 0
;    ldi r16, 9
;    out eearh, r18
;    out eearl, r17
;    out eedr, r16
;    sbi eecr, eemwe
;    sbi eecr, eewe
;    dec r16
;    brne finish
;    inc r17
;    rjmp eeprom_write
;
;finish:
;    sbi DDRB, 2
;    sbi PORTB, 2
;    nop

