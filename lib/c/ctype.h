#ifndef CTYPE_H_
#define CTYPE_H_

int isdigit(int ch) {
	return (unsigned int)ch - '0' < 10;
}

int isspace(int ch) {
	return ch == ' ' || (unsigned int)ch - '\t' < 5;
}

int tolower(int ch) {
	return ch >= 'A' && ch <= 'Z' ? ch + 32 : ch;
}

int toupper(int ch) {
	return ch >= 'a' && ch <= 'z' ? ch - 32 : ch;
}

#endif