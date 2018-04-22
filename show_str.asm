; 实验10.1 按指定属性输出字符串到指定位置
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
        mov ax,0b800h           ;显示区域首地址
        mov es,ax
        
        mov ax,0A0h             ;指定的行偏移地址
        mul dh
        mov di,ax
        
        mov ax,2
        mul dl
        add di,ax               ;指定的显示区域首地址di
        
        mov al,cl               ;暂存字符属性
show :  mov cl,ds:[si]          ;取data段字符
        mov ch,0                ;高位置零，避免影响jcxz判断
        jcxz stop
        mov es:[di],cl          ;存字符
        mov es:[di+1],al        ;存字符属性
        inc si
        inc di
        inc di
        jmp show
stop :
        ret     
code ends
end start