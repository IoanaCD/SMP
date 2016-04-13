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

    


    ;start the line using the cx register

    ;add l to the line

    mov cx, x1

   ; add cx, l                

    ;create a loop to draw the line 

Loop1:
   ; mov dx, y1

    ;crate a function to draw a pixel, then call the interupt

    ;call draw

    ;decrease the X value till the origin is met

    ;dec cx


    ;cmp value in cx to see if origin is met, restart loop if not

    ;cmp cx, x1

    ;jae Loop1

;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

 ;next set the dx (y coord) to ystart and add l

    ;this has to be done after the first loopstart

    mov dx, y1

    add dx, l

    ;loop from (ystart+l) to ystart and add l

Loop2:

    ;draw a pixel

   call draw

    ;decrement the y coord

    dec dx

    ;test to see if y coord has reached start value

    cmp dx, y1

    ;continue loop if dx >= ystart

    jae Loop2

;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

     ;start the line using the cx register

    ;add l to the line

    mov cx, x1

    ;add cx, 24                

     

    ;create a loop to draw the line

;Loop3:

 

    ;create the first point on the line and set the color

    ;mov al, 50
    ;
    ;mov dx, y2

     

    ;crate a function to draw a pixel, then call the interupt

    ;mov ah, 0ch

    ;int 10h

     

    ;decrease the X value till the origin is met

    ;dec cx

     

    ;cmp value in cx to see if origin is met, restart loop if not

    ;cmp cx, x1

    ;jae Loop3

     

;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

 

    ;next set the dx (y coord) to ystart and add l

    ;this has to be done after the first loopstart

    mov dx, y2

   ; add dx, l

     

    ;loop from (ystart+l) to ystart and add l

;Loop4:

 

    ;draw a pixel

    ;set color in al, x in cx, y in dx

   ; mov al, 50

   ; mov cx, x2

    ;int 10h  
    
   ; mov ah, 0ch

   ; int 10h  
     ;decrease the X value till the origin is met

    ;dec dx

     

    ;cmp value in cx to see if origin is met, restart loop if not

    ;cmp dx, y2

    ;jae Loop4

    ;start the line using the cx register

    ;add l to the line

    mov cx, x3

    add cx, l                

     

     

    ;create a loop to draw the line

Loop5:

 

  


   mov dx, y3

    call draw
     

    ;decrease the X value till the origin is met

    dec cx

     

    ;cmp value in cx to see if origin is met, restart loop if not

    cmp cx, x3

    jae Loop5

;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

 

 

 ;next set the dx (y coord) to ystart and add l

    ;this has to be done after the first loopstart

    mov dx, y3

    add dx, l

     

     

    ;loop from (ystart+l) to ystart and add l

Loop6:

 

    ;draw a pixel

    ;set color in al, x in cx, y in dx

    call draw

     

    ;decrement the y coord

    sub dx, 1

     

    ;test to see if y coord has reached start value

    cmp dx, y3

     

    ;continue loop if dx >= ystart

    jae Loop6

     

;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

     

     ;start the line using the cx register

    ;add l to the line

    mov cx, x3

    add cx, l                

     

     

    ;create a loop to draw the line

Loop7:

 

  

    mov dx, y4

   call draw

    ;decrease the X value till the origin is met

    sub cx, 1

     

    ;cmp value in cx to see if origin is met, restart loop if not

    cmp cx, x3

    jae Loop7

;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

;next set the dx (y coord) to ystart and add l

    ;this has to be done after the first loopstart

    mov dx, y3

    add dx, l

     

    ;loop from (ystart+l) to ystart and add l

Loop8:
    ;draw a pixel

    ;set color in al, x in cx, y in dx

 

    mov cx, x4
    call draw

    ;decrement the y coord

    sub dx, 1

    ;test to see if y coord has reached start value

    cmp dx, y3

    ;continue loop if dx >= ystart

    jae Loop8
    
    
    mov cx, x1
    add cx, 25 
    mov dx,y1
    add dx,25
    
Loop9:
    call draw

    ;decrement the y coord

    dec cx
    dec dx

    ;test to see if y coord has reached start value

    cmp cx, x1

    ;continue loop if dx >= ystart

    jae Loop9 
    
     mov cx,x1
     add cx,24
     mov dx,y2
     add dx,24
Loop10:
    call draw
    ;decrement the y coord

    dec cx
    dec dx

    ;test to see if y coord has reached start value

    cmp dx, y2

    ;continue loop if dx >= ystart

    jae Loop10 
     ;mov cx,x2
     ;add cx,25
    ; mov dx,y1
     ;add dx,25
Loop11:
    ;call draw

    ;decrement the y coord

    ;dec cx
    ;dec dx

    ;test to see if y coord has reached start value

    ;cmp cx, x2

    ;continue loop if dx >= ystart

    ;jae Loop11
     mov cx,x3
     ;a cx,25
     mov dx,y3
     ;add dx,25
Loop12:
    call draw

    ;decrement the y coord

    inc cx
    sub dx,2

    ;test to see if y coord has reached start value

    cmp dx, 75

    ;continue loop if dx >= ystart

    jae Loop12
    mov cx,x4
     ;sub cx,25
     mov dx,y3
     ;add dx,l
     
Loop13:
    call draw

    ;decrement the y coord

    dec cx
    sub dx,2

    ;test to see if y coord has reached start value

    cmp dx, 75

    ;continue loop if dx >= ystart

    jae Loop13
   ; mov cx,x2
     ;sub cx,25
    ;mov dx,y1
     ;add dx,l
     
Loop14:
   ; call draw

    ;decrement the y coord

    ;dec cx
   ; sub dx,2
    ;
    ;test to see if y coord has reached start value

    ;cmp dx, 50

    ;continue loop if dx >= ystart

    ;jae Loop14 
    
    mov cx,x1
     ;add cx,27
     mov dx,y1
     ;add dx,25
Loop15:
    call draw
    ;
    ;decrement the y coord

    inc cx
    sub dx,2

    ;test to see if y coord has reached start value

  cmp dx, 50

    ;continue loop if dx >= ystart

    jae Loop15
    mov cx,x3
     ;add cx,27
     mov dx,y3
     sbb dx,75
Loop16:
    call draw

    ;decrement the y coord

    inc cx
    add dx,1

    ;test to see if y coord has reached start value

    cmp cx, x2

    ;continue loop if dx >= ystart

    jbe Loop16    
    
   mov ah, 02
mov dl, 07h       ;07h is the value to produce the beep tone
int 21h                ;produce the sound
;int 20h 
GOTOXY 0,0
PRINTN 'Dati dimensiunea ferestrei(max 20): ' 
    CALL scan_num
    mov lw,cx
    
    mov cx,xw1
    mov dx,yw1
    add dx,lw
Loop17:
    call draw

    ;decrement the y coord

    ;dec cx
    sub dx,1

    ;test to see if y coord has reached start value

    cmp dx, yw1

    ;continue loop if dx >= ystart

    jae Loop17 
    
    
    mov cx,xw1
    add cx,lw
    mov dx,yw1
    add dx,lw
Loop18:
    call draw

    ;decrement the y coord

    dec cx
    sub dx,1

    ;test to see if y coord has reached start value

    cmp dx, yw1

    ;continue loop if dx >= ystart

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

    ;decrement the y coord

    dec cx
    sub dx,1

    ;test to see if y coord has reached start value

    cmp cx, xw1

    ;continue loop if dx >= ystart

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

    ;decrement the y coord

    ;dec cx
    sub dx,1

    ;test to see if y coord has reached start value

    cmp dx, yw2

    ;continue loop if dx >= ystart

    jae Loop20
mov ah, 02
mov dl, 07h       ;07h is the value to produce the beep tone
int 21h
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

    ;decrement the y coord

    ;dec cx
    inc dx

    ;test to see if y coord has reached start value

    cmp dx, yd1

    ;continue loop if dx >= ystart

    jbe Loop21 
    

    
    mov cx,xd1
    add cx,ld
    mov dx,yd1
    sub dx,hd 
    ;inc dx
Loop23:
    call draw

    ;decrement the y coord

    inc dx
    

    ;test to see if y coord has reached start value

    cmp dx, yd1

    ;continue loop if dx >= ystart

    jbe Loop23  
    
    mov cx,xd1
    add cx,ld
    mov dx,yd1
    sub dx,hd
Loop22:
    call draw

    ;decrement the y coord

    dec cx
    

    ;test to see if y coord has reached start value

    cmp cx, xd1

    ;continue loop if dx >= ystart

    jae Loop22
    

draw PROC
    ;create the first point on the line and set the color
    mov al, 50    
    ;crate a function to draw a pixel, then call the interupt
    mov ah, 0ch
    int 10h
    ;ret
draw ENDP
DEFINE_SCAN_NUM
ret







