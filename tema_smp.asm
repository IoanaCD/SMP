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
    xs dw ?
ys dw ?
nr dw ?

Start:
    ;set video mode to 320xw200 @ 256 colo
    mov ah, 0
    mov al, 13h
    int 10h   
    ;aduc in cx si dx coordonatele de plecare pentru desenarea primei linii
    mov cx,x1 
    mov dx,y1
    add dx,l; adaug si lungimea laturii
    
Loop1:
    call draw  ;apelez functia de desenare
    dec dx     ;decrementez dx
    cmp dx,y1  ;si verific daca am terminat de desenat linia
    jae Loop1  ;daca nu continui bucla
    ;trec la desenarea urmatoarei linii si pun coordonatele punctului de plecare in cx si dx
    ;mov cx,x1
    ;mov dx,y2
    mov cx,x3
    add cx,l;adaug si dimensiunea laturii                
    mov dx,y3
Loop2:
    call draw;apelez functia de desenare a unui pixel
    dec cx
    cmp cx,x3 ;si verific daca am terminat de desenat
    jae Loop2 ;daca nu, continui 
    ;trec la desenarea urmatoarei linii si pun coordonata punctului de plecare in dx
    mov dx,y3
    add dx,l
Loop3:
    call draw ;apelez functia de desenare a unui pixel
    dec dx
    cmp dx,y3 ;si verific daca am terminat de desenat
    jae Loop3 ;daca nu, continui
    ;trec la desenarea urmatoarei linii si pun coordonatele punctului de plecare in cx si dx 
    mov cx,x3
    add cx,l
    mov dx,y4                
Loop4:
    call draw ; apelez functia de desenare a unui pixel
    dec cx
    cmp cx,x3  ;verific daca am terminat de desenat
    jae Loop4  ;daca nu,continui
    ;voi face aceeasi pasi dar pentru coordonate de pornire diferite pana voi termina de desenat casuta
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
        
call sound ;cand termin de desenat casa voi apela functia ce genereaza un sunet
;mut cursorul in pozitia cea mai de sus 
GOTOXY 0,0
;si cer dimensiunile ferestrei
PRINTN 'Dati dimensiunea ferestrei(max 20): ' 
    CALL scan_num ;apelez functia pentru citirea unei valori
    mov lw,cx ;valoarea laturii o pun in variabila lw
    ;pozitionez coordonatele 
    mov cx,xw1
    mov dx,yw1
    add dx,lw ;adaug lungimea unei laturi a ferestrei
Loop12:
    call draw ;si incep sa desenez
    sub dx,1
    cmp dx,yw1 ; pana cand termin de desenat latura
    jae Loop12 
    ;voi face acelasi lucru pana cand termin de desenat fereastra
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
call sound ;termin de desenat fereastra si apelez functia de generare de sunet
;cer valorile inaltimiii si latimii pentru usa
GOTOXY 0,0
PRINTN 'Dati inaltimea usii(max 30):       '
CALL scan_num
mov hd,cx ; valoarea inaltimii o pun in hd

GOTOXY 0,0
PRINTN 'Dati latimea usii(max 30):         '
CALL scan_num 
mov ld,cx ;iar valoarea latimii in ld  
GOTOXY 0,0
PRINTN '                                   '
PRINT '      ' 
    ;pozitionez punctele de plecare pentru desenarea usii
    mov cx,xd1
    mov dx,yd1
    sub dx,hd
Loop16:
    call draw ;apelez functia de desenare
    inc dx
    cmp dx,yd1
    jbe Loop16  ;si continui sa deseez pana ajung la final
    ;fac aceeasi pasi si pentru celelalte doua laturi
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
call sound 
;acum vom desena cateva stelute
GOTOXY 0,0
PRINTN 'Alegeti punctul de pornire pentru stelute'
draw_star:
    mov ax, 0 ; initializare mouse
    int 33h
    cmp ax, 0
check_mouse_button:
    mov ax, 3
    int 33h ; preluare pozitie si status butoane
    shr cx, 1 ;  in modul grafic este dublata coordonata x
    cmp bx, 1
    jne check_mouse_button;verific daca nu apas butonul mouseului
    ;pastrez coordonatele punctului pe care am apasat
    mov xs,cx
    mov ys,dx
    add cx,4
    sub dx,4
    ;si incep sa desenez stelutele
draw_s:
    call draw
    dec cx
    inc dx
    cmp cx,xs
    jne draw_s
     
    mov cx,xs
    mov dx,ys
    sub cx,4
    add dx,4
draw_s1:
    call draw
    inc cx
    dec dx
    cmp cx,xs
    jne draw_s1
    mov cx,xs
    mov dx,ys
    sub dx,4
    sub cx,4
draw_s2:
    call draw
    inc dx
    inc cx
    cmp dx,ys
    jne draw_s2
    mov cx,xs
    mov dx,ys
    add dx,4 
    add cx,4
draw_s3:
    call draw
    dec dx
    dec cx
    cmp dx,ys
    jne draw_s3
    add dx,4
draw_s4:
    call draw
    dec dx
    cmp dx,ys
    jne draw_s4
    sub dx,4
draw_s5:
    call draw
    inc dx
    cmp dx,ys
    jne draw_s5
;verific constant daca s-a apasat esc    
check_esc_key:
    mov dl, 255
    mov ah, 6
    int 21h
    cmp al, 27 ;apasare esc?
    jne draw_star; daca nu se apasa continui desenarea    
    
hlt
sound PROC ;functie generare sunet
    mov ah, 02
    mov dl, 07h       ;07h valoarea ce produce beepul
    int 21h
sound ENDP 
draw PROC  ;functia pentru desenarea unui pixel
    ;creaza primul punct si seteaza culoarea
    mov al,50    
    mov ah,0ch
    int 10h
draw ENDP

DEFINE_SCAN_NUM
ret