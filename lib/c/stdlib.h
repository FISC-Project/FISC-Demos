#ifndef STDLIB_H_
#define STDLIB_H_

#include "ctype.h"

#define ALLOCLOC 0x20000
uintptr_t alloc_head __data = ALLOCLOC;

void * malloc(size_t size)
{
	uintptr_t thisloc = alloc_head;
	alloc_head += size;
	return (void*)thisloc;
}

void * memcpy(void * dst, void * src, size_t len)
{
	uint8_t * dst_ = (uint8_t*)dst;
	uint8_t * src_ = (uint8_t*)src;
	for(size_t i = 0; i < len; i++)
		dst_[i] = src_[i];
	return dst;
}

void * memset(void * dst, int32_t val, size_t len)
{
	uint8_t * dst_ = (uint8_t*)dst;
	for(size_t i = 0; i < len; i++)
		dst_[i] = val;
	return dst;
}

int atoi(const char * s) {
	int n = 0;
	int neg = 0;
	while (isspace(*s))
		s++;

	switch (*s) {
	case '-':
		neg = 1;
		/* Fallthrough is intentional here */
	case '+':
		s++;
	}
	while (isdigit(*s))
		n = 10 * n - (*s++ - '0');
	/* The sign order may look incorrect here but this is correct as n is calculated
	* as a negative number to avoid overflow on INT_MAX.
	*/
	return neg ? n : -n;
}

#endif