/* user and group to drop privileges to */
static const char *user  = "nobody";
static const char *group = "nogroup";

static const char *colorname[NUMCOLS] = {
	[BG] =     "#161414",     /* background */
	[INIT] =   "#ebdbc2",   /* after initialization */
	[INPUT] =  "#ebdbc2",   /* during input */
	[FAILED] = "#b6343d",   /* wrong password */
};

/* treat a cleared input like a wrong password (color) */
static const int failonclear = 1;

/* size of square in px */
static const int squaresize = 32;

/* spacing between squares in px */
static const int squarespacing = 6;

