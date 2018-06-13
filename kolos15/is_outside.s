    .data
a:
    .quad 0


    .text
    .type is_outside, @function
    .globl is_outside

is_outside:
    mov %rsi, a

    cmpq a, %rdx
    jg b_greater
a_check:
    cmpq %rdx, a
    jg a_greater
    # a<=b
    cmp %rdx, %rdi
    jg x_greatest
    cmp a, %rdi
    jl x_lowest
    mov $0, %rax
    jmp theend


# a<b
b_greater:
    cmp %rdx, %rdi
    jg x_greatest
    cmp a, %rdi
    jl x_lowest
    mov $0, %rax
    jmp theend

# a>b
a_greater:
    cmp a, %rdi
    jg x_greatest
    cmp %rdx, %rdi
    jl x_lowest
    mov $0, %rax
    jmp theend

x_greatest:
    mov $1, %rax
    jmp theend

x_lowest:
    mov $-1, %rax

theend:
    ret