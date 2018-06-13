    # constants
    .equ kernel, 0x80
    .equ write, 0x04
    .equ exit, 0x01
    .equ stdout, 0x01

    .data
    
arg1txt:
    .ascii "Arg1 = "
arg2txt:
    .ascii "Arg2 = "
sumtxt:
    .ascii "Sum = "
difftxt:
    .ascii "Diff = "
ortxt:
    .ascii "OR = "
andtxt:
    .ascii "AND = "
xortxt:
    .ascii "XOR = "

arg1:
    .byte 0xA0 # 160
arg2:
    .byte 0x05 # 5
result:
    .byte 0    #max 255
tmp:
    .byte 0    #helper to calculation
resttxt:
    .ascii " \n"
txtlen:
    .long 7
reslen:
    .long 3

    .text
    .global _start

_start:
    MOVB arg1, %al
    MOVL $arg1txt, %ecx
    CALL displine
    NOP
    

     # dodajemy liczby
    MOVB arg1,%al
    ADDB arg2,%al
    MOVB %al,result # przekazujemy wynik do zmiennej
    MOVL $sumtxt,%ecx
    CALL displine
    NOP

    # odejmujemy liczby od siebie
    MOVB arg1,%al
    SUBB arg2,%al
    MOVB %al,result
    MOVL $difftxt,%ecx
    CALL displine
    NOP

    # tym razem stosujemy operator logiczny OR
    MOVB arg1,%al
    ORB arg2,%al
    MOVB %al,result
    MOVL $ortxt,%ecx
    CALL displine
    NOP

    # operator AND
    MOVB arg1,%al
    ANDB arg2,%al
    MOVB %al,result
    MOVL $andtxt,%ecx
    CALL displine
    NOP

    # operator XOR
    MOVB arg1,%al
    XORB arg2,%al
    MOVB %al,result
    MOVL $xortxt,%ecx
    CALL displine
    NOP
theend:
    MOVL $exit,%eax
    INT $kernel



.type displine, @function
displine:
    MOVB %al, tmp
    NOP
    MOVL $write, %eax
    MOVL $stdout, %ebx
    MOVL txtlen, %edx
    INT $kernel
    NOP

    MOVB tmp, %al
    AND $0x0F, %al #bierzemy 4 najmlodsze bity 0x0F = 15 = 1111
    CMPB $10, %al
    JB digit1
    ADDB $('A'-0x0A), %al
    JMP insert1
digit1:
    ADDB $'0', %al
insert1:
    MOV %al, %ah
    NOP

    MOVB tmp, %al
    SHR $4, %al
    CMPB $10, %al
    JB digit2
    ADDB $('A'-0x0A), %al
    JMP insert2

digit2:
    ADDB $'0',%al

insert2:
    MOVW %ax, resttxt
    NOP
    MOVL $write, %eax
    MOVL $stdout, %ebx
    MOVL $resttxt, %ecx
    MOVL reslen, %edx
    INT $kernel
    RET






