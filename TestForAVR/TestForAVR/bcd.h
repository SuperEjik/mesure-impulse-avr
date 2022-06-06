#ifndef BCD_H
#define BCD_H

//здесь подключаем свою либу для жкд
//#include "lcd_lib.h"

//здесь переопределяем функцию по выводу символа на экран
#define LcdSendData(data) LCD_WriteData(data)

//разрядность десятичного числа
#define MAX_SIZE 8

//нужно передать значение, количество отображаемых цифр и позицию запятой
void BCD_LongLcd(unsigned long value, unsigned char size, unsigned char comma);

#endif //BCD_H

