; ʵ��10.1 ��ָ����������ַ�����ָ��λ��
assume cs:code,ds:data

data segment
        db 'HELLO WORLD !welcome to masm!',0
data ends

code segment
start : 
        mov dh,8
        mov dl,3
        mov cl,2
        mov ax,data
        mov ds,ax
        mov si,0
        call show_str
        mov ax,4c00h
        int 21h
show_str:
        mov ax,0b800h           ;��ʾ�����׵�ַ
        mov es,ax
        
        mov ax,0A0h             ;ָ������ƫ�Ƶ�ַ
        mul dh
        mov di,ax
        
        mov ax,2
        mul dl
        add di,ax               ;ָ������ʾ�����׵�ַdi
        
        mov al,cl               ;�ݴ��ַ�����
show :  mov cl,ds:[si]          ;ȡdata���ַ�
        mov ch,0                ;��λ���㣬����Ӱ��jcxz�ж�
        jcxz stop
        mov es:[di],cl          ;���ַ�
        mov es:[di+1],al        ;���ַ�����
        inc si
        inc di
        inc di
        jmp show
stop :
        ret     
code ends
end start