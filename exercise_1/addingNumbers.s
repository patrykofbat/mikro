#----------------------------------------------------------------
# Program LAB_1.S - Asemblery Laboratorium IS II rok
# Zadaniem programu jest przeprowadzenie podstawowych operacji
# na liczbach całkowitych.
#----------------------------------------------------------------

 .equ kernel,0x80 #Numer przerwania do systemu
 .equ write,0x04 # #write data to file function
 .equ exit,0x01 #exit program function
 .equ stdout,0x01 #handle to stdout
 .data

starttxt: #first message
 .ascii "Start\n"
endtxt: #second message
 .ascii "Koniec\n"
arg1: #liczba 8-bitowa
 .byte 1
arg2: #liczba 16-bitowa
 .word 2
arg3: #liczba typu long
 .long 3
result: #miejsce gdzie przechowamy wyniki
 .long 0
.equ startlen, endtxt - starttxt
.equ endlen, arg1 - endtxt
 .text
 .global _start

_start:
 nop # nic nie robienie w tym momencie
 MOVL $write,%eax
 MOVL $stdout,%ebx
 MOVL $starttxt,%ecx
 MOVL $startlen,%edx
 INT $kernel
 NOP
 MOVL arg1,%eax # wprowadzenie liczb do rejestrow
 MOVL arg2,%ebx
 MOVL arg3,%ecx
 ADD %ebx,%eax # dodanie do siebie liczb
 SUB %ecx,%eax # odjęcie od siebie liczb
 MOVL %eax,result # zapisanie wyniku do zmiennej result
 NOP # odczekamy

 MOVL $write,%eax # wypisujemy jak w lab0 pliczek
 MOVL $stdout,%ebx
 MOVL $endtxt,%ecx
 MOVL $endlen,%edx
 INT $kernel
 NOP
theend:
 MOVL $exit,%eax
 MOVL result, %ebx # system przekaze wynik jako wartosc zakonczenia
 INT $kernel