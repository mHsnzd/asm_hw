; select case - 64 bit - MASM                    (selectCase.asm)

; Program Description: Assembly code that does the same job as the 
;                      C switch statement below: 
;					   switch(i) {
;						    case 1:
;						    {
;						        x = 1;
;						        break;
;						    }
;						    case 2:
;						    {   
;						        x = 2;
;						        break;
;						    }
;						    case 3:
;						    {
;						        x = 3;
;						        break;
;						    }
;						    case 4:
;						    {
;						        x = 4;
;						        break;
;						    }
;						}
;
; Creation Date: 25/5/2021

ExitProcess PROTO

.data
CaseTable byte 1                                 ; table for look up values
          byte 2
		  byte 3
		  byte 4
TableCount byte 4                                ; number of cases 

ValueTable byte 1                                ; table for values 
           byte 2
		   byte 3
		   byte 4

i          byte ?                                ; i in switch statement
x          byte ?                                ; x in switch statement


;---------------------------------------------------------
.code
main proc
	                                    
	mov i, 5                                     ; i = 5
	call SelectCase                              ; returns without changing x

	mov i, 1                                     ; i = 1
	call SelectCase                              ; x = 1

	call  ExitProcess
main endp

;---------------------------------------------------------
SelectCase PROC uses rax rsi rbx                   ; MASM directive to preserve these registers
; Receives: nothing
; Returns: Sets x to the correct value.
;          Changes the status flags.
; Requires: nothing
;---------------------------------------------------------
	mov bl, i                                      ; bl = i
	cmp bl, [CaseTable]                            ; compares i to 1
	jl done                                        ; terminate procedure if i<1
	cmp bl, [CaseTable + 3]                        ; compares i to 4
	jg done                                        ; terminate procedure if i>4
	
	mov rsi, offset ValueTable                     ; rsi points to ValueTable's first element
	movsx rbx, i                                   ; rbx = i
	dec rbx                                        ; rbx is the index of the ith value
	mov al, [rsi + rbx]                            ; the ith value from ValueTable    
	mov x, al                          

done:	ret
SelectCase ENDP

end