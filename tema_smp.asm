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
    ld dw ? ;inaltimea
Start:

    ;set vid mode to 320xw200 @ 256 colo
    mov ah, 0
    mov al, 13h
    int 10h
    mov cx,x1
    mov dx,y1
    add dx,l
Loop1:
    call draw
    dec dx
    cmp dx,y1
    jae Loop1
    
    mov cx,x1
    mov dx,y2
    mov cx,x3
    add cx,l                

Loop2:
    mov dx,y3
    call draw
    dec cx
    cmp cx,x3
    jae Loop2
    
    mov dx,y3
    add dx,l
Loop3:
    call draw
    dec dx
    cmp dx,y3
    jae Loop3
     
    mov cx,x3
    add cx,l                
Loop4:
    mov dx,y4
    call draw
    dec cx
    cmp cx,x3
    jae Loop4
    
    mov dx,y3
    add dx,l
Loop5:
    mov cx,x4
    call draw
    dec dx
    cmp dx,y3
    jae Loop5
    
    mov cx,x1
    add cx,25 
    mov dx,y1
    add dx,25  
Loop6:
    call draw
    dec cx
    dec dx
    cmp cx,x1
    jae Loop6 
    
     mov cx,x1
     add cx,24
     mov dx,y2
     add dx,24
Loop7:
    call draw
    dec cx
    dec dx
    cmp dx,y2
    jae Loop7 

    mov cx,x3
    mov dx,y3
    
Loop8:
    call draw
    inc cx
    sub dx,2
    cmp dx,75
    jae Loop8
    mov cx,x4
    mov dx,y3
     
Loop9:
    call draw
    dec cx
    sub dx,2
    cmp dx,75
    jae Loop9
   

    mov cx,x1
    mov dx,y1
Loop10:
    call draw
    inc cx
    sub dx,2
    cmp dx,50
    jae Loop10
    
    mov cx,x3
    mov dx,y3
    sbb dx,75
Loop11:
    call draw
    inc cx
    add dx,1
    cmp cx,x2
    jbe Loop11
        
    mov ah, 02
    mov dl, 07h       ;07h is the value to produce the beep tone
    int 21h                ;produce the sound
 
GOTOXY 0,0
PRINTN 'Dati dimensiunea ferestrei(max 20): ' 
    CALL scan_num
    mov lw,cx
    
    mov cx,xw1
    mov dx,yw1
    add dx,lw
Loop12:
    call draw
    sub dx,1
    cmp dx,yw1
    jae Loop12 
    
    mov cx,xw1
    add cx,lw
    mov dx,yw1
    add dx,lw
    
Loop13:
    call draw
    dec cx
    dec dx
    cmp dx,yw1
    jae Loop13 
    
    mov cx,xw1
    add cx,lw
    mov bx,yw1
    add bx,lw
    mov yw2,bx
    mov dx,yw2
    add dx,lw
    
Loop14:
    call draw
    dec cx
    sub dx,1
    cmp cx,xw1
    jae Loop14

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
Loop15:
    call draw
    dec dx
    cmp dx,yw2
    jae Loop15
    
mov ah,02
mov dl,07h       ;07h is the value to produce the beep tone
int 21h
GOTOXY 0,0
PRINTN 'Dati inaltimea usii(max 30):       '
CALL scan_num
mov hd,cx

GOTOXY 0,0
PRINTN 'Dati latimea usii(max 30):         '
CALL scan_num
mov ld,cx
PRINTN '                                   ' 

    mov cx,xd1
    mov dx,yd1
    sub dx,hd
Loop16:
    call draw
    inc dx
    cmp dx,yd1
    jbe Loop16 
   
    mov cx,xd1
    add cx,ld
    mov dx,yd1
    sub dx,hd 
 
Loop17:
    call draw
    inc dx
    cmp dx,yd1
    jbe Loop17  
    
    mov cx,xd1
    add cx,ld
    mov dx,yd1
    sub dx,hd
Loop18:
    call draw
    dec cx   
    cmp cx,xd1
    jae Loop18
    
hlt
draw PROC
    ;create the first point on the line and set the color
    mov al,50    
    ;crate a function to draw a pixel, then call the interupt
    mov ah,0ch
    int 10h
    ;ret
draw ENDP
DEFINE_SCAN_NUM
ret