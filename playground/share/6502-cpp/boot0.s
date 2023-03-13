        .feature at_in_identifiers

        .importzp _sp0, _sp1, _fp0, _fp1
        .importzp _r0, _r1, _r2, _r3, _r4, _r5, _r6, _r7
        .importzp _s0, _s1, _s2, _s3, _s4, _s5, _s6, _s7
        .importzp _tmp0, _tmp1

        .export __STARTUP__ ; requred and used internally
        .import main

;       .import __STARTUP_LOAD__
        .import __BSS_RUN__
        .import __BSS_SIZE__
        .import __stack
;       .import __DATA_RUN__
;       .import __DATA_LOAD__
;       .import __DATA_SIZE__

        .segment "STARTUP"

__STARTUP__:
_start:
        ; Clear BSS.
        lda #<__BSS_RUN__
        sta _r0
        lda #>__BSS_RUN__
        sta _r1
        lda #<__BSS_SIZE__
        sta _r2
        ldx #>__BSS_SIZE__
        stx _r3
        ora _r3
        beq nobss
        .scope
        ldy #0
loop:
        lda #0
        sta (_r0),y
        inc _r0
        bne :+
        inc _r1
: dec _r2
        lda _r2
        cmp #255
        bne :+
        dec _r3
: ora _r3
        bne loop
        .endscope
nobss:

;         lda #<__DATA_LOAD__
;         sta _r0
;         lda #>__DATA_LOAD__
;         sta _r1
;         lda #<__DATA_RUN__
;         sta _r2
;         lda #>__DATA_RUN__
;         sta _r3
;         lda #<__DATA_SIZE__
;         sta _r4
;         ldx #>__DATA_SIZE__
;         stx _r5
;         ora _r5
;         beq nodata
;
;         lda _r0
;         cmp _r2
;         bne outerloop
;         lda _r1
;         cmp _r3
;         beq nodata
;
; outerloop:
;         lda _r5
;         beq lastpage
;
;         ldy #0
; copypage:
;         lda (_r0),y
;         sta (_r2),y
;         iny
;         bne copypage
;         inc _r1
;         inc _r3
;         dec _r5
;         jmp outerloop
; lastpage:
;         ldy #0
; lastbit:
;         lda (_r0),y
;         sta (_r2),y
;         iny
;         cpy _r4
;         bne lastbit
; nodata:

        lda #<__stack
        sta _sp0
        lda #>__stack
        sta _sp1

        lda #0
        sta _r0
        sta _r1
        sta _r2
        sta _r3
        jsr main
        ; Retrieve exit code
        lda _r0
        rts
