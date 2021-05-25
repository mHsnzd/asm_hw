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
TableCount = ($ - CaseTable) / type CaseTable    ; number of cases

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
	call SelectCase                              ; rdx = 1 (error: 5 is not a case)

	mov i, 1                                     ; i = 1
	call SelectCase                              ; x = 1 rdx = 0

	call  ExitProcess
main endp


;---------------------------------------------------------
SelectCase PROC uses rax rsi rbx rdi                ; MASM directive to preserve these registers
; Receives: nothing
; Returns: rdx = 0 in case of success and 1 in case of failure. Sets x to the correct value.
;          Changes the status flags.
; Requires: nothing
;---------------------------------------------------------
	mov rdx, 1                                      ; set rdx to one in case of error

	mov bl, i                                       ; bl = i
	mov rsi, offset CaseTable                       ; rsi points to first element of caseTable 
	cmp bl, byte ptr [rsi]                          ; compares i to first element of caseTable
	jl done                                         ; terminate procedure if i<first element of caseTable
	add rsi, TableCount - 1                         ; rsi points to last element of caseTable
	cmp bl, byte ptr [rsi]                          ; compares i to last element of caseTable
	jg done                                         ; terminate procedure if i>last element of caseTable
	
	mov rdi, offset ValueTable                      ; rdi points to ValueTable's first element
	movsx rbx, i                                    ; rbx = i
	dec rbx                                         ; rbx is the index of the ith value
	mov al, [rdi + rbx]                             ; the ith value from ValueTable    
	mov x, al  
	xor rdx, rdx                                    ; clears rdx for success                            

done:	ret
SelectCase ENDP

end