//***************************************************************************
//
//  Author(s)...: Pashgan    http://ChipEnable.Ru   
//
//  Target(s)...: ATMega8535
//
//  Compiler....: IAR 5.11A
//
//  Description.:  Проект частотомера.
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
    //ждем установки флага от схемы захвата
    while(BitIsClear(TIFR, ICF1));
    //сохраняем значения таймеров
    Capt();
    
    //задержка в 1 секунду
    __delay_cycles(16000000);    
    
    //ждем установки флага от схемы захвата
    while(BitIsClear(TIFR, ICF1));
    //сохраняем значения таймеров
    Capt();

    //вычисляем значение частоты и выводим на lcd
    TIM_Calculation(); 
  }
  return 0;
}
