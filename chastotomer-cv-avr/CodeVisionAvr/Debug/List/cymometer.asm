
;CodeVisionAVR C Compiler V3.48b Evaluation
;(C) Copyright 1998-2022 Pavel Haiduc, HP InfoTech S.R.L.
;http://www.hpinfotech.ro

;Build configuration    : Debug
;Chip type              : ATmega8535
;Program type           : Application
;Clock frequency        : 16,000000 MHz
;Memory model           : Small
;Optimize for           : Size
;(s)printf features     : long, width, precision
;(s)scanf features      : long, width
;External RAM size      : 0
;Data Stack size        : 128 byte(s)
;Heap size              : 0 byte(s)
;Promote 'char' to 'int': No
;'char' is unsigned     : Yes
;8 bit enums            : No
;Global 'const' stored in FLASH: Yes
;Enhanced function parameter passing: Mode 1
;Enhanced core instructions: On
;Automatic register allocation for global variables: On
;Smart register allocation: On

	#define _MODEL_SMALL_

	#pragma AVRPART ADMIN PART_NAME ATmega8535
	#pragma AVRPART MEMORY PROG_FLASH 8192
	#pragma AVRPART MEMORY EEPROM 512
	#pragma AVRPART MEMORY INT_SRAM SIZE 512
	#pragma AVRPART MEMORY INT_SRAM START_ADDR 0x60

	.LISTMAC
	.EQU UDRE=0x5
	.EQU RXC=0x7
	.EQU USR=0xB
	.EQU UDR=0xC
	.EQU SPSR=0xE
	.EQU SPDR=0xF
	.EQU EERE=0x0
	.EQU EEWE=0x1
	.EQU EEMWE=0x2
	.EQU EECR=0x1C
	.EQU EEDR=0x1D
	.EQU EEARL=0x1E
	.EQU EEARH=0x1F
	.EQU WDTCR=0x21
	.EQU MCUCR=0x35
	.EQU SPMCSR=0x37
	.EQU GICR=0x3B
	.EQU SPL=0x3D
	.EQU SPH=0x3E
	.EQU SREG=0x3F

	.DEF R0X0=R0
	.DEF R0X1=R1
	.DEF R0X2=R2
	.DEF R0X3=R3
	.DEF R0X4=R4
	.DEF R0X5=R5
	.DEF R0X6=R6
	.DEF R0X7=R7
	.DEF R0X8=R8
	.DEF R0X9=R9
	.DEF R0XA=R10
	.DEF R0XB=R11
	.DEF R0XC=R12
	.DEF R0XD=R13
	.DEF R0XE=R14
	.DEF R0XF=R15
	.DEF R0X10=R16
	.DEF R0X11=R17
	.DEF R0X12=R18
	.DEF R0X13=R19
	.DEF R0X14=R20
	.DEF R0X15=R21
	.DEF R0X16=R22
	.DEF R0X17=R23
	.DEF R0X18=R24
	.DEF R0X19=R25
	.DEF R0X1A=R26
	.DEF R0X1B=R27
	.DEF R0X1C=R28
	.DEF R0X1D=R29
	.DEF R0X1E=R30
	.DEF R0X1F=R31

	.EQU __SRAM_START=0x0060
	.EQU __SRAM_END=0x025F
	.EQU __DSTACK_SIZE=0x0080
	.EQU __HEAP_SIZE=0x0000
	.EQU __CLEAR_SRAM_SIZE=__SRAM_END-__SRAM_START+1

	.EQU __FLASH_PAGE_SIZE=0x20

	.MACRO __CPD1N
	CPI  R30,LOW(@0)
	LDI  R26,HIGH(@0)
	CPC  R31,R26
	LDI  R26,BYTE3(@0)
	CPC  R22,R26
	LDI  R26,BYTE4(@0)
	CPC  R23,R26
	.ENDM

	.MACRO __CPD2N
	CPI  R26,LOW(@0)
	LDI  R30,HIGH(@0)
	CPC  R27,R30
	LDI  R30,BYTE3(@0)
	CPC  R24,R30
	LDI  R30,BYTE4(@0)
	CPC  R25,R30
	.ENDM

	.MACRO __CPWRR
	CP   R@0,R@2
	CPC  R@1,R@3
	.ENDM

	.MACRO __CPWRN
	CPI  R@0,LOW(@2)
	LDI  R30,HIGH(@2)
	CPC  R@1,R30
	.ENDM

	.MACRO __ADDB1MN
	SUBI R30,LOW(-@0-(@1))
	.ENDM

	.MACRO __ADDB2MN
	SUBI R26,LOW(-@0-(@1))
	.ENDM

	.MACRO __ADDW1MN
	SUBI R30,LOW(-@0-(@1))
	SBCI R31,HIGH(-@0-(@1))
	.ENDM

	.MACRO __ADDW2MN
	SUBI R26,LOW(-@0-(@1))
	SBCI R27,HIGH(-@0-(@1))
	.ENDM

	.MACRO __ADDW1FN
	SUBI R30,LOW(-2*@0-(@1))
	SBCI R31,HIGH(-2*@0-(@1))
	.ENDM

	.MACRO __ADDD1FN
	SUBI R30,LOW(-2*@0-(@1))
	SBCI R31,HIGH(-2*@0-(@1))
	SBCI R22,BYTE3(-2*@0-(@1))
	.ENDM

	.MACRO __ADDD1N
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	SBCI R22,BYTE3(-@0)
	SBCI R23,BYTE4(-@0)
	.ENDM

	.MACRO __ADDD2N
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	SBCI R24,BYTE3(-@0)
	SBCI R25,BYTE4(-@0)
	.ENDM

	.MACRO __SUBD1N
	SUBI R30,LOW(@0)
	SBCI R31,HIGH(@0)
	SBCI R22,BYTE3(@0)
	SBCI R23,BYTE4(@0)
	.ENDM

	.MACRO __SUBD2N
	SUBI R26,LOW(@0)
	SBCI R27,HIGH(@0)
	SBCI R24,BYTE3(@0)
	SBCI R25,BYTE4(@0)
	.ENDM

	.MACRO __ANDBMNN
	LDS  R30,@0+(@1)
	ANDI R30,LOW(@2)
	STS  @0+(@1),R30
	.ENDM

	.MACRO __ANDWMNN
	LDS  R30,@0+(@1)
	ANDI R30,LOW(@2)
	STS  @0+(@1),R30
	LDS  R30,@0+(@1)+1
	ANDI R30,HIGH(@2)
	STS  @0+(@1)+1,R30
	.ENDM

	.MACRO __ANDD1N
	ANDI R30,LOW(@0)
	ANDI R31,HIGH(@0)
	ANDI R22,BYTE3(@0)
	ANDI R23,BYTE4(@0)
	.ENDM

	.MACRO __ANDD2N
	ANDI R26,LOW(@0)
	ANDI R27,HIGH(@0)
	ANDI R24,BYTE3(@0)
	ANDI R25,BYTE4(@0)
	.ENDM

	.MACRO __ORBMNN
	LDS  R30,@0+(@1)
	ORI  R30,LOW(@2)
	STS  @0+(@1),R30
	.ENDM

	.MACRO __ORWMNN
	LDS  R30,@0+(@1)
	ORI  R30,LOW(@2)
	STS  @0+(@1),R30
	LDS  R30,@0+(@1)+1
	ORI  R30,HIGH(@2)
	STS  @0+(@1)+1,R30
	.ENDM

	.MACRO __ORD1N
	ORI  R30,LOW(@0)
	ORI  R31,HIGH(@0)
	ORI  R22,BYTE3(@0)
	ORI  R23,BYTE4(@0)
	.ENDM

	.MACRO __ORD2N
	ORI  R26,LOW(@0)
	ORI  R27,HIGH(@0)
	ORI  R24,BYTE3(@0)
	ORI  R25,BYTE4(@0)
	.ENDM

	.MACRO __DELAY_USB
	LDI  R24,LOW(@0)
__DELAY_USB_LOOP:
	DEC  R24
	BRNE __DELAY_USB_LOOP
	.ENDM

	.MACRO __DELAY_USW
	LDI  R24,LOW(@0)
	LDI  R25,HIGH(@0)
__DELAY_USW_LOOP:
	SBIW R24,1
	BRNE __DELAY_USW_LOOP
	.ENDM

	.MACRO __GETW1P
	LD   R30,X+
	LD   R31,X
	SBIW R26,1
	.ENDM

	.MACRO __GETD1S
	LDD  R30,Y+@0
	LDD  R31,Y+@0+1
	LDD  R22,Y+@0+2
	LDD  R23,Y+@0+3
	.ENDM

	.MACRO __GETD2S
	LDD  R26,Y+@0
	LDD  R27,Y+@0+1
	LDD  R24,Y+@0+2
	LDD  R25,Y+@0+3
	.ENDM

	.MACRO __GETD1P_INC
	LD   R30,X+
	LD   R31,X+
	LD   R22,X+
	LD   R23,X+
	.ENDM

	.MACRO __GETD1P_DEC
	LD   R23,-X
	LD   R22,-X
	LD   R31,-X
	LD   R30,-X
	.ENDM

	.MACRO __PUTDP1
	ST   X+,R30
	ST   X+,R31
	ST   X+,R22
	ST   X,R23
	.ENDM

	.MACRO __PUTDP1_DEC
	ST   -X,R23
	ST   -X,R22
	ST   -X,R31
	ST   -X,R30
	.ENDM

	.MACRO __PUTD1S
	STD  Y+@0,R30
	STD  Y+@0+1,R31
	STD  Y+@0+2,R22
	STD  Y+@0+3,R23
	.ENDM

	.MACRO __PUTD2S
	STD  Y+@0,R26
	STD  Y+@0+1,R27
	STD  Y+@0+2,R24
	STD  Y+@0+3,R25
	.ENDM

	.MACRO __PUTDZ2
	STD  Z+@0,R26
	STD  Z+@0+1,R27
	STD  Z+@0+2,R24
	STD  Z+@0+3,R25
	.ENDM

	.MACRO __CLRD1S
	STD  Y+@0,R30
	STD  Y+@0+1,R30
	STD  Y+@0+2,R30
	STD  Y+@0+3,R30
	.ENDM

	.MACRO __CPD10
	SBIW R30,0
	SBCI R22,0
	SBCI R23,0
	.ENDM

	.MACRO __CPD20
	SBIW R26,0
	SBCI R24,0
	SBCI R25,0
	.ENDM

	.MACRO __ADDD12
	ADD  R30,R26
	ADC  R31,R27
	ADC  R22,R24
	ADC  R23,R25
	.ENDM

	.MACRO __ADDD21
	ADD  R26,R30
	ADC  R27,R31
	ADC  R24,R22
	ADC  R25,R23
	.ENDM

	.MACRO __SUBD12
	SUB  R30,R26
	SBC  R31,R27
	SBC  R22,R24
	SBC  R23,R25
	.ENDM

	.MACRO __SUBD21
	SUB  R26,R30
	SBC  R27,R31
	SBC  R24,R22
	SBC  R25,R23
	.ENDM

	.MACRO __ANDD12
	AND  R30,R26
	AND  R31,R27
	AND  R22,R24
	AND  R23,R25
	.ENDM

	.MACRO __ORD12
	OR   R30,R26
	OR   R31,R27
	OR   R22,R24
	OR   R23,R25
	.ENDM

	.MACRO __XORD12
	EOR  R30,R26
	EOR  R31,R27
	EOR  R22,R24
	EOR  R23,R25
	.ENDM

	.MACRO __XORD21
	EOR  R26,R30
	EOR  R27,R31
	EOR  R24,R22
	EOR  R25,R23
	.ENDM

	.MACRO __COMD1
	COM  R30
	COM  R31
	COM  R22
	COM  R23
	.ENDM

	.MACRO __MULD2_2
	LSL  R26
	ROL  R27
	ROL  R24
	ROL  R25
	.ENDM

	.MACRO __LSRD1
	LSR  R23
	ROR  R22
	ROR  R31
	ROR  R30
	.ENDM

	.MACRO __LSLD1
	LSL  R30
	ROL  R31
	ROL  R22
	ROL  R23
	.ENDM

	.MACRO __ASRB4
	ASR  R30
	ASR  R30
	ASR  R30
	ASR  R30
	.ENDM

	.MACRO __ASRW8
	MOV  R30,R31
	CLR  R31
	SBRC R30,7
	SER  R31
	.ENDM

	.MACRO __LSRD16
	MOV  R30,R22
	MOV  R31,R23
	LDI  R22,0
	LDI  R23,0
	.ENDM

	.MACRO __LSLD16
	MOV  R22,R30
	MOV  R23,R31
	LDI  R30,0
	LDI  R31,0
	.ENDM

	.MACRO __CWD1
	MOV  R22,R31
	ADD  R22,R22
	SBC  R22,R22
	MOV  R23,R22
	.ENDM

	.MACRO __CWD2
	MOV  R24,R27
	ADD  R24,R24
	SBC  R24,R24
	MOV  R25,R24
	.ENDM

	.MACRO __SETMSD1
	SER  R31
	SER  R22
	SER  R23
	.ENDM

	.MACRO __ADDW1R15
	CLR  R0
	ADD  R30,R15
	ADC  R31,R0
	.ENDM

	.MACRO __ADDW2R15
	CLR  R0
	ADD  R26,R15
	ADC  R27,R0
	.ENDM

	.MACRO __EQB12
	CP   R30,R26
	LDI  R30,1
	BREQ PC+2
	CLR  R30
	.ENDM

	.MACRO __NEB12
	CP   R30,R26
	LDI  R30,1
	BRNE PC+2
	CLR  R30
	.ENDM

	.MACRO __LEB12
	CP   R30,R26
	LDI  R30,1
	BRGE PC+2
	CLR  R30
	.ENDM

	.MACRO __GEB12
	CP   R26,R30
	LDI  R30,1
	BRGE PC+2
	CLR  R30
	.ENDM

	.MACRO __LTB12
	CP   R26,R30
	LDI  R30,1
	BRLT PC+2
	CLR  R30
	.ENDM

	.MACRO __GTB12
	CP   R30,R26
	LDI  R30,1
	BRLT PC+2
	CLR  R30
	.ENDM

	.MACRO __LEB12U
	CP   R30,R26
	LDI  R30,1
	BRSH PC+2
	CLR  R30
	.ENDM

	.MACRO __GEB12U
	CP   R26,R30
	LDI  R30,1
	BRSH PC+2
	CLR  R30
	.ENDM

	.MACRO __LTB12U
	CP   R26,R30
	LDI  R30,1
	BRLO PC+2
	CLR  R30
	.ENDM

	.MACRO __GTB12U
	CP   R30,R26
	LDI  R30,1
	BRLO PC+2
	CLR  R30
	.ENDM

	.MACRO __CPW01
	CLR  R0
	CP   R0,R30
	CPC  R0,R31
	.ENDM

	.MACRO __CPW02
	CLR  R0
	CP   R0,R26
	CPC  R0,R27
	.ENDM

	.MACRO __CPD12
	CP   R30,R26
	CPC  R31,R27
	CPC  R22,R24
	CPC  R23,R25
	.ENDM

	.MACRO __CPD21
	CP   R26,R30
	CPC  R27,R31
	CPC  R24,R22
	CPC  R25,R23
	.ENDM

	.MACRO __BSTB1
	CLT
	TST  R30
	BREQ PC+2
	SET
	.ENDM

	.MACRO __LNEGB1
	TST  R30
	LDI  R30,1
	BREQ PC+2
	CLR  R30
	.ENDM

	.MACRO __LNEGW1
	OR   R30,R31
	LDI  R30,1
	BREQ PC+2
	LDI  R30,0
	.ENDM

	.MACRO __POINTB1MN
	LDI  R30,LOW(@0+(@1))
	.ENDM

	.MACRO __POINTW1MN
	LDI  R30,LOW(@0+(@1))
	LDI  R31,HIGH(@0+(@1))
	.ENDM

	.MACRO __POINTD1M
	LDI  R30,LOW(@0)
	LDI  R31,HIGH(@0)
	LDI  R22,BYTE3(@0)
	LDI  R23,BYTE4(@0)
	.ENDM

	.MACRO __POINTW1FN
	LDI  R30,LOW(2*@0+(@1))
	LDI  R31,HIGH(2*@0+(@1))
	.ENDM

	.MACRO __POINTD1FN
	LDI  R30,LOW(2*@0+(@1))
	LDI  R31,HIGH(2*@0+(@1))
	LDI  R22,BYTE3(2*@0+(@1))
	LDI  R23,BYTE4(2*@0+(@1))
	.ENDM

	.MACRO __POINTB2MN
	LDI  R26,LOW(@0+(@1))
	.ENDM

	.MACRO __POINTW2MN
	LDI  R26,LOW(@0+(@1))
	LDI  R27,HIGH(@0+(@1))
	.ENDM

	.MACRO __POINTD2M
	LDI  R26,LOW(@0)
	LDI  R27,HIGH(@0)
	LDI  R24,BYTE3(@0)
	LDI  R25,BYTE4(@0)
	.ENDM

	.MACRO __POINTW2FN
	LDI  R26,LOW(2*@0+(@1))
	LDI  R27,HIGH(2*@0+(@1))
	.ENDM

	.MACRO __POINTD2FN
	LDI  R26,LOW(2*@0+(@1))
	LDI  R27,HIGH(2*@0+(@1))
	LDI  R24,BYTE3(2*@0+(@1))
	LDI  R25,BYTE4(2*@0+(@1))
	.ENDM

	.MACRO __POINTBRM
	LDI  R@0,LOW(@1)
	.ENDM

	.MACRO __POINTWRM
	LDI  R@0,LOW(@2)
	LDI  R@1,HIGH(@2)
	.ENDM

	.MACRO __POINTBRMN
	LDI  R@0,LOW(@1+(@2))
	.ENDM

	.MACRO __POINTWRMN
	LDI  R@0,LOW(@2+(@3))
	LDI  R@1,HIGH(@2+(@3))
	.ENDM

	.MACRO __POINTWRFN
	LDI  R@0,LOW(@2*2+(@3))
	LDI  R@1,HIGH(@2*2+(@3))
	.ENDM

	.MACRO __GETD1N
	LDI  R30,LOW(@0)
	LDI  R31,HIGH(@0)
	LDI  R22,BYTE3(@0)
	LDI  R23,BYTE4(@0)
	.ENDM

	.MACRO __GETD2N
	LDI  R26,LOW(@0)
	LDI  R27,HIGH(@0)
	LDI  R24,BYTE3(@0)
	LDI  R25,BYTE4(@0)
	.ENDM

	.MACRO __GETB1MN
	LDS  R30,@0+(@1)
	.ENDM

	.MACRO __GETB1HMN
	LDS  R31,@0+(@1)
	.ENDM

	.MACRO __GETW1MN
	LDS  R30,@0+(@1)
	LDS  R31,@0+(@1)+1
	.ENDM

	.MACRO __GETD1MN
	LDS  R30,@0+(@1)
	LDS  R31,@0+(@1)+1
	LDS  R22,@0+(@1)+2
	LDS  R23,@0+(@1)+3
	.ENDM

	.MACRO __GETBRMN
	LDS  R@0,@1+(@2)
	.ENDM

	.MACRO __GETWRMN
	LDS  R@0,@2+(@3)
	LDS  R@1,@2+(@3)+1
	.ENDM

	.MACRO __GETWRZ
	LDD  R@0,Z+@2
	LDD  R@1,Z+@2+1
	.ENDM

	.MACRO __GETD2Z
	LDD  R26,Z+@0
	LDD  R27,Z+@0+1
	LDD  R24,Z+@0+2
	LDD  R25,Z+@0+3
	.ENDM

	.MACRO __GETB2MN
	LDS  R26,@0+(@1)
	.ENDM

	.MACRO __GETW2MN
	LDS  R26,@0+(@1)
	LDS  R27,@0+(@1)+1
	.ENDM

	.MACRO __GETD2MN
	LDS  R26,@0+(@1)
	LDS  R27,@0+(@1)+1
	LDS  R24,@0+(@1)+2
	LDS  R25,@0+(@1)+3
	.ENDM

	.MACRO __PUTB1MN
	STS  @0+(@1),R30
	.ENDM

	.MACRO __PUTW1MN
	STS  @0+(@1),R30
	STS  @0+(@1)+1,R31
	.ENDM

	.MACRO __PUTD1MN
	STS  @0+(@1),R30
	STS  @0+(@1)+1,R31
	STS  @0+(@1)+2,R22
	STS  @0+(@1)+3,R23
	.ENDM

	.MACRO __PUTB1EN
	LDI  R26,LOW(@0+(@1))
	LDI  R27,HIGH(@0+(@1))
	RCALL __EEPROMWRB
	.ENDM

	.MACRO __PUTW1EN
	LDI  R26,LOW(@0+(@1))
	LDI  R27,HIGH(@0+(@1))
	RCALL __EEPROMWRW
	.ENDM

	.MACRO __PUTD1EN
	LDI  R26,LOW(@0+(@1))
	LDI  R27,HIGH(@0+(@1))
	RCALL __EEPROMWRD
	.ENDM

	.MACRO __PUTBR0MN
	STS  @0+(@1),R0
	.ENDM

	.MACRO __PUTBMRN
	STS  @0+(@1),R@2
	.ENDM

	.MACRO __PUTWMRN
	STS  @0+(@1),R@2
	STS  @0+(@1)+1,R@3
	.ENDM

	.MACRO __PUTBZR
	STD  Z+@1,R@0
	.ENDM

	.MACRO __PUTWZR
	STD  Z+@2,R@0
	STD  Z+@2+1,R@1
	.ENDM

	.MACRO __GETW1R
	MOV  R30,R@0
	MOV  R31,R@1
	.ENDM

	.MACRO __GETW2R
	MOV  R26,R@0
	MOV  R27,R@1
	.ENDM

	.MACRO __GETWRN
	LDI  R@0,LOW(@2)
	LDI  R@1,HIGH(@2)
	.ENDM

	.MACRO __PUTW1R
	MOV  R@0,R30
	MOV  R@1,R31
	.ENDM

	.MACRO __PUTW2R
	MOV  R@0,R26
	MOV  R@1,R27
	.ENDM

	.MACRO __ADDWRN
	SUBI R@0,LOW(-@2)
	SBCI R@1,HIGH(-@2)
	.ENDM

	.MACRO __ADDWRR
	ADD  R@0,R@2
	ADC  R@1,R@3
	.ENDM

	.MACRO __SUBWRN
	SUBI R@0,LOW(@2)
	SBCI R@1,HIGH(@2)
	.ENDM

	.MACRO __SUBWRR
	SUB  R@0,R@2
	SBC  R@1,R@3
	.ENDM

	.MACRO __ANDWRN
	ANDI R@0,LOW(@2)
	ANDI R@1,HIGH(@2)
	.ENDM

	.MACRO __ANDWRR
	AND  R@0,R@2
	AND  R@1,R@3
	.ENDM

	.MACRO __ORWRN
	ORI  R@0,LOW(@2)
	ORI  R@1,HIGH(@2)
	.ENDM

	.MACRO __ORWRR
	OR   R@0,R@2
	OR   R@1,R@3
	.ENDM

	.MACRO __EORWRR
	EOR  R@0,R@2
	EOR  R@1,R@3
	.ENDM

	.MACRO __GETWRS
	LDD  R@0,Y+@2
	LDD  R@1,Y+@2+1
	.ENDM

	.MACRO __PUTBSR
	STD  Y+@1,R@0
	.ENDM

	.MACRO __PUTWSR
	STD  Y+@2,R@0
	STD  Y+@2+1,R@1
	.ENDM

	.MACRO __MOVEWRR
	MOV  R@0,R@2
	MOV  R@1,R@3
	.ENDM

	.MACRO __INWR
	IN   R@0,@2
	IN   R@1,@2+1
	.ENDM

	.MACRO __OUTWR
	OUT  @2+1,R@1
	OUT  @2,R@0
	.ENDM

	.MACRO __CALL1MN
	LDS  R30,@0+(@1)
	LDS  R31,@0+(@1)+1
	ICALL
	.ENDM

	.MACRO __CALL1FN
	LDI  R30,LOW(2*@0+(@1))
	LDI  R31,HIGH(2*@0+(@1))
	RCALL __GETW1PF
	ICALL
	.ENDM

	.MACRO __CALL2EN
	PUSH R26
	PUSH R27
	LDI  R26,LOW(@0+(@1))
	LDI  R27,HIGH(@0+(@1))
	RCALL __EEPROMRDW
	POP  R27
	POP  R26
	ICALL
	.ENDM

	.MACRO __CALL2EX
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	RCALL __EEPROMRDD
	ICALL
	.ENDM

	.MACRO __GETW1STACK
	IN   R30,SPL
	IN   R31,SPH
	ADIW R30,@0+1
	LD   R0,Z+
	LD   R31,Z
	MOV  R30,R0
	.ENDM

	.MACRO __GETD1STACK
	IN   R30,SPL
	IN   R31,SPH
	ADIW R30,@0+1
	LD   R0,Z+
	LD   R1,Z+
	LD   R22,Z
	MOVW R30,R0
	.ENDM

	.MACRO __NBST
	BST  R@0,@1
	IN   R30,SREG
	LDI  R31,0x40
	EOR  R30,R31
	OUT  SREG,R30
	.ENDM


	.MACRO __PUTB1SN
	LDD  R26,Y+@0
	LDD  R27,Y+@0+1
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X,R30
	.ENDM

	.MACRO __PUTW1SN
	LDD  R26,Y+@0
	LDD  R27,Y+@0+1
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1SN
	LDD  R26,Y+@0
	LDD  R27,Y+@0+1
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X+,R30
	ST   X+,R31
	ST   X+,R22
	ST   X,R23
	.ENDM

	.MACRO __PUTB1SNS
	LDD  R26,Y+@0
	LDD  R27,Y+@0+1
	ADIW R26,@1
	ST   X,R30
	.ENDM

	.MACRO __PUTW1SNS
	LDD  R26,Y+@0
	LDD  R27,Y+@0+1
	ADIW R26,@1
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1SNS
	LDD  R26,Y+@0
	LDD  R27,Y+@0+1
	ADIW R26,@1
	ST   X+,R30
	ST   X+,R31
	ST   X+,R22
	ST   X,R23
	.ENDM

	.MACRO __PUTB1PMN
	LDS  R26,@0
	LDS  R27,@0+1
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X,R30
	.ENDM

	.MACRO __PUTW1PMN
	LDS  R26,@0
	LDS  R27,@0+1
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1PMN
	LDS  R26,@0
	LDS  R27,@0+1
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X+,R30
	ST   X+,R31
	ST   X+,R22
	ST   X,R23
	.ENDM

	.MACRO __PUTB1PMNS
	LDS  R26,@0
	LDS  R27,@0+1
	ADIW R26,@1
	ST   X,R30
	.ENDM

	.MACRO __PUTW1PMNS
	LDS  R26,@0
	LDS  R27,@0+1
	ADIW R26,@1
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1PMNS
	LDS  R26,@0
	LDS  R27,@0+1
	ADIW R26,@1
	ST   X+,R30
	ST   X+,R31
	ST   X+,R22
	ST   X,R23
	.ENDM

	.MACRO __PUTB1RN
	MOVW R26,R@0
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X,R30
	.ENDM

	.MACRO __PUTW1RN
	MOVW R26,R@0
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1RN
	MOVW R26,R@0
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X+,R30
	ST   X+,R31
	ST   X+,R22
	ST   X,R23
	.ENDM

	.MACRO __PUTB1RNS
	MOVW R26,R@0
	ADIW R26,@1
	ST   X,R30
	.ENDM

	.MACRO __PUTW1RNS
	MOVW R26,R@0
	ADIW R26,@1
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1RNS
	MOVW R26,R@0
	ADIW R26,@1
	ST   X+,R30
	ST   X+,R31
	ST   X+,R22
	ST   X,R23
	.ENDM

	.MACRO __PUTB1RON
	MOV  R26,R@0
	MOV  R27,R@1
	SUBI R26,LOW(-@2)
	SBCI R27,HIGH(-@2)
	ST   X,R30
	.ENDM

	.MACRO __PUTW1RON
	MOV  R26,R@0
	MOV  R27,R@1
	SUBI R26,LOW(-@2)
	SBCI R27,HIGH(-@2)
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1RON
	MOV  R26,R@0
	MOV  R27,R@1
	SUBI R26,LOW(-@2)
	SBCI R27,HIGH(-@2)
	ST   X+,R30
	ST   X+,R31
	ST   X+,R22
	ST   X,R23
	.ENDM

	.MACRO __PUTB1RONS
	MOV  R26,R@0
	MOV  R27,R@1
	ADIW R26,@2
	ST   X,R30
	.ENDM

	.MACRO __PUTW1RONS
	MOV  R26,R@0
	MOV  R27,R@1
	ADIW R26,@2
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1RONS
	MOV  R26,R@0
	MOV  R27,R@1
	ADIW R26,@2
	ST   X+,R30
	ST   X+,R31
	ST   X+,R22
	ST   X,R23
	.ENDM


	.MACRO __GETB1SX
	MOVW R30,R28
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	LD   R30,Z
	.ENDM

	.MACRO __GETB1HSX
	MOVW R30,R28
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	LD   R31,Z
	.ENDM

	.MACRO __GETW1SX
	MOVW R30,R28
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	RCALL __GETW1Z
	.ENDM

	.MACRO __GETD1SX
	MOVW R30,R28
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	RCALL __GETD1Z
	.ENDM

	.MACRO __GETB2SX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	LD   R26,X
	.ENDM

	.MACRO __GETW2SX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	RCALL __GETW2X
	.ENDM

	.MACRO __GETD2SX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	RCALL __GETD2X
	.ENDM

	.MACRO __GETBRSX
	MOVW R30,R28
	SUBI R30,LOW(-@1)
	SBCI R31,HIGH(-@1)
	LD   R@0,Z
	.ENDM

	.MACRO __GETWRSX
	MOVW R30,R28
	SUBI R30,LOW(-@2)
	SBCI R31,HIGH(-@2)
	LD   R@0,Z+
	LD   R@1,Z
	.ENDM

	.MACRO __GETBRSX2
	MOVW R26,R28
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	LD   R@0,X
	.ENDM

	.MACRO __GETWRSX2
	MOVW R26,R28
	SUBI R26,LOW(-@2)
	SBCI R27,HIGH(-@2)
	LD   R@0,X+
	LD   R@1,X
	.ENDM

	.MACRO __LSLW8SX
	MOVW R30,R28
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	LD   R31,Z
	CLR  R30
	.ENDM

	.MACRO __PUTB1SX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	ST   X,R30
	.ENDM

	.MACRO __PUTW1SX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1SX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	ST   X+,R30
	ST   X+,R31
	ST   X+,R22
	ST   X,R23
	.ENDM

	.MACRO __CLRW1SX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	ST   X+,R30
	ST   X,R30
	.ENDM

	.MACRO __CLRD1SX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	ST   X+,R30
	ST   X+,R30
	ST   X+,R30
	ST   X,R30
	.ENDM

	.MACRO __PUTB2SX
	MOVW R30,R28
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	ST   Z,R26
	.ENDM

	.MACRO __PUTW2SX
	MOVW R30,R28
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	ST   Z+,R26
	ST   Z,R27
	.ENDM

	.MACRO __PUTD2SX
	MOVW R30,R28
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	ST   Z+,R26
	ST   Z+,R27
	ST   Z+,R24
	ST   Z,R25
	.ENDM

	.MACRO __PUTBSRX
	MOVW R30,R28
	SUBI R30,LOW(-@1)
	SBCI R31,HIGH(-@1)
	ST   Z,R@0
	.ENDM

	.MACRO __PUTWSRX
	MOVW R30,R28
	SUBI R30,LOW(-@2)
	SBCI R31,HIGH(-@2)
	ST   Z+,R@0
	ST   Z,R@1
	.ENDM

	.MACRO __PUTB1SNX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	LD   R0,X+
	LD   R27,X
	MOV  R26,R0
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X,R30
	.ENDM

	.MACRO __PUTW1SNX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	LD   R0,X+
	LD   R27,X
	MOV  R26,R0
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1SNX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	LD   R0,X+
	LD   R27,X
	MOV  R26,R0
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X+,R30
	ST   X+,R31
	ST   X+,R22
	ST   X,R23
	.ENDM

	.MACRO __MULBRR
	MULS R@0,R@1
	MOVW R30,R0
	.ENDM

	.MACRO __MULBRRU
	MUL  R@0,R@1
	MOVW R30,R0
	.ENDM

	.MACRO __MULBRR0
	MULS R@0,R@1
	.ENDM

	.MACRO __MULBRRU0
	MUL  R@0,R@1
	.ENDM

	.MACRO __MULBNWRU
	LDI  R26,@2
	MUL  R26,R@0
	MOVW R30,R0
	MUL  R26,R@1
	ADD  R31,R0
	.ENDM

;NAME DEFINITIONS FOR GLOBAL VARIABLES ALLOCATED TO REGISTERS
	.DEF _icr11=R10
	.DEF _icr11_msb=R11
	.DEF _icr12=R12
	.DEF _icr12_msb=R13

	.CSEG
	.ORG 0x00

;START OF CODE MARKER
__START_OF_CODE:

;INTERRUPT VECTORS
	RJMP __RESET
	RJMP 0x00
	RJMP 0x00
	RJMP 0x00
	RJMP 0x00
	RJMP 0x00
	RJMP 0x00
	RJMP 0x00
	RJMP _Tim1Ovf
	RJMP _Tim0Ovf
	RJMP 0x00
	RJMP 0x00
	RJMP 0x00
	RJMP 0x00
	RJMP 0x00
	RJMP 0x00
	RJMP 0x00
	RJMP 0x00
	RJMP 0x00
	RJMP 0x00
	RJMP 0x00

;GLOBAL REGISTER VARIABLES INITIALIZATION
__REG_VARS:
	.DB  0x0,0x0,0x0,0x0

_0x40000:
	.DB  0x46,0x72,0x65,0x71,0x3A,0x20,0x0
_0x2020008:
	.DB  0xA
_0x2020009:
	.DB  0x0,0x0,0x0,0x0,0x0,0x0,0x0,0x0
	.DB  0x0,0x0,0x0,0x0,0x0,0x0,0x0,0x0
_0x2020016:
	.DB  0x0,0x0,0x0,0x0,0x0,0x0,0x0,0x0
	.DB  0x0,0x0,0x0,0x0,0x0,0x0,0x0,0x0

__GLOBAL_INI_TBL:
	.DW  0x04
	.DW  0x0A
	.DW  __REG_VARS*2

	.DW  0x07
	.DW  _0x40003
	.DW  _0x40000*2

	.DW  0x01
	.DW  _d10_G101
	.DW  _0x2020008*2

_0xFFFFFFFF:
	.DW  0

#define __GLOBAL_INI_TBL_PRESENT 1

__RESET:
	CLI
	CLR  R30
	OUT  EECR,R30

;INTERRUPT VECTORS ARE PLACED
;AT THE START OF FLASH
	LDI  R31,1
	OUT  GICR,R31
	OUT  GICR,R30
	OUT  MCUCR,R30

;DISABLE WATCHDOG
	LDI  R31,0x18
	OUT  WDTCR,R31
	OUT  WDTCR,R30

;CLEAR R2-R14
	LDI  R24,(14-2)+1
	LDI  R26,2
	CLR  R27
__CLEAR_REG:
	ST   X+,R30
	DEC  R24
	BRNE __CLEAR_REG

;CLEAR SRAM
	LDI  R24,LOW(__CLEAR_SRAM_SIZE)
	LDI  R25,HIGH(__CLEAR_SRAM_SIZE)
	LDI  R26,__SRAM_START
__CLEAR_SRAM:
	ST   X+,R30
	SBIW R24,1
	BRNE __CLEAR_SRAM

;GLOBAL VARIABLES INITIALIZATION
	LDI  R30,LOW(__GLOBAL_INI_TBL*2)
	LDI  R31,HIGH(__GLOBAL_INI_TBL*2)
__GLOBAL_INI_NEXT:
	LPM  R24,Z+
	LPM  R25,Z+
	SBIW R24,0
	BREQ __GLOBAL_INI_END
	LPM  R26,Z+
	LPM  R27,Z+
	LPM  R0,Z+
	LPM  R1,Z+
	MOVW R22,R30
	MOVW R30,R0
__GLOBAL_INI_LOOP:
	LPM  R0,Z+
	ST   X+,R0
	SBIW R24,1
	BRNE __GLOBAL_INI_LOOP
	MOVW R30,R22
	RJMP __GLOBAL_INI_NEXT
__GLOBAL_INI_END:

;HARDWARE STACK POINTER INITIALIZATION
	LDI  R30,LOW(__SRAM_END-__HEAP_SIZE)
	OUT  SPL,R30
	LDI  R30,HIGH(__SRAM_END-__HEAP_SIZE)
	OUT  SPH,R30

;DATA STACK POINTER INITIALIZATION
	LDI  R28,LOW(__SRAM_START+__DSTACK_SIZE)
	LDI  R29,HIGH(__SRAM_START+__DSTACK_SIZE)

	RJMP _main

	.ESEG
	.ORG 0x00

	.DSEG
	.ORG 0xE0

	.CSEG
	#ifndef __SLEEP_DEFINED__
	#define __SLEEP_DEFINED__
	.EQU __se_bit=0x40
	.EQU __sm_mask=0xB0
	.EQU __sm_powerdown=0x20
	.EQU __sm_powersave=0x30
	.EQU __sm_standby=0xA0
	.EQU __sm_ext_standby=0xB0
	.EQU __sm_adc_noise_red=0x10
	.SET power_ctrl_reg=mcucr
	#endif
;void BCD_LongLcd(unsigned long value, unsigned char size, unsigned char comma)
; 0000 0006 {

	.CSEG
_BCD_LongLcd:
; .FSTART _BCD_LongLcd
; 0000 0007 unsigned char i;
; 0000 0008 for(i = 0; i<MAX_SIZE; i++){
	RCALL SUBOPT_0x0
;	value -> Y+3
;	size -> Y+2
;	comma -> Y+1
;	i -> R17
	LDI  R17,LOW(0)
_0x4:
	CPI  R17,8
	BRSH _0x5
; 0000 0009 buf[i] = (unsigned char)((value % 10) + 48);
	MOV  R30,R17
	LDI  R31,0
	SUBI R30,LOW(-_buf)
	SBCI R31,HIGH(-_buf)
	PUSH R31
	PUSH R30
	RCALL SUBOPT_0x1
	RCALL __MODD21U
	SUBI R30,-LOW(48)
	POP  R26
	POP  R27
	ST   X,R30
; 0000 000A value = value/10;
	RCALL SUBOPT_0x1
	RCALL __DIVD21U
	__PUTD1S 3
; 0000 000B }
	SUBI R17,-1
	RJMP _0x4
_0x5:
; 0000 000C for(i = 0; i<size; i++){
	LDI  R17,LOW(0)
_0x7:
	LDD  R30,Y+2
	CP   R17,R30
	BRSH _0x8
; 0000 000D if (comma){
	LDD  R30,Y+1
	CPI  R30,0
	BREQ _0x9
; 0000 000E if (i == MAX_SIZE-comma) LcdSendData(',');
	LDD  R26,Y+1
	LDI  R30,LOW(8)
	SUB  R30,R26
	CP   R30,R17
	BRNE _0xA
	LDI  R26,LOW(44)
	RCALL _LCD_WriteData
; 0000 000F }
_0xA:
; 0000 0010 LcdSendData(buf[(MAX_SIZE-1)-i]);
_0x9:
	LDI  R30,LOW(7)
	SUB  R30,R17
	LDI  R31,0
	SUBI R30,LOW(-_buf)
	SBCI R31,HIGH(-_buf)
	LD   R26,Z
	RCALL _LCD_WriteData
; 0000 0011 }
	SUBI R17,-1
	RJMP _0x7
_0x8:
; 0000 0012 }
	LDD  R17,Y+0
	ADIW R28,7
	RET
; .FEND
	#ifndef __SLEEP_DEFINED__
	#define __SLEEP_DEFINED__
	.EQU __se_bit=0x40
	.EQU __sm_mask=0xB0
	.EQU __sm_powerdown=0x20
	.EQU __sm_powersave=0x30
	.EQU __sm_standby=0xA0
	.EQU __sm_ext_standby=0xB0
	.EQU __sm_adc_noise_red=0x10
	.SET power_ctrl_reg=mcucr
	#endif
;unsigned char __swap_nibbles(unsigned char data)
; 0001 000A {

	.CSEG
___swap_nibbles:
; .FSTART ___swap_nibbles
; 0001 000B #asm
	ST   -Y,R26
;	data -> Y+0
; 0001 000C  ld r30, Y
 ld r30, Y
; 0001 000D  swap r30
 swap r30
; 0001 000E  #endasm
; 0001 000F }
	RJMP _0x2080002
; .FEND
;void LCD_WriteComInit(unsigned char data)
; 0001 0012 {
_LCD_WriteComInit:
; .FSTART _LCD_WriteComInit
; 0001 0013 unsigned char tmp;
; 0001 0014 delay_us(40);
	RCALL SUBOPT_0x0
;	data -> Y+1
;	tmp -> R17
	RCALL SUBOPT_0x2
; 0001 0015 ClearBit(PORT_SIG, RS);	//установка RS в 0 - команды
	CBI  0x15,0
; 0001 0016 #ifdef BUS_4BIT
; 0001 0017 tmp  = PORT_DATA & 0x0f;
	RCALL SUBOPT_0x3
; 0001 0018 tmp |= (data & 0xf0);
; 0001 0019 PORT_DATA = tmp;		//вывод старшей тетрады
; 0001 001A #else
; 0001 001B PORT_DATA = data;		//вывод данных на шину индикатора
; 0001 001C #endif
; 0001 001D SetBit(PORT_SIG, EN);	        //установка E в 1
; 0001 001E delay_us(2);
; 0001 001F ClearBit(PORT_SIG, EN);	//установка E в 0 - записывающий фронт
; 0001 0020 }
	LDD  R17,Y+0
	ADIW R28,2
	RET
; .FEND
;inline static void LCD_CommonFunc(unsigned char data)
; 0001 0024 {
; 0001 0025 #ifdef BUS_4BIT
; 0001 0026 unsigned char tmp;
; 0001 0027 tmp  = PORT_DATA & 0x0f;
;	data -> Y+1
;	tmp -> R17
; 0001 0028 tmp |= (data & 0xf0);
; 0001 0029 
; 0001 002A PORT_DATA = tmp;		//вывод старшей тетрады
; 0001 002B SetBit(PORT_SIG, EN);
; 0001 002C delay_us(2);
; 0001 002D ClearBit(PORT_SIG, EN);
; 0001 002E 
; 0001 002F data = __swap_nibbles(data);
; 0001 0030 tmp  = PORT_DATA & 0x0f;
; 0001 0031 tmp |= (data & 0xf0);
; 0001 0032 
; 0001 0033 PORT_DATA = tmp;		//вывод младшей тетрады
; 0001 0034 SetBit(PORT_SIG, EN);
; 0001 0035 delay_us(2);
; 0001 0036 ClearBit(PORT_SIG, EN);
; 0001 0037 #else
; 0001 0038 PORT_DATA = data;		//вывод данных на шину индикатора
; 0001 0039 SetBit(PORT_SIG, EN);	        //установка E в 1
; 0001 003A delay_us(2);
; 0001 003B ClearBit(PORT_SIG, EN);	//установка E в 0 - записывающий фронт
; 0001 003C #endif
; 0001 003D }
;inline static void LCD_Wait(void)
; 0001 0040 {
; 0001 0041 #ifdef CHECK_FLAG_BF
; 0001 0042 #ifdef BUS_4BIT
; 0001 0043 
; 0001 0044 unsigned char data;
; 0001 0045 DDRX_DATA &= 0x0f;            //конфигурируем порт на вход
; 0001 0046 PORT_DATA |= 0xf0;	        //включаем pull-up резисторы
; 0001 0047 SetBit(PORT_SIG, RW);         //RW в 1 чтение из lcd
; 0001 0048 ClearBit(PORT_SIG, RS);	//RS в 0 команды
; 0001 0049 do{
; 0001 004A SetBit(PORT_SIG, EN);
; 0001 004B delay_us(2);
; 0001 004C data = PIN_DATA & 0xf0;      //чтение данных с порта
; 0001 004D ClearBit(PORT_SIG, EN);
; 0001 004E data = __swap_nibbles(data);
; 0001 004F SetBit(PORT_SIG, EN);
; 0001 0050 delay_us(2);
; 0001 0051 data |= PIN_DATA & 0xf0;      //чтение данных с порта
; 0001 0052 ClearBit(PORT_SIG, EN);
; 0001 0053 data = __swap_nibbles(data);
; 0001 0054 }while((data & (1<<FLAG_BF))!= 0 );
; 0001 0055 ClearBit(PORT_SIG, RW);
; 0001 0056 DDRX_DATA |= 0xf0;
; 0001 0057 
; 0001 0058 #else
; 0001 0059 unsigned char data;
; 0001 005A DDRX_DATA = 0;                //конфигурируем порт на вход
; 0001 005B PORT_DATA = 0xff;	        //включаем pull-up резисторы
; 0001 005C SetBit(PORT_SIG, RW);         //RW в 1 чтение из lcd
; 0001 005D ClearBit(PORT_SIG, RS);	//RS в 0 команды
; 0001 005E do{
; 0001 005F SetBit(PORT_SIG, EN);
; 0001 0060 delay_us(2);
; 0001 0061 data = PIN_DATA;            //чтение данных с порта
; 0001 0062 ClearBit(PORT_SIG, EN);
; 0001 0063 }while((data & (1<<FLAG_BF))!= 0 );
; 0001 0064 ClearBit(PORT_SIG, RW);
; 0001 0065 DDRX_DATA = 0xff;
; 0001 0066 #endif
; 0001 0067 #else
; 0001 0068 delay_us(40);
; 0001 0069 #endif
; 0001 006A }
;void LCD_WriteCom(unsigned char data)
; 0001 006E {
_LCD_WriteCom:
; .FSTART _LCD_WriteCom
; 0001 006F LCD_Wait();
	ST   -Y,R26
;	data -> Y+0
	RCALL SUBOPT_0x2
; 0001 0070 ClearBit(PORT_SIG, RS);	//установка RS в 0 - команды
	CBI  0x15,0
; 0001 0071 LCD_CommonFunc(data);
	LD   R26,Y
	RCALL SUBOPT_0x0
	RCALL SUBOPT_0x3
	LDD  R26,Y+1
	RCALL ___swap_nibbles
	STD  Y+1,R30
	RCALL SUBOPT_0x3
	LDD  R17,Y+0
	ADIW R28,2
	RJMP _0x2080001
; 0001 0072 }
; .FEND
;void LCD_WriteData(unsigned char data)
; 0001 0076 {
_LCD_WriteData:
; .FSTART _LCD_WriteData
; 0001 0077 LCD_Wait();
	ST   -Y,R26
;	data -> Y+0
	RCALL SUBOPT_0x2
; 0001 0078 SetBit(PORT_SIG, RS);	        //установка RS в 1 - данные
	SBI  0x15,0
; 0001 0079 LCD_CommonFunc(data);
	LD   R26,Y
	RCALL SUBOPT_0x0
	RCALL SUBOPT_0x3
	LDD  R26,Y+1
	RCALL ___swap_nibbles
	STD  Y+1,R30
	RCALL SUBOPT_0x3
	LDD  R17,Y+0
	ADIW R28,2
_0x2080001:
; 0001 007A }
_0x2080002:
	ADIW R28,1
	RET
; .FEND
;void LCD_Init(void)
; 0001 007E {
_LCD_Init:
; .FSTART _LCD_Init
; 0001 007F #ifdef BUS_4BIT
; 0001 0080 DDRX_DATA |= 0xf0;
	IN   R30,0x14
	ORI  R30,LOW(0xF0)
	OUT  0x14,R30
; 0001 0081 PORT_DATA |= 0xf0;
	IN   R30,0x15
	ORI  R30,LOW(0xF0)
	OUT  0x15,R30
; 0001 0082 #else
; 0001 0083 DDRX_DATA |= 0xff;
; 0001 0084 PORT_DATA |= 0xff;
; 0001 0085 #endif
; 0001 0086 
; 0001 0087 DDRX_SIG |= (1<<RW)|(1<<RS)|(1<<EN);
	IN   R30,0x14
	ORI  R30,LOW(0x7)
	OUT  0x14,R30
; 0001 0088 PORT_SIG |= (1<<RW)|(1<<RS)|(1<<EN);
	IN   R30,0x15
	ORI  R30,LOW(0x7)
	OUT  0x15,R30
; 0001 0089 ClearBit(PORT_SIG, RW);
	CBI  0x15,1
; 0001 008A delay_ms(40);
	LDI  R26,LOW(40)
	RCALL SUBOPT_0x4
; 0001 008B 
; 0001 008C #ifdef HD44780
; 0001 008D LCD_WriteComInit(0x30);
; 0001 008E delay_ms(10);
	LDI  R26,LOW(10)
	RCALL SUBOPT_0x4
; 0001 008F LCD_WriteComInit(0x30);
; 0001 0090 delay_ms(1);
	LDI  R26,LOW(1)
	RCALL SUBOPT_0x4
; 0001 0091 LCD_WriteComInit(0x30);
; 0001 0092 #endif
; 0001 0093 
; 0001 0094 #ifdef BUS_4BIT
; 0001 0095 LCD_WriteComInit(0x20); //4-ми разр€дна€ шина
	LDI  R26,LOW(32)
	RCALL _LCD_WriteComInit
; 0001 0096 LCD_WriteCom(0x28); //4-ми разр€дна€ шина, 2 - строки
	LDI  R26,LOW(40)
	RCALL _LCD_WriteCom
; 0001 0097 #else
; 0001 0098 LCD_WriteCom(0x38); //8-ми разр€дна€ шина, 2 - строки
; 0001 0099 #endif
; 0001 009A LCD_WriteCom(0x08);
	LDI  R26,LOW(8)
	RCALL _LCD_WriteCom
; 0001 009B LCD_WriteCom(0x0c);  //0b00001111 - дисплей вкл, курсор и мерцание выключены
	LDI  R26,LOW(12)
	RCALL _LCD_WriteCom
; 0001 009C LCD_WriteCom(0x01);  //0b00000001 - очистка диспле€
	LDI  R26,LOW(1)
	RCALL _LCD_WriteCom
; 0001 009D delay_ms(2);
	LDI  R26,LOW(2)
	LDI  R27,0
	RCALL _delay_ms
; 0001 009E LCD_WriteCom(0x06);  //0b00000110 - курсор движетс€ вправо, сдвига нет
	LDI  R26,LOW(6)
	RCALL _LCD_WriteCom
; 0001 009F }
	RET
; .FEND
;void LCD_SendStringFlash(char __flash *str)
; 0001 00A3 {
; 0001 00A4 unsigned char data;
; 0001 00A5 while (*str)
;	*str -> Y+1
;	data -> R17
; 0001 00A6 {
; 0001 00A7 data = *str++;
; 0001 00A8 LCD_WriteData(data);
; 0001 00A9 }
; 0001 00AA }
;void LCD_SendString(char *str)
; 0001 00AE {
_LCD_SendString:
; .FSTART _LCD_SendString
; 0001 00AF unsigned char data;
; 0001 00B0 while (*str)
	ST   -Y,R27
	ST   -Y,R26
	ST   -Y,R17
;	*str -> Y+1
;	data -> R17
_0x20008:
	LDD  R26,Y+1
	LDD  R27,Y+1+1
	LD   R30,X
	CPI  R30,0
	BREQ _0x2000A
; 0001 00B1 {
; 0001 00B2 data = *str++;
	LD   R17,X+
	STD  Y+1,R26
	STD  Y+1+1,R27
; 0001 00B3 LCD_WriteData(data);
	MOV  R26,R17
	RCALL _LCD_WriteData
; 0001 00B4 }
	RJMP _0x20008
_0x2000A:
; 0001 00B5 }
	LDD  R17,Y+0
	ADIW R28,3
	RET
; .FEND
;void LCD_Clear(void)
; 0001 00B8 {
; 0001 00B9 LCD_WriteCom(0x01);
; 0001 00BA delay_ms(2);
; 0001 00BB }
	#ifndef __SLEEP_DEFINED__
	#define __SLEEP_DEFINED__
	.EQU __se_bit=0x40
	.EQU __sm_mask=0xB0
	.EQU __sm_powerdown=0x20
	.EQU __sm_powersave=0x30
	.EQU __sm_standby=0xA0
	.EQU __sm_ext_standby=0xB0
	.EQU __sm_adc_noise_red=0x10
	.SET power_ctrl_reg=mcucr
	#endif
;void main(void)
; 0002 0018 {

	.CSEG
_main:
; .FSTART _main
; 0002 0019 LCD_Init();
	RCALL _LCD_Init
; 0002 001A TIM_Init();
	RCALL _TIM_Init
; 0002 001B 
; 0002 001C LCD_Goto(0,0);
	LDI  R26,LOW(128)
	RCALL _LCD_WriteCom
; 0002 001D LCD_SendString("Freq: ");
	__POINTW2MN _0x40003,0
	RCALL _LCD_SendString
; 0002 001E 
; 0002 001F 
; 0002 0020 
; 0002 0021 #asm("sei");
	SEI
; 0002 0022 while(1){
_0x40004:
; 0002 0023 //ждем установки флага от схемы захвата
; 0002 0024 while(BitIsClear(TIFR, ICF1));
_0x40007:
	IN   R30,0x38
	SBRS R30,5
	RJMP _0x40007
; 0002 0025 //сохран€ем значени€ таймеров
; 0002 0026 Capt();
	RCALL _Capt
; 0002 0027 
; 0002 0028 //задержка в 1 секунду
; 0002 0029 delay_ms(1000);
	LDI  R26,LOW(1000)
	LDI  R27,HIGH(1000)
	RCALL _delay_ms
; 0002 002A 
; 0002 002B //ждем установки флага от схемы захвата
; 0002 002C while(BitIsClear(TIFR, ICF1));
_0x4000A:
	IN   R30,0x38
	SBRS R30,5
	RJMP _0x4000A
; 0002 002D //сохран€ем значени€ таймеров
; 0002 002E Capt();
	RCALL _Capt
; 0002 002F 
; 0002 0030 //вычисл€ем значение частоты и выводим на lcd
; 0002 0031 TIM_Calculation();
	RCALL _TIM_Calculation
; 0002 0032 }
	RJMP _0x40004
; 0002 0033 }
_0x4000D:
	RJMP _0x4000D
; .FEND

	.DSEG
_0x40003:
	.BYTE 0x7
	#ifndef __SLEEP_DEFINED__
	#define __SLEEP_DEFINED__
	.EQU __se_bit=0x40
	.EQU __sm_mask=0xB0
	.EQU __sm_powerdown=0x20
	.EQU __sm_powersave=0x30
	.EQU __sm_standby=0xA0
	.EQU __sm_ext_standby=0xB0
	.EQU __sm_adc_noise_red=0x10
	.SET power_ctrl_reg=mcucr
	#endif
;void TIM_Init(void)
; 0003 0006 {

	.CSEG
_TIM_Init:
; .FSTART _TIM_Init
; 0003 0007 /*инициализаци€ таймера “1
; 0003 0008 -разрешение прерывани€ по переполнению
; 0003 0009 -режим normal
; 0003 000A -захват по переднему фронту
; 0003 000B -предделитьель 1*/
; 0003 000C TIMSK |= (1 << TOIE1);
	IN   R30,0x39
	ORI  R30,4
	OUT  0x39,R30
; 0003 000D TCCR1A = (0 << COM1A1) | (0 << COM1A0) | (0 << WGM11) | (0 << WGM10);
	LDI  R30,LOW(0)
	OUT  0x2F,R30
; 0003 000E TCCR1B = (0 < ICNC1) | (1 << ICES1) | (0 << WGM13) | (0 << WGM12) | (0 << CS12) | (0 << CS11) | (1 << CS10);
	LDI  R30,LOW(65)
	OUT  0x2E,R30
; 0003 000F TCNT1 = 0;
	LDI  R30,LOW(0)
	LDI  R31,HIGH(0)
	OUT  0x2C+1,R31
	OUT  0x2C,R30
; 0003 0010 
; 0003 0011 /*инициализаци€ таймера “0
; 0003 0012 -разрешение прерывани€ по переполнению
; 0003 0013 -тактовый сигнал - внешний с вывода “0*/
; 0003 0014 TIMSK |= (1 << TOIE0);
	IN   R30,0x39
	ORI  R30,1
	OUT  0x39,R30
; 0003 0015 TCCR0 = (1 << CS02) | (1 << CS01) | (1 << CS00);
	LDI  R30,LOW(7)
	OUT  0x33,R30
; 0003 0016 TCNT0 = 0;
	LDI  R30,LOW(0)
	OUT  0x32,R30
; 0003 0017 }
	RET
; .FEND
;void Capt(void)
; 0003 0025 {
_Capt:
; .FSTART _Capt
; 0003 0026 unsigned char bufTCNT0;
; 0003 0027 unsigned int bufICR1;
; 0003 0028 unsigned int bufTimer0;
; 0003 0029 unsigned int bufTimer1;
; 0003 002A 
; 0003 002B #asm("cli");
	SBIW R28,2
	RCALL __SAVELOCR6
;	bufTCNT0 -> R17
;	bufICR1 -> R18,R19
;	bufTimer0 -> R20,R21
;	bufTimer1 -> Y+6
	CLI
; 0003 002C bufTCNT0 = TCNT0;
	IN   R17,50
; 0003 002D bufTimer0 = timer0;
	__GETWRMN 20,21,0,_timer0
; 0003 002E bufICR1 =  TCNT1;
	__INWR 18,19,44
; 0003 002F bufTimer1 = timer1;
	LDS  R30,_timer1
	LDS  R31,_timer1+1
	STD  Y+6,R30
	STD  Y+6+1,R31
; 0003 0030 #asm("sei");
	SEI
; 0003 0031 
; 0003 0032 tcnt01 = tcnt02;
	LDS  R30,_tcnt02
	LDS  R31,_tcnt02+1
	STS  _tcnt01,R30
	STS  _tcnt01+1,R31
; 0003 0033 tcnt02 = bufTCNT0;
	MOV  R30,R17
	LDI  R31,0
	STS  _tcnt02,R30
	STS  _tcnt02+1,R31
; 0003 0034 
; 0003 0035 saveTimer01 = saveTimer02;
	RCALL SUBOPT_0x5
	STS  _saveTimer01,R30
	STS  _saveTimer01+1,R31
; 0003 0036 saveTimer02 = bufTimer0;
	__PUTWMRN _saveTimer02,0,20,21
; 0003 0037 
; 0003 0038 saveTimer11 = saveTimer12;
	RCALL SUBOPT_0x6
	STS  _saveTimer11,R30
	STS  _saveTimer11+1,R31
; 0003 0039 saveTimer12 = bufTimer1;
	LDD  R30,Y+6
	LDD  R31,Y+6+1
	RCALL SUBOPT_0x7
; 0003 003A 
; 0003 003B icr11 = icr12;
	MOVW R10,R12
; 0003 003C icr12 = bufICR1;
	MOVW R12,R18
; 0003 003D }
	RCALL __LOADLOCR6
	ADIW R28,8
	RET
; .FEND
;interrupt [9] void Tim1Ovf(void)
; 0003 0041 {
_Tim1Ovf:
; .FSTART _Tim1Ovf
	RCALL SUBOPT_0x8
; 0003 0042 timer1++;
	LDI  R26,LOW(_timer1)
	LDI  R27,HIGH(_timer1)
	RJMP _0x60003
; 0003 0043 }
; .FEND
;interrupt [10] void Tim0Ovf(void)
; 0003 0046 {
_Tim0Ovf:
; .FSTART _Tim0Ovf
	RCALL SUBOPT_0x8
; 0003 0047 timer0++;
	LDI  R26,LOW(_timer0)
	LDI  R27,HIGH(_timer0)
_0x60003:
	LD   R30,X+
	LD   R31,X+
	ADIW R30,1
	ST   -X,R31
	ST   -X,R30
; 0003 0048 }
	LD   R30,Y+
	OUT  SREG,R30
	LD   R31,Y+
	LD   R30,Y+
	LD   R27,Y+
	LD   R26,Y+
	RETI
; .FEND
;void TIM_Calculation(void)
; 0003 004C {
_TIM_Calculation:
; .FSTART _TIM_Calculation
; 0003 004D unsigned long baseImp;
; 0003 004E //unsigned long mesurImp;
; 0003 004F unsigned long mesurImp;
; 0003 0050 unsigned long result;
; 0003 0051 
; 0003 0052 #asm("cli");
	SBIW R28,12
;	baseImp -> Y+8
;	mesurImp -> Y+4
;	result -> Y+0
	CLI
; 0003 0053 //вычисл€ем количество импульсов тактового сигнала
; 0003 0054 saveTimer12 = saveTimer12 - saveTimer11;
	LDS  R26,_saveTimer11
	LDS  R27,_saveTimer11+1
	RCALL SUBOPT_0x6
	SUB  R30,R26
	SBC  R31,R27
	RCALL SUBOPT_0x7
; 0003 0055 baseImp = (icr12 + (unsigned long)saveTimer12 * 65536) - icr11;
	LDS  R26,_saveTimer12
	LDS  R27,_saveTimer12+1
	RCALL SUBOPT_0x9
	__GETD1N 0x10000
	RCALL __MULD12U
	MOVW R26,R12
	RCALL SUBOPT_0x9
	__ADDD21
	MOVW R30,R10
	RCALL SUBOPT_0xA
	__PUTD2S 8
; 0003 0056 
; 0003 0057 //вычисл€ем количество импульсов измер€емого сигнала
; 0003 0058 saveTimer02 = saveTimer02 - saveTimer01;
	LDS  R26,_saveTimer01
	LDS  R27,_saveTimer01+1
	RCALL SUBOPT_0x5
	SUB  R30,R26
	SBC  R31,R27
	STS  _saveTimer02,R30
	STS  _saveTimer02+1,R31
; 0003 0059 mesurImp = ((tcnt02 + (unsigned  long)saveTimer02 * 256) - tcnt01) * 10;
	LDS  R26,_saveTimer02
	LDS  R27,_saveTimer02+1
	RCALL SUBOPT_0x9
	__GETD1N 0x100
	RCALL __MULD12U
	LDS  R26,_tcnt02
	LDS  R27,_tcnt02+1
	RCALL SUBOPT_0x9
	__ADDD21
	LDS  R30,_tcnt01
	LDS  R31,_tcnt01+1
	RCALL SUBOPT_0xA
	__GETD1N 0xA
	RCALL __MULD12U
	__PUTD1S 4
; 0003 005A 
; 0003 005B //вычисл€ем значение частоты
; 0003 005C //вот здесь кос€к - мой CodeVision не поддерживает тип long long
; 0003 005D //поэтому пришлось написать не так
; 0003 005E //result = (16000000UL*(unsigned long long)mesurImp*10)/baseImp;
; 0003 005F //а так
; 0003 0060 //result = (((16000000UL*200)/baseImp)*mesurImp)/20;
; 0003 0061 //result = (((16000000UL)/baseImp)*mesurImp)/20;
; 0003 0062 result = 16000000.0*(float)mesurImp/(float)baseImp;
	RCALL SUBOPT_0xB
	RCALL __CDF1U
	__GETD2N 0x4B742400
	RCALL __MULF12
	MOVW R26,R30
	MOVW R24,R22
	RCALL SUBOPT_0xC
	RCALL __CDF1U
	RCALL __DIVF21
	MOVW R26,R28
	RCALL __CFD1U
	__PUTDP1
; 0003 0063 
; 0003 0064 //выводим на дисплей частоту
; 0003 0065 LCD_Goto(7, 0);
	LDI  R26,LOW(135)
	RCALL _LCD_WriteCom
; 0003 0066 BCD_LongLcd(result, 8, 1);
	__GETD1S 0
	RCALL __PUTPARD1
	LDI  R30,LOW(8)
	ST   -Y,R30
	LDI  R26,LOW(1)
	RCALL _BCD_LongLcd
; 0003 0067 //и дл€ отладки количество опорных и входных импульсов
; 0003 0068 LCD_Goto(8, 1);
	LDI  R26,LOW(200)
	RCALL _LCD_WriteCom
; 0003 0069 BCD_LongLcd(baseImp, 8, 0);
	RCALL SUBOPT_0xC
	RCALL __PUTPARD1
	LDI  R30,LOW(8)
	ST   -Y,R30
	LDI  R26,LOW(0)
	RCALL _BCD_LongLcd
; 0003 006A LCD_Goto(0, 1);
	LDI  R26,LOW(192)
	RCALL _LCD_WriteCom
; 0003 006B BCD_LongLcd(mesurImp, 7, 0);
	RCALL SUBOPT_0xB
	RCALL __PUTPARD1
	LDI  R30,LOW(7)
	ST   -Y,R30
	LDI  R26,LOW(0)
	RCALL _BCD_LongLcd
; 0003 006C 
; 0003 006D saveTimer01 = 0;
	LDI  R30,LOW(0)
	STS  _saveTimer01,R30
	STS  _saveTimer01+1,R30
; 0003 006E saveTimer02 = 0;
	STS  _saveTimer02,R30
	STS  _saveTimer02+1,R30
; 0003 006F saveTimer11 = 0;
	STS  _saveTimer11,R30
	STS  _saveTimer11+1,R30
; 0003 0070 saveTimer12 = 0;
	STS  _saveTimer12,R30
	STS  _saveTimer12+1,R30
; 0003 0071 #asm("sei");
	SEI
; 0003 0072 }
	ADIW R28,12
	RET
; .FEND
	#ifndef __SLEEP_DEFINED__
	#define __SLEEP_DEFINED__
	.EQU __se_bit=0x40
	.EQU __sm_mask=0xB0
	.EQU __sm_powerdown=0x20
	.EQU __sm_powersave=0x30
	.EQU __sm_standby=0xA0
	.EQU __sm_ext_standby=0xB0
	.EQU __sm_adc_noise_red=0x10
	.SET power_ctrl_reg=mcucr
	#endif

	.CSEG
	#ifndef __SLEEP_DEFINED__
	#define __SLEEP_DEFINED__
	.EQU __se_bit=0x40
	.EQU __sm_mask=0xB0
	.EQU __sm_powerdown=0x20
	.EQU __sm_powersave=0x30
	.EQU __sm_standby=0xA0
	.EQU __sm_ext_standby=0xB0
	.EQU __sm_adc_noise_red=0x10
	.SET power_ctrl_reg=mcucr
	#endif

	.CSEG

	.DSEG

	.CSEG

	.CSEG

	.CSEG

	.DSEG
_buf:
	.BYTE 0x8
_timer0:
	.BYTE 0x2
_timer1:
	.BYTE 0x2
_tcnt01:
	.BYTE 0x2
_tcnt02:
	.BYTE 0x2
_saveTimer01:
	.BYTE 0x2
_saveTimer02:
	.BYTE 0x2
_saveTimer11:
	.BYTE 0x2
_saveTimer12:
	.BYTE 0x2
_d10_G101:
	.BYTE 0x8

	.CSEG
;OPTIMIZER ADDED SUBROUTINE, CALLED 4 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0x0:
	ST   -Y,R26
	ST   -Y,R17
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:5 WORDS
SUBOPT_0x1:
	__GETD2S 3
	__GETD1N 0xA
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:2 WORDS
SUBOPT_0x2:
	__DELAY_USB 213
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 5 TIMES, CODE SIZE REDUCTION:42 WORDS
SUBOPT_0x3:
	IN   R30,0x15
	ANDI R30,LOW(0xF)
	MOV  R17,R30
	LDD  R30,Y+1
	ANDI R30,LOW(0xF0)
	OR   R17,R30
	OUT  0x15,R17
	SBI  0x15,2
	__DELAY_USB 11
	CBI  0x15,2
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:4 WORDS
SUBOPT_0x4:
	LDI  R27,0
	RCALL _delay_ms
	LDI  R26,LOW(48)
	RJMP _LCD_WriteComInit

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0x5:
	LDS  R30,_saveTimer02
	LDS  R31,_saveTimer02+1
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0x6:
	LDS  R30,_saveTimer12
	LDS  R31,_saveTimer12+1
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0x7:
	STS  _saveTimer12,R30
	STS  _saveTimer12+1,R31
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:3 WORDS
SUBOPT_0x8:
	ST   -Y,R26
	ST   -Y,R27
	ST   -Y,R30
	ST   -Y,R31
	IN   R30,SREG
	ST   -Y,R30
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 4 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0x9:
	CLR  R24
	CLR  R25
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:3 WORDS
SUBOPT_0xA:
	CLR  R22
	CLR  R23
	__SUBD21
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0xB:
	__GETD1S 4
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0xC:
	__GETD1S 8
	RET

;RUNTIME LIBRARY

	.CSEG
__SAVELOCR6:
	ST   -Y,R21
__SAVELOCR5:
	ST   -Y,R20
__SAVELOCR4:
	ST   -Y,R19
__SAVELOCR3:
	ST   -Y,R18
__SAVELOCR2:
	ST   -Y,R17
	ST   -Y,R16
	RET

__LOADLOCR6:
	LDD  R21,Y+5
__LOADLOCR5:
	LDD  R20,Y+4
__LOADLOCR4:
	LDD  R19,Y+3
__LOADLOCR3:
	LDD  R18,Y+2
__LOADLOCR2:
	LDD  R17,Y+1
	LD   R16,Y
	RET

__ANEGD1:
	COM  R31
	COM  R22
	COM  R23
	NEG  R30
	SBCI R31,-1
	SBCI R22,-1
	SBCI R23,-1
	RET

__MULD12U:
	MUL  R23,R26
	MOV  R23,R0
	MUL  R22,R27
	ADD  R23,R0
	MUL  R31,R24
	ADD  R23,R0
	MUL  R30,R25
	ADD  R23,R0
	MUL  R22,R26
	MOV  R22,R0
	ADD  R23,R1
	MUL  R31,R27
	ADD  R22,R0
	ADC  R23,R1
	MUL  R30,R24
	ADD  R22,R0
	ADC  R23,R1
	CLR  R24
	MUL  R31,R26
	MOV  R31,R0
	ADD  R22,R1
	ADC  R23,R24
	MUL  R30,R27
	ADD  R31,R0
	ADC  R22,R1
	ADC  R23,R24
	MUL  R30,R26
	MOV  R30,R0
	ADD  R31,R1
	ADC  R22,R24
	ADC  R23,R24
	RET

__DIVD21U:
	PUSH R19
	PUSH R20
	PUSH R21
	CLR  R0
	CLR  R1
	MOVW R20,R0
	LDI  R19,32
__DIVD21U1:
	LSL  R26
	ROL  R27
	ROL  R24
	ROL  R25
	ROL  R0
	ROL  R1
	ROL  R20
	ROL  R21
	SUB  R0,R30
	SBC  R1,R31
	SBC  R20,R22
	SBC  R21,R23
	BRCC __DIVD21U2
	ADD  R0,R30
	ADC  R1,R31
	ADC  R20,R22
	ADC  R21,R23
	RJMP __DIVD21U3
__DIVD21U2:
	SBR  R26,1
__DIVD21U3:
	DEC  R19
	BRNE __DIVD21U1
	MOVW R30,R26
	MOVW R22,R24
	MOVW R26,R0
	MOVW R24,R20
	POP  R21
	POP  R20
	POP  R19
	RET

__MODD21U:
	RCALL __DIVD21U
	MOVW R30,R26
	MOVW R22,R24
	RET

__PUTPARD1:
	ST   -Y,R23
	ST   -Y,R22
	ST   -Y,R31
	ST   -Y,R30
	RET

__ROUND_REPACK:
	TST  R21
	BRPL __REPACK
	CPI  R21,0x80
	BRNE __ROUND_REPACK0
	SBRS R30,0
	RJMP __REPACK
__ROUND_REPACK0:
	ADIW R30,1
	ADC  R22,R25
	ADC  R23,R25
	BRVS __REPACK1

__REPACK:
	LDI  R21,0x80
	EOR  R21,R23
	BRNE __REPACK0
	PUSH R21
	RJMP __ZERORES
__REPACK0:
	CPI  R21,0xFF
	BREQ __REPACK1
	LSL  R22
	LSL  R0
	ROR  R21
	ROR  R22
	MOV  R23,R21
	RET
__REPACK1:
	PUSH R21
	TST  R0
	BRMI __REPACK2
	RJMP __MAXRES
__REPACK2:
	RJMP __MINRES

__UNPACK:
	LDI  R21,0x80
	MOV  R1,R25
	AND  R1,R21
	LSL  R24
	ROL  R25
	EOR  R25,R21
	LSL  R21
	ROR  R24

__UNPACK1:
	LDI  R21,0x80
	MOV  R0,R23
	AND  R0,R21
	LSL  R22
	ROL  R23
	EOR  R23,R21
	LSL  R21
	ROR  R22
	RET

__CFD1U:
	SET
	RJMP __CFD1U0
__CFD1:
	CLT
__CFD1U0:
	PUSH R21
	RCALL __UNPACK1
	CPI  R23,0x80
	BRLO __CFD10
	CPI  R23,0xFF
	BRCC __CFD10
	RJMP __ZERORES
__CFD10:
	LDI  R21,22
	SUB  R21,R23
	BRPL __CFD11
	NEG  R21
	CPI  R21,8
	BRTC __CFD19
	CPI  R21,9
__CFD19:
	BRLO __CFD17
	SER  R30
	SER  R31
	SER  R22
	LDI  R23,0x7F
	BLD  R23,7
	RJMP __CFD15
__CFD17:
	CLR  R23
	TST  R21
	BREQ __CFD15
__CFD18:
	LSL  R30
	ROL  R31
	ROL  R22
	ROL  R23
	DEC  R21
	BRNE __CFD18
	RJMP __CFD15
__CFD11:
	CLR  R23
__CFD12:
	CPI  R21,8
	BRLO __CFD13
	MOV  R30,R31
	MOV  R31,R22
	MOV  R22,R23
	SUBI R21,8
	RJMP __CFD12
__CFD13:
	TST  R21
	BREQ __CFD15
__CFD14:
	LSR  R23
	ROR  R22
	ROR  R31
	ROR  R30
	DEC  R21
	BRNE __CFD14
__CFD15:
	TST  R0
	BRPL __CFD16
	RCALL __ANEGD1
__CFD16:
	POP  R21
	RET

__CDF1U:
	SET
	RJMP __CDF1U0
__CDF1:
	CLT
__CDF1U0:
	SBIW R30,0
	SBCI R22,0
	SBCI R23,0
	BREQ __CDF10
	CLR  R0
	BRTS __CDF11
	TST  R23
	BRPL __CDF11
	COM  R0
	RCALL __ANEGD1
__CDF11:
	MOV  R1,R23
	LDI  R23,30
	TST  R1
__CDF12:
	BRMI __CDF13
	DEC  R23
	LSL  R30
	ROL  R31
	ROL  R22
	ROL  R1
	RJMP __CDF12
__CDF13:
	MOV  R30,R31
	MOV  R31,R22
	MOV  R22,R1
	PUSH R21
	RCALL __REPACK
	POP  R21
__CDF10:
	RET

__ZERORES:
	CLR  R30
	CLR  R31
	MOVW R22,R30
	POP  R21
	RET

__MINRES:
	SER  R30
	SER  R31
	LDI  R22,0x7F
	SER  R23
	POP  R21
	RET

__MAXRES:
	SER  R30
	SER  R31
	LDI  R22,0x7F
	LDI  R23,0x7F
	POP  R21
	RET

__MULF12:
	PUSH R21
	RCALL __UNPACK
	CPI  R23,0x80
	BREQ __ZERORES
	CPI  R25,0x80
	BREQ __ZERORES
	EOR  R0,R1
	SEC
	ADC  R23,R25
	BRVC __MULF124
	BRLT __ZERORES
__MULF125:
	TST  R0
	BRMI __MINRES
	RJMP __MAXRES
__MULF124:
	PUSH R0
	PUSH R17
	PUSH R18
	PUSH R19
	PUSH R20
	CLR  R17
	CLR  R18
	CLR  R25
	MUL  R22,R24
	MOVW R20,R0
	MUL  R24,R31
	MOV  R19,R0
	ADD  R20,R1
	ADC  R21,R25
	MUL  R22,R27
	ADD  R19,R0
	ADC  R20,R1
	ADC  R21,R25
	MUL  R24,R30
	RCALL __MULF126
	MUL  R27,R31
	RCALL __MULF126
	MUL  R22,R26
	RCALL __MULF126
	MUL  R27,R30
	RCALL __MULF127
	MUL  R26,R31
	RCALL __MULF127
	MUL  R26,R30
	ADD  R17,R1
	ADC  R18,R25
	ADC  R19,R25
	ADC  R20,R25
	ADC  R21,R25
	MOV  R30,R19
	MOV  R31,R20
	MOV  R22,R21
	MOV  R21,R18
	POP  R20
	POP  R19
	POP  R18
	POP  R17
	POP  R0
	TST  R22
	BRMI __MULF122
	LSL  R21
	ROL  R30
	ROL  R31
	ROL  R22
	RJMP __MULF123
__MULF122:
	INC  R23
	BRVS __MULF125
__MULF123:
	RCALL __ROUND_REPACK
	POP  R21
	RET

__MULF127:
	ADD  R17,R0
	ADC  R18,R1
	ADC  R19,R25
	RJMP __MULF128
__MULF126:
	ADD  R18,R0
	ADC  R19,R1
__MULF128:
	ADC  R20,R25
	ADC  R21,R25
	RET

__DIVF21:
	PUSH R21
	RCALL __UNPACK
	CPI  R23,0x80
	BRNE __DIVF210
	TST  R1
__DIVF211:
	BRPL __DIVF219
	RJMP __MINRES
__DIVF219:
	RJMP __MAXRES
__DIVF210:
	CPI  R25,0x80
	BRNE __DIVF218
__DIVF217:
	RJMP __ZERORES
__DIVF218:
	EOR  R0,R1
	SEC
	SBC  R25,R23
	BRVC __DIVF216
	BRLT __DIVF217
	TST  R0
	RJMP __DIVF211
__DIVF216:
	MOV  R23,R25
	PUSH R17
	PUSH R18
	PUSH R19
	PUSH R20
	CLR  R1
	CLR  R17
	CLR  R18
	CLR  R19
	MOVW R20,R18
	LDI  R25,32
__DIVF212:
	CP   R26,R30
	CPC  R27,R31
	CPC  R24,R22
	CPC  R20,R17
	BRLO __DIVF213
	SUB  R26,R30
	SBC  R27,R31
	SBC  R24,R22
	SBC  R20,R17
	SEC
	RJMP __DIVF214
__DIVF213:
	CLC
__DIVF214:
	ROL  R21
	ROL  R18
	ROL  R19
	ROL  R1
	ROL  R26
	ROL  R27
	ROL  R24
	ROL  R20
	DEC  R25
	BRNE __DIVF212
	MOVW R30,R18
	MOV  R22,R1
	POP  R20
	POP  R19
	POP  R18
	POP  R17
	TST  R22
	BRMI __DIVF215
	LSL  R21
	ROL  R30
	ROL  R31
	ROL  R22
	DEC  R23
	BRVS __DIVF217
__DIVF215:
	RCALL __ROUND_REPACK
	POP  R21
	RET

_delay_ms:
	adiw r26,0
	breq __delay_ms1
__delay_ms0:
	wdr
	__DELAY_USW 0xFA0
	sbiw r26,1
	brne __delay_ms0
__delay_ms1:
	ret

;END OF CODE MARKER
__END_OF_CODE:
