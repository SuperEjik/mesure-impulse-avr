/*
 * TestForAVR.c
 *
 * Created: 06.06.2022 17:38:18
 * Author : oves0
 */ 

/*#include <avr/io.h>


int main(void)
{
    // Replace with your application code
    while (1) 
    {
    }
}*/

//***************************************************************************
//
//  Author(s)...: Pashgan    http://ChipEnable.Ru   
//
//  Target(s)...: ATMega8535
//
//  Compiler....: GNU GCC
//
//  Description.:  Проект частотомера.
//
//  Data........: 01.03.11 
//
//***************************************************************************

//#define F_CPU 16000000UL

#include <util/delay.h>
#include <avr/io.h>
#include <avr/interrupt.h>
//#include "lcd_lib.h"
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
    //ждем установки флага от схемы захвата
    //while(BitIsClear(TIFR, ICF1));
	while(BitIsClear(TIFR0, ICF1));
    //сохраняем значения таймеров
    Capt();
    
    //задержка в 1 секунду
    _delay_ms(1000);    
    i++;
    //ждем установки флага от схемы захвата
    //while(BitIsClear(TIFR, ICF1));
	while(BitIsClear(TIFR0, ICF1));
    //сохраняем значения таймеров
    Capt();

    //вычисляем значение частоты и выводим на lcd
	TIM_Calculation();
  }
  return 0;
}
