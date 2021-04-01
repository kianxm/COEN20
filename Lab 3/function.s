        .syntax     unified
        .cpu        cortex-m4
        .text
      
        .global     UseLDRB
        .thumb_func

//Input: move 512 from array and find fastest time

UseLDRB:                            
        .REPT 512                   //512/1 = 512
        LDRB    R2,[R1],1           //read and increment by 1 byte
        STRB    R2,[R0],1           //store and increment by 1 byte
        .ENDR
        BX      LR

        .global     UseLDRH
        .thumb_func

UseLDRH:
        .REPT 256                   //512/256 = 2
        LDRH    R2,[R1],2           // read and increment by 2 bytes
        STRH    R2,[R0],2           //store and increment by 2 bytes
        .ENDR
        BX      LR
    
        .global     UseLDR
        .thumb_func

UseLDR:
        .REPT 128                   //512/128 = 4
        LDR     R2,[R1],4           //read and increment by 4 bytes
        STR     R2,[R0],4           //store and increment by 4 bytes
        .ENDR
        BX      LR

        .global     UseLDRD
        .thumb_func

UseLDRD:
        .REPT 64                    //512/64 = 8
        LDRD    R2,R3,[R1],8        //load 64 bits to R2 & R3, increase by 8 bytes
        STRD    R2,R3,[R0],8        //store and increment by 8 bytes
        .ENDR
        BX      LR

        .global     UseLDM
        .thumb_func

UseLDM:
        PUSH    {R4-R9}             //uses R4-R9 as placeholders
        .REPT 16                    //512/32 = 16
        LDMIA   R1!,{R2-R9}         //load content from R1 to R2-9
        STMIA   R0!,{R2-R9}         //stores content of R2-9
        .ENDR
        POP     {R4-R9}             //restores R4-R9 data
        BX      LR

        .end

//Output Fastest: UseLDM
//       Rate: 285 MB/sec