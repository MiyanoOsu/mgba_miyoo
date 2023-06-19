#define REG_R0            (0 * 4)
#define REG_R1            (1 * 4)
#define REG_R2            (2 * 4)
#define REG_R3            (3 * 4)
#define REG_R4            (4 * 4)
#define REG_R5            (5 * 4)
#define REG_R6            (6 * 4)
#define REG_R7            (7 * 4)
#define REG_R8            (8 * 4)
#define REG_R9            (9 * 4)
#define REG_R10           (10 * 4)
#define REG_R11           (11 * 4)
#define REG_R12           (12 * 4)
#define REG_SP            (13 * 4)
#define REG_LR            (14 * 4)
#define REG_PC            (15 * 4)

#define REG_N_FLAG        (16 * 4)
#define REG_Z_FLAG        (17 * 4)
#define REG_C_FLAG        (18 * 4)
#define REG_V_FLAG        (19 * 4)
#define REG_E_FLAG        (20 * 4)
#define REG_T_FLAG        (21 * 4)
#define REG_M_FLAG        (22 * 4)

#define REG_CPSR          (23 * 4)
#define CPSR_PACKED	  (24 * 4)

#define REG_SPSR          (25 * 4)
#define SPSR_PACKED	  (26 * 4)

#define REG_GPRS0	  (27 * 4)
#define REG_GPRS1	  (28 * 4)
#define REG_GPRS2	  (29 * 4)
#define REG_GPRS3	  (30 * 4)
#define REG_GPRS4	  (31 * 4)
#define REG_GPRS5	  (32 * 4)
#define REG_GPRS6	  (33 * 4)
#define REG_GPRS7	  (34 * 4)
#define REG_GPRS8	  (35 * 4)
#define REG_GPRS9	  (36 * 4)
#define REG_GPRS10	  (37 * 4)
#define REG_GPRS11	  (38 * 4)
#define REG_GPRS12	  (39 * 4)
#define REG_GPRS13	  (40 * 4)
#define REG_GPRS14	  (41 * 4)
#define REG_GPRS15	  (42 * 4)

#define REG_SAVE          (43 * 4)
#define REG_SAVE2         (44 * 4)
#define REG_SAVE3         (45 * 4)

#define EXC_MODE	  (46 * 4) @ 0->ARM or 1->Thumb
#define CPU_MODE          (47 * 4) @ cpu->privilegeMode
#define PRI_MODE	  (48 * 4) 
#define BANK_MODE	  (49 * 4) @ 0->none, 1->FIQ, 2->IRQ, 3->SVC, 4->abort, 5->undefined
#define CPU_HALT_STATE    (50 * 4)
#define CHANGED_PC_STATUS (51 * 4)

#define PREFETCH_0	  (52 * 4)
#define PREFETCH_1	  (53 * 4)

#define MEM_REGION	  (54 * 4)
#define MEM_MASK	  (55 * 4)
#define MEM_SEQ_CYCLES16  (56 * 4)
#define MEM_SEQ_CYCLES32  (58 * 4)
#define MEM_NSEQ_CYCLES16 (57 * 4)
#define MEM_NSEQ_CYCLES32 (58 * 4)

#define reg_a0            r0
#define reg_a1            r1
#define reg_a2            r2

#define reg_s0            r9
#define reg_base          sp
#define reg_flags         r11

#define reg_cycles        r12

#define reg_x0            r3
#define reg_x1            r4
#define reg_x2            r5
#define reg_x3            r6
#define reg_x4            r7
#define reg_x5            r8

#define MEM_SET_REGION(core, addr)	;\


#define LOAD_16(dest, addr, arr)	;\
	add dest, addr, arr		;\
	ldrsh r0, dest			;\

#define LOAD_32(dest, addr, arr)	;\
	add dest, addr, arr		;\
	ldr r0, dest			;\
 
#define STORE_16(src, addr, arr)	;\
	add src, addr, arr		;\
	strsh r0, src			;\

#define STORE_32(src, addr, arr)	;\
	add src, addr, arr		;\
	str r0, src			;\

.global ARMSelectBank
.global ARMRaiseIRQ
.global ARMRaiseSWI
.global ARMRunFake
.global ARMRaiseUndefined
.global ARMDecodeARM
.global ARMSetComponents
.global ARMInit
.global ARMHotplugAttach
.global ARMRunLoop
.global ARMRun
.global ARMReset
.global ARMDeinit
.global ARMSetPrivilegeMode
.global ARMDecodeThumb
.global ARMStep
.global ThumpStep

ARMWritePC:
	ldr r0, [reg_base, #REG_GPRS15]
	and r1, r0, #-2
	ldr r0, [reg_base, #CPU_MODE]
	MEM_SET_REGION(r0, r1)
	str r1, [reg_base, #REG_SAVE]
	ldr r2, [reg_base, #MEM_MASK]
	and r0, r1, r2
	mov r1, r0
	ldr r0, [reg_base, #PREFETCH_0]
	ldr r2, [reg_base, #MEM_REGION]
	LOAD_32(r0, r1, r2)
	ldr r1, [reg_base, #MEM_SAVE]
	add r1, r1, #4
	str r1, [reg_base, #MEM_SAVE]
	ldr r0, [reg_base, #PREFETCH_1]
	LOAD_32(r0, r1, r2)
	ldr r1, [reg_base, #REG_SAVE]
	str r1, [reg_base, #REG_GPRS15]
	ldr r1, [reg_base, #MEM_NSEQCYCLES32]
	ldr r2, [reg_base, #MEM_SEQCYCLES32]
	add r0, r1, r2
	add r0, r0, #2
	bx lr

ThumbWritePC:
	ldr r0, [reg_base, #REG_GPRS15]
	and r1, r0, #-2
	ldr r0, [reg_base, #CPU_MODE]
	MEM_SET_REGION(r0, r1)
	str r1, [reg_base, #REG_SAVE]
	ldr r2, [reg_base, #MEM_MASK]
	and r0, r1, r2
	mov r1, r0
	ldr r0, [reg_base, #PREFETCH_0]
	ldr r2, [reg_base, #MEM_REGION]
	LOAD_16(r0, r1, r2)
	ldr r1, [reg_base, #MEM_SAVE]
	add r1, r1, #2
	str r1, [reg_base, #MEM_SAVE]
	ldr r0, [reg_base, #PREFETCH_1]
	LOAD_16(r0, r1, r2)
	ldr r1, [reg_base, #REG_SAVE]
	str r1, [reg_base, #REG_GPRS15]
	ldr r1, [reg_base, #MEM_NSEQCYCLES16]
	ldr r2, [reg_base, #MEM_SEQCYCLES16]
	add r0, r1, r2
	add r0, r0, #2
	bx lr

_ARMSetMode:
	ldr r0, [reg_base, #EXC_MODE]
	ldr r1, [reg_base, #UNK]
	cmp r0, r1
	beq 2
	mov r0, r1
	cmp r1, #0
	beq 1
	cmp r1, #1
	beq .1
1:
		
.1:	

2:
	bx lr

ARMSelectBank:
	cmp r0, #0x10	@ mode USR
	beq USR
	cmp r0, #0x1f	@ mode SYS
        beq SYS
	cmp r0, #0x11	@ mode FIQ
        beq FIQ
	cmp r0, #0x12	@ mode IRQ
        beq IRQ
	cmp r0, #0x13	@ mode SVC
        beq SVC
	cmp r0, #0x17	@ mode ABORT
        beq ABORT
	cmp r0, #0x1b	@ mode UNDEFINED
	beq UNDEF
	b default
USR:
	mov r0, #0
	b break
SYS:
	mov r0, #0
	b break
FIQ:
	mov r0, #1
	b break
IRQ:
	mov r0, #2
	b break
SVC:
	mov r0, #3
	b break
ABORT:
	mov r0, #4
	b break
UNDEF:
	mov r0, #5
	b break
default:
	mov r0, #0
break:
	bx lr

ARMSetPrivilegeMode:
	ldr r3, [reg_base, #PRI_MODE]
	ldr r4, [reg_base, #CPU_MODE]
	cmp r3, r4	@ r3 --> mode, r4 --> cpu->privilegeMode
	beq 2

	mov r0, r3	@ newbank
	bl ARMSelectBank
	mov r1, r0

	mov r0, r4	@ oldbank
	bl ARMSelectBank
	mov r2, r0

	cmp r1, r2
	bne 0
0:
	cmp r3,	#0x11
	beq .0
	cmp r4, #0x11
	beq .0
	b 1
.0:
	mov r1, #1
	mov r2, #1
	b 1
1:	
	str r1, [reg_base, #REG_SAVE]
	ldr r0, [reg_base, #REG_GPRS13]
	str r0, [reg_base, #(REG_R0 + 1024 + REG_SAVE * 4)]
	ldr r0, [reg_base, #REG_GPRS14]
	str r0, [reg_base, #(REG_R1 + 1024 + REG_SAVE * 4)]
	ldr r0, [reg_base, #SPSR_PACKED]
	str r0, [reg_base, #(REG_SPSR + 1024 * REG_SAVE * 4)]

	str r2, [reg_base, #REG_SAVE]
	ldr r0, [reg_base, #(REG_R0 + 1024 * REG_SAVE * 4)]
	str r0, [reg_base, #REG_GPRS13]
	ldr r0, [reg_base, #(REG_R1 + 1024 * REG_SAVE * 4)]
	str r0, [reg_base, #REG_GPRS14]
	ldr r0, [reg_base, #(REG_SPSR + 1024 * REG_SAVE * 4)]
	str r0, [reg_base, #SPSR_PACKED]

	b 2
2:
	bx lr

ARMReset:
	mov r0, #0
	str r0, [reg_base, #REG_GPRS0]
	str r0, [reg_base, #REG_GPRS1]
	str r0, [reg_base, #REG_GPRS2]
	str r0, [reg_base, #REG_GPRS3]
	str r0, [reg_base, #REG_GPRS4]
	str r0, [reg_base, #REG_GPRS5]
	str r0, [reg_base, #REG_GPRS6]
	str r0, [reg_base, #REG_GPRS7]
	str r0, [reg_base, #REG_GPRS8]
	str r0, [reg_base, #REG_GPRS9]
	str r0, [reg_base, #REG_GPRS10]
	str r0, [reg_base, #REG_GPRS11]
	str r0, [reg_base, #REG_GPRS12]
	str r0, [reg_base, #REG_GPRS13]
	str r0, [reg_base, #REG_GPRS14]
	str r0, [reg_base, #REG_GPRS15]

	str r0, [reg_base, #REG_R0]
	str r0, [reg_base, #REG_R1]
	str r0, [reg_base, #REG_R2]
	str r0, [reg_base, #REG_R3]
	str r0, [reg_base, #REG_R4]
	str r0, [reg_base, #REG_R5]
	str r0, [reg_base, #REG_R6]
	str r0, [reg_base, #REG_R7]
	str r0, [reg_base, #REG_R8]
	str r0, [reg_base, #REG_R9]
	str r0, [reg_base, #REG_R10]
	str r0, [reg_base, #REG_R11]
	str r0, [reg_base, #REG_R12]
	str r0, [reg_base, #REG_SP]
	str r0, [reg_base, #REG_LR]
	str r0, [reg_base, #REG_PC]
	str r0, [reg_base, #SPSR_PACKED]

	mov r1, #0
	str r1, [reg_base, #REG_SAVE]
	str r0, [reg_base, #(REG_R0 + 1024 + REG_SAVE * 4)]
	str r0, [reg_base, #(REG_R1 + 1024 + REG_SAVE * 4)]
	str r0, [reg_base, #(REG_SPSR + 1024 * REG_SAVE * 4)]

	mov r1, #1
	str r1, [reg_base, #REG_SAVE]
	str r0, [reg_base, #(REG_R0 + 1024 + REG_SAVE * 4)]
	str r0, [reg_base, #(REG_R1 + 1024 + REG_SAVE * 4)]
	str r0, [reg_base, #(REG_SPSR + 1024 * REG_SAVE * 4)]

	mov r1, #2
	str r1, [reg_base, #REG_SAVE]
	str r0, [reg_base, #(REG_R0 + 1024 + REG_SAVE * 4)]
	str r0, [reg_base, #(REG_R1 + 1024 + REG_SAVE * 4)]
	str r0, [reg_base, #(REG_SPSR + 1024 * REG_SAVE * 4)]

	mov r1, #3
	str r1, [reg_base, #REG_SAVE]
	str r0, [reg_base, #(REG_R0 + 1024 + REG_SAVE * 4)]
	str r0, [reg_base, #(REG_R1 + 1024 + REG_SAVE * 4)]
	str r0, [reg_base, #(REG_SPSR + 1024 * REG_SAVE * 4)]

	mov r1, #4
	str r1, [reg_base, #REG_SAVE]
	str r0, [reg_base, #(REG_R0 + 1024 + REG_SAVE * 4)]
	str r0, [reg_base, #(REG_R1 + 1024 + REG_SAVE * 4)]
	str r0, [reg_base, #(REG_SPSR + 1024 * REG_SAVE * 4)]

	mov r1, #5
	str r1, [reg_base, #REG_SAVE]
	str r0, [reg_base, #(REG_R0 + 1024 + REG_SAVE * 4)]
	str r0, [reg_base, #(REG_R1 + 1024 + REG_SAVE * 4)]
	str r0, [reg_base, #(REG_SPSR + 1024 * REG_SAVE * 4)]

	mov r0, #0x1f
	str r0, [reg_base, #CPU_MODE]
	str r0, [reg_base, #CPSR_PACKED]

	
.data
