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
//**************************************************************************
#ifndef TIM_H
#define TIM_H

#include <avr/io.h>
#include <avr/interrupt.h>
#include <stdint.h>
#include "bits_macros.h"
//#include "lcd_lib.h"
#include "bcd.h"

void TIM_Init(void);                 //инициализация таймеров
void TIM_Calculation(void);          //вычисление частоты
void Capt(void);                     //захват значений счетчиков 

#endif //TIM_H