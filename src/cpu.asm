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

    ; OP 03
    TEST_CASE inc bc
    ; DFF8 <- 00 00 01 00 00 00 00 00
    ; DFF0 <- F0 FF FF 00 01 00 FF 00

    ; OP 04
    TEST_CASE inc b
    ; DFE8 <- 00 00 00 01 00 00 00 00
    ; DFE0 <- B0 FF FF 00 FF FF FF FF

    ; OP 05
    TEST_CASE dec b
    ; DFD8 <- 60 00 00 FF 00 00 00 00
    ; DFD0 <- 50 FF FF FE FF FF FF FF

    ; OP 07
    TEST_CASE rlca
    ; DFC8 <- 60 00 00 FF 00 00 00 00
    ; DFC0 <- 50 FF FF FE FF FF FF FF

    ; OP 09
    TEST_CASE add hl,bc
    ; DFB8 <- 60 00 00 FF 00 00 00 00
    ; DFB0 <- 50 FF FF FE FF FF FF FF

    ; OP 0B
    TEST_CASE dec bc
    ; DFA8 <- 60 00 00 FF 00 00 00 00
    ; DFA0 <- 50 FF FF FE FF FF FF FF

    ; OP 0C
    TEST_CASE inc c
    ; DF98 <- 60 00 00 FF 00 00 00 00
    ; DF90 <- 50 FF FF FE FF FF FF FF

    ; OP 0D
    TEST_CASE dec c
    ; DF88 <- 60 00 00 FF 00 00 00 00
    ; DF80 <- 50 FF FF FE FF FF FF FF

    ; OP 0F
    TEST_CASE rrca
    ; DF88 <- 60 00 00 FF 00 00 00 00
    ; DF80 <- 50 FF FF FE FF FF FF FF

endloop:
    jp endloop
