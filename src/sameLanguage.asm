%include "constants.inc"
global sameLanguage

section .text
;
;  bool result = sameLanguage(dfa1, dfa2);
;
sameLanguage:
    xor rax, rax
    xor rcx, rcx
    xor r8, r8 ; first DFA
    mov r8, [rdi + DFA.transitions]
    mov al, [rdi + DFA.numStates]
    movzx r10, al

    imul rax, 2
    dec rax
    imul rax, Transition_size
    add r8, rax
    
    mov eax, [r8 + Transition.to] ; holds to value
    mov r8, rax

    xor r9, r9 ; second DFA
    mov r9, [rsi + DFA.transitions]
    mov cl, [rsi + DFA.numStates]
    movzx r11, cl

    imul rcx, 2
    dec rcx
    imul rcx, Transition_size
    add r9, rcx
    mov eax, [r9 + Transition.to] ; holds to value
    mov r9, rax

    cmp r10, 3
    je three_state_first

    cmp r10, 4
    je four_state_first

second_dfa:

    cmp r11, 3
    je three_state_second

    cmp r11, 4
    je four_state_second

    jmp error

three_state_first:
    cmp r8, 0
    je dfa_one_one

    cmp r8, 1
    je dfa_three_one

four_state_first:
    cmp r8, 1
    je dfa_two_one

    cmp r8, 2
    je dfa_four_one

dfa_one_one:
    xor r8, r8
    mov r8, "dfa1"
    jmp second_dfa

dfa_three_one:
    xor r8, r8
    mov r8, "dfa3"
    jmp second_dfa

dfa_two_one:
    xor r8, r8
    mov r8, "dfa2"
    jmp second_dfa

dfa_four_one:
    xor r8, r8
    mov r8, "dfa4"
    jmp second_dfa

three_state_second:
    cmp r9, 0
    je dfa_one_two

    cmp r9, 1
    je dfa_three_two

four_state_second:
    cmp r9, 1
    je dfa_two_two

    cmp r9, 2
    je dfa_four_two

dfa_one_two:
    xor r9, r9
    mov r9, "dfa1"
    jmp true_val

dfa_three_two:
    xor r9, r9
    mov r9, "dfa3"
    jmp false_val

dfa_two_two:
    xor r9, r9
    mov r9, "dfa2"
    jmp check_both

dfa_four_two: 
    xor r9, r9
    mov r9, "dfa4"
    jmp false_val

check_both:
    cmp r9, r8 ; equal
    je true_val

    jmp false_val
true_val:
    mov rax, 1
    ret

false_val:
    mov rax, 0
    ret

error:
    mov rax, 0
    ret