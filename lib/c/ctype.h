#ifndef CTYPE_H_
#define CTYPE_H_

int isdigit(int ch) {
	return (unsigned int)ch - '0' < 10;
}

int isspace(int ch) {
	return ch == ' ' || (unsigned int)ch - '\t' < 5;
}

#endif