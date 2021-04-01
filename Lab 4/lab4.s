        .syntax		unified
		.cpu		cortex-m4
		.text
		.global		Discriminant
		.thumb_func

Discriminant:
		MUL R1,R1,R1			//R1 = b * b
		LSL R0,R0,2				//R0 = 4 * a
		MLS R0,R0,R2,R1			//R0 = b * b - 4*a*c
		BX LR
		
		.global		Root1
		.thumb_func
Root1:							//finds the positive root
		PUSH {R4,R5,LR}
		NEG R5,R1				//stores -b in R1
		LSL R4,R0,1             //shift
		BL Discriminant			//Discriminant function
		BL SquareRoot			//Square root function
		ADD R0,R5,R0			//adds -b & SquareRoot(Discriminant(a,b,c))
		SDIV R0,R0,R4
		POP {R4,R5,PC}          //pops back
		
		.global		Root2
		.thumb_func
Root2:							//finds the negative root
		PUSH {R4,R5,LR}
		NEG R5,R1               //stores -b in R1
		LSL R4,R0,1
		BL Discriminant			//Discriminant function
		BL SquareRoot			//Square root function
		SUB R0,R5,R0			//subtracts -b & SquareRoot(Discriminant(a,b,c))
		SDIV R0,R0,R4
		POP {R4,R5,PC}          //pops back
		
		.global 	Quadratic
		.thumb_func	
Quadratic:						//to find the quadratic
		PUSH {R4}
		MOV R4,R0
		MUL R0,R4,R4			//square x^2
		MLA R0,R1,R0,R3			//square ax^2 + c
		MLA R0,R4,R2,R0			//square ax^2 + bx + c
		POP {R4}
		BX LR
.end