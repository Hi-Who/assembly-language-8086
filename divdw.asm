; ��������������
assume cs:code,ss:stack

stack segment
        dw 0,0,0,0
stack ends

code segment 

start :
        mov ax,4240h    ;���32bit��������λ
        mov dx,000fh    ;���32bit��������λ
        mov cx,0ah      ;��ų���
        call divdw
        mov ax,4c00h
        int 21h
divdw :
        mov bx,ax       ;bx�ݴ汻������λ
        mov ax,dx       ;��λ���Գ���
        mov dx,0
        div cx
        push ax         ;�̸�λ��ջ
        mov ax,bx       ;��������λת��ax
        div cx
        mov cx,dx       ;��������cx
        pop dx          ;�̸�λ����dx        
        ret
code ends
end start

        