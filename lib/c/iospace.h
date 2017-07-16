#ifndef IOSPACE_H_
#define IOSPACE_H_

#include "stdint.h"

#define VIDEO_PIXEL_CHANNEL_COUNT 50

#define IOSPACE 0x5000

typedef struct IO {
	struct __packed {
		int8_t enDev;
		int8_t enWr;
		int8_t enRd;
		int8_t status;
		int8_t wr;
		int8_t wrRdy;
		int8_t rd;
		int8_t rdRdy;
	} VMConsole;
	struct __packed {
		int8_t   enDev;
		int8_t   enTimer;
		uint32_t period;
		int8_t   status;
	} Timer;
	struct __packed {
		int8_t   enDev;
		int8_t   status;
		uint16_t px_xpos;
		uint16_t px_ypos;
		int8_t   px_access_width;
		int8_t   px_render;
		int8_t   px_read;
		uint64_t px_data[VIDEO_PIXEL_CHANNEL_COUNT];
	} VGA;
} io_t;

static io_t * io __data = (io_t*)IOSPACE;

#endif