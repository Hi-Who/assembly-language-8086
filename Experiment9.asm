;ʵ��9 �Բ�ͬ��ɫ�ͱ�����ʾdata���ַ���

assume cs:code,ds:data,ss:stack

data segment
        db 'welcome to masm!'
        db 02h,24h,71h
data ends

stack segment
        dw 0,0,0,0
stack ends

code segment

start : 
        mov ax,data
        mov ds,ax
        
        mov ax,0b86eh        ;��ʾ�����е�ַ
        mov es,ax        
        mov di,64            ;��ʾ����ƫ�Ƶ�ַ
       
        mov cx,3             ;��ѭ��
        mov bx,16            ;�ַ�����ƫ���׵�ַ
        
s0:     push cx
        push di
        
        mov si,0             ;�ַ���ԭʼƫ���׵�ַ        
        mov cx,16            ;��ѭ��
       
s1:     mov al,ds:[si]       ;ȡ�ַ�ת������ʾ����
        mov es:[di],al
        mov al,[bx]          ;ȡ�ַ�����ת����������
        mov es:[di+1],al
        add di,2
        inc si
        loop s1
        
        pop di       
        pop cx
        add di,160           ;ת����һ��
        inc bx               ;��ȡ��һ�е�����        
        loop s0
        
        mov ax,4c00h
        int 21h
        
code ends
end start
 ;��ʱ��2Сʱ       
        
 