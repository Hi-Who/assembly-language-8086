; ʵ��7 �����Աƽ�����벢����洢

assume cs:code,ds:data,es:table

data segment
    db '1975','1976','1977','1978','1979','1980','1995'
    ;���϶�����ݣ�7��
    dd 16,22,382,1356,2390,8000,5937000 ;����
    dw 3,7,9,13,28,38,17800 ;��Ա��
data ends

table segment
    db 7 dup ('year summ ne ?? ')
table ends

code segment

start : mov ax,data
        mov ds,ax
        mov ax,table
        mov es,ax
        
        mov bx,0
        mov di,56
        mov si,0                  ;table����ƫ��
        mov cx,7
        
      s:mov ax,[bx+28]
        mov dx,[bx+30]
        div word ptr [di]         ;ƽ���������
        
        
        mov es:[si+13],ax         ; �̴���table
        
        ;��ݴ���table
        mov ax,[bx]
        mov es:[si],ax            
        mov ax,[bx+2]
        mov es:[si+2],ax 
        
        ;�������table
        mov ax,[bx+28]
        mov es:[si+5],ax
        mov ax,[bx+30]
        mov es:[si+7],ax
        
        ;��Ա������table
        mov ax,[di]
        mov es:[si+10],ax
        
        add bx,4
        add di,2
        add si,16
        
        loop s
        
        mov ax,4C00H
        INT 21H
code ends
end start


        
        