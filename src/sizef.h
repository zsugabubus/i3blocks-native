static char const UNITS[] =                     { ' ', 'B', 'K', 'M', 'G',  'T',  'Y', };
static unsigned long long const UNIT_SHIFTS[] = {   1, 1e0, 1e3, 1e6, 1e9, 1e12, 1e15, 1e18 };

static void
sizef(char (*const buf)[4], unsigned long long n) {
	int i = 0;

	while (n >= UNIT_SHIFTS[++i])
		;

	n /= (UNIT_SHIFTS - 1)[i];

	(*buf)[0] = n >= 100ULL ? '0' + (n / 100ULL)           : ' ';
	(*buf)[1] = n >= 10ULL  ? '0' + ((n % 100ULL) / 10ULL) : ' ';
	(*buf)[2] = '0' + (n % 10ULL);
	(*buf)[3] = (UNITS - 1)[i];
}
/* vi:set ts=4 sw=4 noet: */
