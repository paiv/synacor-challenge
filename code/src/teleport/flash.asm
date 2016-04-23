
    section .text
    global _flash

_flash:
  ; rdi
  ; rsi
  ; rdx
  ; rcx

x178B:
  ; cmp rcx, 0
  ; jg goon

  ; mov rax, -1
  ; ret

goon:
  ; sub rcx, 1

  cmp di, 1
  jge x1793

  mov di, si
  add di, 1
  and di, 0x7fff
  mov rax, rdi
  ret

x1793:
  cmp si, 1
  jge x17a0

  add di, 0x7fff
  and di, 0x7fff
  mov si, dx
  jmp x178B
  ; call x178B
  ; jmp done

x17a0:
  push rdi
  add si, 0x7fff
  and si, 0x7fff
  call x178B
  mov si, di
  pop rdi
  add di, 0x7fff
  and di, 0x7fff
  jmp x178B
  ; call x178B
  ; jmp done

done:
  mov rax, rdi
  ret
