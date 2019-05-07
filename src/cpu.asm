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
AxDFE0: MACRO
        DB $F0,$FF,$00,$00,$FF,$FF,$FF,$FF
        DB $00,$00,$01,$00,$00,$00,$00,$00
        DB $20,$01,$68,$45,$AB,$89,$EF,$CD
        DB $D0,$FE,$99,$BA,$54,$76,$10,$32
        ENDM

    ; OP 04
    TEST_CASE inc b
AxDFC0: MACRO
        DB $B0,$FF,$FF,$00,$FF,$FF,$FF,$FF
        DB $00,$00,$00,$01,$00,$00,$00,$00
        DB $00,$01,$67,$46,$AB,$89,$EF,$CD
        DB $10,$FE,$98,$BB,$54,$76,$10,$32
        ENDM

    ; OP 05
    TEST_CASE dec b
AxDFA0: MACRO
        DB $50,$FF,$FF,$FE,$FF,$FF,$FF,$FF
        DB $60,$00,$00,$FF,$00,$00,$00,$00
        DB $40,$01,$67,$44,$AB,$89,$EF,$CD
        DB $50,$FE,$98,$B9,$54,$76,$10,$32
        ENDM

    ; OP 07
    TEST_CASE rlca
AxDF80: MACRO
        DB $10,$FF,$FF,$FF,$FF,$FF,$FF,$FF
        DB $00,$00,$00,$00,$00,$00,$00,$00
        DB $00,$02,$67,$45,$AB,$89,$EF,$CD
        DB $10,$FD,$98,$BA,$54,$76,$10,$32
        ENDM

    ; OP 09
    TEST_CASE add hl,bc
AxDF60: MACRO
        DB $B0,$FF,$FF,$FF,$FF,$FF,$FE,$FF
        DB $00,$00,$00,$00,$00,$00,$00,$00
        DB $30,$01,$67,$45,$AB,$89,$56,$13
        DB $80,$FE,$98,$BA,$54,$76,$A8,$EC
        ENDM

    ; OP 0B
    TEST_CASE dec bc
AxDF40: MACRO
        DB $F0,$FF,$FE,$FF,$FF,$FF,$FF,$FF
        DB $00,$00,$FF,$FF,$00,$00,$00,$00
        DB $20,$01,$66,$45,$AB,$89,$EF,$CD
        DB $D0,$FE,$97,$BA,$54,$76,$10,$32
        ENDM

    ; OP 0C
    TEST_CASE inc c
AxDF20: MACRO
        DB $B0,$FF,$00,$FF,$FF,$FF,$FF,$FF
        DB $00,$00,$01,$00,$00,$00,$00,$00
        DB $00,$01,$68,$45,$AB,$89,$EF,$CD
        DB $10,$FE,$99,$BA,$54,$76,$10,$32
        ENDM

    ; OP 0D
    TEST_CASE dec c
AxDF00: MACRO
        DB $50,$FF,$FE,$FF,$FF,$FF,$FF,$FF
        DB $60,$00,$FF,$00,$00,$00,$00,$00
        DB $40,$01,$66,$45,$AB,$89,$EF,$CD
        DB $50,$FE,$97,$BA,$54,$76,$10,$32
        ENDM

    ; OP 0F
    TEST_CASE rrca
AxDEE0: MACRO
        DB $10,$FF,$FF,$FF,$FF,$FF,$FF,$FF
        DB $00,$00,$00,$00,$00,$00,$00,$00
        DB $10,$80,$67,$45,$AB,$89,$EF,$CD
        DB $00,$7F,$98,$BA,$54,$76,$10,$32
        ENDM

; ----

    ; OP 13
    TEST_CASE inc de
AxDEC0: MACRO
        DB $F0,$FF,$FF,$FF,$00,$00,$FF,$FF
        DB $00,$00,$00,$00,$01,$00,$00,$00
        DB $20,$01,$67,$45,$AC,$89,$EF,$CD
        DB $D0,$FE,$98,$BA,$55,$76,$10,$32
        ENDM

    ; OP 14
    TEST_CASE inc d
AxDEA0: MACRO
        DB $B0,$FF,$FF,$FF,$FF,$00,$FF,$FF
        DB $00,$00,$00,$00,$00,$01,$00,$00
        DB $00,$01,$67,$45,$AB,$8A,$EF,$CD
        DB $10,$FE,$98,$BA,$54,$77,$10,$32
        ENDM

    ; OP 15
    TEST_CASE dec d
AxDE80: MACRO
        DB $50,$FF,$FF,$FF,$FF,$FE,$FF,$FF
        DB $60,$00,$00,$00,$00,$FF,$00,$00
        DB $40,$01,$67,$45,$AB,$88,$EF,$CD
        DB $50,$FE,$98,$BA,$54,$75,$10,$32
        ENDM

    ; OP 17
    TEST_CASE rla
AxDE60: MACRO
        DB $10,$FF,$FF,$FF,$FF,$FF,$FF,$FF
        DB $00,$00,$00,$00,$00,$00,$00,$00
        DB $00,$02,$67,$45,$AB,$89,$EF,$CD
        DB $10,$FD,$98,$BA,$54,$76,$10,$32
        ENDM

    ; OP 19
    TEST_CASE add hl,de
AxDE40: MACRO
        DB $B0,$FF,$FF,$FF,$FF,$FF,$FE,$FF
        DB $00,$00,$00,$00,$00,$00,$00,$00
        DB $30,$01,$67,$45,$AB,$89,$9A,$57
        DB $80,$FE,$98,$BA,$54,$76,$64,$A8
        ENDM

    ; OP 1B
    TEST_CASE dec de
AxDE20: MACRO
        DB $F0,$FF,$FF,$FF,$FE,$FF,$FF,$FF
        DB $00,$00,$00,$00,$FF,$FF,$00,$00
        DB $20,$01,$67,$45,$AA,$89,$EF,$CD
        DB $D0,$FE,$98,$BA,$53,$76,$10,$32
        ENDM

    ; OP 1C
    TEST_CASE inc e
AxDE00: MACRO
        DB $B0,$FF,$FF,$FF,$00,$FF,$FF,$FF
        DB $00,$00,$00,$00,$01,$00,$00,$00
        DB $00,$01,$67,$45,$AC,$89,$EF,$CD
        DB $10,$FE,$98,$BA,$55,$76,$10,$32
        ENDM

    ; OP 1D
    TEST_CASE dec e
AxDDE0: MACRO
        DB $50,$FF,$FF,$FF,$FE,$FF,$FF,$FF
        DB $60,$00,$00,$00,$FF,$00,$00,$00
        DB $40,$01,$67,$45,$AA,$89,$EF,$CD
        DB $50,$FE,$98,$BA,$53,$76,$10,$32
        ENDM

    ; OP 1F
    TEST_CASE rra
AxDDC0: MACRO
        DB $10,$FF,$FF,$FF,$FF,$FF,$FF,$FF
        DB $00,$00,$00,$00,$00,$00,$00,$00
        DB $10,$00,$67,$45,$AB,$89,$EF,$CD
        DB $00,$FF,$98,$BA,$54,$76,$10,$32
        ENDM

; ----

    ; OP 23
    TEST_CASE inc hl
AxDDA0: MACRO
        DB $F0,$FF,$FF,$FF,$FF,$FF,$00,$00
        DB $00,$00,$00,$00,$00,$00,$01,$00
        DB $20,$01,$67,$45,$AB,$89,$F0,$CD
        DB $D0,$FE,$98,$BA,$54,$76,$11,$32
        ENDM

    ; OP 24
    TEST_CASE inc h
AxDD80: MACRO
        DB $B0,$FF,$FF,$FF,$FF,$FF,$FF,$00
        DB $00,$00,$00,$00,$00,$00,$00,$01
        DB $00,$01,$67,$45,$AB,$89,$EF,$CE
        DB $10,$FE,$98,$BA,$54,$76,$10,$33
        ENDM

    ; OP 25
    TEST_CASE dec h
AxDD60: MACRO
        DB $50,$FF,$FF,$FF,$FF,$FF,$FF,$FE
        DB $60,$00,$00,$00,$00,$00,$00,$FF
        DB $40,$01,$67,$45,$AB,$89,$EF,$CC
        DB $50,$FE,$98,$BA,$54,$76,$10,$31
        ENDM

    ; OP 27
    TEST_CASE daa
AxDD40: MACRO
        DB $50,$99,$FF,$FF,$FF,$FF,$FF,$FF
        DB $80,$00,$00,$00,$00,$00,$00,$00
        DB $00,$07,$67,$45,$AB,$89,$EF,$CD
        DB $50,$9E,$98,$BA,$54,$76,$10,$32
        ENDM

    ; OP 29
    TEST_CASE add hl,hl
AxDD20: MACRO
        DB $B0,$FF,$FF,$FF,$FF,$FF,$FE,$FF
        DB $00,$00,$00,$00,$00,$00,$00,$00
        DB $30,$01,$67,$45,$AB,$89,$DE,$9B
        DB $80,$FE,$98,$BA,$54,$76,$20,$64
        ENDM

    ; OP 2B
    TEST_CASE dec hl
AxDD00: MACRO
        DB $F0,$FF,$FF,$FF,$FF,$FF,$FE,$FF
        DB $00,$00,$00,$00,$00,$00,$FF,$FF
        DB $20,$01,$67,$45,$AB,$89,$EE,$CD
        DB $D0,$FE,$98,$BA,$54,$76,$0F,$32
        ENDM

    ; OP 2C
    TEST_CASE inc l
AxDCE0: MACRO
        DB $B0,$FF,$FF,$FF,$FF,$FF,$00,$FF
        DB $00,$00,$00,$00,$00,$00,$01,$00
        DB $20,$01,$67,$45,$AB,$89,$F0,$CD
        DB $10,$FE,$98,$BA,$54,$76,$11,$32
        ENDM

    ; OP 2D
    TEST_CASE dec l
AxDCC0: MACRO
        DB $50,$FF,$FF,$FF,$FF,$FF,$FE,$FF
        DB $60,$00,$00,$00,$00,$00,$FF,$00
        DB $40,$01,$67,$45,$AB,$89,$EE,$CD
        DB $70,$FE,$98,$BA,$54,$76,$0F,$32
        ENDM

    ; OP 2F
    TEST_CASE cpl
AxDCA0: MACRO
        DB $F0,$00,$FF,$FF,$FF,$FF,$FF,$FF
        DB $60,$FF,$00,$00,$00,$00,$00,$00
        DB $60,$FE,$67,$45,$AB,$89,$EF,$CD
        DB $F0,$01,$98,$BA,$54,$76,$10,$32
        ENDM

; ----

    ; OP 37
    TEST_CASE scf
AxDC80: MACRO
        DB $90,$FF,$FF,$FF,$FF,$FF,$FF,$FF
        DB $10,$00,$00,$00,$00,$00,$00,$00
        DB $10,$01,$67,$45,$AB,$89,$EF,$CD
        DB $90,$FE,$98,$BA,$54,$76,$10,$32
        ENDM

    ; OP 39
    TEST_CASE add hl,sp
AxDC60: MACRO
        DB $B0,$FF,$FF,$FF,$FF,$FF,$67,$DC
        DB $00,$00,$00,$00,$00,$00,$70,$DC
        DB $30,$01,$67,$45,$AB,$89,$67,$AA
        DB $90,$FE,$98,$BA,$54,$76,$90,$0E
        ENDM

    ; OP 3C
    TEST_CASE inc a
AxDC40: MACRO
        DB $B0,$00,$FF,$FF,$FF,$FF,$FF,$FF
        DB $00,$01,$00,$00,$00,$00,$00,$00
        DB $00,$02,$67,$45,$AB,$89,$EF,$CD
        DB $10,$FF,$98,$BA,$54,$76,$10,$32
        ENDM

    ; OP 3D
    TEST_CASE dec a
AxDC20: MACRO
        DB $50,$FE,$FF,$FF,$FF,$FF,$FF,$FF
        DB $60,$FF,$00,$00,$00,$00,$00,$00
        DB $C0,$00,$67,$45,$AB,$89,$EF,$CD
        DB $50,$FD,$98,$BA,$54,$76,$10,$32
        ENDM

    ; OP 3F
    TEST_CASE ccf
AxDC00: MACRO
        DB $80,$FF,$FF,$FF,$FF,$FF,$FF,$FF
        DB $10,$00,$00,$00,$00,$00,$00,$00
        DB $10,$01,$67,$45,$AB,$89,$EF,$CD
        DB $80,$FE,$98,$BA,$54,$76,$10,$32
        ENDM

; ----

    ; OP 80
    TEST_CASE add a,b
AxDBE0: MACRO
        DB $30,$FE,$FF,$FF,$FF,$FF,$FF,$FF
        DB $80,$00,$00,$00,$00,$00,$00,$00
        DB $00,$46,$67,$45,$AB,$89,$EF,$CD
        DB $30,$B8,$98,$BA,$54,$76,$10,$32
        ENDM

    ; OP 81
    TEST_CASE add a,c
AxDBC0: MACRO
        DB $30,$FE,$FF,$FF,$FF,$FF,$FF,$FF
        DB $80,$00,$00,$00,$00,$00,$00,$00
        DB $00,$68,$67,$45,$AB,$89,$EF,$CD
        DB $30,$96,$98,$BA,$54,$76,$10,$32
        ENDM

    ; OP 82
    TEST_CASE add a,d
AxDBA0: MACRO
        DB $30,$FE,$FF,$FF,$FF,$FF,$FF,$FF
        DB $80,$00,$00,$00,$00,$00,$00,$00
        DB $00,$8A,$67,$45,$AB,$89,$EF,$CD
        DB $30,$74,$98,$BA,$54,$76,$10,$32
        ENDM

    ; OP 83
    TEST_CASE add a,e
AxDB80: MACRO
        DB $30,$FE,$FF,$FF,$FF,$FF,$FF,$FF
        DB $80,$00,$00,$00,$00,$00,$00,$00
        DB $00,$AC,$67,$45,$AB,$89,$EF,$CD
        DB $30,$52,$98,$BA,$54,$76,$10,$32
        ENDM

    ; OP 84
    TEST_CASE add a,h
AxDB60: MACRO
        DB $30,$FE,$FF,$FF,$FF,$FF,$FF,$FF
        DB $80,$00,$00,$00,$00,$00,$00,$00
        DB $00,$CE,$67,$45,$AB,$89,$EF,$CD
        DB $30,$30,$98,$BA,$54,$76,$10,$32
        ENDM

    ; OP 85
    TEST_CASE add a,l
AxDB40: MACRO
        DB $30,$FE,$FF,$FF,$FF,$FF,$FF,$FF
        DB $80,$00,$00,$00,$00,$00,$00,$00
        DB $20,$F0,$67,$45,$AB,$89,$EF,$CD
        DB $10,$0E,$98,$BA,$54,$76,$10,$32
        ENDM

    ; OP 87
    TEST_CASE add a,a
AxDB20: MACRO
        DB $30,$FE,$FF,$FF,$FF,$FF,$FF,$FF
        DB $80,$00,$00,$00,$00,$00,$00,$00
        DB $00,$02,$67,$45,$AB,$89,$EF,$CD
        DB $30,$FC,$98,$BA,$54,$76,$10,$32
        ENDM

    ; OP 88
    TEST_CASE adc a,b
AxDB00: MACRO
        DB $30,$FF,$FF,$FF,$FF,$FF,$FF,$FF
        DB $80,$00,$00,$00,$00,$00,$00,$00
        DB $00,$46,$67,$45,$AB,$89,$EF,$CD
        DB $30,$B9,$98,$BA,$54,$76,$10,$32
        ENDM

    ; OP 89
    TEST_CASE adc a,c
AxDAE0: MACRO
        DB $30,$FF,$FF,$FF,$FF,$FF,$FF,$FF
        DB $80,$00,$00,$00,$00,$00,$00,$00
        DB $00,$68,$67,$45,$AB,$89,$EF,$CD
        DB $30,$97,$98,$BA,$54,$76,$10,$32
        ENDM

    ; OP 8A
    TEST_CASE adc a,d
AxDAC0: MACRO
        DB $30,$FF,$FF,$FF,$FF,$FF,$FF,$FF
        DB $80,$00,$00,$00,$00,$00,$00,$00
        DB $00,$8A,$67,$45,$AB,$89,$EF,$CD
        DB $30,$75,$98,$BA,$54,$76,$10,$32
        ENDM

    ; OP 8B
    TEST_CASE adc a,e
AxDAA0: MACRO
        DB $30,$FF,$FF,$FF,$FF,$FF,$FF,$FF
        DB $80,$00,$00,$00,$00,$00,$00,$00
        DB $00,$AC,$67,$45,$AB,$89,$EF,$CD
        DB $30,$53,$98,$BA,$54,$76,$10,$32
        ENDM

    ; OP 8C
    TEST_CASE adc a,h
AxDA80: MACRO
        DB $30,$FF,$FF,$FF,$FF,$FF,$FF,$FF
        DB $80,$00,$00,$00,$00,$00,$00,$00
        DB $00,$CE,$67,$45,$AB,$89,$EF,$CD
        DB $30,$31,$98,$BA,$54,$76,$10,$32
        ENDM

    ; OP 8D
    TEST_CASE adc a,l
AxDA60: MACRO
        DB $30,$FF,$FF,$FF,$FF,$FF,$FF,$FF
        DB $80,$00,$00,$00,$00,$00,$00,$00
        DB $20,$F0,$67,$45,$AB,$89,$EF,$CD
        DB $10,$0F,$98,$BA,$54,$76,$10,$32
        ENDM

    ; OP 8F
    TEST_CASE adc a,a
AxDA40: MACRO
        DB $30,$FF,$FF,$FF,$FF,$FF,$FF,$FF
        DB $80,$00,$00,$00,$00,$00,$00,$00
        DB $00,$02,$67,$45,$AB,$89,$EF,$CD
        DB $30,$FD,$98,$BA,$54,$76,$10,$32
        ENDM

; ----

    ; OP 90
    TEST_CASE sub b
AxDA20: MACRO
        DB $C0,$00,$FF,$FF,$FF,$FF,$FF,$FF
        DB $C0,$00,$00,$00,$00,$00,$00,$00
        DB $70,$BC,$67,$45,$AB,$89,$EF,$CD
        DB $40,$44,$98,$BA,$54,$76,$10,$32
        ENDM

    ; OP 91
    TEST_CASE sub c
AxDA00: MACRO
        DB $C0,$00,$FF,$FF,$FF,$FF,$FF,$FF
        DB $C0,$00,$00,$00,$00,$00,$00,$00
        DB $70,$9A,$67,$45,$AB,$89,$EF,$CD
        DB $40,$66,$98,$BA,$54,$76,$10,$32
        ENDM

    ; OP 92
    TEST_CASE sub d
AxD9E0: MACRO
        DB $C0,$00,$FF,$FF,$FF,$FF,$FF,$FF
        DB $C0,$00,$00,$00,$00,$00,$00,$00
        DB $70,$78,$67,$45,$AB,$89,$EF,$CD
        DB $40,$88,$98,$BA,$54,$76,$10,$32
        ENDM

    ; OP 93
    TEST_CASE sub e
AxD9C0: MACRO
        DB $C0,$00,$FF,$FF,$FF,$FF,$FF,$FF
        DB $C0,$00,$00,$00,$00,$00,$00,$00
        DB $70,$56,$67,$45,$AB,$89,$EF,$CD
        DB $40,$AA,$98,$BA,$54,$76,$10,$32
        ENDM

    ; OP 94
    TEST_CASE sub h
AxD9A0: MACRO
        DB $C0,$00,$FF,$FF,$FF,$FF,$FF,$FF
        DB $C0,$00,$00,$00,$00,$00,$00,$00
        DB $70,$34,$67,$45,$AB,$89,$EF,$CD
        DB $40,$CC,$98,$BA,$54,$76,$10,$32
        ENDM

    ; OP 95
    TEST_CASE sub l
AxD980: MACRO
        DB $C0,$00,$FF,$FF,$FF,$FF,$FF,$FF
        DB $C0,$00,$00,$00,$00,$00,$00,$00
        DB $70,$12,$67,$45,$AB,$89,$EF,$CD
        DB $40,$EE,$98,$BA,$54,$76,$10,$32
        ENDM

    ; OP 97
    TEST_CASE sub a
AxD960: MACRO
        DB $C0,$00,$FF,$FF,$FF,$FF,$FF,$FF
        DB $C0,$00,$00,$00,$00,$00,$00,$00
        DB $C0,$00,$67,$45,$AB,$89,$EF,$CD
        DB $C0,$00,$98,$BA,$54,$76,$10,$32
        ENDM

    ; OP 98
    TEST_CASE sbc a,b
AxD940: MACRO
        DB $70,$FF,$FF,$FF,$FF,$FF,$FF,$FF
        DB $C0,$00,$00,$00,$00,$00,$00,$00
        DB $70,$BC,$67,$45,$AB,$89,$EF,$CD
        DB $40,$43,$98,$BA,$54,$76,$10,$32
        ENDM

    ; OP 99
    TEST_CASE sbc a,c
AxD920: MACRO
        DB $70,$FF,$FF,$FF,$FF,$FF,$FF,$FF
        DB $C0,$00,$00,$00,$00,$00,$00,$00
        DB $70,$9A,$67,$45,$AB,$89,$EF,$CD
        DB $40,$65,$98,$BA,$54,$76,$10,$32
        ENDM

    ; OP 9A
    TEST_CASE sbc a,d
AxD900: MACRO
        DB $70,$FF,$FF,$FF,$FF,$FF,$FF,$FF
        DB $C0,$00,$00,$00,$00,$00,$00,$00
        DB $70,$78,$67,$45,$AB,$89,$EF,$CD
        DB $40,$87,$98,$BA,$54,$76,$10,$32
        ENDM

    ; OP 9B
    TEST_CASE sbc a,e
AxD8E0: MACRO
        DB $70,$FF,$FF,$FF,$FF,$FF,$FF,$FF
        DB $C0,$00,$00,$00,$00,$00,$00,$00
        DB $70,$56,$67,$45,$AB,$89,$EF,$CD
        DB $40,$A9,$98,$BA,$54,$76,$10,$32
        ENDM

    ; OP 9C
    TEST_CASE sbc a,h
AxD8C0: MACRO
        DB $70,$FF,$FF,$FF,$FF,$FF,$FF,$FF
        DB $C0,$00,$00,$00,$00,$00,$00,$00
        DB $70,$34,$67,$45,$AB,$89,$EF,$CD
        DB $40,$CB,$98,$BA,$54,$76,$10,$32
        ENDM

    ; OP 9D
    TEST_CASE sbc a,l
AxD8A0: MACRO
        DB $70,$FF,$FF,$FF,$FF,$FF,$FF,$FF
        DB $C0,$00,$00,$00,$00,$00,$00,$00
        DB $70,$12,$67,$45,$AB,$89,$EF,$CD
        DB $40,$ED,$98,$BA,$54,$76,$10,$32
        ENDM

    ; OP 9F
    TEST_CASE sbc a,a
AxD880: MACRO
        DB $70,$FF,$FF,$FF,$FF,$FF,$FF,$FF
        DB $C0,$00,$00,$00,$00,$00,$00,$00
        DB $C0,$00,$67,$45,$AB,$89,$EF,$CD
        DB $70,$FF,$98,$BA,$54,$76,$10,$32
        ENDM

; ----

    ; OP A0
    TEST_CASE and b
AxD860: MACRO
        DB $20,$FF,$FF,$FF,$FF,$FF,$FF,$FF
        DB $A0,$00,$00,$00,$00,$00,$00,$00
        DB $20,$01,$67,$45,$AB,$89,$EF,$CD
        DB $20,$BA,$98,$BA,$54,$76,$10,$32
        ENDM

    ; OP A1
    TEST_CASE and c
AxD840: MACRO
        DB $20,$FF,$FF,$FF,$FF,$FF,$FF,$FF
        DB $A0,$00,$00,$00,$00,$00,$00,$00
        DB $20,$01,$67,$45,$AB,$89,$EF,$CD
        DB $20,$98,$98,$BA,$54,$76,$10,$32
        ENDM

    ; OP A2
    TEST_CASE and d
AxD820: MACRO
        DB $20,$FF,$FF,$FF,$FF,$FF,$FF,$FF
        DB $A0,$00,$00,$00,$00,$00,$00,$00
        DB $20,$01,$67,$45,$AB,$89,$EF,$CD
        DB $20,$76,$98,$BA,$54,$76,$10,$32
        ENDM

    ; OP A3
    TEST_CASE and e
AxD800: MACRO
        DB $20,$FF,$FF,$FF,$FF,$FF,$FF,$FF
        DB $A0,$00,$00,$00,$00,$00,$00,$00
        DB $20,$01,$67,$45,$AB,$89,$EF,$CD
        DB $20,$54,$98,$BA,$54,$76,$10,$32
        ENDM

    ; OP A4
    TEST_CASE and h
AxD7E0: MACRO
        DB $20,$FF,$FF,$FF,$FF,$FF,$FF,$FF
        DB $A0,$00,$00,$00,$00,$00,$00,$00
        DB $20,$01,$67,$45,$AB,$89,$EF,$CD
        DB $20,$32,$98,$BA,$54,$76,$10,$32
        ENDM

    ; OP A5
    TEST_CASE and l
AxD7C0: MACRO
        DB $20,$FF,$FF,$FF,$FF,$FF,$FF,$FF
        DB $A0,$00,$00,$00,$00,$00,$00,$00
        DB $20,$01,$67,$45,$AB,$89,$EF,$CD
        DB $20,$10,$98,$BA,$54,$76,$10,$32
        ENDM

    ; OP A7
    TEST_CASE and a
AxD7A0: MACRO
        DB $20,$FF,$FF,$FF,$FF,$FF,$FF,$FF
        DB $A0,$00,$00,$00,$00,$00,$00,$00
        DB $20,$01,$67,$45,$AB,$89,$EF,$CD
        DB $20,$FE,$98,$BA,$54,$76,$10,$32
        ENDM

    ; OP A8
    TEST_CASE xor b
AxD780: MACRO
        DB $80,$00,$FF,$FF,$FF,$FF,$FF,$FF
        DB $80,$00,$00,$00,$00,$00,$00,$00
        DB $00,$44,$67,$45,$AB,$89,$EF,$CD
        DB $00,$44,$98,$BA,$54,$76,$10,$32
        ENDM

    ; OP A9
    TEST_CASE xor c
AxD760: MACRO
        DB $80,$00,$FF,$FF,$FF,$FF,$FF,$FF
        DB $80,$00,$00,$00,$00,$00,$00,$00
        DB $00,$66,$67,$45,$AB,$89,$EF,$CD
        DB $00,$66,$98,$BA,$54,$76,$10,$32
        ENDM

    ; OP AA
    TEST_CASE xor d
AxD740: MACRO
        DB $80,$00,$FF,$FF,$FF,$FF,$FF,$FF
        DB $80,$00,$00,$00,$00,$00,$00,$00
        DB $00,$88,$67,$45,$AB,$89,$EF,$CD
        DB $00,$88,$98,$BA,$54,$76,$10,$32
        ENDM

    ; OP AB
    TEST_CASE xor e
AxD720: MACRO
        DB $80,$00,$FF,$FF,$FF,$FF,$FF,$FF
        DB $80,$00,$00,$00,$00,$00,$00,$00
        DB $00,$AA,$67,$45,$AB,$89,$EF,$CD
        DB $00,$AA,$98,$BA,$54,$76,$10,$32
        ENDM

    ; OP AC
    TEST_CASE xor h
AxD700: MACRO
        DB $80,$00,$FF,$FF,$FF,$FF,$FF,$FF
        DB $80,$00,$00,$00,$00,$00,$00,$00
        DB $00,$CC,$67,$45,$AB,$89,$EF,$CD
        DB $00,$CC,$98,$BA,$54,$76,$10,$32
        ENDM

    ; OP AD
    TEST_CASE xor l
AxD6E0: MACRO
        DB $80,$00,$FF,$FF,$FF,$FF,$FF,$FF
        DB $80,$00,$00,$00,$00,$00,$00,$00
        DB $00,$EE,$67,$45,$AB,$89,$EF,$CD
        DB $00,$EE,$98,$BA,$54,$76,$10,$32
        ENDM

    ; OP AF
    TEST_CASE xor a
AxD6C0: MACRO
        DB $80,$00,$FF,$FF,$FF,$FF,$FF,$FF
        DB $80,$00,$00,$00,$00,$00,$00,$00
        DB $80,$00,$67,$45,$AB,$89,$EF,$CD
        DB $80,$00,$98,$BA,$54,$76,$10,$32
        ENDM

; ----

    ; OP B0
    TEST_CASE or b
AxD6A0: MACRO
        DB $00,$FF,$FF,$FF,$FF,$FF,$FF,$FF
        DB $80,$00,$00,$00,$00,$00,$00,$00
        DB $00,$45,$67,$45,$AB,$89,$EF,$CD
        DB $00,$FE,$98,$BA,$54,$76,$10,$32
        ENDM

    ; OP B1
    TEST_CASE or c
AxD680: MACRO
        DB $00,$FF,$FF,$FF,$FF,$FF,$FF,$FF
        DB $80,$00,$00,$00,$00,$00,$00,$00
        DB $00,$67,$67,$45,$AB,$89,$EF,$CD
        DB $00,$FE,$98,$BA,$54,$76,$10,$32
        ENDM

    ; OP B2
    TEST_CASE or d
AxD660: MACRO
        DB $00,$FF,$FF,$FF,$FF,$FF,$FF,$FF
        DB $80,$00,$00,$00,$00,$00,$00,$00
        DB $00,$89,$67,$45,$AB,$89,$EF,$CD
        DB $00,$FE,$98,$BA,$54,$76,$10,$32
        ENDM

    ; OP B3
    TEST_CASE or e
AxD640: MACRO
        DB $00,$FF,$FF,$FF,$FF,$FF,$FF,$FF
        DB $80,$00,$00,$00,$00,$00,$00,$00
        DB $00,$AB,$67,$45,$AB,$89,$EF,$CD
        DB $00,$FE,$98,$BA,$54,$76,$10,$32
        ENDM

    ; OP B4
    TEST_CASE or h
AxD620: MACRO
        DB $00,$FF,$FF,$FF,$FF,$FF,$FF,$FF
        DB $80,$00,$00,$00,$00,$00,$00,$00
        DB $00,$CD,$67,$45,$AB,$89,$EF,$CD
        DB $00,$FE,$98,$BA,$54,$76,$10,$32
        ENDM

    ; OP B5
    TEST_CASE or l
AxD600: MACRO
        DB $00,$FF,$FF,$FF,$FF,$FF,$FF,$FF
        DB $80,$00,$00,$00,$00,$00,$00,$00
        DB $00,$EF,$67,$45,$AB,$89,$EF,$CD
        DB $00,$FE,$98,$BA,$54,$76,$10,$32
        ENDM

    ; OP B7
    TEST_CASE or a
AxD5E0: MACRO
        DB $00,$FF,$FF,$FF,$FF,$FF,$FF,$FF
        DB $80,$00,$00,$00,$00,$00,$00,$00
        DB $00,$01,$67,$45,$AB,$89,$EF,$CD
        DB $00,$FE,$98,$BA,$54,$76,$10,$32
        ENDM

    ; OP B8
    TEST_CASE cp b
AxD5C0: MACRO
        DB $C0,$FF,$FF,$FF,$FF,$FF,$FF,$FF
        DB $C0,$00,$00,$00,$00,$00,$00,$00
        DB $70,$01,$67,$45,$AB,$89,$EF,$CD
        DB $40,$FE,$98,$BA,$54,$76,$10,$32
        ENDM

    ; OP B9
    TEST_CASE cp c
AxD5A0: MACRO
        DB $C0,$FF,$FF,$FF,$FF,$FF,$FF,$FF
        DB $C0,$00,$00,$00,$00,$00,$00,$00
        DB $70,$01,$67,$45,$AB,$89,$EF,$CD
        DB $40,$FE,$98,$BA,$54,$76,$10,$32
        ENDM

    ; OP BA
    TEST_CASE cp d
AxD580: MACRO
        DB $C0,$FF,$FF,$FF,$FF,$FF,$FF,$FF
        DB $C0,$00,$00,$00,$00,$00,$00,$00
        DB $70,$01,$67,$45,$AB,$89,$EF,$CD
        DB $40,$FE,$98,$BA,$54,$76,$10,$32
        ENDM

    ; OP BB
    TEST_CASE cp e
AxD560: MACRO
        DB $C0,$FF,$FF,$FF,$FF,$FF,$FF,$FF
        DB $C0,$00,$00,$00,$00,$00,$00,$00
        DB $70,$01,$67,$45,$AB,$89,$EF,$CD
        DB $40,$FE,$98,$BA,$54,$76,$10,$32
        ENDM

    ; OP BC
    TEST_CASE cp h
AxD540: MACRO
        DB $C0,$FF,$FF,$FF,$FF,$FF,$FF,$FF
        DB $C0,$00,$00,$00,$00,$00,$00,$00
        DB $70,$01,$67,$45,$AB,$89,$EF,$CD
        DB $40,$FE,$98,$BA,$54,$76,$10,$32
        ENDM

    ; OP BD
    TEST_CASE cp l
AxD520: MACRO
        DB $C0,$FF,$FF,$FF,$FF,$FF,$FF,$FF
        DB $C0,$00,$00,$00,$00,$00,$00,$00
        DB $70,$01,$67,$45,$AB,$89,$EF,$CD
        DB $40,$FE,$98,$BA,$54,$76,$10,$32
        ENDM

    ; OP BF
    TEST_CASE cp a
AxD500: MACRO
        DB $C0,$FF,$FF,$FF,$FF,$FF,$FF,$FF
        DB $C0,$00,$00,$00,$00,$00,$00,$00
        DB $C0,$01,$67,$45,$AB,$89,$EF,$CD
        DB $C0,$FE,$98,$BA,$54,$76,$10,$32
        ENDM

; ----

    ; OP C6
    TEST_CASE add a,$9a
AxD4E0: MACRO
        DB $30,$99,$FF,$FF,$FF,$FF,$FF,$FF
        DB $00,$9A,$00,$00,$00,$00,$00,$00
        DB $00,$9B,$67,$45,$AB,$89,$EF,$CD
        DB $30,$98,$98,$BA,$54,$76,$10,$32
        ENDM

    ; OP CE
    TEST_CASE adc a,$9a
AxD4C0: MACRO
        DB $30,$9A,$FF,$FF,$FF,$FF,$FF,$FF
        DB $00,$9A,$00,$00,$00,$00,$00,$00
        DB $00,$9B,$67,$45,$AB,$89,$EF,$CD
        DB $30,$99,$98,$BA,$54,$76,$10,$32
        ENDM

    ; OP D6
    TEST_CASE sub $9a
AxD4A0: MACRO
        DB $40,$65,$FF,$FF,$FF,$FF,$FF,$FF
        DB $70,$66,$00,$00,$00,$00,$00,$00
        DB $70,$67,$67,$45,$AB,$89,$EF,$CD
        DB $40,$64,$98,$BA,$54,$76,$10,$32
        ENDM

    ; OP DE
    TEST_CASE sbc a,$9a
AxD480: MACRO
        DB $40,$64,$FF,$FF,$FF,$FF,$FF,$FF
        DB $70,$66,$00,$00,$00,$00,$00,$00
        DB $70,$67,$67,$45,$AB,$89,$EF,$CD
        DB $40,$63,$98,$BA,$54,$76,$10,$32
        ENDM

    ; OP E6
    TEST_CASE and $9a
AxD460: MACRO
        DB $20,$9A,$FF,$FF,$FF,$FF,$FF,$FF
        DB $A0,$00,$00,$00,$00,$00,$00,$00
        DB $A0,$00,$67,$45,$AB,$89,$EF,$CD
        DB $20,$9A,$98,$BA,$54,$76,$10,$32
        ENDM

    ; OP EE
    TEST_CASE xor $9a
AxD440: MACRO
        DB $00,$65,$FF,$FF,$FF,$FF,$FF,$FF
        DB $00,$9A,$00,$00,$00,$00,$00,$00
        DB $00,$9B,$67,$45,$AB,$89,$EF,$CD
        DB $00,$64,$98,$BA,$54,$76,$10,$32
        ENDM

    ; OP F6
    TEST_CASE or $9a
AxD420: MACRO
        DB $00,$FF,$FF,$FF,$FF,$FF,$FF,$FF
        DB $00,$9A,$00,$00,$00,$00,$00,$00
        DB $00,$9B,$67,$45,$AB,$89,$EF,$CD
        DB $00,$FE,$98,$BA,$54,$76,$10,$32
        ENDM

    ; OP FE
    TEST_CASE cp $9a
AxD400: MACRO
        DB $40,$FF,$FF,$FF,$FF,$FF,$FF,$FF
        DB $70,$00,$00,$00,$00,$00,$00,$00
        DB $70,$01,$67,$45,$AB,$89,$EF,$CD
        DB $40,$FE,$98,$BA,$54,$76,$10,$32
        ENDM

jp eof

SECTION "data", ROMX[$4000]
    AxD400
    AxD420
    AxD440
    AxD460
    AxD480
    AxD4A0
    AxD4C0
    AxD4E0
    AxD500
    AxD520
    AxD540
    AxD560
    AxD580
    AxD5A0
    AxD5C0
    AxD5E0
    AxD600
    AxD620
    AxD640
    AxD660
    AxD680
    AxD6A0
    AxD6C0
    AxD6E0
    AxD700
    AxD720
    AxD740
    AxD760
    AxD780
    AxD7A0
    AxD7C0
    AxD7E0
    AxD800
    AxD820
    AxD840
    AxD860
    AxD880
    AxD8A0
    AxD8C0
    AxD8E0
    AxD900
    AxD920
    AxD940
    AxD960
    AxD980
    AxD9A0
    AxD9C0
    AxD9E0
    AxDA00
    AxDA20
    AxDA40
    AxDA60
    AxDA80
    AxDAA0
    AxDAC0
    AxDAE0
    AxDB00
    AxDB20
    AxDB40
    AxDB60
    AxDB80
    AxDBA0
    AxDBC0
    AxDBE0
    AxDC00
    AxDC20
    AxDC40
    AxDC60
    AxDC80
    AxDCA0
    AxDCC0
    AxDCE0
    AxDD00
    AxDD20
    AxDD40
    AxDD60
    AxDD80
    AxDDA0
    AxDDC0
    AxDDE0
    AxDE00
    AxDE20
    AxDE40
    AxDE60
    AxDE80
    AxDEA0
    AxDEC0
    AxDEE0
    AxDF00
    AxDF20
    AxDF40
    AxDF60
    AxDF80
    AxDFA0
    AxDFC0
    AxDFE0


SECTION "eof", ROMX[$7ffd]
eof:
    jp eof
