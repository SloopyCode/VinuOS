#ifndef CONSOLE_H
#define CONSOLE_H

#include <stdint.h>

uint8_t inb(uint16_t port);

void console_put_char(char c);


void console_print(const char *str);

void print_hex(uint8_t value);

void keyboard_test(void);

#endif // CONSOLE_H
