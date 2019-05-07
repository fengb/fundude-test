SAVE: MACRO
      push hl
      push de
      push bc
      push af
      ENDM

RESET: MACRO
       ld hl, \1
       push hl
       pop af
       IF _NARG != 1
         ld hl, \2
       ENDC
       push hl
       pop bc
       IF _NARG != 1
         ld hl, \3
       ENDC
       push hl
       pop de
       IF _NARG != 1
         ld hl, \4
       ENDC
       ENDM

TEST_CASE: MACRO
           RESET $fedc, $ba98, $7654, $3210
           IF _NARG == 1
             \1
           ELSE
             \1, \2
           ENDC
           SAVE

           RESET $0123, $4567, $89ab, $cdef
           IF _NARG == 1
             \1
           ELSE
             \1, \2
           ENDC
           SAVE

           RESET 0
           IF _NARG == 1
             \1
           ELSE
             \1, \2
           ENDC
           SAVE

           RESET $ffff
           IF _NARG == 1
             \1
           ELSE
             \1, \2
           ENDC
           SAVE
           ENDM

SECTION "header", HOME[$100]
    nop
    jp $150

    ; $0104-$0133 (Nintendo logo - do _not_ modify the logo data here or the GB will not run the program)
    DB $CE,$ED,$66,$66,$CC,$0D,$00,$0B,$03,$73,$00,$83,$00,$0C,$00,$0D
    DB $00,$08,$11,$1F,$88,$89,$00,$0E,$DC,$CC,$6E,$E6,$DD,$DD,$D9,$99
    DB $BB,$BB,$67,$63,$6E,$0E,$EC,$CC,$DD,$DC,$99,$9F,$BB,$B9,$33,$3E

SECTION "main", HOME[$150]
    di
    ld sp, $e000

; ----

    ; OP 03
    TEST_CASE inc bc
_DFE0_DFFF: MACRO
        DB $F0,$FF,$00,$00,$FF,$FF,$FF,$FF
        DB $00,$00,$01,$00,$00,$00,$00,$00
        DB $20,$01,$68,$45,$AB,$89,$EF,$CD
        DB $D0,$FE,$99,$BA,$54,$76,$10,$32
        ENDM

    ; OP 04
    TEST_CASE inc b
_DFC0_DFDF: MACRO
        DB $B0,$FF,$FF,$00,$FF,$FF,$FF,$FF
        DB $00,$00,$00,$01,$00,$00,$00,$00
        DB $00,$01,$67,$46,$AB,$89,$EF,$CD
        DB $10,$FE,$98,$BB,$54,$76,$10,$32
        ENDM

    ; OP 05
    TEST_CASE dec b
_DFA0_DFBF: MACRO
        DB $50,$FF,$FF,$FE,$FF,$FF,$FF,$FF
        DB $60,$00,$00,$FF,$00,$00,$00,$00
        DB $40,$01,$67,$44,$AB,$89,$EF,$CD
        DB $50,$FE,$98,$B9,$54,$76,$10,$32
        ENDM

    ; OP 07
    TEST_CASE rlca
_DF80_DF9F: MACRO
        DB $10,$FF,$FF,$FF,$FF,$FF,$FF,$FF
        DB $00,$00,$00,$00,$00,$00,$00,$00
        DB $00,$02,$67,$45,$AB,$89,$EF,$CD
        DB $10,$FD,$98,$BA,$54,$76,$10,$32
        ENDM

    ; OP 09
    TEST_CASE add hl,bc
_DF60_DF7F: MACRO
        DB $B0,$FF,$FF,$FF,$FF,$FF,$FE,$FF
        DB $00,$00,$00,$00,$00,$00,$00,$00
        DB $30,$01,$67,$45,$AB,$89,$56,$13
        DB $80,$FE,$98,$BA,$54,$76,$A8,$EC
        ENDM

    ; OP 0B
    TEST_CASE dec bc
_DF40_DF5F: MACRO
        DB $F0,$FF,$FE,$FF,$FF,$FF,$FF,$FF
        DB $00,$00,$FF,$FF,$00,$00,$00,$00
        DB $20,$01,$66,$45,$AB,$89,$EF,$CD
        DB $D0,$FE,$97,$BA,$54,$76,$10,$32
        ENDM

    ; OP 0C
    TEST_CASE inc c
_DF20_DF3F: MACRO
        DB $B0,$FF,$00,$FF,$FF,$FF,$FF,$FF
        DB $00,$00,$01,$00,$00,$00,$00,$00
        DB $00,$01,$68,$45,$AB,$89,$EF,$CD
        DB $10,$FE,$99,$BA,$54,$76,$10,$32
        ENDM

    ; OP 0D
    TEST_CASE dec c
_DF00_DF1F: MACRO
        DB $50,$FF,$FE,$FF,$FF,$FF,$FF,$FF
        DB $60,$00,$FF,$00,$00,$00,$00,$00
        DB $40,$01,$66,$45,$AB,$89,$EF,$CD
        DB $50,$FE,$97,$BA,$54,$76,$10,$32
        ENDM

    ; OP 0F
    TEST_CASE rrca
_DEE0_DEFF: MACRO
        DB $10,$FF,$FF,$FF,$FF,$FF,$FF,$FF
        DB $00,$00,$00,$00,$00,$00,$00,$00
        DB $10,$80,$67,$45,$AB,$89,$EF,$CD
        DB $00,$7F,$98,$BA,$54,$76,$10,$32
        ENDM

; ----

    ; OP 13
    TEST_CASE inc de
_DEC0_DEDF: MACRO
        DB $F0,$FF,$FF,$FF,$00,$00,$FF,$FF
        DB $00,$00,$00,$00,$01,$00,$00,$00
        DB $20,$01,$67,$45,$AC,$89,$EF,$CD
        DB $D0,$FE,$98,$BA,$55,$76,$10,$32
        ENDM

    ; OP 14
    TEST_CASE inc d
_DEA0_DEBF: MACRO
        DB $B0,$FF,$FF,$FF,$FF,$00,$FF,$FF
        DB $00,$00,$00,$00,$00,$01,$00,$00
        DB $00,$01,$67,$45,$AB,$8A,$EF,$CD
        DB $10,$FE,$98,$BA,$54,$77,$10,$32
        ENDM

    ; OP 15
    TEST_CASE dec d
_DE80_DE9F: MACRO
        DB $50,$FF,$FF,$FF,$FF,$FE,$FF,$FF
        DB $60,$00,$00,$00,$00,$FF,$00,$00
        DB $40,$01,$67,$45,$AB,$88,$EF,$CD
        DB $50,$FE,$98,$BA,$54,$75,$10,$32
        ENDM

    ; OP 17
    TEST_CASE rla
_DE60_DE7F: MACRO
        DB $10,$FF,$FF,$FF,$FF,$FF,$FF,$FF
        DB $00,$00,$00,$00,$00,$00,$00,$00
        DB $00,$02,$67,$45,$AB,$89,$EF,$CD
        DB $10,$FD,$98,$BA,$54,$76,$10,$32
        ENDM

    ; OP 19
    TEST_CASE add hl,de
_DE40_DE5F: MACRO
        DB $B0,$FF,$FF,$FF,$FF,$FF,$FE,$FF
        DB $00,$00,$00,$00,$00,$00,$00,$00
        DB $30,$01,$67,$45,$AB,$89,$9A,$57
        DB $80,$FE,$98,$BA,$54,$76,$64,$A8
        ENDM

    ; OP 1B
    TEST_CASE dec de
_DE20_DE3F: MACRO
        DB $F0,$FF,$FF,$FF,$FE,$FF,$FF,$FF
        DB $00,$00,$00,$00,$FF,$FF,$00,$00
        DB $20,$01,$67,$45,$AA,$89,$EF,$CD
        DB $D0,$FE,$98,$BA,$53,$76,$10,$32
        ENDM

    ; OP 1C
    TEST_CASE inc e
_DE00_DE1F: MACRO
        DB $B0,$FF,$FF,$FF,$00,$FF,$FF,$FF
        DB $00,$00,$00,$00,$01,$00,$00,$00
        DB $00,$01,$67,$45,$AC,$89,$EF,$CD
        DB $10,$FE,$98,$BA,$55,$76,$10,$32
        ENDM

    ; OP 1D
    TEST_CASE dec e
_DDE0_DDFF: MACRO
        DB $50,$FF,$FF,$FF,$FE,$FF,$FF,$FF
        DB $60,$00,$00,$00,$FF,$00,$00,$00
        DB $40,$01,$67,$45,$AA,$89,$EF,$CD
        DB $50,$FE,$98,$BA,$53,$76,$10,$32
        ENDM

    ; OP 1F
    TEST_CASE rra
_DDC0_DDDF: MACRO
        DB $10,$FF,$FF,$FF,$FF,$FF,$FF,$FF
        DB $00,$00,$00,$00,$00,$00,$00,$00
        DB $10,$00,$67,$45,$AB,$89,$EF,$CD
        DB $00,$FF,$98,$BA,$54,$76,$10,$32
        ENDM

; ----

    ; OP 23
    TEST_CASE inc hl
_DDA0_DDBF: MACRO
        DB $F0,$FF,$FF,$FF,$FF,$FF,$00,$00
        DB $00,$00,$00,$00,$00,$00,$01,$00
        DB $20,$01,$67,$45,$AB,$89,$F0,$CD
        DB $D0,$FE,$98,$BA,$54,$76,$11,$32
        ENDM

    ; OP 24
    TEST_CASE inc h
_DD80_DD9F: MACRO
        DB $B0,$FF,$FF,$FF,$FF,$FF,$FF,$00
        DB $00,$00,$00,$00,$00,$00,$00,$01
        DB $00,$01,$67,$45,$AB,$89,$EF,$CE
        DB $10,$FE,$98,$BA,$54,$76,$10,$33
        ENDM

    ; OP 25
    TEST_CASE dec h
_DD60_DD7F: MACRO
        DB $50,$FF,$FF,$FF,$FF,$FF,$FF,$FE
        DB $60,$00,$00,$00,$00,$00,$00,$FF
        DB $40,$01,$67,$45,$AB,$89,$EF,$CC
        DB $50,$FE,$98,$BA,$54,$76,$10,$31
        ENDM

    ; OP 27
    TEST_CASE daa
_DD40_DD5F: MACRO
        DB $50,$99,$FF,$FF,$FF,$FF,$FF,$FF
        DB $80,$00,$00,$00,$00,$00,$00,$00
        DB $00,$07,$67,$45,$AB,$89,$EF,$CD
        DB $50,$9E,$98,$BA,$54,$76,$10,$32
        ENDM

    ; OP 29
    TEST_CASE add hl,hl
_DD20_DD3F: MACRO
        DB $B0,$FF,$FF,$FF,$FF,$FF,$FE,$FF
        DB $00,$00,$00,$00,$00,$00,$00,$00
        DB $30,$01,$67,$45,$AB,$89,$DE,$9B
        DB $80,$FE,$98,$BA,$54,$76,$20,$64
        ENDM

    ; OP 2B
    TEST_CASE dec hl
_DD00_DD1F: MACRO
        DB $F0,$FF,$FF,$FF,$FF,$FF,$FE,$FF
        DB $00,$00,$00,$00,$00,$00,$FF,$FF
        DB $20,$01,$67,$45,$AB,$89,$EE,$CD
        DB $D0,$FE,$98,$BA,$54,$76,$0F,$32
        ENDM

    ; OP 2C
    TEST_CASE inc l
_DCE0_DCFF: MACRO
        DB $B0,$FF,$FF,$FF,$FF,$FF,$00,$FF
        DB $00,$00,$00,$00,$00,$00,$01,$00
        DB $20,$01,$67,$45,$AB,$89,$F0,$CD
        DB $10,$FE,$98,$BA,$54,$76,$11,$32
        ENDM

    ; OP 2D
    TEST_CASE dec l
_DCC0_DCDF: MACRO
        DB $50,$FF,$FF,$FF,$FF,$FF,$FE,$FF
        DB $60,$00,$00,$00,$00,$00,$FF,$00
        DB $40,$01,$67,$45,$AB,$89,$EE,$CD
        DB $70,$FE,$98,$BA,$54,$76,$0F,$32
        ENDM

    ; OP 2F
    TEST_CASE cpl
_DCA0_DCBF: MACRO
        DB $F0,$00,$FF,$FF,$FF,$FF,$FF,$FF
        DB $60,$FF,$00,$00,$00,$00,$00,$00
        DB $60,$FE,$67,$45,$AB,$89,$EF,$CD
        DB $F0,$01,$98,$BA,$54,$76,$10,$32
        ENDM

; ----

    ; OP 37
    TEST_CASE scf
_DC80_DC9F: MACRO
        DB $90,$FF,$FF,$FF,$FF,$FF,$FF,$FF
        DB $10,$00,$00,$00,$00,$00,$00,$00
        DB $10,$01,$67,$45,$AB,$89,$EF,$CD
        DB $90,$FE,$98,$BA,$54,$76,$10,$32
        ENDM

    ; OP 39
    TEST_CASE add hl,sp
_DC60_DC7F: MACRO
        DB $B0,$FF,$FF,$FF,$FF,$FF,$67,$DC
        DB $00,$00,$00,$00,$00,$00,$70,$DC
        DB $30,$01,$67,$45,$AB,$89,$67,$AA
        DB $90,$FE,$98,$BA,$54,$76,$90,$0E
        ENDM

    ; OP 3C
    TEST_CASE inc a
_DC40_DC5F: MACRO
        DB $B0,$00,$FF,$FF,$FF,$FF,$FF,$FF
        DB $00,$01,$00,$00,$00,$00,$00,$00
        DB $00,$02,$67,$45,$AB,$89,$EF,$CD
        DB $10,$FF,$98,$BA,$54,$76,$10,$32
        ENDM

    ; OP 3D
    TEST_CASE dec a
_DC20_DC3F: MACRO
        DB $50,$FE,$FF,$FF,$FF,$FF,$FF,$FF
        DB $60,$FF,$00,$00,$00,$00,$00,$00
        DB $C0,$00,$67,$45,$AB,$89,$EF,$CD
        DB $50,$FD,$98,$BA,$54,$76,$10,$32
        ENDM

    ; OP 3F
    TEST_CASE ccf
_DC00_DC1F: MACRO
        DB $80,$FF,$FF,$FF,$FF,$FF,$FF,$FF
        DB $10,$00,$00,$00,$00,$00,$00,$00
        DB $10,$01,$67,$45,$AB,$89,$EF,$CD
        DB $80,$FE,$98,$BA,$54,$76,$10,$32
        ENDM

; ----

    ; OP 80
    TEST_CASE add a,b
_DBE0_DBFF: MACRO
        DB $30,$FE,$FF,$FF,$FF,$FF,$FF,$FF
        DB $80,$00,$00,$00,$00,$00,$00,$00
        DB $00,$46,$67,$45,$AB,$89,$EF,$CD
        DB $30,$B8,$98,$BA,$54,$76,$10,$32
        ENDM

    ; OP 81
    TEST_CASE add a,c
_DBC0_DBDF: MACRO
        DB $30,$FE,$FF,$FF,$FF,$FF,$FF,$FF
        DB $80,$00,$00,$00,$00,$00,$00,$00
        DB $00,$68,$67,$45,$AB,$89,$EF,$CD
        DB $30,$96,$98,$BA,$54,$76,$10,$32
        ENDM

    ; OP 82
    TEST_CASE add a,d
_DBA0_DBBF: MACRO
        DB $30,$FE,$FF,$FF,$FF,$FF,$FF,$FF
        DB $80,$00,$00,$00,$00,$00,$00,$00
        DB $00,$8A,$67,$45,$AB,$89,$EF,$CD
        DB $30,$74,$98,$BA,$54,$76,$10,$32
        ENDM

    ; OP 83
    TEST_CASE add a,e
_DB80_DB9F: MACRO
        DB $30,$FE,$FF,$FF,$FF,$FF,$FF,$FF
        DB $80,$00,$00,$00,$00,$00,$00,$00
        DB $00,$AC,$67,$45,$AB,$89,$EF,$CD
        DB $30,$52,$98,$BA,$54,$76,$10,$32
        ENDM

    ; OP 84
    TEST_CASE add a,h
_DB60_DB7F: MACRO
        DB $30,$FE,$FF,$FF,$FF,$FF,$FF,$FF
        DB $80,$00,$00,$00,$00,$00,$00,$00
        DB $00,$CE,$67,$45,$AB,$89,$EF,$CD
        DB $30,$30,$98,$BA,$54,$76,$10,$32
        ENDM

    ; OP 85
    TEST_CASE add a,l
_DB40_DB5F: MACRO
        DB $30,$FE,$FF,$FF,$FF,$FF,$FF,$FF
        DB $80,$00,$00,$00,$00,$00,$00,$00
        DB $20,$F0,$67,$45,$AB,$89,$EF,$CD
        DB $10,$0E,$98,$BA,$54,$76,$10,$32
        ENDM

    ; OP 87
    TEST_CASE add a,a
_DB20_DB3F: MACRO
        DB $30,$FE,$FF,$FF,$FF,$FF,$FF,$FF
        DB $80,$00,$00,$00,$00,$00,$00,$00
        DB $00,$02,$67,$45,$AB,$89,$EF,$CD
        DB $30,$FC,$98,$BA,$54,$76,$10,$32
        ENDM

    ; OP 88
    TEST_CASE adc a,b
_DB00_DB1F: MACRO
        DB $30,$FF,$FF,$FF,$FF,$FF,$FF,$FF
        DB $80,$00,$00,$00,$00,$00,$00,$00
        DB $00,$46,$67,$45,$AB,$89,$EF,$CD
        DB $30,$B9,$98,$BA,$54,$76,$10,$32
        ENDM

    ; OP 89
    TEST_CASE adc a,c
_DAE0_DAFF: MACRO
        DB $30,$FF,$FF,$FF,$FF,$FF,$FF,$FF
        DB $80,$00,$00,$00,$00,$00,$00,$00
        DB $00,$68,$67,$45,$AB,$89,$EF,$CD
        DB $30,$97,$98,$BA,$54,$76,$10,$32
        ENDM

    ; OP 8A
    TEST_CASE adc a,d
_DAC0_DADF: MACRO
        DB $30,$FF,$FF,$FF,$FF,$FF,$FF,$FF
        DB $80,$00,$00,$00,$00,$00,$00,$00
        DB $00,$8A,$67,$45,$AB,$89,$EF,$CD
        DB $30,$75,$98,$BA,$54,$76,$10,$32
        ENDM

    ; OP 8B
    TEST_CASE adc a,e
_DAA0_DABF: MACRO
        DB $30,$FF,$FF,$FF,$FF,$FF,$FF,$FF
        DB $80,$00,$00,$00,$00,$00,$00,$00
        DB $00,$AC,$67,$45,$AB,$89,$EF,$CD
        DB $30,$53,$98,$BA,$54,$76,$10,$32
        ENDM

    ; OP 8C
    TEST_CASE adc a,h
_DA80_DA9F: MACRO
        DB $30,$FF,$FF,$FF,$FF,$FF,$FF,$FF
        DB $80,$00,$00,$00,$00,$00,$00,$00
        DB $00,$CE,$67,$45,$AB,$89,$EF,$CD
        DB $30,$31,$98,$BA,$54,$76,$10,$32
        ENDM

    ; OP 8D
    TEST_CASE adc a,l
_DA60_DA7F: MACRO
        DB $30,$FF,$FF,$FF,$FF,$FF,$FF,$FF
        DB $80,$00,$00,$00,$00,$00,$00,$00
        DB $20,$F0,$67,$45,$AB,$89,$EF,$CD
        DB $10,$0F,$98,$BA,$54,$76,$10,$32
        ENDM

    ; OP 8F
    TEST_CASE adc a,a
_DA40_DA5F: MACRO
        DB $30,$FF,$FF,$FF,$FF,$FF,$FF,$FF
        DB $80,$00,$00,$00,$00,$00,$00,$00
        DB $00,$02,$67,$45,$AB,$89,$EF,$CD
        DB $30,$FD,$98,$BA,$54,$76,$10,$32
        ENDM

; ----

    ; OP 90
    TEST_CASE sub b
_DA20_DA3F: MACRO
        DB $C0,$00,$FF,$FF,$FF,$FF,$FF,$FF
        DB $C0,$00,$00,$00,$00,$00,$00,$00
        DB $70,$BC,$67,$45,$AB,$89,$EF,$CD
        DB $40,$44,$98,$BA,$54,$76,$10,$32
        ENDM

    ; OP 91
    TEST_CASE sub c
_DA00_DA1F: MACRO
        DB $C0,$00,$FF,$FF,$FF,$FF,$FF,$FF
        DB $C0,$00,$00,$00,$00,$00,$00,$00
        DB $70,$9A,$67,$45,$AB,$89,$EF,$CD
        DB $40,$66,$98,$BA,$54,$76,$10,$32
        ENDM

    ; OP 92
    TEST_CASE sub d
_D9E0_D9FF: MACRO
        DB $C0,$00,$FF,$FF,$FF,$FF,$FF,$FF
        DB $C0,$00,$00,$00,$00,$00,$00,$00
        DB $70,$78,$67,$45,$AB,$89,$EF,$CD
        DB $40,$88,$98,$BA,$54,$76,$10,$32
        ENDM

    ; OP 93
    TEST_CASE sub e
_D9C0_D9DF: MACRO
        DB $C0,$00,$FF,$FF,$FF,$FF,$FF,$FF
        DB $C0,$00,$00,$00,$00,$00,$00,$00
        DB $70,$56,$67,$45,$AB,$89,$EF,$CD
        DB $40,$AA,$98,$BA,$54,$76,$10,$32
        ENDM

    ; OP 94
    TEST_CASE sub h
_D9A0_D9BF: MACRO
        DB $C0,$00,$FF,$FF,$FF,$FF,$FF,$FF
        DB $C0,$00,$00,$00,$00,$00,$00,$00
        DB $70,$34,$67,$45,$AB,$89,$EF,$CD
        DB $40,$CC,$98,$BA,$54,$76,$10,$32
        ENDM

    ; OP 95
    TEST_CASE sub l
_D980_D99F: MACRO
        DB $C0,$00,$FF,$FF,$FF,$FF,$FF,$FF
        DB $C0,$00,$00,$00,$00,$00,$00,$00
        DB $70,$12,$67,$45,$AB,$89,$EF,$CD
        DB $40,$EE,$98,$BA,$54,$76,$10,$32
        ENDM

    ; OP 97
    TEST_CASE sub a
_D960_D97F: MACRO
        DB $C0,$00,$FF,$FF,$FF,$FF,$FF,$FF
        DB $C0,$00,$00,$00,$00,$00,$00,$00
        DB $C0,$00,$67,$45,$AB,$89,$EF,$CD
        DB $C0,$00,$98,$BA,$54,$76,$10,$32
        ENDM

    ; OP 98
    TEST_CASE sbc a,b
_D940_D95F: MACRO
        DB $70,$FF,$FF,$FF,$FF,$FF,$FF,$FF
        DB $C0,$00,$00,$00,$00,$00,$00,$00
        DB $70,$BC,$67,$45,$AB,$89,$EF,$CD
        DB $40,$43,$98,$BA,$54,$76,$10,$32
        ENDM

    ; OP 99
    TEST_CASE sbc a,c
_D920_D93F: MACRO
        DB $70,$FF,$FF,$FF,$FF,$FF,$FF,$FF
        DB $C0,$00,$00,$00,$00,$00,$00,$00
        DB $70,$9A,$67,$45,$AB,$89,$EF,$CD
        DB $40,$65,$98,$BA,$54,$76,$10,$32
        ENDM

    ; OP 9A
    TEST_CASE sbc a,d
_D900_D91F: MACRO
        DB $70,$FF,$FF,$FF,$FF,$FF,$FF,$FF
        DB $C0,$00,$00,$00,$00,$00,$00,$00
        DB $70,$78,$67,$45,$AB,$89,$EF,$CD
        DB $40,$87,$98,$BA,$54,$76,$10,$32
        ENDM

    ; OP 9B
    TEST_CASE sbc a,e
_D8E0_D8FF: MACRO
        DB $70,$FF,$FF,$FF,$FF,$FF,$FF,$FF
        DB $C0,$00,$00,$00,$00,$00,$00,$00
        DB $70,$56,$67,$45,$AB,$89,$EF,$CD
        DB $40,$A9,$98,$BA,$54,$76,$10,$32
        ENDM

    ; OP 9C
    TEST_CASE sbc a,h
_D8C0_D8DF: MACRO
        DB $70,$FF,$FF,$FF,$FF,$FF,$FF,$FF
        DB $C0,$00,$00,$00,$00,$00,$00,$00
        DB $70,$34,$67,$45,$AB,$89,$EF,$CD
        DB $40,$CB,$98,$BA,$54,$76,$10,$32
        ENDM

    ; OP 9D
    TEST_CASE sbc a,l
_D8A0_D8BF: MACRO
        DB $70,$FF,$FF,$FF,$FF,$FF,$FF,$FF
        DB $C0,$00,$00,$00,$00,$00,$00,$00
        DB $70,$12,$67,$45,$AB,$89,$EF,$CD
        DB $40,$ED,$98,$BA,$54,$76,$10,$32
        ENDM

    ; OP 9F
    TEST_CASE sbc a,a
_D880_D89F: MACRO
        DB $70,$FF,$FF,$FF,$FF,$FF,$FF,$FF
        DB $C0,$00,$00,$00,$00,$00,$00,$00
        DB $C0,$00,$67,$45,$AB,$89,$EF,$CD
        DB $70,$FF,$98,$BA,$54,$76,$10,$32
        ENDM

; ----

    ; OP A0
    TEST_CASE and b
_D860_D87F: MACRO
        DB $20,$FF,$FF,$FF,$FF,$FF,$FF,$FF
        DB $A0,$00,$00,$00,$00,$00,$00,$00
        DB $20,$01,$67,$45,$AB,$89,$EF,$CD
        DB $20,$BA,$98,$BA,$54,$76,$10,$32
        ENDM

    ; OP A1
    TEST_CASE and c
_D840_D85F: MACRO
        DB $20,$FF,$FF,$FF,$FF,$FF,$FF,$FF
        DB $A0,$00,$00,$00,$00,$00,$00,$00
        DB $20,$01,$67,$45,$AB,$89,$EF,$CD
        DB $20,$98,$98,$BA,$54,$76,$10,$32
        ENDM

    ; OP A2
    TEST_CASE and d
_D820_D83F: MACRO
        DB $20,$FF,$FF,$FF,$FF,$FF,$FF,$FF
        DB $A0,$00,$00,$00,$00,$00,$00,$00
        DB $20,$01,$67,$45,$AB,$89,$EF,$CD
        DB $20,$76,$98,$BA,$54,$76,$10,$32
        ENDM

    ; OP A3
    TEST_CASE and e
_D800_D81F: MACRO
        DB $20,$FF,$FF,$FF,$FF,$FF,$FF,$FF
        DB $A0,$00,$00,$00,$00,$00,$00,$00
        DB $20,$01,$67,$45,$AB,$89,$EF,$CD
        DB $20,$54,$98,$BA,$54,$76,$10,$32
        ENDM

    ; OP A4
    TEST_CASE and h
_D7E0_D7FF: MACRO
        DB $20,$FF,$FF,$FF,$FF,$FF,$FF,$FF
        DB $A0,$00,$00,$00,$00,$00,$00,$00
        DB $20,$01,$67,$45,$AB,$89,$EF,$CD
        DB $20,$32,$98,$BA,$54,$76,$10,$32
        ENDM

    ; OP A5
    TEST_CASE and l
_D7C0_D7DF: MACRO
        DB $20,$FF,$FF,$FF,$FF,$FF,$FF,$FF
        DB $A0,$00,$00,$00,$00,$00,$00,$00
        DB $20,$01,$67,$45,$AB,$89,$EF,$CD
        DB $20,$10,$98,$BA,$54,$76,$10,$32
        ENDM

    ; OP A7
    TEST_CASE and a
_D7A0_D7BF: MACRO
        DB $20,$FF,$FF,$FF,$FF,$FF,$FF,$FF
        DB $A0,$00,$00,$00,$00,$00,$00,$00
        DB $20,$01,$67,$45,$AB,$89,$EF,$CD
        DB $20,$FE,$98,$BA,$54,$76,$10,$32
        ENDM

    ; OP A8
    TEST_CASE xor b
_D780_D79F: MACRO
        DB $80,$00,$FF,$FF,$FF,$FF,$FF,$FF
        DB $80,$00,$00,$00,$00,$00,$00,$00
        DB $00,$44,$67,$45,$AB,$89,$EF,$CD
        DB $00,$44,$98,$BA,$54,$76,$10,$32
        ENDM

    ; OP A9
    TEST_CASE xor c
_D760_D77F: MACRO
        DB $80,$00,$FF,$FF,$FF,$FF,$FF,$FF
        DB $80,$00,$00,$00,$00,$00,$00,$00
        DB $00,$66,$67,$45,$AB,$89,$EF,$CD
        DB $00,$66,$98,$BA,$54,$76,$10,$32
        ENDM

    ; OP AA
    TEST_CASE xor d
_D740_D75F: MACRO
        DB $80,$00,$FF,$FF,$FF,$FF,$FF,$FF
        DB $80,$00,$00,$00,$00,$00,$00,$00
        DB $00,$88,$67,$45,$AB,$89,$EF,$CD
        DB $00,$88,$98,$BA,$54,$76,$10,$32
        ENDM

    ; OP AB
    TEST_CASE xor e
_D720_D73F: MACRO
        DB $80,$00,$FF,$FF,$FF,$FF,$FF,$FF
        DB $80,$00,$00,$00,$00,$00,$00,$00
        DB $00,$AA,$67,$45,$AB,$89,$EF,$CD
        DB $00,$AA,$98,$BA,$54,$76,$10,$32
        ENDM

    ; OP AC
    TEST_CASE xor h
_D700_D71F: MACRO
        DB $80,$00,$FF,$FF,$FF,$FF,$FF,$FF
        DB $80,$00,$00,$00,$00,$00,$00,$00
        DB $00,$CC,$67,$45,$AB,$89,$EF,$CD
        DB $00,$CC,$98,$BA,$54,$76,$10,$32
        ENDM

    ; OP AD
    TEST_CASE xor l
_D6E0_D6FF: MACRO
        DB $80,$00,$FF,$FF,$FF,$FF,$FF,$FF
        DB $80,$00,$00,$00,$00,$00,$00,$00
        DB $00,$EE,$67,$45,$AB,$89,$EF,$CD
        DB $00,$EE,$98,$BA,$54,$76,$10,$32
        ENDM

    ; OP AF
    TEST_CASE xor a
_D6C0_D6DF: MACRO
        DB $80,$00,$FF,$FF,$FF,$FF,$FF,$FF
        DB $80,$00,$00,$00,$00,$00,$00,$00
        DB $80,$00,$67,$45,$AB,$89,$EF,$CD
        DB $80,$00,$98,$BA,$54,$76,$10,$32
        ENDM

; ----

    ; OP B0
    TEST_CASE or b
_D6A0_D6BF: MACRO
        DB $00,$FF,$FF,$FF,$FF,$FF,$FF,$FF
        DB $80,$00,$00,$00,$00,$00,$00,$00
        DB $00,$45,$67,$45,$AB,$89,$EF,$CD
        DB $00,$FE,$98,$BA,$54,$76,$10,$32
        ENDM

    ; OP B1
    TEST_CASE or c
_D680_D69F: MACRO
        DB $00,$FF,$FF,$FF,$FF,$FF,$FF,$FF
        DB $80,$00,$00,$00,$00,$00,$00,$00
        DB $00,$67,$67,$45,$AB,$89,$EF,$CD
        DB $00,$FE,$98,$BA,$54,$76,$10,$32
        ENDM

    ; OP B2
    TEST_CASE or d
_D660_D67F: MACRO
        DB $00,$FF,$FF,$FF,$FF,$FF,$FF,$FF
        DB $80,$00,$00,$00,$00,$00,$00,$00
        DB $00,$89,$67,$45,$AB,$89,$EF,$CD
        DB $00,$FE,$98,$BA,$54,$76,$10,$32
        ENDM

    ; OP B3
    TEST_CASE or e
_D640_D65F: MACRO
        DB $00,$FF,$FF,$FF,$FF,$FF,$FF,$FF
        DB $80,$00,$00,$00,$00,$00,$00,$00
        DB $00,$AB,$67,$45,$AB,$89,$EF,$CD
        DB $00,$FE,$98,$BA,$54,$76,$10,$32
        ENDM

    ; OP B4
    TEST_CASE or h
_D620_D63F: MACRO
        DB $00,$FF,$FF,$FF,$FF,$FF,$FF,$FF
        DB $80,$00,$00,$00,$00,$00,$00,$00
        DB $00,$CD,$67,$45,$AB,$89,$EF,$CD
        DB $00,$FE,$98,$BA,$54,$76,$10,$32
        ENDM

    ; OP B5
    TEST_CASE or l
_D600_D61F: MACRO
        DB $00,$FF,$FF,$FF,$FF,$FF,$FF,$FF
        DB $80,$00,$00,$00,$00,$00,$00,$00
        DB $00,$EF,$67,$45,$AB,$89,$EF,$CD
        DB $00,$FE,$98,$BA,$54,$76,$10,$32
        ENDM

    ; OP B7
    TEST_CASE or a
_D5E0_D5FF: MACRO
        DB $00,$FF,$FF,$FF,$FF,$FF,$FF,$FF
        DB $80,$00,$00,$00,$00,$00,$00,$00
        DB $00,$01,$67,$45,$AB,$89,$EF,$CD
        DB $00,$FE,$98,$BA,$54,$76,$10,$32
        ENDM

    ; OP B8
    TEST_CASE cp b
_D5C0_D5DF: MACRO
        DB $C0,$FF,$FF,$FF,$FF,$FF,$FF,$FF
        DB $C0,$00,$00,$00,$00,$00,$00,$00
        DB $70,$01,$67,$45,$AB,$89,$EF,$CD
        DB $40,$FE,$98,$BA,$54,$76,$10,$32
        ENDM

    ; OP B9
    TEST_CASE cp c
_D5A0_D5BF: MACRO
        DB $C0,$FF,$FF,$FF,$FF,$FF,$FF,$FF
        DB $C0,$00,$00,$00,$00,$00,$00,$00
        DB $70,$01,$67,$45,$AB,$89,$EF,$CD
        DB $40,$FE,$98,$BA,$54,$76,$10,$32
        ENDM

    ; OP BA
    TEST_CASE cp d
_D580_D59F: MACRO
        DB $C0,$FF,$FF,$FF,$FF,$FF,$FF,$FF
        DB $C0,$00,$00,$00,$00,$00,$00,$00
        DB $70,$01,$67,$45,$AB,$89,$EF,$CD
        DB $40,$FE,$98,$BA,$54,$76,$10,$32
        ENDM

    ; OP BB
    TEST_CASE cp e
_D560_D57F: MACRO
        DB $C0,$FF,$FF,$FF,$FF,$FF,$FF,$FF
        DB $C0,$00,$00,$00,$00,$00,$00,$00
        DB $70,$01,$67,$45,$AB,$89,$EF,$CD
        DB $40,$FE,$98,$BA,$54,$76,$10,$32
        ENDM

    ; OP BC
    TEST_CASE cp h
_D540_D55F: MACRO
        DB $C0,$FF,$FF,$FF,$FF,$FF,$FF,$FF
        DB $C0,$00,$00,$00,$00,$00,$00,$00
        DB $70,$01,$67,$45,$AB,$89,$EF,$CD
        DB $40,$FE,$98,$BA,$54,$76,$10,$32
        ENDM

    ; OP BD
    TEST_CASE cp l
_D520_D53F: MACRO
        DB $C0,$FF,$FF,$FF,$FF,$FF,$FF,$FF
        DB $C0,$00,$00,$00,$00,$00,$00,$00
        DB $70,$01,$67,$45,$AB,$89,$EF,$CD
        DB $40,$FE,$98,$BA,$54,$76,$10,$32
        ENDM

    ; OP BF
    TEST_CASE cp a
_D500_D51F: MACRO
        DB $C0,$FF,$FF,$FF,$FF,$FF,$FF,$FF
        DB $C0,$00,$00,$00,$00,$00,$00,$00
        DB $C0,$01,$67,$45,$AB,$89,$EF,$CD
        DB $C0,$FE,$98,$BA,$54,$76,$10,$32
        ENDM

; ----

    ; OP C6
    TEST_CASE add a,$9a
_D4E0_D4FF: MACRO
        DB $30,$99,$FF,$FF,$FF,$FF,$FF,$FF
        DB $00,$9A,$00,$00,$00,$00,$00,$00
        DB $00,$9B,$67,$45,$AB,$89,$EF,$CD
        DB $30,$98,$98,$BA,$54,$76,$10,$32
        ENDM

    ; OP CE
    TEST_CASE adc a,$9a
_D4C0_D4DF: MACRO
        DB $30,$9A,$FF,$FF,$FF,$FF,$FF,$FF
        DB $00,$9A,$00,$00,$00,$00,$00,$00
        DB $00,$9B,$67,$45,$AB,$89,$EF,$CD
        DB $30,$99,$98,$BA,$54,$76,$10,$32
        ENDM

    ; OP D6
    TEST_CASE sub $9a
_D4A0_D4BF: MACRO
        DB $40,$65,$FF,$FF,$FF,$FF,$FF,$FF
        DB $70,$66,$00,$00,$00,$00,$00,$00
        DB $70,$67,$67,$45,$AB,$89,$EF,$CD
        DB $40,$64,$98,$BA,$54,$76,$10,$32
        ENDM

    ; OP DE
    TEST_CASE sbc a,$9a
_D480_D49F: MACRO
        DB $40,$64,$FF,$FF,$FF,$FF,$FF,$FF
        DB $70,$66,$00,$00,$00,$00,$00,$00
        DB $70,$67,$67,$45,$AB,$89,$EF,$CD
        DB $40,$63,$98,$BA,$54,$76,$10,$32
        ENDM

    ; OP E6
    TEST_CASE and $9a
_D460_D47F: MACRO
        DB $20,$9A,$FF,$FF,$FF,$FF,$FF,$FF
        DB $A0,$00,$00,$00,$00,$00,$00,$00
        DB $A0,$00,$67,$45,$AB,$89,$EF,$CD
        DB $20,$9A,$98,$BA,$54,$76,$10,$32
        ENDM

    ; OP EE
    TEST_CASE xor $9a
_D440_D45F: MACRO
        DB $00,$65,$FF,$FF,$FF,$FF,$FF,$FF
        DB $00,$9A,$00,$00,$00,$00,$00,$00
        DB $00,$9B,$67,$45,$AB,$89,$EF,$CD
        DB $00,$64,$98,$BA,$54,$76,$10,$32
        ENDM

    ; OP F6
    TEST_CASE or $9a
_D420_D43F: MACRO
        DB $00,$FF,$FF,$FF,$FF,$FF,$FF,$FF
        DB $00,$9A,$00,$00,$00,$00,$00,$00
        DB $00,$9B,$67,$45,$AB,$89,$EF,$CD
        DB $00,$FE,$98,$BA,$54,$76,$10,$32
        ENDM

    ; OP FE
    TEST_CASE cp $9a
_D400_D41F: MACRO
        DB $40,$FF,$FF,$FF,$FF,$FF,$FF,$FF
        DB $70,$00,$00,$00,$00,$00,$00,$00
        DB $70,$01,$67,$45,$AB,$89,$EF,$CD
        DB $40,$FE,$98,$BA,$54,$76,$10,$32
        ENDM

jp eof

SECTION "data", ROMX[$4000]
    _D400_D41F
    _D420_D43F
    _D440_D45F
    _D460_D47F
    _D480_D49F
    _D4A0_D4BF
    _D4C0_D4DF
    _D4E0_D4FF
    _D500_D51F
    _D520_D53F
    _D540_D55F
    _D560_D57F
    _D580_D59F
    _D5A0_D5BF
    _D5C0_D5DF
    _D5E0_D5FF
    _D600_D61F
    _D620_D63F
    _D640_D65F
    _D660_D67F
    _D680_D69F
    _D6A0_D6BF
    _D6C0_D6DF
    _D6E0_D6FF
    _D700_D71F
    _D720_D73F
    _D740_D75F
    _D760_D77F
    _D780_D79F
    _D7A0_D7BF
    _D7C0_D7DF
    _D7E0_D7FF
    _D800_D81F
    _D820_D83F
    _D840_D85F
    _D860_D87F
    _D880_D89F
    _D8A0_D8BF
    _D8C0_D8DF
    _D8E0_D8FF
    _D900_D91F
    _D920_D93F
    _D940_D95F
    _D960_D97F
    _D980_D99F
    _D9A0_D9BF
    _D9C0_D9DF
    _D9E0_D9FF
    _DA00_DA1F
    _DA20_DA3F
    _DA40_DA5F
    _DA60_DA7F
    _DA80_DA9F
    _DAA0_DABF
    _DAC0_DADF
    _DAE0_DAFF
    _DB00_DB1F
    _DB20_DB3F
    _DB40_DB5F
    _DB60_DB7F
    _DB80_DB9F
    _DBA0_DBBF
    _DBC0_DBDF
    _DBE0_DBFF
    _DC00_DC1F
    _DC20_DC3F
    _DC40_DC5F
    _DC60_DC7F
    _DC80_DC9F
    _DCA0_DCBF
    _DCC0_DCDF
    _DCE0_DCFF
    _DD00_DD1F
    _DD20_DD3F
    _DD40_DD5F
    _DD60_DD7F
    _DD80_DD9F
    _DDA0_DDBF
    _DDC0_DDDF
    _DDE0_DDFF
    _DE00_DE1F
    _DE20_DE3F
    _DE40_DE5F
    _DE60_DE7F
    _DE80_DE9F
    _DEA0_DEBF
    _DEC0_DEDF
    _DEE0_DEFF
    _DF00_DF1F
    _DF20_DF3F
    _DF40_DF5F
    _DF60_DF7F
    _DF80_DF9F
    _DFA0_DFBF
    _DFC0_DFDF
    _DFE0_DFFF


SECTION "eof", ROMX[$7ffd]
eof:
    jp eof
