.model small
.stack 100h



PRINT MACRO MSG
mov ah, 9
lea dx, MSG
int 21h
ENDM


.data

        val1 dw ?
        val2 dw ?
        res dw 0
        result dw 1
        base db ?
        powerr db ?
        var1 db 100 dup('$')

        PR1 db 0dh, 0ah, 'a-addition$'
        PR2 db 0dh,0ah, 'b-Subtraction$'
        PR3 db 0dh,0ah, 'c-Multiplication$'
        PR4 db 0dh, 0ah, 'd-Division$'
        PR5 db 0dh, 0ah, 'e-Factorial$'
        PR6 db 0dh, 0ah, 'f-Square of any number$'
        PR7 db 0dh,0ah, 'g-Cube of any number$'
        PR8 db 0dh,0ah, 'h-Calculate power$'

        MSG4 db 10,13, 'Press the key of the operation you want to select:   $'
        MSG5 db 10,13, 'Enter first  number (0-9): $'
        MSG6 db 10,13, 'Enter second  number(0-9):  $'
        MSG7 db 10,13, 'The result is: $'
        MSG8 db 10,13, 'Thank you for using the calculator !!! $'
        MSG9 db 10,13, 'Choice Error, TRY AGAIN! $'
        MSG10 db 10,13, 'Enter the base: $'
        MSG11 db 10,13, 'Enter the power: $'
        MSG12 db 10,13, "Enter a number  to square (0-9) $"
        MSG13 db 10,13, "Enter a number  to cube  (0-4) $"
        MSG14 db 10,13, "Enter base $"
        MSG15 db 10,13,"Enter power $"
        MSG16 db ' ^ $'
        MSG17 db ' =  $'
        MSG18 db 10,13, "Enter the number to factorial (1-8): $"
        MSG19 db 10,13, 'Enter first - bigger number (0-9): $'
        MSG20 db 10,13, 'Enter second - smaller number(0-9):  $'
        LINE db 13,10, "$"

        SQ1 db 10,13, 'Square of  $'
        SQ2 db " is $"
        CB1 db 10,13, 'Square of  $'
        CB2 db " is $"
        QUIT db 10,13, "Do you want to repeat y/n $"

        WELCOME DB 'Welcome $'
        USERNAME DB 10,13,'Enter a username:$'


.code

MAIN PROC
mov ax, @data
mov ds, ax


PRINT USERNAME
mov si, offset var1
l1:
mov ah,1
int 21h

cmp al, 13
je printusername

mov[si], al
inc si
jmp l1

printusername:
PRINT Welcome
PRINT var1
PRINT LINE



start:
PRINT LINE
PRINT PR1
PRINT PR2
PRINT PR3
PRINT PR4
PRINT PR5
PRINT PR6
PRINT PR7
PRINT PR8

PRINT MSG4

mov ah, 0
int 16h
cmp al, 61h
jne j1
jmp Addition
j1:
cmp al, 62h
jne j2
jmp Subtraction
j2:
cmp al, 63h
jne j3
jmp Multiplication
j3:
cmp al, 64h
jne j4
jmp Division
j4:
cmp al, 65h
jne j5
jmp Factorial
j5:
cmp al, 66h
jne j6
jmp Squared
j6:
cmp al, 67h
jne j7
jmp Cube
j7:
cmp al, 68h
jne try
jmp Power

try:
PRINT LINE
PRINT MSG9
jmp start


Addition:
PRINT MSG5
mov ah, 1
int 21h
mov val1, al

PRINT MSG6
mov ah, 1
int 21h
mov val2, al

add al, val1
mov ah, 0
aaa
add al, 48
add ah, 48

mov bx,ax

PRINT MSG7
mov ah, 2
mov dl, bh
int 21h

mov ah,2
mov dl, bl
int 21h

PRINT quit
mov ah, 1
int 21h
or al, 20h
cmp al, 'y'
jne e11
jmp start
e11:
mov ah, 4ch
int 21h

Subtraction:
PRINT MSG19
mov ah,  1
int 21h
mov bl ,al

PRINT MSG20
mov ah, 1
int 21h
mov cl, al

sub bl, cl
add bl, 48

PRINT MSG7
mov ah, 2
mov dl, bl
int 21h

PRINT quit
mov ah, 1
int 21h
or al, 20h
cmp al, 'y'
jne e9
jmp start
e9:
mov ah, 4ch
int 21h


Multiplication:
PRINT MSG5
mov ah, 1
int 21h
mov val1, al
sub val1, 30h

PRINT MSG6
mov ah, 1
int 21h
sub al, 30h

mul val1
mov res, al
aam

add ah, 30h
add al, 30h

mov bx ,ax

PRINT MSG7
mov ah,2
mov dl, bh
int 21h

mov ah,2
mov dl, bl
int 21h

PRINT quit
mov ah, 1
int 21h
or al, 20h
cmp al, 'y'
jne e6
jmp start
e6:
mov ah, 4ch
int 21h

Division:
PRINT MSG5
mov ah, 1
int 21h

sub al, '0'
mov val1, al

PRINT MSG6
mov ah, 1
int 21h

sub al, '0'
mov val2, al

PRINT MSG7

mov ax ,val1
mov dx, 0
div val2
mov dl, ax
add dl, '0'

mov ah, 2h
int 21h
PRINT quit
mov ah, 1
int 21h
or al, 20h
cmp al, 'y'
jne e10
jmp start
e10:
mov ah, 4ch
int 21h

Factorial:
PRINT MSG18
facts:
mov ah, 1
int 21h
cmp al, 13d
jne n1

and cx, 0
mov cl, bh
dec cx
and ax, 0
mov al, bh

jmp fact


n1:
sub al, 30h
mov cl, al
mov al, bh
mul bl
add al, cl
mov bh, al


jmp facts

fact:
mul cx
loop fact

and dx, 0
mov cx, 10d
mov bx, 0000H

store:
div cx
mov[0000H+bx], dx
add bx, 2h
mov dx,0
cmp ax,0
jne store

mov ah, 2
mov dl, 0dh
int 21h
mov dl, 0ah
int 21h


printt:
sub bx, 2h
mov dl, [0000H+bx]
add dl, 30h
int 21h

cmp bx, 0
jne printt

PRINT quit
mov ah, 1
int 21h
or al, 20h
cmp al, 'y'
jne e5
jmp start
e5:
mov ah, 4ch
int 21h

Power:

PRINT MSG15
mov ah, 1
int 21h
mov [powerr], al
sub [powerr], 30h

PRINT MSG14
mov ah, 1
int 21h
sub al, 30h
mov [base], al
mov cl, [powerr]

mult:
mul [result]
cmp cl, 1
je inner_exit
mov result, ax
mov al, [base]
loop mult

inner_exit:
aam
mov [result], ax

PRINT line
mov dl, [base]
add dl, 30h
mov ah, 2
int 21h

PRINT MSG16

mov dl, [powerr]
add dl, 30h
mov ah, 2
int 21h

PRINT MSG17

mov dl, byte ptr result[1]
add dl, 30h
mov ah, 2
int 21h

mov dl, byte ptr result[0]
add dl, 30h
mov ah, 2
int 21h

PRINT quit
mov ah, 1
int 21h
or al, 20h
cmp al, 'y'
jne e3
jmp start
e3:
mov ah, 4ch
int 21h

Squared:
PRINT MSG12
mov ah, 1
int 21h
push ax
cmp al, 39h
jg Squared
cmp al, 30h
jl Squared
push ax
sub al, 30h
mov bl, al
mul bl
aam

mov bx, ax
PRINT SQ1
pop dx
mov ah, 2
int 21h
PRINT SQ2

mov dl, bh
add dl, 30h
mov ah, 2
int 21h

mov dl,bl
add dl, 30h
mov ah, 2
int 21h

PRINT quit
mov ah, 1
int 21h
or al, 20h
cmp al, 'y'
jne e1
jmp start

e1:
mov ah, 4ch
int 21h

 Cube:
PRINT MSG13
mov ah, 1
int 21h
push ax
cmp al, 39h
jg Cube
cmp al, 30h
jl Cube
push ax
sub al, 30h
mov bl, al
mul bl
mul bl
aam

mov bx, ax
PRINT CB1
pop dx
mov ah, 2
int 21h
PRINT CB2

mov dl, bh
add dl, 30h
mov ah, 2
int 21h

mov dl,bl
add dl, 30h
mov ah, 2
int 21h

PRINT quit
mov ah, 1
int 21h
or al, 20h
cmp al, 'y'
jne e2
jmp start
e2:
mov ah, 4ch
int 21h

MAIN ENDP
END MAIN
