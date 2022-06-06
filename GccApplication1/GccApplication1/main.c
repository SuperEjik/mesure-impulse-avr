//***************************************************************************
//
//  Author(s)...: Pashgan    http://ChipEnable.Ru   
//
//  Target(s)...: ATMega8535
//
//  Compiler....: GNU GCC
//
//  Description.:  ������ �����������.
//
//  Data........: 01.03.11 
//
//***************************************************************************

#define F_CPU 16000000UL

#include <util/delay.h>
#include <avr/io.h>
#include <avr/interrupt.h>
#include "lcd_lib.h"
#include "bcd.h"
#include "timer.h"
#include "bits_macros.h"

int i = 0;

int main(void)
{ 
  //LCD_Init();
  TIM_Init();
  
  //LCD_Goto(0,0);
  //LCD_SendString("Freq: ");
  
  sei();
  while(1){
    //���� ��������� ����� �� ����� �������
    while(BitIsClear(TIFR, ICF1));
    //��������� �������� ��������
    Capt();
    
    //�������� � 1 �������
    _delay_ms(1000);    
    i++;
    //���� ��������� ����� �� ����� �������
    while(BitIsClear(TIFR, ICF1));
    //��������� �������� ��������
    Capt();

    //��������� �������� ������� � ������� �� lcd
	TIM_Calculation();
  }
  return 0;
}
