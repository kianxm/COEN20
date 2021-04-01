//Kian Malakooti
//11-28-2020

		.syntax		unified
		.cpu		cortex-m4
		.text
		.global Discriminant
		.thumb_func

Discriminant:						// S0=a,S1=b,S2=c
		VMUL.F32 S1,S1,S1			// S1=b*b
		VMOV S3,4.0					
		VMUL.F32 S0,S0,S3			// S0 = 4*a
		VMLS.F32 S1,S0,S2			// S = b*b-(4*a*c) discriminant
		VMOV S0,S1
		BX LR
		
		.global		Quadratic
		.thumb_func

Quadratic:							// S0=x,S1=a,S2=b,S3=c
		VMLA.F32 S3,S0,S2			// S3 = S3+S0*S2
		VMUL.F32 S0,S0,S0			// S0 = x*x
		VMUL.F32 S1,S1,S0			// S1 = S1*S0
		VADD.F32 S0,S3,S1			// S0 =(c+b*x)+(a*x*x)
		BX LR
		
		.global Root1
		.thumb_func

Root1:								// S0=a,S1=b,S2=c
		PUSH {R4,R5,LR}
		VMOV R4,S0					// R4 = a
		VMOV R5,S1					// R5 = b
		BL Discriminant				// Recurse Discriminant function
		VSQRT.F32 S3,S0				// S3 = sqrt(Discriminant)
		VMOV S0,R4					// S0 = a
		VMOV S1,R5					// S1 = b
		VNEG.F32 S1,S1				// S1 = -b
		VADD.F32 S3,S1,S3			// S3 = -b+sqrt(Discriminant)
		VMOV S1,2.0					
		VMUL.F32 S0,S0,S1			// S0 = a*2
		VDIV.F32 S0,S3,S0			// (-sqrt(Discriminant))/(a*2)
		POP {R4,R5,PC}
		
		.global Root2
		.thumb_func

Root2:								// S0=a,S1=b,S2=c
		PUSH {R4,R5,LR}
		VMOV R4,S0					// R4 = a
		VMOV R5,S1					// R5 = b
		BL Discriminant				// Recurse Discriminant function
		VSQRT.F32 S3,S0				// S3 = sqrt(Discriminant)
		VMOV S0,R4					// S0 = a
		VMOV S1,R5					// S1 = b
		VNEG.F32 S1,S1				// S1 = -b
		VSUB.F32 S3,S1,S3			// S3 = -b-sqrt(Discriminant)
		VADD.F32 S0,S0,S0			// S0 = a+a (same as saying 2*a)
		VDIV.F32 S0,S3,S0			// (-sqrt(Discriminant))/(a*2)
		POP {R4,R5,PC}

.end