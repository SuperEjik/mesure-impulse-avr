//***************************************************************************
//
//  Author(s)...: Pashgan    http://ChipEnable.Ru   
//
//  Target(s)...: ATMega8535
//
//  Compiler....: CodeVision 2.04
//
//  Description.:  ������ �����������.
//
//  Data........: 01.03.11 
//
//***************************************************************************
#include <mega8535.h>
#include <delay.h>
#include <stdio.h>
#include "lcd_lib.h"
#include "bcd.h"
#include "timer.h"
#include "bits_macros.h"


void main(void)
{
  LCD_Init();
  TIM_Init();
  
  LCD_Goto(0,0);
  LCD_SendString("Freq: ");  
  
  
  
  #asm("sei");
  while(1){
    //���� ��������� ����� �� ����� �������
    while(BitIsClear(TIFR, ICF1));
    //��������� �������� ��������
    Capt();
    
    //�������� � 1 �������
    delay_ms(1000);    
    
    //���� ��������� ����� �� ����� �������
    while(BitIsClear(TIFR, ICF1));
    //��������� �������� ��������
    Capt();

    //��������� �������� ������� � ������� �� lcd
    TIM_Calculation();  
  }
}
