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
        DB $F0,$FF,$FF,$00,$01,$00,$FF,$00
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

endloop:
    jp endloop

SECTION "data", ROMX[$4000]
    AxDF70
    AxDF80
    AxDF90
    AxDFA0
    AxDFB0
    AxDFC0
    AxDFD0
    AxDFE0
    AxDFF0
