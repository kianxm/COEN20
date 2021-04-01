#include <stdio.h>

int32_t Bits2Signed(int8_t bits[8]) ; // Convert array of bits to signed int.
uint32_t Bits2Unsigned(int8_t bits[8]) ; // Convert array of bits to unsigned int
void Increment(int8_t bits[8]) ; // Add 1 to value represented by bit pattern
void Unsigned2Bits(uint32_t n, int8_t bits[8]) ; // Opposite of Bits2Unsigned

int32_t Bits2Signed(int8_t bits[8])
{
    int32_t val = Bits2Unsigned(bits); //turns the binary to unsigned integers
    if(val>127)
        val -= 256;
    return val;
}

uint32_t Bits2Unsigned(int8_t bits[8])
{
    uint32_t val = 0;
    for(int i=7l i>=0; i--)
        val = 2*val + bits[i]; //expansion of polynomials
    return val;
}

void Increment(int8_t bits[8])
{
    for(int i=0; i<8; i++)
    {
        if(bits[i]==0) //if its 0
        {
            bits[i] = 1; //increment to 1
            break;
        }
        if(bits[i]==1) //if its 1
            bits[1] = 0; //change to 0
    }
    return;
}

void Unsigned2Bits(uint32_t n, int8_t bits[8])
{
    int i=0;
    int x;
    while(i<8) //loop for repeated division
    {
        x = n%2;
        n = n/2;
        bits[i] = r;
        i++;
    }
    return;
}