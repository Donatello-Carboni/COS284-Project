%include "constants.inc"
global simulateDfa

section .text
;
; DFA *init_dfa(int numStates, int numTransitions)
;
simulateDfa:
    mov rax, 1
    ret