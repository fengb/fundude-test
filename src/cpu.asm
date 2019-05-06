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

_x03: ; INC BC
    RESET 0
    inc bc
    DUMP ; DFF8 <- 00 00 01 00 00 00 00 00

    RESET $ffff
    inc bc
    DUMP ; DFF8 <- F0 FF FF 00 01 00 FF 00

_x04: ; INC B
    RESET 0
    inc b
    DUMP ; DFE8 <- 00 00 00 01 00 00 00 00

    RESET $ffff
    inc b
    DUMP ; DFE0 <- B0 FF FF 00 FF FF FF FF

_x05: ; DEC B
    RESET 0
    dec b
    DUMP ; DFD8 <- 60 00 00 FF 00 00 00 00

    RESET $ffff
    dec b
    DUMP ; DFD0 <- 50 FF FF FE FF FF FF FF

_x07: ; RLCA
    RESET 0
    rlca
    DUMP ; DFC8 <- 60 00 00 FF 00 00 00 00

    RESET $ffff
    rlca
    DUMP ; DFC0 <- 50 FF FF FE FF FF FF FF

_x09: ; ADD HL,BC
    RESET 0
    add hl,bc
    DUMP ; DFB8 <- 60 00 00 FF 00 00 00 00

    RESET $ffff
    add hl,bc
    DUMP ; DFB0 <- 50 FF FF FE FF FF FF FF

_x0B: ; DEC BC
    RESET 0
    dec bc
    DUMP ; DFA8 <- 60 00 00 FF 00 00 00 00

    RESET $ffff
    dec bc
    DUMP ; DFA0 <- 50 FF FF FE FF FF FF FF

_x0C: ; INC C
    RESET 0
    inc c
    DUMP ; DF98 <- 60 00 00 FF 00 00 00 00

    RESET $ffff
    inc c
    DUMP ; DF90 <- 50 FF FF FE FF FF FF FF

_x0D: ; DEC C
    RESET 0
    dec c
    DUMP ; DF88 <- 60 00 00 FF 00 00 00 00

    RESET $ffff
    dec b
    DUMP ; DF80 <- 50 FF FF FE FF FF FF FF

_x0F: ; RRCA
    RESET 0
    rrca
    DUMP ; DF88 <- 60 00 00 FF 00 00 00 00

    RESET $ffff
    rrca
    DUMP ; DF80 <- 50 FF FF FE FF FF FF FF

endloop:
    jp endloop
