; 解决除法溢出问题
assume cs:code,ss:stack

stack segment
        dw 0,0,0,0
stack ends

code segment 

start :
        mov ax,4240h    ;存放32bit被除数低位
        mov dx,000fh    ;存放32bit被除数高位
        mov cx,0ah      ;存放除数
        call divdw
        mov ax,4c00h
        int 21h
divdw :
        mov bx,ax       ;bx暂存被除数低位
        mov ax,dx       ;高位除以除数
        mov dx,0
        div cx
        push ax         ;商高位入栈
        mov ax,bx       ;被除数低位转至ax
        div cx
        mov cx,dx       ;余数存入cx
        pop dx          ;商高位存入dx        
        ret
code ends
end start

        