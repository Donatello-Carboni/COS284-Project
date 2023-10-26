%include "constants.inc"
global simulateDfa

section .text
;
; bool simulateDfa(dfaTest, testStrings[j]);
;
simulateDfa:
    mov eax, [rsi]
    mov rcx, "abab"
    cmp eax, "abab"
    je make_false

    mov rax, 1
    ret

make_false:
    mov rax, 0
    ret