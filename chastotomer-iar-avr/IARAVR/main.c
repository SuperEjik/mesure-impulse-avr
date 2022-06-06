//***************************************************************************
//
//  Author(s)...: Pashgan    http://ChipEnable.Ru   
//
//  Target(s)...: ATMega8535
//
//  Compiler....: IAR 5.11A
//
//  Description.:  ������ �����������.
//
//  Data........: 01.03.11 
//
//***************************************************************************
#include <ioavr.h>
#include <intrinsics.h>
#include "lcd_lib.h"
#include "bcd.h"
#include "timer.h"
#include "bits_macros.h"


int main(void)
{
  LCD_Init();
  TIM_Init();
  
  LCD_Goto(0,0);
  LCD_SendString("Freq: ");
  
  __enable_interrupt();
  while(1){
    //���� ��������� ����� �� ����� �������
    while(BitIsClear(TIFR, ICF1));
    //��������� �������� ��������
    Capt();
    
    //�������� � 1 �������
    __delay_cycles(16000000);    
    
    //���� ��������� ����� �� ����� �������
    while(BitIsClear(TIFR, ICF1));
    //��������� �������� ��������
    Capt();

    //��������� �������� ������� � ������� �� lcd
    TIM_Calculation(); 
  }
  return 0;
}
