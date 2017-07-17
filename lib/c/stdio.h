#ifndef STDIO_H_
#define STDIO_H_

#include "iospace.h"
#include "string.h"
#include "stdint.h"
#include "attr.h"
#include "math.h"

/************************/
/******* PRINTING *******/
/************************/
static void print_dec(unsigned int value, unsigned int width, char * buf, int * ptr)
{
	unsigned int n_width = 1;
	unsigned int i = 9;
	while (value > i && i < UINT32_MAX) {
		n_width += 1;
		i *= 10;
		i += 9;
	}

	int printed = 0;
	while (n_width + printed < width) {
		buf[*ptr] = '0';
		*ptr += 1;
		printed += 1;
	}

	i = n_width;

	while (i > 0) {
		unsigned int n = div10(value);
		int r = mod10(value);
		buf[*ptr + i - 1] = r + '0';
		i--;
		value = n;
	}

	*ptr += n_width;
}

static void print_hex(unsigned int value, unsigned int width, char * buf, int * ptr)
{
	int i = width;
	
	if (i == 0) i = 8;

	unsigned int n_width = 1;
	unsigned int j = 0x0F;
	while (value > j && j < UINT32_MAX) {
		n_width += 1;
		j *= 0x10;
		j += 0x0F;
	}

	while (i >(int)n_width) {
		buf[*ptr] = '0';
		*ptr += 1;
		i--;
	}

	i = (int)n_width;

	value *= 2;

	while (i-- > 0) {
		buf[*ptr] = "0123456789abcdef"[(value >> (i * 4)) & 0xF];
		*ptr += 1;
	}
}

size_t vasprintf(char * buf, const char * fmt, va_list args)
{
	int i = 0;
	char * s;
	char * b = buf;
	int ctr = 0;
	for (const char *f = fmt; *f; f++) {
		if (*f != '%') {
			*b++ = *f;
			ctr++;
			continue;
		}
		++f;
		unsigned int arg_width = 0;
		while (*f >= '0' && *f <= '9') {
			arg_width *= 10;
			arg_width += *f - '0';
			++f;
		}
		/* fmt[i] == '%' */
		switch (*f) {
		case 's': /* String pointer -> String */
			s = (char *)va_arg(args, char *);
			if (s == NULL) {
				s = (char*)"(null)";
			}
			while (*s) {
				*b++ = *s++;
				ctr++;
			}
			break;
		case 'c': /* Single character */
			*b++ = (char)va_arg(args, int);
			ctr++;
			break;
		case 'x': /* Hexadecimal number */
			i = ctr;
			print_hex((unsigned long)va_arg(args, unsigned long), arg_width, buf, &i);
			ctr = i;
			b = buf + i;
			break;
		case 'd': /* Decimal number */
			i = ctr;
			print_dec((unsigned long)va_arg(args, unsigned long), arg_width, buf, &i);
			ctr = i;
			b = buf + i;
			break;
		case '%': /* Escape */
			*b++ = '%';
			ctr++;
			break;
		default: /* Nothing at all, just dump it */
			*b++ = *f;
			ctr++;
			break;
		}
	}
	/* Ensure the buffer ends in a null */
	*b = '\0';
	return b - buf;
}

#define strfmt(buffer, fmt) do { va_list args; va_start(args, fmt); vasprintf(buffer, fmt, args); va_end(args); } while(0)

int sprintf(char * buf, const char * fmt, ...)
{
	va_list args;
	va_start(args, fmt);
	int out = vasprintf(buf, fmt, args);
	va_end(args);
	return out;
}

/*******************************/
/******* STANDARD OUTPUT *******/
/*******************************/
void wait_stdout_flush()
{
	while(!io->VMConsole.wrRdy);
}

void putc(char ch)
{
	/* Send byte to virtual console */
	io->VMConsole.wr = ch;
}

void puts(char * str)
{
	/* Send full string to virtual console */
	for(size_t i = 0; i < strlen(str); i++)
		putc(str[i]);
}

static char __printf_buff__[256] __data;

int printf(const char * fmt, ...)
{
	strfmt(__printf_buff__, fmt);
	puts(__printf_buff__);
	return strlen(__printf_buff__);
}

/******************************/
/******* STANDARD INPUT *******/
/******************************/
bool kbhit()
{
	return io->VMConsole.rdRdy;
}

char getch()
{
	while(!kbhit());
	return io->VMConsole.rd;
}

char getch_async()
{
	return io->VMConsole.rd;
}

#define DEBUGLOC 0x10000
#define DEBUG(loc, integer) (((uint32_t*)DEBUGLOC)[(loc)] = ((uint32_t)(integer)))
#define DEBUGLIST(listsize, list) for(size_t _i_ = 0; _i_ < ((size_t)(listsize)); _i_++) DEBUG(_i_, ((uint32_t*)(list)[_i_]));
#define DEBUGLISTOFF(offset, listsize, list) for(size_t _i_ = ((size_t)(offset)); _i_ < ((size_t)(offset)) + ((size_t)(listsize)); _i_++) DEBUG(_i_, ((uint32_t*)(list)[_i_ - ((size_t)(offset))]));

#endif