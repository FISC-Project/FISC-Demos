#ifndef MATH_H_
#define MATH_H_

int32_t div10(int32_t dividend)
{
	int64_t invDivisor = 0x1999999A;
	return (int32_t)((invDivisor * dividend) >> 32);
}

int32_t mod10(int32_t a)
{
	return a - (10 * (div10(a)));
}

int32_t mod(int32_t a, uint32_t b)
{
	return a - (b * (a / b));
}


#endif