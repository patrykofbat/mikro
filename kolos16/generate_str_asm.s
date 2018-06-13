    .data

text:
    .ascii  "as"

    .text
    .type generate_str, @function
    .globl generate_str
# char *generate_str(char *s, int c, int n, int inc);
# args = %rdi, %rsi, %rdx, %rcx, ret - %rax
generate_str:
    push %rdi
add:
    mov %rsi, (%rdi)
    inc %rdi
    dec %rdx
    cmp $0,%rdx
    jz theend
    cmp $0,%rcx
    jz add
    inc %rsi
    jmp add  
theend:
    pop %rax
    ret

