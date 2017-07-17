#include "include_all_libs.h"
#include "fisc_system.h"
#include "intro.h"
#include "bitmap.h"

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

		if(video_x >= VIDEO_WIDTH) {
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

void program1_fizzbuzz()
{
	for(int i = 1; i <= 100; i++) {
		bool fizz = !((bool)mod(i, 3));
		bool buzz = !((bool)mod(i, 5));

		if(fizz && buzz) puts("FizzBuzz ");
		else if(fizz)    puts("Fizz ");
		else if(buzz)    puts("Buzz ");
		else             printf("%d ", i);
	}

	printf("\n\n> Done (press q to return)");
	while(tolower(getch()) != 'q');
}

int read_number(int maxnum)
{
	int number = -1;
	while(!isdigit(number) || number - '0' > maxnum) {
		number = getch();
		if(tolower(number) == 'q') return number;
	}
	return number - '0';
}

char read_operator()
{
	char operator = 0;
	while(1) {
		operator = getch();
		if(operator == '+' || operator == '-' || 
		   operator == '*' || operator == '/' || 
		   operator == '%' || operator == '&' || 
		   operator == '|' || operator == 'q')
		{
			return operator;
		}
	}
}

int calculate(int num1, int num2, char operation)
{
	if(operation == '+')
		return num1 + num2;
	else if(operation == '-')
		return num1 - num2;
	else if(operation == '*')
		return num1 * num2;
	else if(operation == '/')
		return num1 / num2;
	else if(operation == '%')
		return mod(num1, num2);
	else if(operation == '&')
		return num1 & num2;
	else if(operation == '|')
		return num1 | num2;
	return -1;
}

void program2_calculator()
{
	while(1)
	{
		if(kbhit() && tolower(getch_async()) == 'q') break;
		
		puts("(press q to return)\nHow many numbers do you want to calculate : ");
		int numcount = read_number(8);
		if(tolower(numcount) == 'q') { putc(numcount); return; }
		putc(numcount + '0');	
		
		int ans = 0;
		static int numbers[9] __data;
		static char operators[8] __data;

		for(int i = 0; i < numcount; i++) {
			FIXSTACK;
			printf("\n> Number %d: ", i + 1);
			numbers[i] = read_number(9);
			if(tolower(numbers[i]) == 'q') { putc(numcount); return; }
			putc(numbers[i] + '0');

			if(i >= numcount - 1) break;

			puts("\n> Operator (+ - * / % & |): ");
			operators[i] = read_operator();
			if(tolower(operators[i]) == 'q') { putc(numcount); return; }
			putc(operators[i]);
		}

		if(numcount == 1) {
			ans = numbers[0];
		} else {
			int operator_counter = 0;
			for(int i = 0; i < numcount - 1; i += 2)
				ans += calculate(numbers[i], numbers[i + 1], operators[operator_counter++]);
			if(mod(numcount, 2))
				ans = calculate(ans, numbers[numcount - 1], operators[numcount - 2]);
		}

		printf("\n>>>>> Answer: %d <<<<<\n\n", ans);
	}
}

void program3_painting_vga()
{
	bool running = true;
	while(running)
	{
		if(kbhit() && tolower(getch_async()) == 'q') break;
		/* TODO: Paint the VGA screen using keyboard (Needs keyboard + mouse device) */
	}
}

void program4_vga_game()
{
	bool running = true;
	while(running)
	{
		if(kbhit() && tolower(getch_async()) == 'q') break;
		/* TODO: Play a game on the VGA screen (Needs keyboard + mouse device) */
	}
}

void print_menu()
{
	puts("\nChoose the demo from the list below:\n1- FizzBuzz\n2- Calculator\n3- Pixel painter\n4- Secret game\nq- Quit\n\n> Choose: ");
}

void start()
{
	welcome();

	print_menu();

	while(1) {
		if(!video_is_enabled()) break;

		video_test();

		if(kbhit())
		{	
			char ch = getch_async();
			bool unknown_option = false;

			if(tolower(ch) == 'q') {
				putc(ch);
				break;
			} else if(ch == '1') {
				putc(ch);
				puts("\nYou are now in the FizzBuzz program (press q to return at any time)\n________\n");
				program1_fizzbuzz();
			} else if(ch == '2') {
				putc(ch);
				puts("\nYou are now in the Calculator program (press q to return at any time)\n________\n");
				program2_calculator();	
			} else if(ch == '3') {
				putc(ch);
				puts("\nYou are now in the Pixel painter program (press q to return at any time)\n________\n");
				program3_painting_vga();
			} else if(ch == '4') {
				putc(ch);
				puts("\nYou are now in the Secret game program (press q to return at any time)\n________\n");
				program4_vga_game();
			} else {
				unknown_option = true;
			}

			if(!unknown_option) {
				puts("\n________\nWelcome back to the main menu");
				print_menu();
			}
		}
	}

	goodbye();
}
