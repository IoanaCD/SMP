include 'emu8086.inc'
org 100h
jmp Start
Data:
    x1 dw 100 ;valoarea de inceput a laturii din spate pe axa x
    x2 dw 150 ;valoarea de sfarsit a laturii din spate pe axa x
    x3 dw 125 ;valoarea de inceput a laturii din fata pe axa x
    x4 dw 175 ;valoarea de sfarsit a laturii din fata pe axa x
    y1 dw 100 ;valoarea de inceput a laturii din spate pe axa y
    y2 dw 150 ;valoarea de sfarsit a laturii din spate pe axa y
    y3 dw 125 ;valoarea de inceput a laturii din fata pe axa y
    y4 dw 175 ;valoarea de sfarsit a laturii din fata pe axa y
    l dw 50 ;dimensiunea unei laturi a casei
    xw1 dw 103 ;punctul pe axa x de incepere a desenarii ferestrei
    yw1 dw 115 ;punctul pe axa y de incepere a desenarii ferestrei
    xw2 dw ? ;punctul pe x ales in functie de dimensiunea ferestrei
    yw2 dw ? ;punctul pe y ales in functie de dimensiunea ferestrei
    xd1 dw 130 ;punctul pe axa x de incepere a desenarii usii
    yd1 dw 175 ;punctul pe axa y de incepere a desenarii usii
    lw dw ? ;dimensiunea laturii ferestrei
    hd dw ? ;inaltimea usii
    ld dw ? ;latimea usii
Start:
    ;set video mode to 320xw200
    mov ah,0 
    mov al,13h
    int 10h
    ;incep desenarea laturii din spate
    mov cx,x1 ;pun in cx valoarea de inceput de pe x   
    mov dx,y1 ;pun in dx valoarea de inceput de pe y
    add dx,l ;adaug dimensiunea unei laturi
Loop1:
    call draw ;apelez functia draw pentru a desena primul pixel
    dec dx ;decrementez valoarea de pe axa y
    cmp dx,y1 ;verific daca am ajuns la sfarsitul liniei
    ;daca nu continui bucla pana ajung la finalul liniei ce trebuie desenata
    jae Loop1

    mov cx,x3
    add cx,l
    mov dx,y3                
Loop5:
    call draw
    dec cx
    cmp cx, x3
    jae Loop5


    mov dx,y3
    add dx,l
Loop6:
    call draw
    dec dx
    cmp dx,y3
    jae Loop6
    
    mov cx,x3
    add cx,l                
Loop7:
    mov dx,y4
    call draw
    dec cx
    cmp cx,x3
    jae Loop7
    
    mov dx,y3
    inc dx
    mov cx, x4
Loop8:    
    call draw
    dec dx
    cmp dx,y3
    jae Loop8
    
    mov cx,x1
    add cx,25 
    mov dx,y1
    add dx,25    
Loop9:
    call draw
    dec cx
    dec dx
    cmp cx,x1
    jae Loop9 
    
    mov cx,x1
    add cx,24
    mov dx,y2
    add dx,24
Loop10:
    call draw
    dec cx
    dec dx
    cmp dx,y2
    jae Loop10 

    mov cx,x3
    mov dx,y3
Loop12:
    call draw
    inc cx
    sub dx,2
    cmp dx, 75
    jae Loop12 
    
    mov cx,x4
    mov dx,y3  
Loop13:
    call draw
    dec cx
    sub dx,2
    cmp dx, 75
    jae Loop13
    
    mov cx,x1
    mov dx,y1
Loop15:
    call draw
    inc cx
    sub dx,2
    cmp dx, 50
    jae Loop15
    
    mov cx,x3
    mov dx,y3
    sbb dx,75
Loop16:
    call draw
    inc cx
    add dx,1
    cmp cx, x2
    jbe Loop16 
;cand termin de desenat apelez functia pentru generarea de sunet       
call sound 
;mut cursorul la inceputul paginii
GOTOXY 0,0
PRINTN 'Dati dimensiunea ferestrei(max 20): ' 
;apelez functia pentru citirea valorii dimensiunii ferestrei
CALL scan_num
mov lw,cx ;pun valoarea citita in variabila destinata memorarii acesteia
;pregatesc registrii pentru inceperea desenarii ferestrei    
mov cx,xw1
mov dx,yw1
add dx,lw

Loop17:
    call draw
    sub dx,1
    cmp dx,yw1
    jae Loop17 

mov cx,xw1
add cx,lw
mov dx,yw1
add dx,lw
Loop18:
    call draw
    dec cx
    sub dx,1
    cmp dx,yw1
    jae Loop18 
    
    mov cx,xw1
    add cx,lw
    mov bx,yw1
    add bx,lw
    mov yw2,bx
    mov dx,yw2
    add dx,lw 
Loop19:
    call draw
    dec cx
    sub dx,1
    cmp cx, xw1
    jae Loop19
    
    
    mov bx,xw1
    add bx,lw
    mov xw2,bx
    mov cx,xw1
    add cx,lw
    mov bx,yw1
    add bx,lw
    mov yw2,bx
    mov dx,yw2
    add dx,lw
Loop20:
    call draw
    sub dx,1
    cmp dx, yw2
    jae Loop20
call sound
GOTOXY 0,0
PRINTN 'Dati inaltimea usii(max 30):       '
CALL scan_num
mov hd,cx 

GOTOXY 0,0
PRINTN 'Dati latimea usii(max 30):         '
CALL scan_num
mov ld,cx 

mov cx, xd1
mov dx, yd1
sub dx,hd
Loop21:
    call draw
    inc dx
    cmp dx, yd1
    jbe Loop21 

mov cx,xd1
add cx,ld
mov dx,yd1
sub dx,hd 
Loop23:
    call draw
    inc dx
    cmp dx, yd1
    jbe Loop23  
    
mov cx,xd1
add cx,ld
mov dx,yd1
sub dx,hd
Loop22:
    call draw
    dec cx
    cmp cx, xd1
    jae Loop22

draw PROC ;desenarea unui pixel
    mov al, 50    
    mov ah, 0ch
    int 10h
draw ENDP

sound proc ;generarea de sunet
    mov ah, 02
    mov dl, 07h
    int 21h
sound ENDP
    
DEFINE_SCAN_NUM
ret