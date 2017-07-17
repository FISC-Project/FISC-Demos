#include "include_all_libs.h"
#include "fisc_system.h"
#include "intro.h"
#include "bitmap.h"

void start()
{
	welcome();
	puts("\nOptions: q - quit | s - stop animation | r - resume animation");

	bool animation_toggle = 1;
	bool paint_direction = 0;
	int16_t video_x = 0;
	int16_t video_y = 0;
	uint32_t pxidx = 0;
	uint32_t bitmap_count = 2;
	bool bitmap_count_increase = true;
	uint64_t video_colorinfo = 0;
	rgbpack_t * rgbs = (rgbpack_t*)&video_colorinfo;
	
	uint8_t red1   = 75;
	uint8_t green1 = 128;
	uint8_t blue1  = 255;

	uint8_t red2   = 75;
	uint8_t green2 = 128;
	uint8_t blue2  = 255;

	while(1) {
		if(!video_is_enabled()) break;

		if(animation_toggle) {
			if(video_y <= 0)
				paint_direction = 0;

			if(video_y < VIDEO_HEIGHT) {
				video_backend_setaddress(video_x, video_y);

				for(int i = 0; i < VIDEO_PIXEL_CHANNEL_COUNT; i++) {

					if(img[pxidx] == 0xFF) {
						rgbs->rgb1.r = red1;
						rgbs->rgb1.g = green1;
						rgbs->rgb1.b = blue1;
					} else {
						rgbs->rgb1.r = rgbs->rgb1.g = rgbs->rgb1.b = 0xFF;
					}

					if(img[pxidx + 1] == 0xFF) {
						rgbs->rgb2.r = red2;
						rgbs->rgb2.g = green2;
						rgbs->rgb2.b = blue2;
					} else {
						rgbs->rgb2.r = rgbs->rgb2.g = rgbs->rgb2.b = 0xFF;
					}

					pxidx += bitmap_count;

					if(pxidx > sizeof(img)) {
						pxidx = 0;

						blue1 -= 10;
						blue2 -= 10;

						if(bitmap_count_increase) {
							bitmap_count += 2;
							if(bitmap_count > 8)
								bitmap_count_increase = 0;
						}
						else {
							bitmap_count -= 2;
							if(bitmap_count <= 2)
								bitmap_count_increase = 1;
						}
					}
					video_pixels_pack(i, rgbs);
				}

				video_x += VIDEO_PIXEL_CHANNEL_COUNT * 2;
				
				if(video_x >= 480 || video_x <= 0) {
					video_x = 0;
					if(!paint_direction)
						video_y++;
					else
						video_y--;
				}
					
				video_backend_render_block(40);
			} else {
				video_backend_render_block(0);
				video_x = 0;
				video_y--;
				paint_direction = 1;
			}
		}

		if(kbhit()) { 
			char ch = tolower(getch_async());
			if(ch == 'q')
				break;
			if(ch == 's')
				animation_toggle = 0;
			if(ch == 'r')
				animation_toggle = 1;
		}
	}

	goodbye();
}
