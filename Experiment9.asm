;实验9 以不同颜色和背景显示data中字符串

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
        
        mov ax,0b86eh        ;显示区域行地址
        mov es,ax        
        mov di,64            ;显示区域偏移地址
       
        mov cx,3             ;行循环
        mov bx,16            ;字符属性偏移首地址
        
s0:     push cx
        push di
        
        mov si,0             ;字符串原始偏移首地址        
        mov cx,16            ;列循环
       
s1:     mov al,ds:[si]       ;取字符转存至显示区域
        mov es:[di],al
        mov al,[bx]          ;取字符属性转存至属性区
        mov es:[di+1],al
        add di,2
        inc si
        loop s1
        
        pop di       
        pop cx
        add di,160           ;转至下一行
        inc bx               ;读取下一行的属性        
        loop s0
        
        mov ax,4c00h
        int 21h
        
code ends
end start
 ;耗时近2小时       
        
 