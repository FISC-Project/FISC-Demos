#ifndef VIDEO_H_
#define VIDEO_H_

#define VIDEO_WIDTH  800
#define VIDEO_HEIGHT 600
#define VIDEO_PITCH  4
#define VIDEO_LINBUFFSIZE (VIDEO_WIDTH * VIDEO_HEIGHT * VIDEO_PITCH)

typedef struct {
	uint8_t r, g, b, a;
} rgb_t;

typedef struct {
	rgb_t rgb1, rgb2;
} rgbpack_t;

static uint32_t video_render_counter __data = 0;

void initialize_video()
{
	io->VGA.enDev = 1;
	io->VGA.px_xpos = 0;
	io->VGA.px_ypos = 0;
	io->VGA.px_access_width = 0;
	io->VGA.px_render = 0;

	for(int i=0;i<11000;i++)
		for(int j=0;j<10;j++);
}

bool video_is_on()
{
	return io->VGA.status & 2;
}

void video_backend_setaddress(uint16_t x, uint16_t y)
{
	uint16_t * ptr = &io->VGA.px_xpos;
	*ptr = x;
	ptr = &io->VGA.px_ypos;
	*ptr = y;
}

void video_pixels_pack(uint32_t loc, rgbpack_t * rgbpack)
{
	uint64_t * rgbpack_64cast = (uint64_t*)rgbpack;
	uint64_t * pxdata_ptr = io->VGA.px_data;
	pxdata_ptr[loc] = *rgbpack_64cast;
}

void video_backend_render()
{
	io->VGA.px_render = 1;
}

void video_backend_render_block(uint32_t blocksize)
{
	if(video_render_counter++ >= blocksize) {
		video_render_counter = 0;	
		video_backend_render();
	}
}

#endif