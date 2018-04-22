assume cs:code,ds:data,ss:stack,es:strsg

data segment
        dw 123,12666,1,8,3,38
data ends

stack segment
        dw 10 dup (0)
stack ends

strsg segment
        db '00000000',0        
strsg ends

code segment
start : mov ax,data
        mov ds,ax
        mov ax,stack
        mov ss,ax
        mov sp,20
        mov ax,strsg
        mov es,ax
        mov bx,2
        
        mov ax,[bx]       ;��ȡ���ݶε�һ�����ݣ�׼����������
        mov si,0ah
        mov di,0
getnumber : div si            ;ȡʮ���Ƹ�λ�ϵ���ֵ��ȡ�����������Ǹ���ʮ���٣�ǧ���򣬣���
            mov cx,ax         ;��Ϊ0�ű�ʾʮ�������ĸ���λ��ȫ��ȡ��                    
            add dx,30h        ;��ʮ������0~9תΪ��Ӧ���ֵ�ASCII��
            push dx           ;������ջ
            mov dx,0
            jcxz pop2strsg    ;��Ϊ����ת��ok
            jmp getnumber             
    pop2strsg :
            pop ax            ;ʮ�������ִӸ�λ����λ����ȡ����ax�ݴ�            
            mov es:[di],al    ;ȡ���ĵ�λ����ASCII�룬��λΪ0
            mov cx,20         ;�ж��Ƿ�ջ��
            sub cx,sp
            jcxz str2display  ;�����ʾ�ַ�����ȡ��ϣ���ת����ʾ�ַ�����
            inc di
            jmp pop2strsg     ;���������ȡ�ַ�
               
    str2display :
            mov ax,4c00h
            int 21h 
            ;׼����ʾ�ַ������ȱ������üĴ�����ֵ
            push bx
            push ds
            push si
            push di
            push es
            ;��������ʾ���ַ�����Դ��ַ����ʾ����λ�ú�����
            mov dh,8                ;��ʾ������
            mov dl,3                ;��ʾ������
            mov cl,2                ;��ʾ�ַ�������
            mov ax,strsg            ;��Ҫ��ʾ�������ַ���λ��
            mov ds,ax
            mov si,0                ;����ʾ�ַ�����ʼƫ�Ƶ�ַ
        
            call show_str           ;��ʾ�ַ�
            ;��ԭ�Ĵ�����ֵ
            
            pop es
            pop di
            pop si
            pop ds
            pop bx 

           
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
        wd2dpa: mov cl,ds:[si]          ;ȡdata���ַ�,��ȡ����������0��ʾǰ����ַ�����ȡ���
                mov ch,0                ;��λ���㣬����Ӱ��jcxz�ж�
                jcxz ok                 ;
                mov es:[di],cl          ;���ַ�
                mov es:[di+1],al        ;���ַ�����
                inc si
                inc di
                inc di
                jmp wd2dpa                ;writedata2displayarea
        ok :
                ret                     

        
code ends
end start
