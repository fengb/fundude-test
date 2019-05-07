DUMP: MACRO
      push hl
      push de
      push bc
      push af
      ENDM

RESET: MACRO
       ld hl, \1
       push hl
       pop af
       push hl
       pop bc
       push hl
       pop de
       ENDM

TEST_CASE: MACRO
           RESET 0
           \1
           DUMP

           RESET $ffff
           \1
           DUMP
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
AxDFF0: MACRO
        DB $F0,$FF,$00,$00,$FF,$FF,$FF,$FF
        DB $00,$00,$01,$00,$00,$00,$00,$00
        ENDM

    ; OP 04
    TEST_CASE inc b
AxDFE0: MACRO
        DB $B0,$FF,$FF,$00,$FF,$FF,$FF,$FF
        DB $00,$00,$00,$01,$00,$00,$00,$00
        ENDM

    ; OP 05
    TEST_CASE dec b
AxDFD0: MACRO
        DB $50,$FF,$FF,$FE,$FF,$FF,$FF,$FF
        DB $60,$00,$00,$FF,$00,$00,$00,$00
        ENDM

    ; OP 07
    TEST_CASE rlca
AxDFC0: MACRO
        DB $10,$FF,$FF,$FF,$FF,$FF,$FF,$FF
        DB $00,$00,$00,$00,$00,$00,$00,$00
        ENDM

    ; OP 09
    TEST_CASE add hl,bc
AxDFB0: MACRO
        DB $B0,$FF,$FF,$FF,$FF,$FF,$FE,$FF
        DB $00,$00,$00,$00,$00,$00,$00,$00
        ENDM

    ; OP 0B
    TEST_CASE dec bc
AxDFA0: MACRO
        DB $F0,$FF,$FE,$FF,$FF,$FF,$FF,$FF
        DB $00,$00,$FF,$FF,$00,$00,$00,$00
        ENDM

    ; OP 0C
    TEST_CASE inc c
AxDF90: MACRO
        DB $B0,$FF,$00,$FF,$FF,$FF,$FF,$FF
        DB $00,$00,$01,$00,$00,$00,$00,$00
        ENDM

    ; OP 0D
    TEST_CASE dec c
AxDF80: MACRO
        DB $50,$FF,$FE,$FF,$FF,$FF,$FF,$FF
        DB $60,$00,$FF,$00,$00,$00,$00,$00
        ENDM

    ; OP 0F
    TEST_CASE rrca
AxDF70: MACRO
        DB $10,$FF,$FF,$FF,$FF,$FF,$FF,$FF
        DB $00,$00,$00,$00,$00,$00,$00,$00
        ENDM

; ----

    ; OP 13
    TEST_CASE inc de
AxDF60: MACRO
        DB $F0,$FF,$FF,$FF,$00,$00,$FF,$FF
        DB $00,$00,$00,$00,$01,$00,$00,$00
        ENDM

    ; OP 14
    TEST_CASE inc d
AxDF50: MACRO
        DB $B0,$FF,$FF,$FF,$FF,$00,$FF,$FF
        DB $00,$00,$00,$00,$00,$01,$00,$00
        ENDM

    ; OP 15
    TEST_CASE dec d
AxDF40: MACRO
        DB $50,$FF,$FF,$FF,$FF,$FE,$FF,$FF
        DB $60,$00,$00,$00,$00,$FF,$00,$00
        ENDM

    ; OP 17
    TEST_CASE rla
AxDF30: MACRO
        DB $10,$FF,$FF,$FF,$FF,$FF,$FF,$FF
        DB $00,$00,$00,$00,$00,$00,$00,$00
        ENDM

    ; OP 19
    TEST_CASE add hl,de
AxDF20: MACRO
        DB $B0,$FF,$FF,$FF,$FF,$FF,$FE,$FF
        DB $00,$00,$00,$00,$00,$00,$00,$00
        ENDM

    ; OP 1B
    TEST_CASE dec de
AxDF10: MACRO
        DB $F0,$FF,$FF,$FF,$FE,$FF,$FF,$FF
        DB $00,$00,$00,$00,$FF,$FF,$00,$00
        ENDM

    ; OP 1C
    TEST_CASE inc e
AxDF00: MACRO
        DB $B0,$FF,$FF,$FF,$00,$FF,$FF,$FF
        DB $00,$00,$00,$00,$01,$00,$00,$00
        ENDM

    ; OP 1D
    TEST_CASE dec e
AxDEF0: MACRO
        DB $50,$FF,$FF,$FF,$FE,$FF,$FF,$FF
        DB $60,$00,$00,$00,$FF,$00,$00,$00
        ENDM

    ; OP 1F
    TEST_CASE rra
AxDEE0: MACRO
        DB $10,$FF,$FF,$FF,$FF,$FF,$FF,$FF
        DB $00,$00,$00,$00,$00,$00,$00,$00
        ENDM

; ----

    ; OP 23
    TEST_CASE inc hl
AxDED0: MACRO
        DB $F0,$FF,$FF,$FF,$FF,$FF,$00,$00
        DB $00,$00,$00,$00,$00,$00,$01,$00
        ENDM

    ; OP 24
    TEST_CASE inc h
AxDEC0: MACRO
        DB $B0,$FF,$FF,$FF,$FF,$FF,$FF,$00
        DB $00,$00,$00,$00,$00,$00,$00,$01
        ENDM

    ; OP 25
    TEST_CASE dec h
AxDEB0: MACRO
        DB $50,$FF,$FF,$FF,$FF,$FF,$FF,$FE
        DB $60,$00,$00,$00,$00,$00,$00,$FF
        ENDM

    ; OP 27
    TEST_CASE daa
AxDEA0: MACRO
        DB $50,$99,$FF,$FF,$FF,$FF,$FF,$FF
        DB $80,$00,$00,$00,$00,$00,$00,$00
        ENDM

    ; OP 29
    TEST_CASE add hl,hl
AxDE90: MACRO
        DB $B0,$FF,$FF,$FF,$FF,$FF,$FE,$FF
        DB $00,$00,$00,$00,$00,$00,$00,$00
        ENDM

    ; OP 2B
    TEST_CASE dec hl
AxDE80: MACRO
        DB $F0,$FF,$FF,$FF,$FF,$FF,$FE,$FF
        DB $00,$00,$00,$00,$00,$00,$FF,$FF
        ENDM

    ; OP 2C
    TEST_CASE inc l
AxDE70: MACRO
        DB $B0,$FF,$FF,$FF,$FF,$FF,$00,$FF
        DB $00,$00,$00,$00,$00,$00,$01,$00
        ENDM

    ; OP 2D
    TEST_CASE dec l
AxDE60: MACRO
        DB $50,$FF,$FF,$FF,$FF,$FF,$FE,$FF
        DB $60,$00,$00,$00,$00,$00,$FF,$00
        ENDM

    ; OP 2F
    TEST_CASE cpl
AxDE50: MACRO
        DB $F0,$00,$FF,$FF,$FF,$FF,$FF,$FF
        DB $60,$FF,$00,$00,$00,$00,$00,$00
        ENDM

; ----

    ; OP 37
    TEST_CASE scf
AxDE40: MACRO
        DB $90,$FF,$FF,$FF,$FF,$FF,$FF,$FF
        DB $10,$00,$00,$00,$00,$00,$00,$00
        ENDM

    ; OP 39
    ; TODO -- this is buggy and outputs 0x29 (add hl,hl)
    TEST_CASE add hl,sp
AxDE30: MACRO
        DB $B0,$FF,$FF,$FF,$FF,$FF,$FE,$FF
        DB $00,$00,$00,$00,$00,$00,$00,$00
        ENDM

    ; OP 3C
    TEST_CASE inc a
AxDE20: MACRO
        DB $B0,$00,$FF,$FF,$FF,$FF,$FF,$FF
        DB $00,$01,$00,$00,$00,$00,$00,$00
        ENDM

    ; OP 3D
    TEST_CASE dec a
AxDE10: MACRO
        DB $50,$FE,$FF,$FF,$FF,$FF,$FF,$FF
        DB $60,$FF,$00,$00,$00,$00,$00,$00
        ENDM

    ; OP 3F
    TEST_CASE ccf
AxDE00: MACRO
        DB $80,$FF,$FF,$FF,$FF,$FF,$FF,$FF
        DB $10,$00,$00,$00,$00,$00,$00,$00
        ENDM

; ----

    ; OP 80
    TEST_CASE add a,b
AxDDF0: MACRO
        DB $30,$FE,$FF,$FF,$FF,$FF,$FF,$FF
        DB $80,$00,$00,$00,$00,$00,$00,$00
        ENDM

    ; OP 81
    TEST_CASE add a,c
AxDDE0: MACRO
        DB $30,$FE,$FF,$FF,$FF,$FF,$FF,$FF
        DB $80,$00,$00,$00,$00,$00,$00,$00
        ENDM

    ; OP 82
    TEST_CASE add a,d
AxDDD0: MACRO
        DB $30,$FE,$FF,$FF,$FF,$FF,$FF,$FF
        DB $80,$00,$00,$00,$00,$00,$00,$00
        ENDM

    ; OP 83
    TEST_CASE add a,e
AxDDC0: MACRO
        DB $30,$FE,$FF,$FF,$FF,$FF,$FF,$FF
        DB $80,$00,$00,$00,$00,$00,$00,$00
        ENDM

    ; OP 84
    TEST_CASE add a,h
AxDDB0: MACRO
        DB $30,$FE,$FF,$FF,$FF,$FF,$FF,$FF
        DB $80,$00,$00,$00,$00,$00,$00,$00
        ENDM

    ; OP 85
    TEST_CASE add a,l
AxDDA0: MACRO
        DB $30,$FE,$FF,$FF,$FF,$FF,$FF,$FF
        DB $80,$00,$00,$00,$00,$00,$00,$00
        ENDM

    ; OP 87
    TEST_CASE add a,a
AxDD90: MACRO
        DB $30,$FE,$FF,$FF,$FF,$FF,$FF,$FF
        DB $80,$00,$00,$00,$00,$00,$00,$00
        ENDM

    ; OP 88
    TEST_CASE adc a,b
AxDD80: MACRO
        DB $30,$FF,$FF,$FF,$FF,$FF,$FF,$FF
        DB $80,$00,$00,$00,$00,$00,$00,$00
        ENDM

    ; OP 89
    TEST_CASE adc a,c
AxDD70: MACRO
        DB $30,$FF,$FF,$FF,$FF,$FF,$FF,$FF
        DB $80,$00,$00,$00,$00,$00,$00,$00
        ENDM

    ; OP 8A
    TEST_CASE adc a,d
AxDD60: MACRO
        DB $30,$FF,$FF,$FF,$FF,$FF,$FF,$FF
        DB $80,$00,$00,$00,$00,$00,$00,$00
        ENDM

    ; OP 8B
    TEST_CASE adc a,e
AxDD50: MACRO
        DB $30,$FF,$FF,$FF,$FF,$FF,$FF,$FF
        DB $80,$00,$00,$00,$00,$00,$00,$00
        ENDM

    ; OP 8C
    TEST_CASE adc a,h
AxDD40: MACRO
        DB $30,$FF,$FF,$FF,$FF,$FF,$FF,$FF
        DB $80,$00,$00,$00,$00,$00,$00,$00
        ENDM

    ; OP 8D
    TEST_CASE adc a,l
AxDD30: MACRO
        DB $30,$FF,$FF,$FF,$FF,$FF,$FF,$FF
        DB $80,$00,$00,$00,$00,$00,$00,$00
        ENDM

    ; OP 8F
    TEST_CASE adc a,a
AxDD20: MACRO
        DB $30,$FF,$FF,$FF,$FF,$FF,$FF,$FF
        DB $80,$00,$00,$00,$00,$00,$00,$00
        ENDM

; ----

    ; OP 90
    TEST_CASE sub b
AxDD10: MACRO
        DB $C0,$00,$FF,$FF,$FF,$FF,$FF,$FF
        DB $C0,$00,$00,$00,$00,$00,$00,$00
        ENDM

    ; OP 91
    TEST_CASE sub c
AxDD00: MACRO
        DB $C0,$00,$FF,$FF,$FF,$FF,$FF,$FF
        DB $C0,$00,$00,$00,$00,$00,$00,$00
        ENDM

    ; OP 92
    TEST_CASE sub d
AxDCF0: MACRO
        DB $C0,$00,$FF,$FF,$FF,$FF,$FF,$FF
        DB $C0,$00,$00,$00,$00,$00,$00,$00
        ENDM

    ; OP 93
    TEST_CASE sub e
AxDCE0: MACRO
        DB $C0,$00,$FF,$FF,$FF,$FF,$FF,$FF
        DB $C0,$00,$00,$00,$00,$00,$00,$00
        ENDM

    ; OP 94
    TEST_CASE sub h
AxDCD0: MACRO
        DB $C0,$00,$FF,$FF,$FF,$FF,$FF,$FF
        DB $C0,$00,$00,$00,$00,$00,$00,$00
        ENDM

    ; OP 95
    TEST_CASE sub l
AxDCC0: MACRO
        DB $C0,$00,$FF,$FF,$FF,$FF,$FF,$FF
        DB $C0,$00,$00,$00,$00,$00,$00,$00
        ENDM

    ; OP 97
    TEST_CASE sub a
AxDCB0: MACRO
        DB $C0,$00,$FF,$FF,$FF,$FF,$FF,$FF
        DB $C0,$00,$00,$00,$00,$00,$00,$00
        ENDM

    ; OP 98
    TEST_CASE sbc a,b
AxDCA0: MACRO
        DB $70,$FF,$FF,$FF,$FF,$FF,$FF,$FF
        DB $C0,$00,$00,$00,$00,$00,$00,$00
        ENDM

    ; OP 99
    TEST_CASE sbc a,c
AxDC90: MACRO
        DB $70,$FF,$FF,$FF,$FF,$FF,$FF,$FF
        DB $C0,$00,$00,$00,$00,$00,$00,$00
        ENDM

    ; OP 9A
    TEST_CASE sbc a,d
AxDC80: MACRO
        DB $70,$FF,$FF,$FF,$FF,$FF,$FF,$FF
        DB $C0,$00,$00,$00,$00,$00,$00,$00
        ENDM

    ; OP 9B
    TEST_CASE sbc a,e
AxDC70: MACRO
        DB $70,$FF,$FF,$FF,$FF,$FF,$FF,$FF
        DB $C0,$00,$00,$00,$00,$00,$00,$00
        ENDM

    ; OP 9C
    TEST_CASE sbc a,h
AxDC60: MACRO
        DB $70,$FF,$FF,$FF,$FF,$FF,$FF,$FF
        DB $C0,$00,$00,$00,$00,$00,$00,$00
        ENDM

    ; OP 9D
    TEST_CASE sbc a,l
AxDC50: MACRO
        DB $70,$FF,$FF,$FF,$FF,$FF,$FF,$FF
        DB $C0,$00,$00,$00,$00,$00,$00,$00
        ENDM

    ; OP 9F
    TEST_CASE sbc a,a
AxDC40: MACRO
        DB $70,$FF,$FF,$FF,$FF,$FF,$FF,$FF
        DB $C0,$00,$00,$00,$00,$00,$00,$00
        ENDM

; ----

    ; OP A0
    TEST_CASE and b
AxDC30: MACRO
        DB $20,$FF,$FF,$FF,$FF,$FF,$FF,$FF
        DB $A0,$00,$00,$00,$00,$00,$00,$00
        ENDM

    ; OP A1
    TEST_CASE and c
AxDC20: MACRO
        DB $20,$FF,$FF,$FF,$FF,$FF,$FF,$FF
        DB $A0,$00,$00,$00,$00,$00,$00,$00
        ENDM

    ; OP A2
    TEST_CASE and d
AxDC10: MACRO
        DB $20,$FF,$FF,$FF,$FF,$FF,$FF,$FF
        DB $A0,$00,$00,$00,$00,$00,$00,$00
        ENDM

    ; OP A3
    TEST_CASE and e
AxDC00: MACRO
        DB $20,$FF,$FF,$FF,$FF,$FF,$FF,$FF
        DB $A0,$00,$00,$00,$00,$00,$00,$00
        ENDM

    ; OP A4
    TEST_CASE and h
AxDBF0: MACRO
        DB $20,$FF,$FF,$FF,$FF,$FF,$FF,$FF
        DB $A0,$00,$00,$00,$00,$00,$00,$00
        ENDM

    ; OP A5
    TEST_CASE and l
AxDBE0: MACRO
        DB $20,$FF,$FF,$FF,$FF,$FF,$FF,$FF
        DB $A0,$00,$00,$00,$00,$00,$00,$00
        ENDM

    ; OP A7
    TEST_CASE and a
AxDBD0: MACRO
        DB $20,$FF,$FF,$FF,$FF,$FF,$FF,$FF
        DB $A0,$00,$00,$00,$00,$00,$00,$00
        ENDM

    ; OP A8
    TEST_CASE xor b
AxDBC0: MACRO
        DB $80,$00,$FF,$FF,$FF,$FF,$FF,$FF
        DB $80,$00,$00,$00,$00,$00,$00,$00
        ENDM

    ; OP A9
    TEST_CASE xor c
AxDBB0: MACRO
        DB $80,$00,$FF,$FF,$FF,$FF,$FF,$FF
        DB $80,$00,$00,$00,$00,$00,$00,$00
        ENDM

    ; OP AA
    TEST_CASE xor d
AxDBA0: MACRO
        DB $80,$00,$FF,$FF,$FF,$FF,$FF,$FF
        DB $80,$00,$00,$00,$00,$00,$00,$00
        ENDM

    ; OP AB
    TEST_CASE xor e
AxDB90: MACRO
        DB $80,$00,$FF,$FF,$FF,$FF,$FF,$FF
        DB $80,$00,$00,$00,$00,$00,$00,$00
        ENDM

    ; OP AC
    TEST_CASE xor h
AxDB80: MACRO
        DB $80,$00,$FF,$FF,$FF,$FF,$FF,$FF
        DB $80,$00,$00,$00,$00,$00,$00,$00
        ENDM

    ; OP AD
    TEST_CASE xor l
AxDB70: MACRO
        DB $80,$00,$FF,$FF,$FF,$FF,$FF,$FF
        DB $80,$00,$00,$00,$00,$00,$00,$00
        ENDM

    ; OP AF
    TEST_CASE xor a
AxDB60: MACRO
        DB $80,$00,$FF,$FF,$FF,$FF,$FF,$FF
        DB $80,$00,$00,$00,$00,$00,$00,$00
        ENDM

; ----

    ; OP B0
    TEST_CASE or b
AxDB50: MACRO
        DB $00,$FF,$FF,$FF,$FF,$FF,$FF,$FF
        DB $80,$00,$00,$00,$00,$00,$00,$00
        ENDM

    ; OP B1
    TEST_CASE or c
AxDB40: MACRO
        DB $00,$FF,$FF,$FF,$FF,$FF,$FF,$FF
        DB $80,$00,$00,$00,$00,$00,$00,$00
        ENDM

    ; OP B2
    TEST_CASE or d
AxDB30: MACRO
        DB $00,$FF,$FF,$FF,$FF,$FF,$FF,$FF
        DB $80,$00,$00,$00,$00,$00,$00,$00
        ENDM

    ; OP B3
    TEST_CASE or e
AxDB20: MACRO
        DB $00,$FF,$FF,$FF,$FF,$FF,$FF,$FF
        DB $80,$00,$00,$00,$00,$00,$00,$00
        ENDM

    ; OP B4
    TEST_CASE or h
AxDB10: MACRO
        DB $00,$FF,$FF,$FF,$FF,$FF,$FF,$FF
        DB $80,$00,$00,$00,$00,$00,$00,$00
        ENDM

    ; OP B5
    TEST_CASE or l
AxDB00: MACRO
        DB $00,$FF,$FF,$FF,$FF,$FF,$FF,$FF
        DB $80,$00,$00,$00,$00,$00,$00,$00
        ENDM

    ; OP B7
    TEST_CASE or a
AxDAF0: MACRO
        DB $00,$FF,$FF,$FF,$FF,$FF,$FF,$FF
        DB $80,$00,$00,$00,$00,$00,$00,$00
        ENDM

    ; OP B8
    TEST_CASE cp b
AxDAE0: MACRO
        DB $C0,$FF,$FF,$FF,$FF,$FF,$FF,$FF
        DB $C0,$00,$00,$00,$00,$00,$00,$00
        ENDM

    ; OP B9
    TEST_CASE cp c
AxDAD0: MACRO
        DB $C0,$FF,$FF,$FF,$FF,$FF,$FF,$FF
        DB $C0,$00,$00,$00,$00,$00,$00,$00
        ENDM

    ; OP BA
    TEST_CASE cp d
AxDAC0: MACRO
        DB $C0,$FF,$FF,$FF,$FF,$FF,$FF,$FF
        DB $C0,$00,$00,$00,$00,$00,$00,$00
        ENDM

    ; OP BB
    TEST_CASE cp e
AxDAB0: MACRO
        DB $C0,$FF,$FF,$FF,$FF,$FF,$FF,$FF
        DB $C0,$00,$00,$00,$00,$00,$00,$00
        ENDM

    ; OP BC
    TEST_CASE cp h
AxDAA0: MACRO
        DB $C0,$FF,$FF,$FF,$FF,$FF,$FF,$FF
        DB $C0,$00,$00,$00,$00,$00,$00,$00
        ENDM

    ; OP BD
    TEST_CASE cp l
AxDA90: MACRO
        DB $C0,$FF,$FF,$FF,$FF,$FF,$FF,$FF
        DB $C0,$00,$00,$00,$00,$00,$00,$00
        ENDM

    ; OP BF
    TEST_CASE cp a
AxDA80: MACRO
        DB $C0,$FF,$FF,$FF,$FF,$FF,$FF,$FF
        DB $C0,$00,$00,$00,$00,$00,$00,$00
        ENDM

; ----

    ; OP C6
    TEST_CASE add a,$9a
AxDA70: MACRO
        DB $30,$FE,$FF,$FF,$FF,$FF,$FF,$FF
        DB $80,$00,$00,$00,$00,$00,$00,$00
        ENDM

    ; OP CE
    TEST_CASE adc a,$9a
AxDA60: MACRO
        DB $30,$FF,$FF,$FF,$FF,$FF,$FF,$FF
        DB $80,$00,$00,$00,$00,$00,$00,$00
        ENDM

    ; OP D6
    TEST_CASE sub $9a
AxDA50: MACRO
        DB $40,$65,$FF,$FF,$FF,$FF,$FF,$FF
        DB $70,$66,$00,$00,$00,$00,$00,$00
        ENDM

    ; OP DE
    TEST_CASE sbc a,$9a
AxDA40: MACRO
        DB $70,$FF,$FF,$FF,$FF,$FF,$FF,$FF
        DB $C0,$00,$00,$00,$00,$00,$00,$00
        ENDM

    ; OP E6
    TEST_CASE and $9a
AxDA30: MACRO
        DB $20,$9A,$FF,$FF,$FF,$FF,$FF,$FF
        DB $A0,$00,$00,$00,$00,$00,$00,$00
        ENDM

    ; OP EE
    TEST_CASE xor $9a
AxDA20: MACRO
        DB $00,$65,$FF,$FF,$FF,$FF,$FF,$FF
        DB $00,$9A,$00,$00,$00,$00,$00,$00
        ENDM

    ; OP F6
    TEST_CASE or $9a
AxDA10: MACRO
        DB $00,$FF,$FF,$FF,$FF,$FF,$FF,$FF
        DB $00,$9A,$00,$00,$00,$00,$00,$00
        ENDM

    ; OP FE
    TEST_CASE cp $9a
AxDA00: MACRO
        DB $40,$FF,$FF,$FF,$FF,$FF,$FF,$FF
        DB $70,$00,$00,$00,$00,$00,$00,$00
        ENDM

jp eof

SECTION "data", ROMX[$4000]
    AxDA00
    AxDA10
    AxDA20
    AxDA30
    AxDA40
    AxDA50
    AxDA60
    AxDA70
    AxDA80
    AxDA90
    AxDAA0
    AxDAB0
    AxDAC0
    AxDAD0
    AxDAE0
    AxDAF0
    AxDB00
    AxDB10
    AxDB20
    AxDB30
    AxDB40
    AxDB50
    AxDB60
    AxDB70
    AxDB80
    AxDB90
    AxDBA0
    AxDBB0
    AxDBC0
    AxDBD0
    AxDBE0
    AxDBF0
    AxDC00
    AxDC10
    AxDC20
    AxDC30
    AxDC40
    AxDC50
    AxDC60
    AxDC70
    AxDC80
    AxDC90
    AxDCA0
    AxDCB0
    AxDCC0
    AxDCD0
    AxDCE0
    AxDCF0
    AxDD00
    AxDD10
    AxDD20
    AxDD30
    AxDD40
    AxDD50
    AxDD60
    AxDD70
    AxDD80
    AxDD90
    AxDDA0
    AxDDB0
    AxDDC0
    AxDDD0
    AxDDE0
    AxDDF0
    AxDE00
    AxDE10
    AxDE20
    AxDE30
    AxDE40
    AxDE50
    AxDE60
    AxDE70
    AxDE80
    AxDE90
    AxDEA0
    AxDEB0
    AxDEC0
    AxDED0
    AxDEE0
    AxDEF0
    AxDF00
    AxDF10
    AxDF20
    AxDF30
    AxDF40
    AxDF50
    AxDF60
    AxDF70
    AxDF80
    AxDF90
    AxDFA0
    AxDFB0
    AxDFC0
    AxDFD0
    AxDFE0
    AxDFF0

SECTION "eof", ROMX[$7ffd]
eof:
    jp eof
