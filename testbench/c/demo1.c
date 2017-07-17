#include "include_all_libs.h"
#include "fisc_system.h"
#include "intro.h"

void video_test()
{
	static uint16_t video_x __data = 0;
	static uint16_t video_y __data = 0;
	static uint64_t video_colorinfo __data = 0;
	static bool inc __data = 0;

	rgbpack_t * rgbs = (rgbpack_t*)&video_colorinfo;
	if(video_y < VIDEO_HEIGHT) {
		video_backend_setaddress(video_x, video_y);

		for(int i = 0; i < VIDEO_PIXEL_CHANNEL_COUNT; i++)
			video_pixels_pack(i, rgbs);

		video_x += VIDEO_PIXEL_CHANNEL_COUNT * 2;

		if(video_x > VIDEO_WIDTH) {
			video_x = 0;
			video_y++;

			if(inc) {
				if(video_y >= 254)
					inc = !inc;

				rgbs->rgb1.r += 2;
				rgbs->rgb1.g += 3;
				rgbs->rgb1.b += 4;

				rgbs->rgb2.r += 2;
				rgbs->rgb2.g += 3;
				rgbs->rgb2.b += 4;
			} else {
				rgbs->rgb1.r -= 2;
				rgbs->rgb1.g -= 2;
				rgbs->rgb1.b -= 2;

				rgbs->rgb2.r -= 2;
				rgbs->rgb2.g -= 2;
				rgbs->rgb2.b -= 2;

				if(rgbs->rgb1.r <= 0)
					inc = !inc;
			}

		}
			
		video_backend_render_block(40);
	} else {
		video_backend_render_block(0);
	}
}

void start()
{
	welcome();
	printf("\n> This is demo # 1\n");

	while(1) {
		if(!video_is_enabled()) break;

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
