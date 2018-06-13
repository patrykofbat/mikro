    .data

.LC0:
  .string "Outter = %d\n"

    .text
    .type check_tab, @function
    .globl check_tab

check_tab:
  pushq %rbp
  movq %rsp, %rbp
  subq $48, %rsp
  movq %rdi, -24(%rbp)
  movl %esi, -28(%rbp)
  movq %rdx, -40(%rbp)
  movl $0, -4(%rbp)
.L3:
  movl -4(%rbp), %eax
  cmpl -28(%rbp), %eax
  jge .L2
  movl -4(%rbp), %eax
  leaq 0(,%rax,4), %rdx
  movq -24(%rbp), %rax
  addq %rdx, %rax
  movl (%rax), %eax
  movl %eax, %esi
  movl $.LC0, %edi
  movl $0, %eax
  call printf
  addl $1, -4(%rbp)
  jmp .L3
.L2:
  leave
  ret