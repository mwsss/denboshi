;--------------------------------------------
; mysub.asm
; 私のサブルーチン集
;--------------------------------------------


hosisc: ;--hosi scrool
    ld b, 30
ld de, (ver2)
  lp1:

;-- jiki ido 
ld a, b
cp 15
jp nz, jikim2
push hl
call jikiido1;--15 no toki
pop hl
jikim2:
;--

;-- srar ido 
push hl
    call RandomValue
    ld hl, (WK_RANDOM_VALUE)
    sra hl
    sra hl
    sra hl
    sra hl
    sra hl
ld a, l
pop hl
cp 2
jp c, jikim3
push hl
call starido1;--
pop hl
jikim3:





;--




    ld  a, $00
    call WRTVRM
    dec hl


call REDVRM
xor $82 ;--jiki
jr nz, notbeep1
CALL  00C0H 
push hl

ld hl, $1a27   ;--スコアの位置
call REDVRM    ;--にある数を読んで
dec a          ;--１下げる
ld hl, $1a27   ;--その位置に
    call WRTVRM;--下げた数を書き込む
cp $30         ;--０か？
jp z, gameover1;--０ならゲームオーバー


pop hl
ret
notbeep1:


    ld  a, $84
    call WRTVRM
    push bc
    call DelayLoop
    pop bc

  djnz lp1
    ld  a, $00
    call WRTVRM
ret
;--

gamen: ;--gamen sakusei
    ; 文字コード80Hの文字を256バイトぶん
    ; VRAMのパターンネームテーブルに埋める
    ; (横32文字 x 縦8行＝256バイト)
    ld hl, $1800
    ld  a, $80 ;--kabe
    call PutVRAM256Bytes

    ; 文字コード00Hの文字を256バイトぶん
    ld hl, $1900
    ld  a, $00 ;--kuro
    call PutVRAM256Bytes

    ; 文字コード80Hの文字を256バイトぶん
    ld hl, $1A00
    ld  a, $80 ;--kabe
    call PutVRAM256Bytes


;--
    ld hl, MESSAGE1
    ld de, $19c9 
    ld bc, 12       ; 
    call LDIRVM

    ld hl, MESSAGE2
    ld de, $1a64 
    ld bc, 22       ; 
    call LDIRVM

    ld hl, MESSAGE3
    ld de, $1a24 
    ld bc, 5       ; 
    call LDIRVM

    ld hl, ttl2
    ld de, $1821 
    ld bc, 30
    call LDIRVM

    ld hl, ttl3
    ld de, $1841 
    ld bc, 30
    call LDIRVM

    ld hl, ttl4
    ld de, $1861 
    ld bc, 30
    call LDIRVM

    ld hl, ttl5
    ld de, $1881 
    ld bc, 30
    call LDIRVM

    ld hl, ttl6
    ld de, $18A1 
    ld bc, 30
    call LDIRVM

    ld hl, ttl7
    ld de, $18C1 
    ld bc, 30
    call LDIRVM


;--w machi
wmachi:
ld a, 5
call SNSMAT ;w11101111ef
xor $ef ;w
jr z, wpush2

jp wmachi

wpush2:
    ;ld hl, MESSAGE3
    ;ld de, $1a24 
    ;ld bc, 22       ; 
    ;call LDIRVM

CALL  00C0H ;--beep



MESSAGE1:
    defm " PUSH W Key "
MESSAGE2:
    defm " c2023 yuuto inashiro "
MESSAGE3:
    defm "   5 "
MESSAGE4:
    defm " GAME OVER "

ttl2: defm " BB  BB B  B BB   B  BB B B B "
ttl3: defm "XBXBXBXXBBXBXBXBXBXBXBXXBXBXBX"
ttl4: defm "X X X  X  X X  XX X X  X   X X"
ttl5: defm "X X X XX X  X X X X XX X X X X"
ttl6: defm "XBXBXBXXBXBBXBXBXBXBXXBXBXBXBX"
ttl7: defm " BB  BB B  B BB   B  BB B B B "

;--

ret
;--



jikiido1: ;--jiki ido
ld a, 5
call SNSMAT ;w11101111ef s11111110fe
cp $ef ;w
jp z, wpush1
ld a, 5
call SNSMAT
cp $fe ;s
jp z, spush1
jp jikiend

wpush1:
;--kabe
ld hl, (ver1)
add hl, -32
call REDVRM
cp $80 ;--kabe
jr z, nowido1
;--
ld hl, (ver1)
    ld  a, $00
    call WRTVRM
add hl, -32
    ld  a, $82
    call WRTVRM
ld (ver1), hl
nowido1:
jr jikiend

spush1:
;--kabe
ld hl, (ver1)
add hl, 32
call REDVRM
cp $80 ;--kabe
jr z, nosido1
;--
ld hl, (ver1)
    ld  a, $00
    call WRTVRM
add hl, 32
    ld  a, $82
    call WRTVRM
ld (ver1), hl
nosido1:
jr jikiend

jikiend:
ret
;--jiki end

gameover1: ;--ゲームオーバー
    ld hl, MESSAGE4
    ld de, $1a2a 
    ld bc, 11       ; 
    call LDIRVM

    call DelayLoop
    call DelayLoop
CALL  00C0H ;--beep
CALL  00C0H ;--beep
CALL  00C0H ;--beep
;--w machi2
wmachi2:
ld a, 5
call SNSMAT ;w11101111ef
cp $ef ;w
jr z, wpush3

jp wmachi2

wpush3:

jp Main


;-- star
starido1:

ld hl, de
    ld  a, $00
    call WRTVRM
dec hl
    ld  a, $85
    call WRTVRM
   push bc
    call DelayLoop
   pop bc
    ld  a, $00
    call WRTVRM

dec de
ret

