typedef unsigned int size_t;
typedef unsigned char uint8_t;

#define UART_BASE ((size_t *)0x10013000)
#define TXDATA (UART_BASE + 0)

// Making putchar static optimizes space as it will not be 'exported'
// to be visible in other source files.
static void putchar(uint8_t ch) {
	while ((volatile int)*TXDATA < 0);
	*TXDATA = ch;
}

void puts(char *s) {
	// while char pointed to by s is non-zero, putchar and increment the pointer
	while (*s) putchar(*s++);
	putchar('\n');
}

void main() {
	puts("Hello RISC-V from C!");
	puts("bye");
}
