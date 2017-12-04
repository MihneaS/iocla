%include "io.inc"

section .data
    %include "input.inc"
    bad_base: db "Baza incorecta", 0

section .text
global CMAIN
CMAIN:
    mov ebp, esp

    xor ecx, ecx;                       for(ecx = 0; ecx != nums;ecx ++)
    forbeg:
    cmp ecx, [nums]
    jae forend
        cmp DWORD[base_array + 4*ecx], 2;   if base_array[ecx] <2
        jae nextcheck;
        badbase:
            PRINT_STRING bad_base;              print "Baza incorecta"
            NEWLINE;                            print new line
            jmp forinc
        nextcheck:;                         else
            cmp DWORD[base_array + 4*ecx], 16;  if base_array[ecx] > 16
            ja badbase;                             print "Baza incorecta" 
;                                               else
            mov eax, [nums_array + 4*ecx];          eax = nums_array[ecx]
            test eax, eax;                          if eax == 0
            jnz convertno
                PRINT_CHAR '0';                         print 0
                NEWLINE;                                print new line
            jmp forinc
            convertno:;                             else
                dowhile1:;                              do
                    xor edx, edx;                           edx:eax = unsigned eax
                    div DWORD[base_array + 4*ecx];          eax = edx:eax/base_array[ecx]
                    push dx;                                push edx:eax%base_array[ecx] as word
                test eax, eax
                jnz dowhile1;                           while(eax != 0)

                dowhile2:;                              do
                    pop ax;                                 pop ax as word
                    cmp ax, 9;                              if(ax <= 9)
                    ja isalpha
                        add ax, '0';                            ax += '0'
                        jmp endif
                    isalpha:;                               else
                        add ax, 'a' - 10;                       ax += 'a' - 10
                    endif:
                    PRINT_CHAR al;                          print al as char
                cmp esp, ebp;
                jnz dowhile2;                           while (!stackEmpty)
                NEWLINE;                                print new line
    forinc:
    inc ecx;        ecx++
    jmp forbeg;     redo for
    forend:

    xor eax, eax;   eax = 0
    mov esp, ebp;   restore stack pointer
    ret;            return eax // 0
