#include "bcd.h"

unsigned char buf[MAX_SIZE];

void BCD_LongLcd(unsigned long value, unsigned char size, unsigned char comma)
{
  unsigned char i;
  for(i = 0; i<MAX_SIZE; i++){
    buf[i] = (unsigned char)((value % 10) + 48);
    value = value/10;
  }
  for(i = 0; i<size; i++){
    if (comma){
      if (i == MAX_SIZE-comma) LcdSendData(',');
    }
    LcdSendData(buf[(MAX_SIZE-1)-i]);
  }
}