#include <stdint.h>
#include <stdbool.h>

bool get_bit(uint32_t pp){
	bool p_v1 = (pp & (0x1<<6));
	bool p_v2 = (pp & (0x1<<5));

	return (p_v1 ^ p_v2);
}

extern "C" uint32_t prbs7_calc(uint32_t seed){
	uint8_t i = 0;

	while(1) {
		if(get_bit(seed)) {
            seed <<=1;
            seed += 1;
        } else seed <<=1;

        i++;
        if(!(i%32)) break;
	}

    return seed;
}