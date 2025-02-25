#include <stdio.h>

int max(int a, int b) {
	if (a >= b) {
		return a;
	}
	else {
		return b;
	}

}

int min(int a, int b) {
	if (a <= b) {
		return a;
	}
	else {
		return b;
	}
}

int GCD(int a, int b) {
	if (min(a, b) == 0) {
		return max(a, b);
	}
	while (min(a, b) != 0) {
		if (a - b >= 0) {
			a = a - b;
		}
		else {
			b = b - a;
		}
	}
	return max(a, b);
}

void main(void) {
	printf("GCD: %d\n", GCD(165, 363));
	printf("GCD: %d\n", GCD(48, 180));
	printf("GCD: %d\n", GCD(27, 36));
}