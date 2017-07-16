#include "include_all_libs.h"
#include "fisc_system.h"
#include "intro.h"

static void print_dec(unsigned int value, unsigned int width, char * buf, int * ptr)
{
/*
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
		unsigned int n = value / 10;
		int r = value % 10;
		buf[*ptr + i - 1] = r + '0';
		i--;
		value = n;
	}
	*ptr += n_width;
*/
}

static void print_hex(unsigned int value, unsigned int width, char * buf, int * ptr)
{
/*
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
	while (i-- > 0) {
		buf[*ptr] = "0123456789abcdef"[(value >> (i * 4)) & 0xF];
		*ptr += +1;
	}
*/
}

size_t vasprintf(char * buf, const char * fmt, va_list args)
{
	int i = 0;
	char * s;
	char * b = buf;
	for (const char *f = fmt; *f; f++) {
		if (*f != '%') {
			*b++ = *f;
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
			}
			break;
		case 'c': /* Single character */
			*b++ = (char)va_arg(args, int);
			break;
		case 'x': /* Hexadecimal number */
			i = b - buf;
			print_hex((unsigned long)va_arg(args, unsigned long), arg_width, buf, &i);
			b = buf + i;
			break;
		case 'd': /* Decimal number */
			i = b - buf;
			print_dec((unsigned long)va_arg(args, unsigned long), arg_width, buf, &i);
			b = buf + i;
			break;
		case '%': /* Escape */
			*b++ = '%';
			break;
		default: /* Nothing at all, just dump it */
			*b++ = *f;
			break;
		}
	}
	/* Ensure the buffer ends in a null */
	*b = '\0';
	return b - buf;
}

int sprintf(char * buf, const char *fmt, ...) {
	va_list args;
	va_start(args, fmt);
	int out = vasprintf(buf, fmt, args);
	va_end(args);
	return out;
}

static uint16_t video_x __data = 0;
static uint16_t video_y __data = 0;
static uint64_t video_colorinfo __data = 0;

void video_test()
{
	rgbpack_t * rgbs = (rgbpack_t*)&video_colorinfo;
	if(video_y < VIDEO_HEIGHT) {
		video_backend_setaddress(video_x, video_y);

		for(int i = 0; i < VIDEO_PIXEL_CHANNEL_COUNT; i++)
			video_pixels_pack(i, rgbs);

		video_x += VIDEO_PIXEL_CHANNEL_COUNT * 2;

		if(video_x > VIDEO_WIDTH) {
			video_x = 0;
			video_y++;

			rgbs->rgb1.r += 1;
			rgbs->rgb1.g -= 2;
			rgbs->rgb1.b += 1;
			rgbs->rgb1.b *= 3;

			rgbs->rgb2.r += 1;
			rgbs->rgb2.g += 2;
			rgbs->rgb2.b += 3;
		}
		
		video_backend_render_block(50);
	} else {
		video_backend_render_block(0);
	}
}

void start()
{
	welcome();
	puts("\nAvailable Options:\nq- Quit\n\n");

	/*static char buff[10] __data;
	FIXSTACK;
	sprintf(buff, "Text: %s", "formatted");*/

	while(1) {
		if(!video_is_enabled())
			break;

		video_test();

		if(kbhit())
		{
			char ch = getch_async();
			if(ch == 'q')
				break;
			putc(ch);
		}
	}

	goodbye();
}
