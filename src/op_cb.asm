SAVE: MACRO
      push hl
      push de
      push bc
      push af
      ENDM

; Need to save a few instructions so we opted to use LD BC, LD DE
RESET: MACRO
       ld hl, \1
       push hl
       pop af
       IF _NARG != 1
         ld bc, \2
       ELSE
         push hl
         pop bc
       ENDC
       IF _NARG != 1
         ld de, \3
       ELSE
         push hl
         pop de
       ENDC
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

; ====================================================================

    ; CB 00
    TEST_CASE rlc b
_DFE0_DFFF: MACRO
        DB $10,$FF,$FF,$FF,$FF,$FF,$FF,$FF
        DB $80,$00,$00,$00,$00,$00,$00,$00
        DB $00,$01,$67,$8A,$AB,$89,$EF,$CD
        DB $10,$FE,$98,$75,$54,$76,$10,$32
        ENDM

    ; CB 01
    TEST_CASE rlc c
_DFC0_DFDF: MACRO
        DB $10,$FF,$FF,$FF,$FF,$FF,$FF,$FF
        DB $80,$00,$00,$00,$00,$00,$00,$00
        DB $00,$01,$CE,$45,$AB,$89,$EF,$CD
        DB $10,$FE,$31,$BA,$54,$76,$10,$32
        ENDM

    ; CB 02
    TEST_CASE rlc d
_DFA0_DFBF: MACRO
        DB $10,$FF,$FF,$FF,$FF,$FF,$FF,$FF
        DB $80,$00,$00,$00,$00,$00,$00,$00
        DB $10,$01,$67,$45,$AB,$13,$EF,$CD
        DB $00,$FE,$98,$BA,$54,$EC,$10,$32
        ENDM

    ; CB 03
    TEST_CASE rlc e
_DF80_DF9F: MACRO
        DB $10,$FF,$FF,$FF,$FF,$FF,$FF,$FF
        DB $80,$00,$00,$00,$00,$00,$00,$00
        DB $10,$01,$67,$45,$57,$89,$EF,$CD
        DB $00,$FE,$98,$BA,$A8,$76,$10,$32
        ENDM

    ; CB 04
    TEST_CASE rlc h
_DF60_DF7F: MACRO
        DB $10,$FF,$FF,$FF,$FF,$FF,$FF,$FF
        DB $80,$00,$00,$00,$00,$00,$00,$00
        DB $10,$01,$67,$45,$AB,$89,$EF,$9B
        DB $00,$FE,$98,$BA,$54,$76,$10,$64
        ENDM

    ; CB 05
    TEST_CASE rlc l
_DF40_DF5F: MACRO
        DB $10,$FF,$FF,$FF,$FF,$FF,$FF,$FF
        DB $80,$00,$00,$00,$00,$00,$00,$00
        DB $10,$01,$67,$45,$AB,$89,$DF,$CD
        DB $00,$FE,$98,$BA,$54,$76,$20,$32
        ENDM

    ; CB 07
    TEST_CASE rlc a
_DF20_DF3F: MACRO
        DB $10,$FF,$FF,$FF,$FF,$FF,$FF,$FF
        DB $80,$00,$00,$00,$00,$00,$00,$00
        DB $00,$02,$67,$45,$AB,$89,$EF,$CD
        DB $10,$FD,$98,$BA,$54,$76,$10,$32
        ENDM

    ; CB 08
    TEST_CASE rrc b
_DF00_DF1F: MACRO
        DB $10,$FF,$FF,$FF,$FF,$FF,$FF,$FF
        DB $80,$00,$00,$00,$00,$00,$00,$00
        DB $10,$01,$67,$A2,$AB,$89,$EF,$CD
        DB $00,$FE,$98,$5D,$54,$76,$10,$32
        ENDM

    ; CB 09
    TEST_CASE rrc c
_DEE0_DEFF: MACRO
        DB $10,$FF,$FF,$FF,$FF,$FF,$FF,$FF
        DB $80,$00,$00,$00,$00,$00,$00,$00
        DB $10,$01,$B3,$45,$AB,$89,$EF,$CD
        DB $00,$FE,$4C,$BA,$54,$76,$10,$32
        ENDM

    ; CB 0A
    TEST_CASE rrc d
_DEC0_DEDF: MACRO
        DB $10,$FF,$FF,$FF,$FF,$FF,$FF,$FF
        DB $80,$00,$00,$00,$00,$00,$00,$00
        DB $10,$01,$67,$45,$AB,$C4,$EF,$CD
        DB $00,$FE,$98,$BA,$54,$3B,$10,$32
        ENDM

    ; CB 0B
    TEST_CASE rrc e
_DEA0_DEBF: MACRO
        DB $10,$FF,$FF,$FF,$FF,$FF,$FF,$FF
        DB $80,$00,$00,$00,$00,$00,$00,$00
        DB $10,$01,$67,$45,$D5,$89,$EF,$CD
        DB $00,$FE,$98,$BA,$2A,$76,$10,$32
        ENDM

    ; CB 0C
    TEST_CASE rrc h
_DE80_DE9F: MACRO
        DB $10,$FF,$FF,$FF,$FF,$FF,$FF,$FF
        DB $80,$00,$00,$00,$00,$00,$00,$00
        DB $10,$01,$67,$45,$AB,$89,$EF,$E6
        DB $00,$FE,$98,$BA,$54,$76,$10,$19
        ENDM

    ; CB 0D
    TEST_CASE rrc l
_DE60_DE7F: MACRO
        DB $10,$FF,$FF,$FF,$FF,$FF,$FF,$FF
        DB $80,$00,$00,$00,$00,$00,$00,$00
        DB $10,$01,$67,$45,$AB,$89,$F7,$CD
        DB $00,$FE,$98,$BA,$54,$76,$08,$32
        ENDM

    ; CB 0F

; --------------------------------------------------------------------

    TEST_CASE rrc a
_DE40_DE5F: MACRO
        DB $10,$FF,$FF,$FF,$FF,$FF,$FF,$FF
        DB $80,$00,$00,$00,$00,$00,$00,$00
        DB $10,$80,$67,$45,$AB,$89,$EF,$CD
        DB $00,$7F,$98,$BA,$54,$76,$10,$32
        ENDM

    ; CB 10
    TEST_CASE rl b
_DE20_DE3F: MACRO
        DB $10,$FF,$FF,$FF,$FF,$FF,$FF,$FF
        DB $80,$00,$00,$00,$00,$00,$00,$00
        DB $00,$01,$67,$8A,$AB,$89,$EF,$CD
        DB $10,$FE,$98,$75,$54,$76,$10,$32
        ENDM

    ; CB 11
    TEST_CASE rl c
_DE00_DE1F: MACRO
        DB $10,$FF,$FF,$FF,$FF,$FF,$FF,$FF
        DB $80,$00,$00,$00,$00,$00,$00,$00
        DB $00,$01,$CE,$45,$AB,$89,$EF,$CD
        DB $10,$FE,$31,$BA,$54,$76,$10,$32
        ENDM

    ; CB 12
    TEST_CASE rl d
_DDE0_DDFF: MACRO
        DB $10,$FF,$FF,$FF,$FF,$FF,$FF,$FF
        DB $80,$00,$00,$00,$00,$00,$00,$00
        DB $10,$01,$67,$45,$AB,$12,$EF,$CD
        DB $00,$FE,$98,$BA,$54,$ED,$10,$32
        ENDM

    ; CB 13
    TEST_CASE rl e
_DDC0_DDDF: MACRO
        DB $10,$FF,$FF,$FF,$FF,$FF,$FF,$FF
        DB $80,$00,$00,$00,$00,$00,$00,$00
        DB $10,$01,$67,$45,$56,$89,$EF,$CD
        DB $00,$FE,$98,$BA,$A9,$76,$10,$32
        ENDM

    ; CB 14
    TEST_CASE rl h
_DDA0_DDBF: MACRO
        DB $10,$FF,$FF,$FF,$FF,$FF,$FF,$FF
        DB $80,$00,$00,$00,$00,$00,$00,$00
        DB $10,$01,$67,$45,$AB,$89,$EF,$9A
        DB $00,$FE,$98,$BA,$54,$76,$10,$65
        ENDM

    ; CB 15
    TEST_CASE rl l
_DD80_DD9F: MACRO
        DB $10,$FF,$FF,$FF,$FF,$FF,$FF,$FF
        DB $80,$00,$00,$00,$00,$00,$00,$00
        DB $10,$01,$67,$45,$AB,$89,$DE,$CD
        DB $00,$FE,$98,$BA,$54,$76,$21,$32
        ENDM

    ; CB 17
    TEST_CASE rl a
_DD60_DD7F: MACRO
        DB $10,$FF,$FF,$FF,$FF,$FF,$FF,$FF
        DB $80,$00,$00,$00,$00,$00,$00,$00
        DB $00,$02,$67,$45,$AB,$89,$EF,$CD
        DB $10,$FD,$98,$BA,$54,$76,$10,$32
        ENDM

    ; CB 18
    TEST_CASE rr b
_DD40_DD5F: MACRO
        DB $10,$FF,$FF,$FF,$FF,$FF,$FF,$FF
        DB $80,$00,$00,$00,$00,$00,$00,$00
        DB $10,$01,$67,$22,$AB,$89,$EF,$CD
        DB $00,$FE,$98,$DD,$54,$76,$10,$32
        ENDM

    ; CB 19
    TEST_CASE rr c
_DD20_DD3F: MACRO
        DB $10,$FF,$FF,$FF,$FF,$FF,$FF,$FF
        DB $80,$00,$00,$00,$00,$00,$00,$00
        DB $10,$01,$33,$45,$AB,$89,$EF,$CD
        DB $00,$FE,$CC,$BA,$54,$76,$10,$32
        ENDM

    ; CB 1A
    TEST_CASE rr d
_DD00_DD1F: MACRO
        DB $10,$FF,$FF,$FF,$FF,$FF,$FF,$FF
        DB $80,$00,$00,$00,$00,$00,$00,$00
        DB $10,$01,$67,$45,$AB,$44,$EF,$CD
        DB $00,$FE,$98,$BA,$54,$BB,$10,$32
        ENDM

    ; CB 1B
    TEST_CASE rr e
_DCE0_DCFF: MACRO
        DB $10,$FF,$FF,$FF,$FF,$FF,$FF,$FF
        DB $80,$00,$00,$00,$00,$00,$00,$00
        DB $10,$01,$67,$45,$55,$89,$EF,$CD
        DB $00,$FE,$98,$BA,$AA,$76,$10,$32
        ENDM

    ; CB 1C
    TEST_CASE rr h
_DCC0_DCDF: MACRO
        DB $10,$FF,$FF,$FF,$FF,$FF,$FF,$FF
        DB $80,$00,$00,$00,$00,$00,$00,$00
        DB $10,$01,$67,$45,$AB,$89,$EF,$66
        DB $00,$FE,$98,$BA,$54,$76,$10,$99
        ENDM

    ; CB 1D
    TEST_CASE rr l
_DCA0_DCBF: MACRO
        DB $10,$FF,$FF,$FF,$FF,$FF,$FF,$FF
        DB $80,$00,$00,$00,$00,$00,$00,$00
        DB $10,$01,$67,$45,$AB,$89,$77,$CD
        DB $00,$FE,$98,$BA,$54,$76,$88,$32
        ENDM

    ; CB 1F

; --------------------------------------------------------------------

    TEST_CASE rr a
_DC80_DC9F: MACRO
        DB $10,$FF,$FF,$FF,$FF,$FF,$FF,$FF
        DB $80,$00,$00,$00,$00,$00,$00,$00
        DB $90,$00,$67,$45,$AB,$89,$EF,$CD
        DB $00,$FF,$98,$BA,$54,$76,$10,$32
        ENDM

    ; CB 20
    TEST_CASE sla b
_DC60_DC7F: MACRO
        DB $10,$FF,$FF,$FE,$FF,$FF,$FF,$FF
        DB $80,$00,$00,$00,$00,$00,$00,$00
        DB $00,$01,$67,$8A,$AB,$89,$EF,$CD
        DB $10,$FE,$98,$74,$54,$76,$10,$32
        ENDM

    ; CB 21
    TEST_CASE sla c
_DC40_DC5F: MACRO
        DB $10,$FF,$FE,$FF,$FF,$FF,$FF,$FF
        DB $80,$00,$00,$00,$00,$00,$00,$00
        DB $00,$01,$CE,$45,$AB,$89,$EF,$CD
        DB $10,$FE,$30,$BA,$54,$76,$10,$32
        ENDM

    ; CB 22
    TEST_CASE sla d
_DC20_DC3F: MACRO
        DB $10,$FF,$FF,$FF,$FF,$FE,$FF,$FF
        DB $80,$00,$00,$00,$00,$00,$00,$00
        DB $10,$01,$67,$45,$AB,$12,$EF,$CD
        DB $00,$FE,$98,$BA,$54,$EC,$10,$32
        ENDM

    ; CB 23
    TEST_CASE sla e
_DC00_DC1F: MACRO
        DB $10,$FF,$FF,$FF,$FE,$FF,$FF,$FF
        DB $80,$00,$00,$00,$00,$00,$00,$00
        DB $10,$01,$67,$45,$56,$89,$EF,$CD
        DB $00,$FE,$98,$BA,$A8,$76,$10,$32
        ENDM

    ; CB 24
    TEST_CASE sla h
_DBE0_DBFF: MACRO
        DB $10,$FF,$FF,$FF,$FF,$FF,$FF,$FE
        DB $80,$00,$00,$00,$00,$00,$00,$00
        DB $10,$01,$67,$45,$AB,$89,$EF,$9A
        DB $00,$FE,$98,$BA,$54,$76,$10,$64
        ENDM

    ; CB 25
    TEST_CASE sla l
_DBC0_DBDF: MACRO
        DB $10,$FF,$FF,$FF,$FF,$FF,$FE,$FF
        DB $80,$00,$00,$00,$00,$00,$00,$00
        DB $10,$01,$67,$45,$AB,$89,$DE,$CD
        DB $00,$FE,$98,$BA,$54,$76,$20,$32
        ENDM

    ; CB 27
    TEST_CASE sla a
_DBA0_DBBF: MACRO
        DB $10,$FE,$FF,$FF,$FF,$FF,$FF,$FF
        DB $80,$00,$00,$00,$00,$00,$00,$00
        DB $00,$02,$67,$45,$AB,$89,$EF,$CD
        DB $10,$FC,$98,$BA,$54,$76,$10,$32
        ENDM

    ; CB 28
    TEST_CASE sra b
_DB80_DB9F: MACRO
        DB $10,$FF,$FF,$FF,$FF,$FF,$FF,$FF
        DB $80,$00,$00,$00,$00,$00,$00,$00
        DB $10,$01,$67,$22,$AB,$89,$EF,$CD
        DB $00,$FE,$98,$DD,$54,$76,$10,$32
        ENDM

    ; CB 29
    TEST_CASE sra c
_DB60_DB7F: MACRO
        DB $10,$FF,$FF,$FF,$FF,$FF,$FF,$FF
        DB $80,$00,$00,$00,$00,$00,$00,$00
        DB $10,$01,$33,$45,$AB,$89,$EF,$CD
        DB $00,$FE,$CC,$BA,$54,$76,$10,$32
        ENDM

    ; CB 2A
    TEST_CASE sra d
_DB40_DB5F: MACRO
        DB $10,$FF,$FF,$FF,$FF,$FF,$FF,$FF
        DB $80,$00,$00,$00,$00,$00,$00,$00
        DB $10,$01,$67,$45,$AB,$C4,$EF,$CD
        DB $00,$FE,$98,$BA,$54,$3B,$10,$32
        ENDM

    ; CB 2B
    TEST_CASE sra e
_DB20_DB3F: MACRO
        DB $10,$FF,$FF,$FF,$FF,$FF,$FF,$FF
        DB $80,$00,$00,$00,$00,$00,$00,$00
        DB $10,$01,$67,$45,$D5,$89,$EF,$CD
        DB $00,$FE,$98,$BA,$2A,$76,$10,$32
        ENDM

    ; CB 2C
    TEST_CASE sra h
_DB00_DB1F: MACRO
        DB $10,$FF,$FF,$FF,$FF,$FF,$FF,$FF
        DB $80,$00,$00,$00,$00,$00,$00,$00
        DB $10,$01,$67,$45,$AB,$89,$EF,$E6
        DB $00,$FE,$98,$BA,$54,$76,$10,$19
        ENDM

    ; CB 2D
    TEST_CASE sra l
_DAE0_DAFF: MACRO
        DB $10,$FF,$FF,$FF,$FF,$FF,$FF,$FF
        DB $80,$00,$00,$00,$00,$00,$00,$00
        DB $10,$01,$67,$45,$AB,$89,$F7,$CD
        DB $00,$FE,$98,$BA,$54,$76,$08,$32
        ENDM

    ; CB 2F
    TEST_CASE sra a
_DAC0_DADF: MACRO
        DB $10,$FF,$FF,$FF,$FF,$FF,$FF,$FF
        DB $80,$00,$00,$00,$00,$00,$00,$00
        DB $90,$00,$67,$45,$AB,$89,$EF,$CD
        DB $00,$FF,$98,$BA,$54,$76,$10,$32
        ENDM


; --------------------------------------------------------------------

    ; CB 30
    TEST_CASE swap b
_DAA0_DABF: MACRO
        DB $00,$FF,$FF,$FF,$FF,$FF,$FF,$FF
        DB $80,$00,$00,$00,$00,$00,$00,$00
        DB $00,$01,$67,$54,$AB,$89,$EF,$CD
        DB $00,$FE,$98,$AB,$54,$76,$10,$32
        ENDM

    ; CB 31
    TEST_CASE swap c
_DA80_DA9F: MACRO
        DB $00,$FF,$FF,$FF,$FF,$FF,$FF,$FF
        DB $80,$00,$00,$00,$00,$00,$00,$00
        DB $00,$01,$76,$45,$AB,$89,$EF,$CD
        DB $00,$FE,$89,$BA,$54,$76,$10,$32
        ENDM

    ; CB 32
    TEST_CASE swap d
_DA60_DA7F: MACRO
        DB $00,$FF,$FF,$FF,$FF,$FF,$FF,$FF
        DB $80,$00,$00,$00,$00,$00,$00,$00
        DB $00,$01,$67,$45,$AB,$98,$EF,$CD
        DB $00,$FE,$98,$BA,$54,$67,$10,$32
        ENDM

    ; CB 33
    TEST_CASE swap e
_DA40_DA5F: MACRO
        DB $00,$FF,$FF,$FF,$FF,$FF,$FF,$FF
        DB $80,$00,$00,$00,$00,$00,$00,$00
        DB $00,$01,$67,$45,$BA,$89,$EF,$CD
        DB $00,$FE,$98,$BA,$45,$76,$10,$32
        ENDM

    ; CB 34
    TEST_CASE swap h
_DA20_DA3F: MACRO
        DB $00,$FF,$FF,$FF,$FF,$FF,$FF,$FF
        DB $80,$00,$00,$00,$00,$00,$00,$00
        DB $00,$01,$67,$45,$AB,$89,$EF,$DC
        DB $00,$FE,$98,$BA,$54,$76,$10,$23
        ENDM

    ; CB 35
    TEST_CASE swap l
_DA00_DA1F: MACRO
        DB $00,$FF,$FF,$FF,$FF,$FF,$FF,$FF
        DB $80,$00,$00,$00,$00,$00,$00,$00
        DB $00,$01,$67,$45,$AB,$89,$FE,$CD
        DB $00,$FE,$98,$BA,$54,$76,$01,$32
        ENDM

    ; CB 37
    TEST_CASE swap a
_D9E0_D9FF: MACRO
        DB $00,$FF,$FF,$FF,$FF,$FF,$FF,$FF
        DB $80,$00,$00,$00,$00,$00,$00,$00
        DB $00,$10,$67,$45,$AB,$89,$EF,$CD
        DB $00,$EF,$98,$BA,$54,$76,$10,$32
        ENDM

    ; CB 38
    TEST_CASE srl b
_D9C0_D9DF: MACRO
        DB $10,$FF,$FF,$7F,$FF,$FF,$FF,$FF
        DB $80,$00,$00,$00,$00,$00,$00,$00
        DB $10,$01,$67,$22,$AB,$89,$EF,$CD
        DB $00,$FE,$98,$5D,$54,$76,$10,$32
        ENDM

    ; CB 39
    TEST_CASE srl c
_D9A0_D9BF: MACRO
        DB $10,$FF,$7F,$FF,$FF,$FF,$FF,$FF
        DB $80,$00,$00,$00,$00,$00,$00,$00
        DB $10,$01,$33,$45,$AB,$89,$EF,$CD
        DB $00,$FE,$4C,$BA,$54,$76,$10,$32
        ENDM

    ; CB 3A
    TEST_CASE srl d
_D980_D99F: MACRO
        DB $10,$FF,$FF,$FF,$FF,$7F,$FF,$FF
        DB $80,$00,$00,$00,$00,$00,$00,$00
        DB $10,$01,$67,$45,$AB,$44,$EF,$CD
        DB $00,$FE,$98,$BA,$54,$3B,$10,$32
        ENDM

    ; CB 3B
    TEST_CASE srl e
_D960_D97F: MACRO
        DB $10,$FF,$FF,$FF,$7F,$FF,$FF,$FF
        DB $80,$00,$00,$00,$00,$00,$00,$00
        DB $10,$01,$67,$45,$55,$89,$EF,$CD
        DB $00,$FE,$98,$BA,$2A,$76,$10,$32
        ENDM

    ; CB 3C
    TEST_CASE srl h
_D940_D95F: MACRO
        DB $10,$FF,$FF,$FF,$FF,$FF,$FF,$7F
        DB $80,$00,$00,$00,$00,$00,$00,$00
        DB $10,$01,$67,$45,$AB,$89,$EF,$66
        DB $00,$FE,$98,$BA,$54,$76,$10,$19
        ENDM

    ; CB 3D
    TEST_CASE srl l
_D920_D93F: MACRO
        DB $10,$FF,$FF,$FF,$FF,$FF,$7F,$FF
        DB $80,$00,$00,$00,$00,$00,$00,$00
        DB $10,$01,$67,$45,$AB,$89,$77,$CD
        DB $00,$FE,$98,$BA,$54,$76,$08,$32
        ENDM

    ; CB 3F
    TEST_CASE srl a
_D900_D91F: MACRO
        DB $10,$7F,$FF,$FF,$FF,$FF,$FF,$FF
        DB $80,$00,$00,$00,$00,$00,$00,$00
        DB $90,$00,$67,$45,$AB,$89,$EF,$CD
        DB $00,$7F,$98,$BA,$54,$76,$10,$32
        ENDM


; ====================================================================

    ; CB 40
    TEST_CASE bit 0,b
_D8E0_D8FF: MACRO
        DB $30,$FF,$FF,$FF,$FF,$FF,$FF,$FF
        DB $A0,$00,$00,$00,$00,$00,$00,$00
        DB $20,$01,$67,$45,$AB,$89,$EF,$CD
        DB $B0,$FE,$98,$BA,$54,$76,$10,$32
        ENDM

    ; CB 41
    TEST_CASE bit 0,c
_D8C0_D8DF: MACRO
        DB $30,$FF,$FF,$FF,$FF,$FF,$FF,$FF
        DB $A0,$00,$00,$00,$00,$00,$00,$00
        DB $20,$01,$67,$45,$AB,$89,$EF,$CD
        DB $B0,$FE,$98,$BA,$54,$76,$10,$32
        ENDM

    ; CB 42
    TEST_CASE bit 0,d
_D8A0_D8BF: MACRO
        DB $30,$FF,$FF,$FF,$FF,$FF,$FF,$FF
        DB $A0,$00,$00,$00,$00,$00,$00,$00
        DB $20,$01,$67,$45,$AB,$89,$EF,$CD
        DB $B0,$FE,$98,$BA,$54,$76,$10,$32
        ENDM

    ; CB 43
    TEST_CASE bit 0,e
_D880_D89F: MACRO
        DB $30,$FF,$FF,$FF,$FF,$FF,$FF,$FF
        DB $A0,$00,$00,$00,$00,$00,$00,$00
        DB $20,$01,$67,$45,$AB,$89,$EF,$CD
        DB $B0,$FE,$98,$BA,$54,$76,$10,$32
        ENDM

    ; CB 44
    TEST_CASE bit 0,h
_D860_D87F: MACRO
        DB $30,$FF,$FF,$FF,$FF,$FF,$FF,$FF
        DB $A0,$00,$00,$00,$00,$00,$00,$00
        DB $20,$01,$67,$45,$AB,$89,$EF,$CD
        DB $B0,$FE,$98,$BA,$54,$76,$10,$32
        ENDM

    ; CB 45
    TEST_CASE bit 0,l
_D840_D85F: MACRO
        DB $30,$FF,$FF,$FF,$FF,$FF,$FF,$FF
        DB $A0,$00,$00,$00,$00,$00,$00,$00
        DB $20,$01,$67,$45,$AB,$89,$EF,$CD
        DB $B0,$FE,$98,$BA,$54,$76,$10,$32
        ENDM

    ; CB 47
    TEST_CASE bit 0,a
_D820_D83F: MACRO
        DB $30,$FF,$FF,$FF,$FF,$FF,$FF,$FF
        DB $A0,$00,$00,$00,$00,$00,$00,$00
        DB $20,$01,$67,$45,$AB,$89,$EF,$CD
        DB $B0,$FE,$98,$BA,$54,$76,$10,$32
        ENDM

    ; CB 48
    TEST_CASE bit 1,b
_D800_D81F: MACRO
        DB $30,$FF,$FF,$FF,$FF,$FF,$FF,$FF
        DB $A0,$00,$00,$00,$00,$00,$00,$00
        DB $A0,$01,$67,$45,$AB,$89,$EF,$CD
        DB $30,$FE,$98,$BA,$54,$76,$10,$32
        ENDM

    ; CB 49
    TEST_CASE bit 1,c
_D7E0_D7FF: MACRO
        DB $30,$FF,$FF,$FF,$FF,$FF,$FF,$FF
        DB $A0,$00,$00,$00,$00,$00,$00,$00
        DB $20,$01,$67,$45,$AB,$89,$EF,$CD
        DB $B0,$FE,$98,$BA,$54,$76,$10,$32
        ENDM

    ; CB 4A
    TEST_CASE bit 1,d
_D7C0_D7DF: MACRO
        DB $30,$FF,$FF,$FF,$FF,$FF,$FF,$FF
        DB $A0,$00,$00,$00,$00,$00,$00,$00
        DB $A0,$01,$67,$45,$AB,$89,$EF,$CD
        DB $30,$FE,$98,$BA,$54,$76,$10,$32
        ENDM

    ; CB 4B
    TEST_CASE bit 1,e
_D7A0_D7BF: MACRO
        DB $30,$FF,$FF,$FF,$FF,$FF,$FF,$FF
        DB $A0,$00,$00,$00,$00,$00,$00,$00
        DB $20,$01,$67,$45,$AB,$89,$EF,$CD
        DB $B0,$FE,$98,$BA,$54,$76,$10,$32
        ENDM

    ; CB 4C
    TEST_CASE bit 1,h
_D780_D79F: MACRO
        DB $30,$FF,$FF,$FF,$FF,$FF,$FF,$FF
        DB $A0,$00,$00,$00,$00,$00,$00,$00
        DB $A0,$01,$67,$45,$AB,$89,$EF,$CD
        DB $30,$FE,$98,$BA,$54,$76,$10,$32
        ENDM

    ; CB 4D
    TEST_CASE bit 1,l
_D760_D77F: MACRO
        DB $30,$FF,$FF,$FF,$FF,$FF,$FF,$FF
        DB $A0,$00,$00,$00,$00,$00,$00,$00
        DB $20,$01,$67,$45,$AB,$89,$EF,$CD
        DB $B0,$FE,$98,$BA,$54,$76,$10,$32
        ENDM

    ; CB 4F
    TEST_CASE bit 1,a
_D740_D75F: MACRO
        DB $30,$FF,$FF,$FF,$FF,$FF,$FF,$FF
        DB $A0,$00,$00,$00,$00,$00,$00,$00
        DB $A0,$01,$67,$45,$AB,$89,$EF,$CD
        DB $30,$FE,$98,$BA,$54,$76,$10,$32
        ENDM


; --------------------------------------------------------------------

    ; CB 50
    TEST_CASE bit 2,b
_D720_D73F: MACRO
        DB $30,$FF,$FF,$FF,$FF,$FF,$FF,$FF
        DB $A0,$00,$00,$00,$00,$00,$00,$00
        DB $20,$01,$67,$45,$AB,$89,$EF,$CD
        DB $B0,$FE,$98,$BA,$54,$76,$10,$32
        ENDM

    ; CB 51
    TEST_CASE bit 2,c
_D700_D71F: MACRO
        DB $30,$FF,$FF,$FF,$FF,$FF,$FF,$FF
        DB $A0,$00,$00,$00,$00,$00,$00,$00
        DB $20,$01,$67,$45,$AB,$89,$EF,$CD
        DB $B0,$FE,$98,$BA,$54,$76,$10,$32
        ENDM

    ; CB 52
    TEST_CASE bit 2,d
_D6E0_D6FF: MACRO
        DB $30,$FF,$FF,$FF,$FF,$FF,$FF,$FF
        DB $A0,$00,$00,$00,$00,$00,$00,$00
        DB $A0,$01,$67,$45,$AB,$89,$EF,$CD
        DB $30,$FE,$98,$BA,$54,$76,$10,$32
        ENDM

    ; CB 53
    TEST_CASE bit 2,e
_D6C0_D6DF: MACRO
        DB $30,$FF,$FF,$FF,$FF,$FF,$FF,$FF
        DB $A0,$00,$00,$00,$00,$00,$00,$00
        DB $A0,$01,$67,$45,$AB,$89,$EF,$CD
        DB $30,$FE,$98,$BA,$54,$76,$10,$32
        ENDM

    ; CB 54
    TEST_CASE bit 2,h
_D6A0_D6BF: MACRO
        DB $30,$FF,$FF,$FF,$FF,$FF,$FF,$FF
        DB $A0,$00,$00,$00,$00,$00,$00,$00
        DB $20,$01,$67,$45,$AB,$89,$EF,$CD
        DB $B0,$FE,$98,$BA,$54,$76,$10,$32
        ENDM

    ; CB 55
    TEST_CASE bit 2,l
_D680_D69F: MACRO
        DB $30,$FF,$FF,$FF,$FF,$FF,$FF,$FF
        DB $A0,$00,$00,$00,$00,$00,$00,$00
        DB $20,$01,$67,$45,$AB,$89,$EF,$CD
        DB $B0,$FE,$98,$BA,$54,$76,$10,$32
        ENDM

    ; CB 57
    TEST_CASE bit 2,a
_D660_D67F: MACRO
        DB $30,$FF,$FF,$FF,$FF,$FF,$FF,$FF
        DB $A0,$00,$00,$00,$00,$00,$00,$00
        DB $A0,$01,$67,$45,$AB,$89,$EF,$CD
        DB $30,$FE,$98,$BA,$54,$76,$10,$32
        ENDM

    ; CB 58
    TEST_CASE bit 3,b
_D640_D65F: MACRO
        DB $30,$FF,$FF,$FF,$FF,$FF,$FF,$FF
        DB $A0,$00,$00,$00,$00,$00,$00,$00
        DB $A0,$01,$67,$45,$AB,$89,$EF,$CD
        DB $30,$FE,$98,$BA,$54,$76,$10,$32
        ENDM

    ; CB 59
    TEST_CASE bit 3,c
_D620_D63F: MACRO
        DB $30,$FF,$FF,$FF,$FF,$FF,$FF,$FF
        DB $A0,$00,$00,$00,$00,$00,$00,$00
        DB $A0,$01,$67,$45,$AB,$89,$EF,$CD
        DB $30,$FE,$98,$BA,$54,$76,$10,$32
        ENDM

    ; CB 5A
    TEST_CASE bit 3,d
_D600_D61F: MACRO
        DB $30,$FF,$FF,$FF,$FF,$FF,$FF,$FF
        DB $A0,$00,$00,$00,$00,$00,$00,$00
        DB $20,$01,$67,$45,$AB,$89,$EF,$CD
        DB $B0,$FE,$98,$BA,$54,$76,$10,$32
        ENDM

    ; CB 5B
    TEST_CASE bit 3,e
_D5E0_D5FF: MACRO
        DB $30,$FF,$FF,$FF,$FF,$FF,$FF,$FF
        DB $A0,$00,$00,$00,$00,$00,$00,$00
        DB $20,$01,$67,$45,$AB,$89,$EF,$CD
        DB $B0,$FE,$98,$BA,$54,$76,$10,$32
        ENDM

    ; CB 5C
    TEST_CASE bit 3,h
_D5C0_D5DF: MACRO
        DB $30,$FF,$FF,$FF,$FF,$FF,$FF,$FF
        DB $A0,$00,$00,$00,$00,$00,$00,$00
        DB $20,$01,$67,$45,$AB,$89,$EF,$CD
        DB $B0,$FE,$98,$BA,$54,$76,$10,$32
        ENDM

    ; CB 5D
    TEST_CASE bit 3,l
_D5A0_D5BF: MACRO
        DB $30,$FF,$FF,$FF,$FF,$FF,$FF,$FF
        DB $A0,$00,$00,$00,$00,$00,$00,$00
        DB $20,$01,$67,$45,$AB,$89,$EF,$CD
        DB $B0,$FE,$98,$BA,$54,$76,$10,$32
        ENDM

    ; CB 5F
    TEST_CASE bit 3,a
_D580_D59F: MACRO
        DB $30,$FF,$FF,$FF,$FF,$FF,$FF,$FF
        DB $A0,$00,$00,$00,$00,$00,$00,$00
        DB $A0,$01,$67,$45,$AB,$89,$EF,$CD
        DB $30,$FE,$98,$BA,$54,$76,$10,$32
        ENDM


; --------------------------------------------------------------------

    ; CB 60
    TEST_CASE bit 4,b
_D560_D57F: MACRO
        DB $30,$FF,$FF,$FF,$FF,$FF,$FF,$FF
        DB $A0,$00,$00,$00,$00,$00,$00,$00
        DB $A0,$01,$67,$45,$AB,$89,$EF,$CD
        DB $30,$FE,$98,$BA,$54,$76,$10,$32
        ENDM

    ; CB 61
    TEST_CASE bit 4,c
_D540_D55F: MACRO
        DB $30,$FF,$FF,$FF,$FF,$FF,$FF,$FF
        DB $A0,$00,$00,$00,$00,$00,$00,$00
        DB $A0,$01,$67,$45,$AB,$89,$EF,$CD
        DB $30,$FE,$98,$BA,$54,$76,$10,$32
        ENDM

    ; CB 62
    TEST_CASE bit 4,d
_D520_D53F: MACRO
        DB $30,$FF,$FF,$FF,$FF,$FF,$FF,$FF
        DB $A0,$00,$00,$00,$00,$00,$00,$00
        DB $A0,$01,$67,$45,$AB,$89,$EF,$CD
        DB $30,$FE,$98,$BA,$54,$76,$10,$32
        ENDM

    ; CB 63
    TEST_CASE bit 4,e
_D500_D51F: MACRO
        DB $30,$FF,$FF,$FF,$FF,$FF,$FF,$FF
        DB $A0,$00,$00,$00,$00,$00,$00,$00
        DB $A0,$01,$67,$45,$AB,$89,$EF,$CD
        DB $30,$FE,$98,$BA,$54,$76,$10,$32
        ENDM

    ; CB 64
    TEST_CASE bit 4,h
_D4E0_D4FF: MACRO
        DB $30,$FF,$FF,$FF,$FF,$FF,$FF,$FF
        DB $A0,$00,$00,$00,$00,$00,$00,$00
        DB $A0,$01,$67,$45,$AB,$89,$EF,$CD
        DB $30,$FE,$98,$BA,$54,$76,$10,$32
        ENDM

    ; CB 65
    TEST_CASE bit 4,l
_D4C0_D4DF: MACRO
        DB $30,$FF,$FF,$FF,$FF,$FF,$FF,$FF
        DB $A0,$00,$00,$00,$00,$00,$00,$00
        DB $A0,$01,$67,$45,$AB,$89,$EF,$CD
        DB $30,$FE,$98,$BA,$54,$76,$10,$32
        ENDM

    ; CB 67
    TEST_CASE bit 4,a
_D4A0_D4BF: MACRO
        DB $30,$FF,$FF,$FF,$FF,$FF,$FF,$FF
        DB $A0,$00,$00,$00,$00,$00,$00,$00
        DB $A0,$01,$67,$45,$AB,$89,$EF,$CD
        DB $30,$FE,$98,$BA,$54,$76,$10,$32
        ENDM

    ; CB 68
    TEST_CASE bit 5,b
_D480_D49F: MACRO
        DB $30,$FF,$FF,$FF,$FF,$FF,$FF,$FF
        DB $A0,$00,$00,$00,$00,$00,$00,$00
        DB $A0,$01,$67,$45,$AB,$89,$EF,$CD
        DB $30,$FE,$98,$BA,$54,$76,$10,$32
        ENDM

    ; CB 69
    TEST_CASE bit 5,c
_D460_D47F: MACRO
        DB $30,$FF,$FF,$FF,$FF,$FF,$FF,$FF
        DB $A0,$00,$00,$00,$00,$00,$00,$00
        DB $20,$01,$67,$45,$AB,$89,$EF,$CD
        DB $B0,$FE,$98,$BA,$54,$76,$10,$32
        ENDM

    ; CB 6A
    TEST_CASE bit 5,d
_D440_D45F: MACRO
        DB $30,$FF,$FF,$FF,$FF,$FF,$FF,$FF
        DB $A0,$00,$00,$00,$00,$00,$00,$00
        DB $A0,$01,$67,$45,$AB,$89,$EF,$CD
        DB $30,$FE,$98,$BA,$54,$76,$10,$32
        ENDM

    ; CB 6B
    TEST_CASE bit 5,e
_D420_D43F: MACRO
        DB $30,$FF,$FF,$FF,$FF,$FF,$FF,$FF
        DB $A0,$00,$00,$00,$00,$00,$00,$00
        DB $20,$01,$67,$45,$AB,$89,$EF,$CD
        DB $B0,$FE,$98,$BA,$54,$76,$10,$32
        ENDM

    ; CB 6C
    TEST_CASE bit 5,h
_D400_D41F: MACRO
        DB $30,$FF,$FF,$FF,$FF,$FF,$FF,$FF
        DB $A0,$00,$00,$00,$00,$00,$00,$00
        DB $A0,$01,$67,$45,$AB,$89,$EF,$CD
        DB $30,$FE,$98,$BA,$54,$76,$10,$32
        ENDM

    ; CB 6D
    TEST_CASE bit 5,l
_D3E0_D3FF: MACRO
        DB $30,$FF,$FF,$FF,$FF,$FF,$FF,$FF
        DB $A0,$00,$00,$00,$00,$00,$00,$00
        DB $20,$01,$67,$45,$AB,$89,$EF,$CD
        DB $B0,$FE,$98,$BA,$54,$76,$10,$32
        ENDM

    ; CB 6F
    TEST_CASE bit 5,a
_D3C0_D3DF: MACRO
        DB $30,$FF,$FF,$FF,$FF,$FF,$FF,$FF
        DB $A0,$00,$00,$00,$00,$00,$00,$00
        DB $A0,$01,$67,$45,$AB,$89,$EF,$CD
        DB $30,$FE,$98,$BA,$54,$76,$10,$32
        ENDM


; --------------------------------------------------------------------

    ; CB 70
    TEST_CASE bit 6,b
_D3A0_D3BF: MACRO
        DB $30,$FF,$FF,$FF,$FF,$FF,$FF,$FF
        DB $A0,$00,$00,$00,$00,$00,$00,$00
        DB $20,$01,$67,$45,$AB,$89,$EF,$CD
        DB $B0,$FE,$98,$BA,$54,$76,$10,$32
        ENDM

    ; CB 71
    TEST_CASE bit 6,c
_D380_D39F: MACRO
        DB $30,$FF,$FF,$FF,$FF,$FF,$FF,$FF
        DB $A0,$00,$00,$00,$00,$00,$00,$00
        DB $20,$01,$67,$45,$AB,$89,$EF,$CD
        DB $B0,$FE,$98,$BA,$54,$76,$10,$32
        ENDM

    ; CB 72
    TEST_CASE bit 6,d
_D360_D37F: MACRO
        DB $30,$FF,$FF,$FF,$FF,$FF,$FF,$FF
        DB $A0,$00,$00,$00,$00,$00,$00,$00
        DB $A0,$01,$67,$45,$AB,$89,$EF,$CD
        DB $30,$FE,$98,$BA,$54,$76,$10,$32
        ENDM

    ; CB 73
    TEST_CASE bit 6,e
_D340_D35F: MACRO
        DB $30,$FF,$FF,$FF,$FF,$FF,$FF,$FF
        DB $A0,$00,$00,$00,$00,$00,$00,$00
        DB $A0,$01,$67,$45,$AB,$89,$EF,$CD
        DB $30,$FE,$98,$BA,$54,$76,$10,$32
        ENDM

    ; CB 74
    TEST_CASE bit 6,h
_D320_D33F: MACRO
        DB $30,$FF,$FF,$FF,$FF,$FF,$FF,$FF
        DB $A0,$00,$00,$00,$00,$00,$00,$00
        DB $20,$01,$67,$45,$AB,$89,$EF,$CD
        DB $B0,$FE,$98,$BA,$54,$76,$10,$32
        ENDM

    ; CB 75
    TEST_CASE bit 6,l
_D300_D31F: MACRO
        DB $30,$FF,$FF,$FF,$FF,$FF,$FF,$FF
        DB $A0,$00,$00,$00,$00,$00,$00,$00
        DB $20,$01,$67,$45,$AB,$89,$EF,$CD
        DB $B0,$FE,$98,$BA,$54,$76,$10,$32
        ENDM

    ; CB 77
    TEST_CASE bit 6,a
_D2E0_D2FF: MACRO
        DB $30,$FF,$FF,$FF,$FF,$FF,$FF,$FF
        DB $A0,$00,$00,$00,$00,$00,$00,$00
        DB $A0,$01,$67,$45,$AB,$89,$EF,$CD
        DB $30,$FE,$98,$BA,$54,$76,$10,$32
        ENDM

    ; CB 78
    TEST_CASE bit 7,b
_D2C0_D2DF: MACRO
        DB $30,$FF,$FF,$FF,$FF,$FF,$FF,$FF
        DB $A0,$00,$00,$00,$00,$00,$00,$00
        DB $A0,$01,$67,$45,$AB,$89,$EF,$CD
        DB $30,$FE,$98,$BA,$54,$76,$10,$32
        ENDM

    ; CB 79
    TEST_CASE bit 7,c
_D2A0_D2BF: MACRO
        DB $30,$FF,$FF,$FF,$FF,$FF,$FF,$FF
        DB $A0,$00,$00,$00,$00,$00,$00,$00
        DB $A0,$01,$67,$45,$AB,$89,$EF,$CD
        DB $30,$FE,$98,$BA,$54,$76,$10,$32
        ENDM

    ; CB 7A
    TEST_CASE bit 7,d
_D280_D29F: MACRO
        DB $30,$FF,$FF,$FF,$FF,$FF,$FF,$FF
        DB $A0,$00,$00,$00,$00,$00,$00,$00
        DB $20,$01,$67,$45,$AB,$89,$EF,$CD
        DB $B0,$FE,$98,$BA,$54,$76,$10,$32
        ENDM

    ; CB 7B
    TEST_CASE bit 7,e
_D260_D27F: MACRO
        DB $30,$FF,$FF,$FF,$FF,$FF,$FF,$FF
        DB $A0,$00,$00,$00,$00,$00,$00,$00
        DB $20,$01,$67,$45,$AB,$89,$EF,$CD
        DB $B0,$FE,$98,$BA,$54,$76,$10,$32
        ENDM

    ; CB 7C
    TEST_CASE bit 7,h
_D240_D25F: MACRO
        DB $30,$FF,$FF,$FF,$FF,$FF,$FF,$FF
        DB $A0,$00,$00,$00,$00,$00,$00,$00
        DB $20,$01,$67,$45,$AB,$89,$EF,$CD
        DB $B0,$FE,$98,$BA,$54,$76,$10,$32
        ENDM

    ; CB 7D
    TEST_CASE bit 7,l
_D220_D23F: MACRO
        DB $30,$FF,$FF,$FF,$FF,$FF,$FF,$FF
        DB $A0,$00,$00,$00,$00,$00,$00,$00
        DB $20,$01,$67,$45,$AB,$89,$EF,$CD
        DB $B0,$FE,$98,$BA,$54,$76,$10,$32
        ENDM

    ; CB 7F
    TEST_CASE bit 7,a
_D200_D21F: MACRO
        DB $30,$FF,$FF,$FF,$FF,$FF,$FF,$FF
        DB $A0,$00,$00,$00,$00,$00,$00,$00
        DB $A0,$01,$67,$45,$AB,$89,$EF,$CD
        DB $30,$FE,$98,$BA,$54,$76,$10,$32
        ENDM


; ====================================================================

    ; CB 80
    TEST_CASE res 0,b
_D1E0_D1FF: MACRO
        DB $F0,$FF,$FF,$FE,$FF,$FF,$FF,$FF
        DB $00,$00,$00,$00,$00,$00,$00,$00
        DB $20,$01,$67,$44,$AB,$89,$EF,$CD
        DB $D0,$FE,$98,$BA,$54,$76,$10,$32
        ENDM

    ; CB 81
    TEST_CASE res 0,c
_D1C0_D1DF: MACRO
        DB $F0,$FF,$FE,$FF,$FF,$FF,$FF,$FF
        DB $00,$00,$00,$00,$00,$00,$00,$00
        DB $20,$01,$66,$45,$AB,$89,$EF,$CD
        DB $D0,$FE,$98,$BA,$54,$76,$10,$32
        ENDM

    ; CB 82
    TEST_CASE res 0,d
_D1A0_D1BF: MACRO
        DB $F0,$FF,$FF,$FF,$FF,$FE,$FF,$FF
        DB $00,$00,$00,$00,$00,$00,$00,$00
        DB $20,$01,$67,$45,$AB,$88,$EF,$CD
        DB $D0,$FE,$98,$BA,$54,$76,$10,$32
        ENDM

    ; CB 83
    TEST_CASE res 0,e
_D180_D19F: MACRO
        DB $F0,$FF,$FF,$FF,$FE,$FF,$FF,$FF
        DB $00,$00,$00,$00,$00,$00,$00,$00
        DB $20,$01,$67,$45,$AA,$89,$EF,$CD
        DB $D0,$FE,$98,$BA,$54,$76,$10,$32
        ENDM

    ; CB 84
    TEST_CASE res 0,h
_D160_D17F: MACRO
        DB $F0,$FF,$FF,$FF,$FF,$FF,$FF,$FE
        DB $00,$00,$00,$00,$00,$00,$00,$00
        DB $20,$01,$67,$45,$AB,$89,$EF,$CC
        DB $D0,$FE,$98,$BA,$54,$76,$10,$32
        ENDM

    ; CB 85
    TEST_CASE res 0,l
_D140_D15F: MACRO
        DB $F0,$FF,$FF,$FF,$FF,$FF,$FE,$FF
        DB $00,$00,$00,$00,$00,$00,$00,$00
        DB $20,$01,$67,$45,$AB,$89,$EE,$CD
        DB $D0,$FE,$98,$BA,$54,$76,$10,$32
        ENDM

    ; CB 87
    TEST_CASE res 0,a
_D120_D13F: MACRO
        DB $F0,$FE,$FF,$FF,$FF,$FF,$FF,$FF
        DB $00,$00,$00,$00,$00,$00,$00,$00
        DB $20,$00,$67,$45,$AB,$89,$EF,$CD
        DB $D0,$FE,$98,$BA,$54,$76,$10,$32
        ENDM

    ; CB 88
    TEST_CASE res 1,b
_D100_D11F: MACRO
        DB $F0,$FF,$FF,$FD,$FF,$FF,$FF,$FF
        DB $00,$00,$00,$00,$00,$00,$00,$00
        DB $20,$01,$67,$45,$AB,$89,$EF,$CD
        DB $D0,$FE,$98,$B8,$54,$76,$10,$32
        ENDM

    ; CB 89
    TEST_CASE res 1,c
_D0E0_D0FF: MACRO
        DB $F0,$FF,$FD,$FF,$FF,$FF,$FF,$FF
        DB $00,$00,$00,$00,$00,$00,$00,$00
        DB $20,$01,$65,$45,$AB,$89,$EF,$CD
        DB $D0,$FE,$98,$BA,$54,$76,$10,$32
        ENDM

    ; CB 8A
    TEST_CASE res 1,d
_D0C0_D0DF: MACRO
        DB $F0,$FF,$FF,$FF,$FF,$FD,$FF,$FF
        DB $00,$00,$00,$00,$00,$00,$00,$00
        DB $20,$01,$67,$45,$AB,$89,$EF,$CD
        DB $D0,$FE,$98,$BA,$54,$74,$10,$32
        ENDM

    ; CB 8B
    TEST_CASE res 1,e
_D0A0_D0BF: MACRO
        DB $F0,$FF,$FF,$FF,$FD,$FF,$FF,$FF
        DB $00,$00,$00,$00,$00,$00,$00,$00
        DB $20,$01,$67,$45,$A9,$89,$EF,$CD
        DB $D0,$FE,$98,$BA,$54,$76,$10,$32
        ENDM

    ; CB 8C
    TEST_CASE res 1,h
_D080_D09F: MACRO
        DB $F0,$FF,$FF,$FF,$FF,$FF,$FF,$FD
        DB $00,$00,$00,$00,$00,$00,$00,$00
        DB $20,$01,$67,$45,$AB,$89,$EF,$CD
        DB $D0,$FE,$98,$BA,$54,$76,$10,$30
        ENDM

    ; CB 8D
    TEST_CASE res 1,l
_D060_D07F: MACRO
        DB $F0,$FF,$FF,$FF,$FF,$FF,$FD,$FF
        DB $00,$00,$00,$00,$00,$00,$00,$00
        DB $20,$01,$67,$45,$AB,$89,$ED,$CD
        DB $D0,$FE,$98,$BA,$54,$76,$10,$32
        ENDM

    ; CB 8F
    TEST_CASE res 1,a
_D040_D05F: MACRO
        DB $F0,$FD,$FF,$FF,$FF,$FF,$FF,$FF
        DB $00,$00,$00,$00,$00,$00,$00,$00
        DB $20,$01,$67,$45,$AB,$89,$EF,$CD
        DB $D0,$FC,$98,$BA,$54,$76,$10,$32
        ENDM


; --------------------------------------------------------------------

    ; CB 90
    TEST_CASE res 2,b
_D020_D03F: MACRO
        DB $F0,$FF,$FF,$FB,$FF,$FF,$FF,$FF
        DB $00,$00,$00,$00,$00,$00,$00,$00
        DB $20,$01,$67,$41,$AB,$89,$EF,$CD
        DB $D0,$FE,$98,$BA,$54,$76,$10,$32
        ENDM

    ; CB 91
    TEST_CASE res 2,c
_D000_D01F: MACRO
        DB $F0,$FF,$FB,$FF,$FF,$FF,$FF,$FF
        DB $00,$00,$00,$00,$00,$00,$00,$00
        DB $20,$01,$63,$45,$AB,$89,$EF,$CD
        DB $D0,$FE,$98,$BA,$54,$76,$10,$32
        ENDM

    ; CB 92
    TEST_CASE res 2,d
_CFE0_CFFF: MACRO
        DB $F0,$FF,$FF,$FF,$FF,$FB,$FF,$FF
        DB $00,$00,$00,$00,$00,$00,$00,$00
        DB $20,$01,$67,$45,$AB,$89,$EF,$CD
        DB $D0,$FE,$98,$BA,$54,$72,$10,$32
        ENDM

    ; CB 93
    TEST_CASE res 2,e
_CFC0_CFDF: MACRO
        DB $F0,$FF,$FF,$FF,$FB,$FF,$FF,$FF
        DB $00,$00,$00,$00,$00,$00,$00,$00
        DB $20,$01,$67,$45,$AB,$89,$EF,$CD
        DB $D0,$FE,$98,$BA,$50,$76,$10,$32
        ENDM

    ; CB 94
    TEST_CASE res 2,h
_CFA0_CFBF: MACRO
        DB $F0,$FF,$FF,$FF,$FF,$FF,$FF,$FB
        DB $00,$00,$00,$00,$00,$00,$00,$00
        DB $20,$01,$67,$45,$AB,$89,$EF,$C9
        DB $D0,$FE,$98,$BA,$54,$76,$10,$32
        ENDM

    ; CB 95
    TEST_CASE res 2,l
_CF80_CF9F: MACRO
        DB $F0,$FF,$FF,$FF,$FF,$FF,$FB,$FF
        DB $00,$00,$00,$00,$00,$00,$00,$00
        DB $20,$01,$67,$45,$AB,$89,$EB,$CD
        DB $D0,$FE,$98,$BA,$54,$76,$10,$32
        ENDM

    ; CB 97
    TEST_CASE res 2,a
_CF60_CF7F: MACRO
        DB $F0,$FB,$FF,$FF,$FF,$FF,$FF,$FF
        DB $00,$00,$00,$00,$00,$00,$00,$00
        DB $20,$01,$67,$45,$AB,$89,$EF,$CD
        DB $D0,$FA,$98,$BA,$54,$76,$10,$32
        ENDM

    ; CB 98
    TEST_CASE res 3,b
_CF40_CF5F: MACRO
        DB $F0,$FF,$FF,$F7,$FF,$FF,$FF,$FF
        DB $00,$00,$00,$00,$00,$00,$00,$00
        DB $20,$01,$67,$45,$AB,$89,$EF,$CD
        DB $D0,$FE,$98,$B2,$54,$76,$10,$32
        ENDM

    ; CB 99
    TEST_CASE res 3,c
_CF20_CF3F: MACRO
        DB $F0,$FF,$F7,$FF,$FF,$FF,$FF,$FF
        DB $00,$00,$00,$00,$00,$00,$00,$00
        DB $20,$01,$67,$45,$AB,$89,$EF,$CD
        DB $D0,$FE,$90,$BA,$54,$76,$10,$32
        ENDM

    ; CB 9A
    TEST_CASE res 3,d
_CF00_CF1F: MACRO
        DB $F0,$FF,$FF,$FF,$FF,$F7,$FF,$FF
        DB $00,$00,$00,$00,$00,$00,$00,$00
        DB $20,$01,$67,$45,$AB,$81,$EF,$CD
        DB $D0,$FE,$98,$BA,$54,$76,$10,$32
        ENDM

    ; CB 9B
    TEST_CASE res 3,e
_CEE0_CEFF: MACRO
        DB $F0,$FF,$FF,$FF,$F7,$FF,$FF,$FF
        DB $00,$00,$00,$00,$00,$00,$00,$00
        DB $20,$01,$67,$45,$A3,$89,$EF,$CD
        DB $D0,$FE,$98,$BA,$54,$76,$10,$32
        ENDM

    ; CB 9C
    TEST_CASE res 3,h
_CEC0_CEDF: MACRO
        DB $F0,$FF,$FF,$FF,$FF,$FF,$FF,$F7
        DB $00,$00,$00,$00,$00,$00,$00,$00
        DB $20,$01,$67,$45,$AB,$89,$EF,$C5
        DB $D0,$FE,$98,$BA,$54,$76,$10,$32
        ENDM

    ; CB 9D
    TEST_CASE res 3,l
_CEA0_CEBF: MACRO
        DB $F0,$FF,$FF,$FF,$FF,$FF,$F7,$FF
        DB $00,$00,$00,$00,$00,$00,$00,$00
        DB $20,$01,$67,$45,$AB,$89,$E7,$CD
        DB $D0,$FE,$98,$BA,$54,$76,$10,$32
        ENDM

    ; CB 9F
    TEST_CASE res 3,a
_CE80_CE9F: MACRO
        DB $F0,$F7,$FF,$FF,$FF,$FF,$FF,$FF
        DB $00,$00,$00,$00,$00,$00,$00,$00
        DB $20,$01,$67,$45,$AB,$89,$EF,$CD
        DB $D0,$F6,$98,$BA,$54,$76,$10,$32
        ENDM


; --------------------------------------------------------------------

    ; CB A0
    TEST_CASE res 4,b
_CE60_CE7F: MACRO
        DB $F0,$FF,$FF,$EF,$FF,$FF,$FF,$FF
        DB $00,$00,$00,$00,$00,$00,$00,$00
        DB $20,$01,$67,$45,$AB,$89,$EF,$CD
        DB $D0,$FE,$98,$AA,$54,$76,$10,$32
        ENDM

    ; CB A1
    TEST_CASE res 4,c
_CE40_CE5F: MACRO
        DB $F0,$FF,$EF,$FF,$FF,$FF,$FF,$FF
        DB $00,$00,$00,$00,$00,$00,$00,$00
        DB $20,$01,$67,$45,$AB,$89,$EF,$CD
        DB $D0,$FE,$88,$BA,$54,$76,$10,$32
        ENDM

    ; CB A2
    TEST_CASE res 4,d
_CE20_CE3F: MACRO
        DB $F0,$FF,$FF,$FF,$FF,$EF,$FF,$FF
        DB $00,$00,$00,$00,$00,$00,$00,$00
        DB $20,$01,$67,$45,$AB,$89,$EF,$CD
        DB $D0,$FE,$98,$BA,$54,$66,$10,$32
        ENDM

    ; CB A3
    TEST_CASE res 4,e
_CE00_CE1F: MACRO
        DB $F0,$FF,$FF,$FF,$EF,$FF,$FF,$FF
        DB $00,$00,$00,$00,$00,$00,$00,$00
        DB $20,$01,$67,$45,$AB,$89,$EF,$CD
        DB $D0,$FE,$98,$BA,$44,$76,$10,$32
        ENDM

    ; CB A4
    TEST_CASE res 4,h
_CDE0_CDFF: MACRO
        DB $F0,$FF,$FF,$FF,$FF,$FF,$FF,$EF
        DB $00,$00,$00,$00,$00,$00,$00,$00
        DB $20,$01,$67,$45,$AB,$89,$EF,$CD
        DB $D0,$FE,$98,$BA,$54,$76,$10,$22
        ENDM

    ; CB A5
    TEST_CASE res 4,l
_CDC0_CDDF: MACRO
        DB $F0,$FF,$FF,$FF,$FF,$FF,$EF,$FF
        DB $00,$00,$00,$00,$00,$00,$00,$00
        DB $20,$01,$67,$45,$AB,$89,$EF,$CD
        DB $D0,$FE,$98,$BA,$54,$76,$00,$32
        ENDM

    ; CB A7
    TEST_CASE res 4,a
_CDA0_CDBF: MACRO
        DB $F0,$EF,$FF,$FF,$FF,$FF,$FF,$FF
        DB $00,$00,$00,$00,$00,$00,$00,$00
        DB $20,$01,$67,$45,$AB,$89,$EF,$CD
        DB $D0,$EE,$98,$BA,$54,$76,$10,$32
        ENDM

    ; CB A8
    TEST_CASE res 5,b
_CD80_CD9F: MACRO
        DB $F0,$FF,$FF,$DF,$FF,$FF,$FF,$FF
        DB $00,$00,$00,$00,$00,$00,$00,$00
        DB $20,$01,$67,$45,$AB,$89,$EF,$CD
        DB $D0,$FE,$98,$9A,$54,$76,$10,$32
        ENDM

    ; CB A9
    TEST_CASE res 5,c
_CD60_CD7F: MACRO
        DB $F0,$FF,$DF,$FF,$FF,$FF,$FF,$FF
        DB $00,$00,$00,$00,$00,$00,$00,$00
        DB $20,$01,$47,$45,$AB,$89,$EF,$CD
        DB $D0,$FE,$98,$BA,$54,$76,$10,$32
        ENDM

    ; CB AA
    TEST_CASE res 5,d
_CD40_CD5F: MACRO
        DB $F0,$FF,$FF,$FF,$FF,$DF,$FF,$FF
        DB $00,$00,$00,$00,$00,$00,$00,$00
        DB $20,$01,$67,$45,$AB,$89,$EF,$CD
        DB $D0,$FE,$98,$BA,$54,$56,$10,$32
        ENDM

    ; CB AB
    TEST_CASE res 5,e
_CD20_CD3F: MACRO
        DB $F0,$FF,$FF,$FF,$DF,$FF,$FF,$FF
        DB $00,$00,$00,$00,$00,$00,$00,$00
        DB $20,$01,$67,$45,$8B,$89,$EF,$CD
        DB $D0,$FE,$98,$BA,$54,$76,$10,$32
        ENDM

    ; CB AC
    TEST_CASE res 5,h
_CD00_CD1F: MACRO
        DB $F0,$FF,$FF,$FF,$FF,$FF,$FF,$DF
        DB $00,$00,$00,$00,$00,$00,$00,$00
        DB $20,$01,$67,$45,$AB,$89,$EF,$CD
        DB $D0,$FE,$98,$BA,$54,$76,$10,$12
        ENDM

    ; CB AD
    TEST_CASE res 5,l
_CCE0_CCFF: MACRO
        DB $F0,$FF,$FF,$FF,$FF,$FF,$DF,$FF
        DB $00,$00,$00,$00,$00,$00,$00,$00
        DB $20,$01,$67,$45,$AB,$89,$CF,$CD
        DB $D0,$FE,$98,$BA,$54,$76,$10,$32
        ENDM

    ; CB AF
    TEST_CASE res 5,a
_CCC0_CCDF: MACRO
        DB $F0,$DF,$FF,$FF,$FF,$FF,$FF,$FF
        DB $00,$00,$00,$00,$00,$00,$00,$00
        DB $20,$01,$67,$45,$AB,$89,$EF,$CD
        DB $D0,$DE,$98,$BA,$54,$76,$10,$32
        ENDM


; --------------------------------------------------------------------

    ; CB B0
    TEST_CASE res 6,b
_CCA0_CCBF: MACRO
        DB $F0,$FF,$FF,$BF,$FF,$FF,$FF,$FF
        DB $00,$00,$00,$00,$00,$00,$00,$00
        DB $20,$01,$67,$05,$AB,$89,$EF,$CD
        DB $D0,$FE,$98,$BA,$54,$76,$10,$32
        ENDM

    ; CB B1
    TEST_CASE res 6,c
_CC80_CC9F: MACRO
        DB $F0,$FF,$BF,$FF,$FF,$FF,$FF,$FF
        DB $00,$00,$00,$00,$00,$00,$00,$00
        DB $20,$01,$27,$45,$AB,$89,$EF,$CD
        DB $D0,$FE,$98,$BA,$54,$76,$10,$32
        ENDM

    ; CB B2
    TEST_CASE res 6,d
_CC60_CC7F: MACRO
        DB $F0,$FF,$FF,$FF,$FF,$BF,$FF,$FF
        DB $00,$00,$00,$00,$00,$00,$00,$00
        DB $20,$01,$67,$45,$AB,$89,$EF,$CD
        DB $D0,$FE,$98,$BA,$54,$36,$10,$32
        ENDM

    ; CB B3
    TEST_CASE res 6,e
_CC40_CC5F: MACRO
        DB $F0,$FF,$FF,$FF,$BF,$FF,$FF,$FF
        DB $00,$00,$00,$00,$00,$00,$00,$00
        DB $20,$01,$67,$45,$AB,$89,$EF,$CD
        DB $D0,$FE,$98,$BA,$14,$76,$10,$32
        ENDM

    ; CB B4
    TEST_CASE res 6,h
_CC20_CC3F: MACRO
        DB $F0,$FF,$FF,$FF,$FF,$FF,$FF,$BF
        DB $00,$00,$00,$00,$00,$00,$00,$00
        DB $20,$01,$67,$45,$AB,$89,$EF,$8D
        DB $D0,$FE,$98,$BA,$54,$76,$10,$32
        ENDM

    ; CB B5
    TEST_CASE res 6,l
_CC00_CC1F: MACRO
        DB $F0,$FF,$FF,$FF,$FF,$FF,$BF,$FF
        DB $00,$00,$00,$00,$00,$00,$00,$00
        DB $20,$01,$67,$45,$AB,$89,$AF,$CD
        DB $D0,$FE,$98,$BA,$54,$76,$10,$32
        ENDM

    ; CB B7
    TEST_CASE res 6,a
_CBE0_CBFF: MACRO
        DB $F0,$BF,$FF,$FF,$FF,$FF,$FF,$FF
        DB $00,$00,$00,$00,$00,$00,$00,$00
        DB $20,$01,$67,$45,$AB,$89,$EF,$CD
        DB $D0,$BE,$98,$BA,$54,$76,$10,$32
        ENDM

    ; CB B8
    TEST_CASE res 7,b
_CBC0_CBDF: MACRO
        DB $F0,$FF,$FF,$7F,$FF,$FF,$FF,$FF
        DB $00,$00,$00,$00,$00,$00,$00,$00
        DB $20,$01,$67,$45,$AB,$89,$EF,$CD
        DB $D0,$FE,$98,$3A,$54,$76,$10,$32
        ENDM

    ; CB B9
    TEST_CASE res 7,c
_CBA0_CBBF: MACRO
        DB $F0,$FF,$7F,$FF,$FF,$FF,$FF,$FF
        DB $00,$00,$00,$00,$00,$00,$00,$00
        DB $20,$01,$67,$45,$AB,$89,$EF,$CD
        DB $D0,$FE,$18,$BA,$54,$76,$10,$32
        ENDM

    ; CB BA
    TEST_CASE res 7,d
_CB80_CB9F: MACRO
        DB $F0,$FF,$FF,$FF,$FF,$7F,$FF,$FF
        DB $00,$00,$00,$00,$00,$00,$00,$00
        DB $20,$01,$67,$45,$AB,$09,$EF,$CD
        DB $D0,$FE,$98,$BA,$54,$76,$10,$32
        ENDM

    ; CB BB
    TEST_CASE res 7,e
_CB60_CB7F: MACRO
        DB $F0,$FF,$FF,$FF,$7F,$FF,$FF,$FF
        DB $00,$00,$00,$00,$00,$00,$00,$00
        DB $20,$01,$67,$45,$2B,$89,$EF,$CD
        DB $D0,$FE,$98,$BA,$54,$76,$10,$32
        ENDM

    ; CB BC
    TEST_CASE res 7,h
_CB40_CB5F: MACRO
        DB $F0,$FF,$FF,$FF,$FF,$FF,$FF,$7F
        DB $00,$00,$00,$00,$00,$00,$00,$00
        DB $20,$01,$67,$45,$AB,$89,$EF,$4D
        DB $D0,$FE,$98,$BA,$54,$76,$10,$32
        ENDM

    ; CB BD
    TEST_CASE res 7,l
_CB20_CB3F: MACRO
        DB $F0,$FF,$FF,$FF,$FF,$FF,$7F,$FF
        DB $00,$00,$00,$00,$00,$00,$00,$00
        DB $20,$01,$67,$45,$AB,$89,$6F,$CD
        DB $D0,$FE,$98,$BA,$54,$76,$10,$32
        ENDM

    ; CB BF
    TEST_CASE res 7,a
_CB00_CB1F: MACRO
        DB $F0,$7F,$FF,$FF,$FF,$FF,$FF,$FF
        DB $00,$00,$00,$00,$00,$00,$00,$00
        DB $20,$01,$67,$45,$AB,$89,$EF,$CD
        DB $D0,$7E,$98,$BA,$54,$76,$10,$32
        ENDM


; ====================================================================

    ; CB C0
    TEST_CASE set 0,b
_CAE0_CAFF: MACRO
        DB $F0,$FF,$FF,$FF,$FF,$FF,$FF,$FF
        DB $00,$00,$00,$01,$00,$00,$00,$00
        DB $20,$01,$67,$45,$AB,$89,$EF,$CD
        DB $D0,$FE,$98,$BB,$54,$76,$10,$32
        ENDM

    ; CB C1
    TEST_CASE set 0,c
_CAC0_CADF: MACRO
        DB $F0,$FF,$FF,$FF,$FF,$FF,$FF,$FF
        DB $00,$00,$01,$00,$00,$00,$00,$00
        DB $20,$01,$67,$45,$AB,$89,$EF,$CD
        DB $D0,$FE,$99,$BA,$54,$76,$10,$32
        ENDM

    ; CB C2
    TEST_CASE set 0,d
_CAA0_CABF: MACRO
        DB $F0,$FF,$FF,$FF,$FF,$FF,$FF,$FF
        DB $00,$00,$00,$00,$00,$01,$00,$00
        DB $20,$01,$67,$45,$AB,$89,$EF,$CD
        DB $D0,$FE,$98,$BA,$54,$77,$10,$32
        ENDM

    ; CB C3
    TEST_CASE set 0,e
_CA80_CA9F: MACRO
        DB $F0,$FF,$FF,$FF,$FF,$FF,$FF,$FF
        DB $00,$00,$00,$00,$01,$00,$00,$00
        DB $20,$01,$67,$45,$AB,$89,$EF,$CD
        DB $D0,$FE,$98,$BA,$55,$76,$10,$32
        ENDM

    ; CB C4
    TEST_CASE set 0,h
_CA60_CA7F: MACRO
        DB $F0,$FF,$FF,$FF,$FF,$FF,$FF,$FF
        DB $00,$00,$00,$00,$00,$00,$00,$01
        DB $20,$01,$67,$45,$AB,$89,$EF,$CD
        DB $D0,$FE,$98,$BA,$54,$76,$10,$33
        ENDM

    ; CB C5
    TEST_CASE set 0,l
_CA40_CA5F: MACRO
        DB $F0,$FF,$FF,$FF,$FF,$FF,$FF,$FF
        DB $00,$00,$00,$00,$00,$00,$01,$00
        DB $20,$01,$67,$45,$AB,$89,$EF,$CD
        DB $D0,$FE,$98,$BA,$54,$76,$11,$32
        ENDM

    ; CB C7
    TEST_CASE set 0,a
_CA20_CA3F: MACRO
        DB $F0,$FF,$FF,$FF,$FF,$FF,$FF,$FF
        DB $00,$01,$00,$00,$00,$00,$00,$00
        DB $20,$01,$67,$45,$AB,$89,$EF,$CD
        DB $D0,$FF,$98,$BA,$54,$76,$10,$32
        ENDM

    ; CB C8
    TEST_CASE set 1,b
_CA00_CA1F: MACRO
        DB $F0,$FF,$FF,$FF,$FF,$FF,$FF,$FF
        DB $00,$00,$00,$02,$00,$00,$00,$00
        DB $20,$01,$67,$47,$AB,$89,$EF,$CD
        DB $D0,$FE,$98,$BA,$54,$76,$10,$32
        ENDM

    ; CB C9
    TEST_CASE set 1,c
_C9E0_C9FF: MACRO
        DB $F0,$FF,$FF,$FF,$FF,$FF,$FF,$FF
        DB $00,$00,$02,$00,$00,$00,$00,$00
        DB $20,$01,$67,$45,$AB,$89,$EF,$CD
        DB $D0,$FE,$9A,$BA,$54,$76,$10,$32
        ENDM

    ; CB CA
    TEST_CASE set 1,d
_C9C0_C9DF: MACRO
        DB $F0,$FF,$FF,$FF,$FF,$FF,$FF,$FF
        DB $00,$00,$00,$00,$00,$02,$00,$00
        DB $20,$01,$67,$45,$AB,$8B,$EF,$CD
        DB $D0,$FE,$98,$BA,$54,$76,$10,$32
        ENDM

    ; CB CB
    TEST_CASE set 1,e
_C9A0_C9BF: MACRO
        DB $F0,$FF,$FF,$FF,$FF,$FF,$FF,$FF
        DB $00,$00,$00,$00,$02,$00,$00,$00
        DB $20,$01,$67,$45,$AB,$89,$EF,$CD
        DB $D0,$FE,$98,$BA,$56,$76,$10,$32
        ENDM

    ; CB CC
    TEST_CASE set 1,h
_C980_C99F: MACRO
        DB $F0,$FF,$FF,$FF,$FF,$FF,$FF,$FF
        DB $00,$00,$00,$00,$00,$00,$00,$02
        DB $20,$01,$67,$45,$AB,$89,$EF,$CF
        DB $D0,$FE,$98,$BA,$54,$76,$10,$32
        ENDM

    ; CB CD
    TEST_CASE set 1,l
_C960_C97F: MACRO
        DB $F0,$FF,$FF,$FF,$FF,$FF,$FF,$FF
        DB $00,$00,$00,$00,$00,$00,$02,$00
        DB $20,$01,$67,$45,$AB,$89,$EF,$CD
        DB $D0,$FE,$98,$BA,$54,$76,$12,$32
        ENDM

    ; CB CF
    TEST_CASE set 1,a
_C940_C95F: MACRO
        DB $F0,$FF,$FF,$FF,$FF,$FF,$FF,$FF
        DB $00,$02,$00,$00,$00,$00,$00,$00
        DB $20,$03,$67,$45,$AB,$89,$EF,$CD
        DB $D0,$FE,$98,$BA,$54,$76,$10,$32
        ENDM


; --------------------------------------------------------------------

    ; CB D0
    TEST_CASE set 2,b
_C920_C93F: MACRO
        DB $F0,$FF,$FF,$FF,$FF,$FF,$FF,$FF
        DB $00,$00,$00,$04,$00,$00,$00,$00
        DB $20,$01,$67,$45,$AB,$89,$EF,$CD
        DB $D0,$FE,$98,$BE,$54,$76,$10,$32
        ENDM

    ; CB D1
    TEST_CASE set 2,c
_C900_C91F: MACRO
        DB $F0,$FF,$FF,$FF,$FF,$FF,$FF,$FF
        DB $00,$00,$04,$00,$00,$00,$00,$00
        DB $20,$01,$67,$45,$AB,$89,$EF,$CD
        DB $D0,$FE,$9C,$BA,$54,$76,$10,$32
        ENDM

    ; CB D2
    TEST_CASE set 2,d
_C8E0_C8FF: MACRO
        DB $F0,$FF,$FF,$FF,$FF,$FF,$FF,$FF
        DB $00,$00,$00,$00,$00,$04,$00,$00
        DB $20,$01,$67,$45,$AB,$8D,$EF,$CD
        DB $D0,$FE,$98,$BA,$54,$76,$10,$32
        ENDM

    ; CB D3
    TEST_CASE set 2,e
_C8C0_C8DF: MACRO
        DB $F0,$FF,$FF,$FF,$FF,$FF,$FF,$FF
        DB $00,$00,$00,$00,$04,$00,$00,$00
        DB $20,$01,$67,$45,$AF,$89,$EF,$CD
        DB $D0,$FE,$98,$BA,$54,$76,$10,$32
        ENDM

    ; CB D4
    TEST_CASE set 2,h
_C8A0_C8BF: MACRO
        DB $F0,$FF,$FF,$FF,$FF,$FF,$FF,$FF
        DB $00,$00,$00,$00,$00,$00,$00,$04
        DB $20,$01,$67,$45,$AB,$89,$EF,$CD
        DB $D0,$FE,$98,$BA,$54,$76,$10,$36
        ENDM

    ; CB D5
    TEST_CASE set 2,l
_C880_C89F: MACRO
        DB $F0,$FF,$FF,$FF,$FF,$FF,$FF,$FF
        DB $00,$00,$00,$00,$00,$00,$04,$00
        DB $20,$01,$67,$45,$AB,$89,$EF,$CD
        DB $D0,$FE,$98,$BA,$54,$76,$14,$32
        ENDM

    ; CB D7
    TEST_CASE set 2,a
_C860_C87F: MACRO
        DB $F0,$FF,$FF,$FF,$FF,$FF,$FF,$FF
        DB $00,$04,$00,$00,$00,$00,$00,$00
        DB $20,$05,$67,$45,$AB,$89,$EF,$CD
        DB $D0,$FE,$98,$BA,$54,$76,$10,$32
        ENDM

    ; CB D8
    TEST_CASE set 3,b
_C840_C85F: MACRO
        DB $F0,$FF,$FF,$FF,$FF,$FF,$FF,$FF
        DB $00,$00,$00,$08,$00,$00,$00,$00
        DB $20,$01,$67,$4D,$AB,$89,$EF,$CD
        DB $D0,$FE,$98,$BA,$54,$76,$10,$32
        ENDM

    ; CB D9
    TEST_CASE set 3,c
_C820_C83F: MACRO
        DB $F0,$FF,$FF,$FF,$FF,$FF,$FF,$FF
        DB $00,$00,$08,$00,$00,$00,$00,$00
        DB $20,$01,$6F,$45,$AB,$89,$EF,$CD
        DB $D0,$FE,$98,$BA,$54,$76,$10,$32
        ENDM

    ; CB DA
    TEST_CASE set 3,d
_C800_C81F: MACRO
        DB $F0,$FF,$FF,$FF,$FF,$FF,$FF,$FF
        DB $00,$00,$00,$00,$00,$08,$00,$00
        DB $20,$01,$67,$45,$AB,$89,$EF,$CD
        DB $D0,$FE,$98,$BA,$54,$7E,$10,$32
        ENDM

    ; CB DB
    TEST_CASE set 3,e
_C7E0_C7FF: MACRO
        DB $F0,$FF,$FF,$FF,$FF,$FF,$FF,$FF
        DB $00,$00,$00,$00,$08,$00,$00,$00
        DB $20,$01,$67,$45,$AB,$89,$EF,$CD
        DB $D0,$FE,$98,$BA,$5C,$76,$10,$32
        ENDM

    ; CB DC
    TEST_CASE set 3,h
_C7C0_C7DF: MACRO
        DB $F0,$FF,$FF,$FF,$FF,$FF,$FF,$FF
        DB $00,$00,$00,$00,$00,$00,$00,$08
        DB $20,$01,$67,$45,$AB,$89,$EF,$CD
        DB $D0,$FE,$98,$BA,$54,$76,$10,$3A
        ENDM

    ; CB DD
    TEST_CASE set 3,l
_C7A0_C7BF: MACRO
        DB $F0,$FF,$FF,$FF,$FF,$FF,$FF,$FF
        DB $00,$00,$00,$00,$00,$00,$08,$00
        DB $20,$01,$67,$45,$AB,$89,$EF,$CD
        DB $D0,$FE,$98,$BA,$54,$76,$18,$32
        ENDM

    ; CB DF
    TEST_CASE set 3,a
_C780_C79F: MACRO
        DB $F0,$FF,$FF,$FF,$FF,$FF,$FF,$FF
        DB $00,$08,$00,$00,$00,$00,$00,$00
        DB $20,$09,$67,$45,$AB,$89,$EF,$CD
        DB $D0,$FE,$98,$BA,$54,$76,$10,$32
        ENDM


; --------------------------------------------------------------------

    ; CB E0
    TEST_CASE set 4,b
_C760_C77F: MACRO
        DB $F0,$FF,$FF,$FF,$FF,$FF,$FF,$FF
        DB $00,$00,$00,$10,$00,$00,$00,$00
        DB $20,$01,$67,$55,$AB,$89,$EF,$CD
        DB $D0,$FE,$98,$BA,$54,$76,$10,$32
        ENDM

    ; CB E1
    TEST_CASE set 4,c
_C740_C75F: MACRO
        DB $F0,$FF,$FF,$FF,$FF,$FF,$FF,$FF
        DB $00,$00,$10,$00,$00,$00,$00,$00
        DB $20,$01,$77,$45,$AB,$89,$EF,$CD
        DB $D0,$FE,$98,$BA,$54,$76,$10,$32
        ENDM

    ; CB E2
    TEST_CASE set 4,d
_C720_C73F: MACRO
        DB $F0,$FF,$FF,$FF,$FF,$FF,$FF,$FF
        DB $00,$00,$00,$00,$00,$10,$00,$00
        DB $20,$01,$67,$45,$AB,$99,$EF,$CD
        DB $D0,$FE,$98,$BA,$54,$76,$10,$32
        ENDM

    ; CB E3
    TEST_CASE set 4,e
_C700_C71F: MACRO
        DB $F0,$FF,$FF,$FF,$FF,$FF,$FF,$FF
        DB $00,$00,$00,$00,$10,$00,$00,$00
        DB $20,$01,$67,$45,$BB,$89,$EF,$CD
        DB $D0,$FE,$98,$BA,$54,$76,$10,$32
        ENDM

    ; CB E4
    TEST_CASE set 4,h
_C6E0_C6FF: MACRO
        DB $F0,$FF,$FF,$FF,$FF,$FF,$FF,$FF
        DB $00,$00,$00,$00,$00,$00,$00,$10
        DB $20,$01,$67,$45,$AB,$89,$EF,$DD
        DB $D0,$FE,$98,$BA,$54,$76,$10,$32
        ENDM

    ; CB E5
    TEST_CASE set 4,l
_C6C0_C6DF: MACRO
        DB $F0,$FF,$FF,$FF,$FF,$FF,$FF,$FF
        DB $00,$00,$00,$00,$00,$00,$10,$00
        DB $20,$01,$67,$45,$AB,$89,$FF,$CD
        DB $D0,$FE,$98,$BA,$54,$76,$10,$32
        ENDM

    ; CB E7
    TEST_CASE set 4,a
_C6A0_C6BF: MACRO
        DB $F0,$FF,$FF,$FF,$FF,$FF,$FF,$FF
        DB $00,$10,$00,$00,$00,$00,$00,$00
        DB $20,$11,$67,$45,$AB,$89,$EF,$CD
        DB $D0,$FE,$98,$BA,$54,$76,$10,$32
        ENDM

    ; CB E8
    TEST_CASE set 5,b
_C680_C69F: MACRO
        DB $F0,$FF,$FF,$FF,$FF,$FF,$FF,$FF
        DB $00,$00,$00,$20,$00,$00,$00,$00
        DB $20,$01,$67,$65,$AB,$89,$EF,$CD
        DB $D0,$FE,$98,$BA,$54,$76,$10,$32
        ENDM

    ; CB E9
    TEST_CASE set 5,c
_C660_C67F: MACRO
        DB $F0,$FF,$FF,$FF,$FF,$FF,$FF,$FF
        DB $00,$00,$20,$00,$00,$00,$00,$00
        DB $20,$01,$67,$45,$AB,$89,$EF,$CD
        DB $D0,$FE,$B8,$BA,$54,$76,$10,$32
        ENDM

    ; CB EA
    TEST_CASE set 5,d
_C640_C65F: MACRO
        DB $F0,$FF,$FF,$FF,$FF,$FF,$FF,$FF
        DB $00,$00,$00,$00,$00,$20,$00,$00
        DB $20,$01,$67,$45,$AB,$A9,$EF,$CD
        DB $D0,$FE,$98,$BA,$54,$76,$10,$32
        ENDM

    ; CB EB
    TEST_CASE set 5,e
_C620_C63F: MACRO
        DB $F0,$FF,$FF,$FF,$FF,$FF,$FF,$FF
        DB $00,$00,$00,$00,$20,$00,$00,$00
        DB $20,$01,$67,$45,$AB,$89,$EF,$CD
        DB $D0,$FE,$98,$BA,$74,$76,$10,$32
        ENDM

    ; CB EC
    TEST_CASE set 5,h
_C600_C61F: MACRO
        DB $F0,$FF,$FF,$FF,$FF,$FF,$FF,$FF
        DB $00,$00,$00,$00,$00,$00,$00,$20
        DB $20,$01,$67,$45,$AB,$89,$EF,$ED
        DB $D0,$FE,$98,$BA,$54,$76,$10,$32
        ENDM

    ; CB ED
    TEST_CASE set 5,l
_C5E0_C5FF: MACRO
        DB $F0,$FF,$FF,$FF,$FF,$FF,$FF,$FF
        DB $00,$00,$00,$00,$00,$00,$20,$00
        DB $20,$01,$67,$45,$AB,$89,$EF,$CD
        DB $D0,$FE,$98,$BA,$54,$76,$30,$32
        ENDM

    ; CB EF
    TEST_CASE set 5,a
_C5C0_C5DF: MACRO
        DB $F0,$FF,$FF,$FF,$FF,$FF,$FF,$FF
        DB $00,$20,$00,$00,$00,$00,$00,$00
        DB $20,$21,$67,$45,$AB,$89,$EF,$CD
        DB $D0,$FE,$98,$BA,$54,$76,$10,$32
        ENDM


; --------------------------------------------------------------------

    ; CB F0
    TEST_CASE set 6,b
_C5A0_C5BF: MACRO
        DB $F0,$FF,$FF,$FF,$FF,$FF,$FF,$FF
        DB $00,$00,$00,$40,$00,$00,$00,$00
        DB $20,$01,$67,$45,$AB,$89,$EF,$CD
        DB $D0,$FE,$98,$FA,$54,$76,$10,$32
        ENDM

    ; CB F1
    TEST_CASE set 6,c
_C580_C59F: MACRO
        DB $F0,$FF,$FF,$FF,$FF,$FF,$FF,$FF
        DB $00,$00,$40,$00,$00,$00,$00,$00
        DB $20,$01,$67,$45,$AB,$89,$EF,$CD
        DB $D0,$FE,$D8,$BA,$54,$76,$10,$32
        ENDM

    ; CB F2
    TEST_CASE set 6,d
_C560_C57F: MACRO
        DB $F0,$FF,$FF,$FF,$FF,$FF,$FF,$FF
        DB $00,$00,$00,$00,$00,$40,$00,$00
        DB $20,$01,$67,$45,$AB,$C9,$EF,$CD
        DB $D0,$FE,$98,$BA,$54,$76,$10,$32
        ENDM

    ; CB F3
    TEST_CASE set 6,e
_C540_C55F: MACRO
        DB $F0,$FF,$FF,$FF,$FF,$FF,$FF,$FF
        DB $00,$00,$00,$00,$40,$00,$00,$00
        DB $20,$01,$67,$45,$EB,$89,$EF,$CD
        DB $D0,$FE,$98,$BA,$54,$76,$10,$32
        ENDM

    ; CB F4
    TEST_CASE set 6,h
_C520_C53F: MACRO
        DB $F0,$FF,$FF,$FF,$FF,$FF,$FF,$FF
        DB $00,$00,$00,$00,$00,$00,$00,$40
        DB $20,$01,$67,$45,$AB,$89,$EF,$CD
        DB $D0,$FE,$98,$BA,$54,$76,$10,$72
        ENDM

    ; CB F5
    TEST_CASE set 6,l
_C500_C51F: MACRO
        DB $F0,$FF,$FF,$FF,$FF,$FF,$FF,$FF
        DB $00,$00,$00,$00,$00,$00,$40,$00
        DB $20,$01,$67,$45,$AB,$89,$EF,$CD
        DB $D0,$FE,$98,$BA,$54,$76,$50,$32
        ENDM

    ; CB F7
    TEST_CASE set 6,a
_C4E0_C4FF: MACRO
        DB $F0,$FF,$FF,$FF,$FF,$FF,$FF,$FF
        DB $00,$40,$00,$00,$00,$00,$00,$00
        DB $20,$41,$67,$45,$AB,$89,$EF,$CD
        DB $D0,$FE,$98,$BA,$54,$76,$10,$32
        ENDM

    ; CB F8
    TEST_CASE set 7,b
_C4C0_C4DF: MACRO
        DB $F0,$FF,$FF,$FF,$FF,$FF,$FF,$FF
        DB $00,$00,$00,$80,$00,$00,$00,$00
        DB $20,$01,$67,$C5,$AB,$89,$EF,$CD
        DB $D0,$FE,$98,$BA,$54,$76,$10,$32
        ENDM

    ; CB F9
    TEST_CASE set 7,c
_C4A0_C4BF: MACRO
        DB $F0,$FF,$FF,$FF,$FF,$FF,$FF,$FF
        DB $00,$00,$80,$00,$00,$00,$00,$00
        DB $20,$01,$E7,$45,$AB,$89,$EF,$CD
        DB $D0,$FE,$98,$BA,$54,$76,$10,$32
        ENDM

    ; CB FA
    TEST_CASE set 7,d
_C480_C49F: MACRO
        DB $F0,$FF,$FF,$FF,$FF,$FF,$FF,$FF
        DB $00,$00,$00,$00,$00,$80,$00,$00
        DB $20,$01,$67,$45,$AB,$89,$EF,$CD
        DB $D0,$FE,$98,$BA,$54,$F6,$10,$32
        ENDM

    ; CB FB
    TEST_CASE set 7,e
_C460_C47F: MACRO
        DB $F0,$FF,$FF,$FF,$FF,$FF,$FF,$FF
        DB $00,$00,$00,$00,$80,$00,$00,$00
        DB $20,$01,$67,$45,$AB,$89,$EF,$CD
        DB $D0,$FE,$98,$BA,$D4,$76,$10,$32
        ENDM

    ; CB FC
    TEST_CASE set 7,h
_C440_C45F: MACRO
        DB $F0,$FF,$FF,$FF,$FF,$FF,$FF,$FF
        DB $00,$00,$00,$00,$00,$00,$00,$80
        DB $20,$01,$67,$45,$AB,$89,$EF,$CD
        DB $D0,$FE,$98,$BA,$54,$76,$10,$B2
        ENDM

    ; CB FD
    TEST_CASE set 7,l
_C420_C43F: MACRO
        DB $F0,$FF,$FF,$FF,$FF,$FF,$FF,$FF
        DB $00,$00,$00,$00,$00,$00,$80,$00
        DB $20,$01,$67,$45,$AB,$89,$EF,$CD
        DB $D0,$FE,$98,$BA,$54,$76,$90,$32
        ENDM

    ; CB FF
    TEST_CASE set 7,a
_C400_C41F: MACRO
        DB $F0,$FF,$FF,$FF,$FF,$FF,$FF,$FF
        DB $00,$80,$00,$00,$00,$00,$00,$00
        DB $20,$81,$67,$45,$AB,$89,$EF,$CD
        DB $D0,$FE,$98,$BA,$54,$76,$10,$32
        ENDM

jp eof

SECTION "data", ROMX[$4000]
    _C400_C41F
    _C420_C43F
    _C440_C45F
    _C460_C47F
    _C480_C49F
    _C4A0_C4BF
    _C4C0_C4DF
    _C4E0_C4FF
    _C500_C51F
    _C520_C53F
    _C540_C55F
    _C560_C57F
    _C580_C59F
    _C5A0_C5BF
    _C5C0_C5DF
    _C5E0_C5FF
    _C600_C61F
    _C620_C63F
    _C640_C65F
    _C660_C67F
    _C680_C69F
    _C6A0_C6BF
    _C6C0_C6DF
    _C6E0_C6FF
    _C700_C71F
    _C720_C73F
    _C740_C75F
    _C760_C77F
    _C780_C79F
    _C7A0_C7BF
    _C7C0_C7DF
    _C7E0_C7FF
    _C800_C81F
    _C820_C83F
    _C840_C85F
    _C860_C87F
    _C880_C89F
    _C8A0_C8BF
    _C8C0_C8DF
    _C8E0_C8FF
    _C900_C91F
    _C920_C93F
    _C940_C95F
    _C960_C97F
    _C980_C99F
    _C9A0_C9BF
    _C9C0_C9DF
    _C9E0_C9FF
    _CA00_CA1F
    _CA20_CA3F
    _CA40_CA5F
    _CA60_CA7F
    _CA80_CA9F
    _CAA0_CABF
    _CAC0_CADF
    _CAE0_CAFF
    _CB00_CB1F
    _CB20_CB3F
    _CB40_CB5F
    _CB60_CB7F
    _CB80_CB9F
    _CBA0_CBBF
    _CBC0_CBDF
    _CBE0_CBFF
    _CC00_CC1F
    _CC20_CC3F
    _CC40_CC5F
    _CC60_CC7F
    _CC80_CC9F
    _CCA0_CCBF
    _CCC0_CCDF
    _CCE0_CCFF
    _CD00_CD1F
    _CD20_CD3F
    _CD40_CD5F
    _CD60_CD7F
    _CD80_CD9F
    _CDA0_CDBF
    _CDC0_CDDF
    _CDE0_CDFF
    _CE00_CE1F
    _CE20_CE3F
    _CE40_CE5F
    _CE60_CE7F
    _CE80_CE9F
    _CEA0_CEBF
    _CEC0_CEDF
    _CEE0_CEFF
    _CF00_CF1F
    _CF20_CF3F
    _CF40_CF5F
    _CF60_CF7F
    _CF80_CF9F
    _CFA0_CFBF
    _CFC0_CFDF
    _CFE0_CFFF
    _D000_D01F
    _D020_D03F
    _D040_D05F
    _D060_D07F
    _D080_D09F
    _D0A0_D0BF
    _D0C0_D0DF
    _D0E0_D0FF
    _D100_D11F
    _D120_D13F
    _D140_D15F
    _D160_D17F
    _D180_D19F
    _D1A0_D1BF
    _D1C0_D1DF
    _D1E0_D1FF
    _D200_D21F
    _D220_D23F
    _D240_D25F
    _D260_D27F
    _D280_D29F
    _D2A0_D2BF
    _D2C0_D2DF
    _D2E0_D2FF
    _D300_D31F
    _D320_D33F
    _D340_D35F
    _D360_D37F
    _D380_D39F
    _D3A0_D3BF
    _D3C0_D3DF
    _D3E0_D3FF
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
