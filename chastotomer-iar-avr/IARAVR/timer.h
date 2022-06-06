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
//**************************************************************************
#ifndef TIM_H
#define TIM_H

#include <ioavr.h>
#include <intrinsics.h>
#include "bits_macros.h"
#include "lcd_lib.h"
#include "bcd.h"

void TIM_Init(void);                 //инициализация таймеров
void TIM_Calculation(void);          //вычисление частоты
void Capt(void);                     //захват значений счетчиков 

#endif //TIM_H