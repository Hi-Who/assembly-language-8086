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
        
        mov ax,[bx]       ;读取数据段第一个数据，准备除法运算
        mov si,0ah
        mov di,0
getnumber : div si            ;取十进制各位上的数值，取出来的依次是个，十，百，千，万，，，
            mov cx,ax         ;商为0才表示十进制数的各个位数全部取完                    
            add dx,30h        ;将十进制数0~9转为对应数字的ASCII码
            push dx           ;余数入栈
            mov dx,0
            jcxz pop2strsg    ;商为零跳转至ok
            jmp getnumber             
    pop2strsg :
            pop ax            ;十进制数字从高位至低位依次取出至ax暂存            
            mov es:[di],al    ;取出的低位才是ASCII码，高位为0
            mov cx,20         ;判断是否到栈底
            sub cx,sp
            jcxz str2display  ;是则表示字符串读取完毕，跳转至显示字符步骤
            inc di
            jmp pop2strsg     ;否则继续读取字符
               
    str2display :
            mov ax,4c00h
            int 21h 
            ;准备显示字符串，先保存有用寄存器的值
            push bx
            push ds
            push si
            push di
            push es
            ;设置需显示的字符串的源地址及显示行列位置和属性
            mov dh,8                ;显示所在行
            mov dl,3                ;显示所在列
            mov cl,2                ;显示字符的属性
            mov ax,strsg            ;需要显示出来的字符串位置
            mov ds,ax
            mov si,0                ;需显示字符的起始偏移地址
        
            call show_str           ;显示字符
            ;还原寄存器的值
            
            pop es
            pop di
            pop si
            pop ds
            pop bx 

           
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
        wd2dpa: mov cl,ds:[si]          ;取data段字符,读取到最后的数字0表示前面的字符串读取完毕
                mov ch,0                ;高位置零，避免影响jcxz判断
                jcxz ok                 ;
                mov es:[di],cl          ;存字符
                mov es:[di+1],al        ;存字符属性
                inc si
                inc di
                inc di
                jmp wd2dpa                ;writedata2displayarea
        ok :
                ret                     

        
code ends
end start
