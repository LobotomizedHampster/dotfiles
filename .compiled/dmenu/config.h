/* Default settings; can be overriden by command line. */

/* 0 = bottom, 1 = top */
static int topbar = 0; 
static const char *fonts[] = { "Hermit:size=10" };
static const char *prompt  = NULL; /* -p */
static const char *colors[SchemeLast][2] = {
	               /* fg         bg       */
	[SchemeNorm] = { "#ebdbc2", "#161414" },
	[SchemeSel]  = { "#161414", "#ebdbc2" },
	[SchemeOut]  = { "#000000", "#00ffff" },
};
/* if nonzero, dmenu uses vertical list with given number of lines */
static unsigned int lines = 0;

static const char worddelimiters[] = " ";

