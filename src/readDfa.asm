%include "constants.inc"
global readDfa

section .data
  states: db 0
  transitions: db 0
  fd: dd 0
  dfaPointer dq 0 

section .bss
  info resb 1
  
section .text
extern initDfa 

readDfa:
  ; Open the file for reading.
  .dfa equ 8
  
  mov eax, 5 ; sys_open system call
  mov rbx, rdi ; file name
  mov ecx, 0 ; read only access
  mov edx, 0777 ; permissions (read, write, and execute for all)
  int 0x80 ; call kernel

  ; Check if the file was opened successfully.
  cmp eax, -1
  je error
  
  mov [fd], eax
  xor r9, r9

; Read from the file until the end of file is reached.
read_loop:
  mov eax, 3 ; sys_read system call
  mov ebx, [fd] ; file descriptor is in the rax register
  mov ecx, info ; buffer to store the read data
  mov edx, 1 ; number of bytes to read
  int 0x80 ; call kernel

  mov r8, [info]
  cmp r8, ','  ; Compare the least significant byte (AL) of eax with ASCII value of comma (',')
  je read_loop  ; Jump if equal to comma

  ; Check if the value in eax is equal to newline ('\n')
  cmp r8, 10  ; Compare AL with ASCII value of newline ('\n')
  je second_loop  ; Jump if equal to newline
  ; Check if the end of file was reached.
  cmp eax, 0
  je end_of_file
  
  ; Print the info.
  mov eax, 4 ; sys_write system call
  mov ebx, 1 ; standard output file descriptor
  mov ecx, info ; buffer containing the read data
  mov edx, 1 ;eax ; number of bytes to print
  int 0x80 ; call kernel
  
  ; Check if r9 is 1, transition has been read
  cmp r9, 1
  jz move_transition

  ; Check if r9 is 0, state has been read
  cmp r9, 0
  jz move_state  ; Jump to move_data label if r9 is 0

  ; Go back to the beginning of the loop.
  jmp read_loop

move_state:
  mov rax, [info]  ; Move the byte from info to AL register
  mov [states], al      ; Move the value from AL to states ; Move data from info to states if r9 is 0

  inc r9
  jmp read_loop  

move_transition:
  mov rax, [info]  ; Move the byte from info to AL register
  mov [transitions], al      ; Move the value from AL to states ; Move data from info to states if r9 is 0

  movzx rdi, byte [states]  
  movzx rsi, byte [transitions]   
  call initDfa
  ; rax holds pointer to dfa struct
  ; assign it
  mov [dfaPointer], rax

  jmp read_loop  

end_of_file:
  ; Close the file.
  mov eax, 6         ; sys_close system call
  mov ebx, [fd]       ; file descriptor is in the edi register
  int 0x80           ; call kernel

  ret

second_loop:
  mov eax, 3 ; sys_read system call
  mov ebx, eax ; file descriptor is in the rax register
  mov ecx, info ; buffer to store the read data
  mov edx, 1 ; number of bytes to read
  int 0x80 ; call kernel

  mov r8, [info]
  cmp r8, ','  ; Compare the least significant byte (AL) of eax with ASCII value of comma (',')
  je second_loop  ; Jump if equal to comma

  ; Check if the value in eax is equal to newline ('\n')
  cmp r8, 10  ; Compare AL with ASCII value of newline ('\n')
  je third_loop  ; Jump if equal to newline
  ; Check if the end of file was reached.
  cmp eax, 0
  je end_of_file

  ; Print the info.
  mov eax, 4 ; sys_write system call
  mov ebx, 1 ; standard output file descriptor
  mov ecx, info ; buffer containing the read data
  mov edx, 1 ;eax ; number of bytes to print
  int 0x80 ; call kernel

  ; Go back to the beginning of the loop.
  jmp second_loop

third_loop:
  mov eax, 3 ; sys_read system call
  mov ebx, eax ; file descriptor is in the rax register
  mov ecx, info ; buffer to store the read data
  mov edx, 1 ; number of bytes to read
  int 0x80 ; call kernel

  mov r8, [info]
  cmp r8, ','  ; Compare the least significant byte (AL) of eax with ASCII value of comma (',')
  je third_loop  ; Jump if equal to comma

  ; Check if the value in eax is equal to newline ('\n')
  cmp r8, 10  ; Compare AL with ASCII value of newline ('\n')
  je fourth_loop  ; Jump if equal to newline
  ; Check if the end of file was reached.
  cmp eax, 0
  je end_of_file

  ; Print the info.
  mov eax, 4 ; sys_write system call
  mov ebx, 1 ; standard output file descriptor
  mov ecx, info ; buffer containing the read data
  mov edx, 1 ;eax ; number of bytes to print
  int 0x80 ; call kernel

  ; Go back to the beginning of the loop.
  jmp third_loop

fourth_loop:
  ret

error:
  ; Some error
  leave
  ret
