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

endloop:
    jp endloop
