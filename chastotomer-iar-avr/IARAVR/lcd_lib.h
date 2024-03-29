//***************************************************************************
//  File........: lcd_lib.h
//
//  Author(s)...: Pashgan    chipenable.ru
//
//  Target(s)...: ATMega...
//
//  Compiler....: IAR EWAAVR 5.11a
//
//  Description.: ������� ������������������� �� �������
//
//  Data........: 28.10.09  
//
//***************************************************************************
#ifndef LCD_LIB_H
#define LCD_LIB_H

#include <ioavr.h>
#include <intrinsics.h>

//���� � �������� ���������� ���� ������ ���
#define PORT_DATA PORTC
#define PIN_DATA  PINC
#define DDRX_DATA DDRC

//���� � �������� ���������� ����������� ������ ���
#define PORT_SIG PORTC
#define PIN_SIG  PINC
#define DDRX_SIG DDRC

//������ ������� � ������� ���������� ����������� ������ ��� 
#define RS 0
#define RW 1
#define EN 2

#define F_CPU 16000000

//#define CHECK_FLAG_BF
#define BUS_4BIT
#define HD44780
//******************************************************************************
//�������

/*���������������� �������*/
#define LCD_Goto(x,y) LCD_WriteCom(((((y)& 1)*0x40)+((x)& 15))|128) 


//��������� �������
void LCD_Init(void);//������������� ������ � ���
void LCD_Clear(void);//������� ���
void LCD_WriteData(unsigned char data); //������� ���� ������ �� ���
void LCD_WriteCom(unsigned char data); //�������� ������� ���
void LCD_SendStringFlash(char __flash *str); //������� ������ �� ���� ������
void LCD_SendString(char *str); //������� ������ �� ���
#endif