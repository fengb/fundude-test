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

SECTION "main", HOME[$100]
    nop
    jp init

    ; $0104-$0133 (Nintendo logo - do _not_ modify the logo data here or the GB will not run the program)
    DB $CE,$ED,$66,$66,$CC,$0D,$00,$0B,$03,$73,$00,$83,$00,$0C,$00,$0D
    DB $00,$08,$11,$1F,$88,$89,$00,$0E,$DC,$CC,$6E,$E6,$DD,$DD,$D9,$99
    DB $BB,$BB,$67,$63,$6E,$0E,$EC,$CC,$DD,$DC,$99,$9F,$BB,$B9,$33,$3E


init:
    di
    ld sp, $e000

_x03: ; INC BC
; DFF8 <- 00 00 01 00 00 00 00 00
    RESET 0
    inc bc
    DUMP

; DFF8 <- F0 FF FF 00 01 00 FF 00
    RESET $ffff
    inc bc
    DUMP

_x04: ; INC B
; DFE8 <- 00 00 00 01 00 00 00 00
    RESET 0
    inc b
    DUMP

; DFE0 <- B0 FF FF 00 FF FF FF FF
    RESET $ffff
    inc b
    DUMP

_x05: ; DEC B
; DFD8 <- 60 00 00 FF 00 00 00 00
    RESET 0
    dec b
    DUMP

; DFD0 <- 50 FF FF FE FF FF FF FF
    RESET $ffff
    dec b
    DUMP

endloop:
    jp endloop
