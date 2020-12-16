#include "soc.h"
#include "type.h"

volatile uint32_t *bus_base = (volatile u32 *) SYSTEM_AXI_A_BMB;

void main() {
	while (1) {
		int i;

		for (i = 0; i < 10; i++) {
			(*(bus_base + i)) = (u32) (i + 1);
		}

		u32 val;
		for (i = 0; i < 10; i++) {
			val = (*(bus_base + i));
		}
	}
}


