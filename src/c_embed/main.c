typedef unsigned int size_t;
typedef unsigned char uint8_t;

#define UART_BASE ((size_t *)0x10013000)
#define TXDATA (UART_BASE + 0)

static int putchar(uint8_t ch) {
	while ((volatile int)*TXDATA < 0);
	*TXDATA = ch;
	
	return (int)ch;
}

void puts(char *s) {
	while (*s) putchar(*s++);
	putchar('\n');
}

void main() {
	puts("Hello RISC-V from C");
}
