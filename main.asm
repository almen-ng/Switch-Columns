%include "simple_io.inc"
global asm_main
extern rperm

; Initializations of variables 
section .data
	array:      dq 1,2,3,4,5,6,7,8
	prompt1: db "enter a,b to swap",10,0
	prompt2: db "0 to terminate",10,0
	errMess1: db "first coordinate not 1..8",10,0
	errMess2: db "comma not there", 10,0
	errMess3: db "second coordinate not 1..8",10,0

	oneBottom: db ".....+....",0

	twoTop: db "     ++   ",0
	twoBottom: db ".....++...",0

	threeTop: db "    +-+   ",0
	threeBody: db "    + +   ",0
	threeBottom: db "....+-+...",0

	fourTop: db "    +--+  ",0
	fourBody: db "    +  +  ",0
	fourBottom: db "....+--+..",0

	fiveTop: db "   +---+  ",0
	fiveBody: db "   +   +  ",0
	fiveBottom: db "...+---+..",0

	sixTop: db "   +----+ ",0
	sixBody: db "   +    + ",0
	sixBottom: db "...+----+.",0

	sevenTop: db "  +-----+ ",0
	sevenBody: db "  +     + ",0
	sevenBottom: db "..+-----+.",0

	eightTop: db "  +------+",0
	eightBody: db "  +      +",0
	eightBottom: db "..+------+",0

	emptyString: db "",10,0

	EmptyBody: db "          ",0

	labelsForTowersSpacing: db "     ",0

	oneLabel: db "1    ",0
	twoLabel: db "2    ",0
	threeLabel: db "3    ",0
	fourLabel: db "4    ",0
	fiveLabel: db "5    ",0
	sixLabel: db "6    ",0
	sevenLabel: db "7    ",0
	eightLabel: db "8    ",0

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; Display Function
display:
	enter 0,0
	saveregs
	mov rbx, [rbp+24]
	mov rdx, [rbp+32]
	mov rcx, rdx

; Counter for rows
rowCounter:
	mov r13, 0
	mov r15, rbx
	call print_nl
	cmp rcx, 1
	je bottomLevel
	jmp columnCounter

; Decrement the rows 
decrementRow:
	dec rcx
	jmp rowCounter

; Counter for columns 
columnCounter:
	cmp r13, rdx
	je decrementRow
	cmp qword [r15], rcx
	jb printEmptyBody
	cmp qword [r15], rcx
	je topLevel
	cmp qword [r15], rcx
	ja bodyLevel

; Go to a new line 
resetLine:
	mov r13, 0
	mov r15, rbx
	call print_nl

; Main function for labels 
numberLabels:
	mov rax, labelsForTowersSpacing
	call print_string
	cmp r13, rdx
	je displayend
	cmp qword [r15], 1
	je printOneLabel
	cmp qword [r15], 2
	je printTwoLabel
	cmp qword [r15], 3
	je printThreeLabel
	cmp qword [r15], 4
	je printFourLabel
	cmp qword [r15], 5
	je printFiveLabel
	cmp qword [r15], 6
	je printSixLabel
	cmp qword [r15], 7
	je printSevenLabel
	cmp qword [r15], 8
	je printEightLabel
	jmp displayend

; Print the label for column one
printOneLabel:
	mov rax, oneLabel
	call print_string
	add r15, 8
	inc r13
	jmp numberLabels

; Print the label for column two
printTwoLabel:
	mov rax, twoLabel
	call print_string
	add r15, 8
	inc r13
	jmp numberLabels

; Print the label for column three
printThreeLabel:
	mov rax, threeLabel
	call print_string
	add r15, 8
	inc r13
	jmp numberLabels

; Print the label for column four
printFourLabel:
	mov rax, fourLabel
	call print_string
	add r15, 8
	inc r13
	jmp numberLabels

; Print the label for column five
printFiveLabel:
	mov rax, fiveLabel
	call print_string
	add r15, 8
	inc r13
	jmp numberLabels

; Print the label for column six
printSixLabel:
	mov rax, sixLabel
	call print_string
	add r15, 8
	inc r13
	jmp numberLabels

; Print the label for column seven
printSevenLabel:
	mov rax, sevenLabel
	call print_string
	add r15, 8
	inc r13
	jmp numberLabels

; Print the label for column eight
printEightLabel:
	mov rax, eightLabel
	call print_string
	add r15, 8
	inc r13
	jmp numberLabels

; Main Function for the Top Level of the columns
topLevel:
	cmp qword [r15], 2
	je printTwoTop
	cmp qword [r15], 3
	je printThreeTop
	cmp qword [r15], 4
	je printFourTop
	cmp qword [r15], 5
	je printFiveTop
	cmp qword [r15], 6
	je printSixTop
	cmp qword [r15], 7
	je printSevenTop
	cmp qword [r15], 8
	je printEightTop
	jmp displayend

; Print the top for column one
printOneTop:
	mov rax, oneBottom
	call print_string
	add r15, 8
	inc r13
	jmp bottomLevel

; Print the top for column two
printTwoTop:
	mov rax, twoTop
	call print_string
	add r15, 8
	inc r13
	jmp columnCounter

; Print the top for column three
printThreeTop:
	mov rax, threeTop
	call print_string
	add r15, 8
	inc r13
	jmp columnCounter

; Print the top for column four
printFourTop:
	mov rax, fourTop
	call print_string
	add r15, 8
	inc r13
	jmp columnCounter

; Print the top for column five
printFiveTop:
	mov rax, fiveTop
	call print_string
	add r15, 8
	inc r13
	jmp columnCounter

; Print the top for column six
printSixTop:
	mov rax, sixTop
	call print_string
	add r15, 8
	inc r13
	jmp columnCounter

; Print the top for column seven
printSevenTop:
	mov rax, sevenTop
	call print_string
	add r15, 8
	inc r13
	jmp columnCounter

; Print the top for column eight
printEightTop:
	mov rax, eightTop
	call print_string
	add r15, 8
	inc r13
	jmp columnCounter

; Main Function for the Body Levels
bodyLevel:
	cmp qword [r15], 2
	cmp qword [r15], 3
	je printThreeBody
	cmp qword [r15], 4
	je printFourBody
	cmp qword [r15], 5
	je printFiveBody
	cmp qword [r15], 6
	je printSixBody
	cmp qword [r15], 7
	je printSevenBody
	cmp qword [r15], 8
	je printEightBody
	jmp displayend

; Print the body of column three
printThreeBody:
	mov rax, threeBody
	call print_string
	add r15, 8
	inc r13
	jmp columnCounter

; Print the body of column four
printFourBody:
	mov rax, fourBody
	call print_string
	add r15, 8
	inc r13
	jmp columnCounter

; Print the body of column five
printFiveBody:
	mov rax, fiveBody
	call print_string
	add r15, 8
	inc r13
	jmp columnCounter

; Print the body of column six
printSixBody:
	mov rax, sixBody
	call print_string
	add r15, 8
	inc r13
	jmp columnCounter

; Print the body of column seven
printSevenBody:
	mov rax, sevenBody
	call print_string
	add r15, 8
	inc r13
	jmp columnCounter

; Print the body of column eight
printEightBody:
	mov rax, eightBody
	call print_string
	add r15, 8
	inc r13
	jmp columnCounter

; Main function for the bottom level 
bottomLevel:
	cmp r13, rdx
	je resetLine
	cmp qword [r15], 1
	je printOneTop
	cmp qword [r15], 2
	je printTwoBottom
	cmp qword [r15], 3
	je printThreeBottom
	cmp qword [r15], 4
	je printFourBottom
	cmp qword [r15], 5
	je printFiveBottom
	cmp qword [r15], 6
	je printSixBottom
	cmp qword [r15], 7
	je printSevenBottom
	cmp qword [r15], 8
	je printEightBottom
	jmp displayend

; Print the bottom level of column two
printTwoBottom:
	mov rax, twoBottom
	call print_string
	add r15, 8
	inc r13
	jmp bottomLevel

; Print the bottom level of column three
printThreeBottom:
	mov rax, threeBottom
	call print_string
	add r15, 8
	inc r13
	jmp bottomLevel

; Print the bottom level of column four
printFourBottom:
	mov rax, fourBottom
	call print_string
	add r15, 8
	inc r13
	jmp bottomLevel

; Print the bottom level of column five
printFiveBottom:
	mov rax, fiveBottom
	call print_string
	add r15, 8
	inc r13
	jmp bottomLevel

; Print the bottom level of column six
printSixBottom:
	mov rax, sixBottom
	call print_string
	add r15, 8
	inc r13
	jmp bottomLevel

; Print the bottom level of column seven
printSevenBottom:
	mov rax, sevenBottom
	call print_string
	add r15, 8
	inc r13
	jmp bottomLevel

; Print the bottom level of column eight
printEightBottom:
	mov rax, eightBottom
	call print_string
	add r15, 8
	inc r13
	jmp bottomLevel

; Print an empty body 
printEmptyBody:
	mov rax, EmptyBody
	call print_string
	add r15, 8
	inc r13
	jmp columnCounter

; Restore all registers 
displayend:
	restoregs
	leave
	ret

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; Main Assembly Function 
asm_main:
	enter 0,0
	saveregs

	mov	rdi, array
	mov	rsi, 8

	call rperm

; Pushing to be displayed 
pushParam:
	push qword 8
	push array
	sub rsp, 8
	call display
	add rsp, 24

; Prompt determiner 
prompt:
  mov rax, emptyString
  call print_string
	mov	rax, prompt1
	call print_string
	mov	rax, prompt2
	call print_string

; Reading the input from user 
read:
	call read_char
	cmp	al, '0'
	je asm_main_end
	cmp al, '1'
	jb error1
	cmp al, '8'
	ja error1

	mov r12, 0
	mov r12b, al
	sub r12b, '0'

	call read_char
	cmp al, ','
	jne error2

	call read_char
	cmp al, '1'
	jb error3
	cmp al, '8'
	ja error3

	mov r13, 0
	mov r13b, al
	sub r13b, '0'
	mov r14, array

; Function to clean the buffer 
cleanBuffer:
	call read_char
	cmp al, 10
	je	compareFirst
	jmp cleanBuffer

; Compare the first digit
compareFirst:
	cmp [r14], r12
	je intermediateArrayAssignment
	add r14, 8
	jmp compareFirst

; Assigning the array to a register 
intermediateArrayAssignment:
	mov r15, array

; Compare the second digit 
compareSecond:
	cmp [r15], r13
	je finalize
	add r15, 8
	jmp compareSecond

; Finalize the two registers 
finalize:
	mov [r14], r13
	mov [r15], r12

	call pushParam

; Clean buffer error 
cleanBufferError:
	call read_char
	cmp al, 10
	je	pushParam
	jmp cleanBufferError

; Printing the first error: "first coordinate not 1..8"
error1:
	mov	rax, errMess1
	call	print_string
	jmp	cleanBufferError

; Printing the second error: "comma not there"
error2:
	mov	rax, errMess2
	call	print_string
	jmp	cleanBufferError

; Printing the first error: "second coordinate not 1..8"
error3:
	mov	rax, errMess3
	call	print_string
	jmp	cleanBufferError

; Restoring the registers 
asm_main_end:
	restoregs
	leave
	ret
