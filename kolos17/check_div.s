    .data
result:
    .quad 0
tmp:
    .quad 1
licz:
    .byte 1

    .text
    .type check_div, @function
    .globl check_div
#unsigned long check_div(long a, long b, long c);
check_div:
    cmp $0, %rdx
    jnz cRozneZero #check c flag
    mov %rdi, %rax
    div %rsi # %rax / %rsi reminder in %rdx
    cmp $0, %rdx
    jz divisible
    movq $0, %rax
    jmp theend
cRozneZero:
    mov licz, %rcx #save licz in %rcx
    mov tmp, %r8 #save tmp in %r8
    mov result, %r9 #save result in %r9
loop:
    mov %rdi, %rax # a-> %rax
    cmp $64, %rcx # check licznik 
    ja theend # jmp if %rcx > 64
    xor %rdx, %rdx
    div %rcx # %rax(a) / % rcx reminder %rdx
    inc %rcx # zwiekszamy licznik
    cmp $0, %rdx #check if divisible_2
    jz divisible_2
    shl $1, %r8
    jmp loop
divisible_2:
    add %r8, %r9
    shl $1, %r8
    jmp loop
divisible:
    movq $1, %r9
theend:
    mov %r9, %rax
    ret 