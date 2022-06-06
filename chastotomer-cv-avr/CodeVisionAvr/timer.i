#pragma used+
sfrb TWBR=0;
sfrb TWSR=1;
sfrb TWAR=2;
sfrb TWDR=3;
sfrb ADCL=4;
sfrb ADCH=5;
sfrw ADCW=4;      
sfrb ADCSRA=6;
sfrb ADMUX=7;
sfrb ACSR=8;
sfrb UBRRL=9;
sfrb UCSRB=0xa;
sfrb UCSRA=0xb;
sfrb UDR=0xc;
sfrb SPCR=0xd;
sfrb SPSR=0xe;
sfrb SPDR=0xf;
sfrb PIND=0x10;
sfrb DDRD=0x11;
sfrb PORTD=0x12;
sfrb PINC=0x13;
sfrb DDRC=0x14;
sfrb PORTC=0x15;
sfrb PINB=0x16;
sfrb DDRB=0x17;
sfrb PORTB=0x18;
sfrb PINA=0x19;
sfrb DDRA=0x1a;
sfrb PORTA=0x1b;
sfrb EECR=0x1c;
sfrb EEDR=0x1d;
sfrb EEARL=0x1e;
sfrb EEARH=0x1f;
sfrw EEAR=0x1e;   
sfrb UBRRH=0x20;
sfrb UCSRC=0X20;
sfrb WDTCR=0x21;
sfrb ASSR=0x22;
sfrb OCR2=0x23;
sfrb TCNT2=0x24;
sfrb TCCR2=0x25;
sfrb ICR1L=0x26;
sfrb ICR1H=0x27;
sfrb OCR1BL=0x28;
sfrb OCR1BH=0x29;
sfrw OCR1B=0x28;  
sfrb OCR1AL=0x2a;
sfrb OCR1AH=0x2b;
sfrw OCR1A=0x2a;  
sfrb TCNT1L=0x2c;
sfrb TCNT1H=0x2d;
sfrw TCNT1=0x2c;  
sfrb TCCR1B=0x2e;
sfrb TCCR1A=0x2f;
sfrb SFIOR=0x30;
sfrb OSCCAL=0x31;
sfrb OCDR=0x31;
sfrb TCNT0=0x32;
sfrb TCCR0=0x33;
sfrb MCUCSR=0x34;
sfrb MCUCR=0x35;
sfrb TWCR=0x36;
sfrb SPMCR=0x37;
sfrb TIFR=0x38;
sfrb TIMSK=0x39;
sfrb GIFR=0x3a;
sfrb GICR=0x3b;
sfrb OCR0=0X3c;
sfrb SPL=0x3d;
sfrb SPH=0x3e;
sfrb SREG=0x3f;
#pragma used-
#asm
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
#endasm

#pragma used+
void delay_us(unsigned int n);
void delay_ms(unsigned int n);
#pragma used-

void LCD_Init(void);
void LCD_Clear(void);
void LCD_WriteData(unsigned char data); 
void LCD_WriteCom(unsigned char data); 
void LCD_SendStringFlash(char __flash *str); 
void LCD_SendString(char *str); 
void BCD_LongLcd(unsigned long value, unsigned char size, unsigned char comma);
void TIM_Init(void);                 
void TIM_Calculation(void);          
void Capt(void);                     
typedef struct
{
unsigned long lo;
long hi;
} long64_t;
typedef struct
{
unsigned long lo;
unsigned long hi;
} ulong64_t;
long64_t tolong64(long x);
ulong64_t tolong64u(unsigned long x);
long64_t neg64(long64_t x);
ulong64_t abs64(long64_t x);
ulong64_t com64(ulong64_t x);
ulong64_t not64(ulong64_t x);
signed char sign64(long64_t x);
signed char cmp64(long64_t x, long64_t y);
signed char cmp64u(ulong64_t x, ulong64_t y);
long64_t add64(long64_t x, long64_t y);
long64_t sub64(long64_t x, long64_t y);
long64_t mul64(long64_t x, long64_t y);
ulong64_t mul64u(ulong64_t x, ulong64_t y);
long64_t div64(long64_t x, long64_t y);
ulong64_t div64u(ulong64_t x, ulong64_t y);
long64_t mod64(long64_t x, long64_t y);
ulong64_t mod64u(ulong64_t x, ulong64_t y);
ulong64_t or64(ulong64_t x, ulong64_t y);
ulong64_t and64(ulong64_t x, ulong64_t y);
ulong64_t xor64(ulong64_t x, ulong64_t y);
void asr64(long64_t *x, unsigned char n);
void lsr64(ulong64_t *x, unsigned char n);
void lsl64(ulong64_t *x, unsigned char n);
void inc64(long64_t *x);
void dec64(long64_t *x);
unsigned long sqrt64(ulong64_t x);
long64_t atol64(char *str);
ulong64_t xtol64(char *str);
void ltoa64(long64_t x, char *str);
void ltox64(ulong64_t x, char *str);
void printl64(long64_t x);
void printx64(ulong64_t x);
#pragma library math64.lib
void TIM_Init(void)
{

TIMSK |= (1 << 2       );
TCCR1A = (0 << 7       ) | (0 << 6       ) | (0 << 1       ) | (0 << 0       );
TCCR1B = (0 < 7       ) | (1 << 6       ) | (0 << 4       ) | (0 << 3       ) | (0 << 2       ) | (0 << 1       ) | (1 << 0       );
TCNT1 = 0;

TIMSK |= (1 << 0       );
TCCR0 = (1 << 2       ) | (1 << 1       ) | (1 << 0       );
TCNT0 = 0;
}
volatile unsigned int timer0 = 0; 
volatile unsigned int timer1 = 0; 
unsigned int icr11 = 0, icr12 = 0;
unsigned int tcnt01 = 0, tcnt02 = 0;
unsigned int saveTimer01 = 0, saveTimer02 = 0;
unsigned int saveTimer11 = 0, saveTimer12 = 0;
void Capt(void)
{
unsigned char bufTCNT0;
unsigned int bufICR1;
unsigned int bufTimer0;
unsigned int bufTimer1;
#asm("cli");
bufTCNT0 = TCNT0;
bufTimer0 = timer0;
bufICR1 =  TCNT1;
bufTimer1 = timer1;
#asm("sei");
tcnt01 = tcnt02;
tcnt02 = bufTCNT0;
saveTimer01 = saveTimer02;
saveTimer02 = bufTimer0;
saveTimer11 = saveTimer12;
saveTimer12 = bufTimer1;
icr11 = icr12;
icr12 = bufICR1;
}
interrupt [9] void Tim1Ovf(void)
{
timer1++;
}
interrupt [10] void Tim0Ovf(void)
{
timer0++;
}
void TIM_Calculation(void)
{
unsigned long baseImp;
unsigned long mesurImp;
unsigned long result;
#asm("cli");
saveTimer12 = saveTimer12 - saveTimer11;
baseImp = (icr12 + (unsigned long)saveTimer12 * 65536) - icr11;
saveTimer02 = saveTimer02 - saveTimer01;
mesurImp = ((tcnt02 + (unsigned  long)saveTimer02 * 256) - tcnt01) * 10;
result = 16000000.0*(float)mesurImp/(float)baseImp;
LCD_WriteCom(((((0)& 1)*0x40)+((7)& 15))|128);
BCD_LongLcd(result, 8, 1);
LCD_WriteCom(((((1)& 1)*0x40)+((8)& 15))|128);
BCD_LongLcd(baseImp, 8, 0);
LCD_WriteCom(((((1)& 1)*0x40)+((0)& 15))|128);
BCD_LongLcd(mesurImp, 7, 0);
saveTimer01 = 0;
saveTimer02 = 0;
saveTimer11 = 0;
saveTimer12 = 0;
#asm("sei");
}
