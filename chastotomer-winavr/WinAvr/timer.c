#include "timer.h"
unsigned long result;

//������������� ������� �1
void TIM_Init(void)
{
   /*������������� ������� �1
     -���������� ���������� �� ������������
     -����� normal
     -������ �� ��������� ������
     -������������� 1*/
   TIMSK |= (1<<TOIE1);
   TCCR1A=(0<<COM1A1)|(0<<COM1A0)|(0<<WGM11)|(0<<WGM10); 
   TCCR1B=(0<ICNC1)|(1<<ICES1)|(0<<WGM13)|(0<<WGM12)|(0<<CS12)|(0<<CS11)|(1<<CS10); 
   TCNT1 = 0;
   
   /*������������� ������� �0
      -���������� ���������� �� ������������
      -�������� ������ - ������� � ������ �0*/
   TIMSK |= (1<<TOIE0);
   TCCR0 = (1<<CS02)|(1<<CS01)|(1<<CS00);
   TCNT0 = 0;
}

//����������� ��������
volatile unsigned int timer0 = 0; //������� ����� ������������ ������� �0
volatile unsigned int timer1 = 0; //������� ����� ������������ ������� �1

//������ ��� �������� �������� ���������
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

   cli();
   bufTCNT0 = TCNT0;   
   bufTimer0 = timer0;
   bufICR1 =  TCNT1;
   bufTimer1 = timer1;
   sei();
  
  tcnt01 = tcnt02;
  tcnt02 = bufTCNT0;
  
  saveTimer01 = saveTimer02;
  saveTimer02 = bufTimer0;
  
  saveTimer11 = saveTimer12;
  saveTimer12 = bufTimer1;
  
  icr11 = icr12;
  icr12 = bufICR1;   
}


ISR(TIMER1_OVF_vect)
{
   timer1++;  
}

ISR(TIMER0_OVF_vect)
{  
   timer0++;   
}


void TIM_Calculation(void)
{
  unsigned long baseImp;
  unsigned long mesurImp;
  //unsigned long result;
 
  cli(); 
  //��������� ���������� ��������� ��������� �������
  saveTimer12 = saveTimer12 - saveTimer11;
  baseImp = (icr12 + (unsigned long)saveTimer12*65536) - icr11;
  
  //��������� ���������� ��������� ����������� �������
  saveTimer02 = saveTimer02 - saveTimer01;
  mesurImp = ((tcnt02 + (unsigned  long)saveTimer02*256) - tcnt01)*10;
  
  //��������� �������� �������
  //�� �� ������� � ����� long long �������� ������������ ���������
  //� ��������� ������� �� �������:
  //result = (((16000000UL*200)/baseImp)*mesurImp)/20;
  result = 16000000.0*(float)mesurImp/(float)baseImp;
  
   //������� �� ������� �������
  LCD_Goto(7,0);
  BCD_LongLcd(result, 8, 1); 
  //� ��� ������� ���������� ������� � ������� ���������
  LCD_Goto(8,1);
  BCD_LongLcd(baseImp, 8,0); 
  LCD_Goto(0,1);
  BCD_LongLcd(mesurImp, 7, 0);  
  
  saveTimer01 = 0;
  saveTimer02 = 0;  
  saveTimer11 = 0;
  saveTimer12 = 0;
  sei();
}

