#ifndef BCD_H
#define BCD_H

//����� ���������� ���� ���� ��� ���
//#include "lcd_lib.h"

//����� �������������� ������� �� ������ ������� �� �����
#define LcdSendData(data) LCD_WriteData(data)

//����������� ����������� �����
#define MAX_SIZE 8

//����� �������� ��������, ���������� ������������ ���� � ������� �������
void BCD_LongLcd(unsigned long value, unsigned char size, unsigned char comma);

#endif //BCD_H

