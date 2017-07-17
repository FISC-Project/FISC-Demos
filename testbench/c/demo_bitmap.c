#include "include_all_libs.h"
#include "fisc_system.h"
#include "intro.h"
#include "bitmap.h"

void start()
{
	welcome();

	uint16_t video_x = 0;
	uint16_t video_y = 0;
	uint32_t pxidx = 0;
	uint32_t bitmap_count = 2;
	bool bitmap_count_increase = true;
	uint64_t video_colorinfo = 0;
	rgbpack_t * rgbs = (rgbpack_t*)&video_colorinfo;

	while(1) {
		if(!video_is_enabled()) break;

		if(video_y < VIDEO_HEIGHT) {
			video_backend_setaddress(video_x, video_y);

			for(int i = 0; i < VIDEO_PIXEL_CHANNEL_COUNT; i++) {
				rgbs->rgb1.r = img[pxidx];
				rgbs->rgb1.g = img[pxidx];
				rgbs->rgb1.b = img[pxidx];

				rgbs->rgb2.r = img[pxidx+1];
				rgbs->rgb2.g = img[pxidx+1];
				rgbs->rgb2.b = img[pxidx+1];

				pxidx += bitmap_count;

				if(pxidx > sizeof(img)) {
					pxidx = 0;

					if(bitmap_count_increase)
						bitmap_count += 2;
					else
						bitmap_count -= 2;
				}
				video_pixels_pack(i, rgbs);
			}

			video_x += VIDEO_PIXEL_CHANNEL_COUNT * 2;

			if(video_x >= 480) {
				video_x = 0;
				video_y++;
			}
				
			video_backend_render_block(40);
		} else {
			video_backend_render_block(0);
			video_x = 0;
			video_y = 0;
			bitmap_count_increase = !bitmap_count_increase;
		}

		if(kbhit() && tolower(getch_async()) == 'q') break;
	}

	goodbye();
}
