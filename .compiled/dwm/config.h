/* appearance */
static const unsigned int borderpx  = 2;        /* border pixel of windows */
static const unsigned int snap      = 32;       /* snap pixel */
static const int showbar            = 1;        /* 0 means no bar */
static const int topbar             = 0;        /* 0 means bottom bar */
static const char *fonts[]          = { "Hermit:size=10" };
static const char col_white[]       = "#ebdbc2";
static const char col_black[]       = "#161414";
static const char col_muted[]       = "#a89984";
static const char *colors[][3]      = {
	/*               fg         bg         border   */
	[SchemeNorm] = { col_white, col_black, col_black },
	[SchemeSel]  = { col_black, col_white, col_white },
};

/* tagging */
static const char *tags[] = { "z", "a", "x", "s", "d", "c", "f" };

static const Rule rules[] = {
	{ "Firefox",  NULL,       NULL,       1 << 8,       0,           -1 },
};

/* layout(s) */
static const float mfact     = 0.55; /* factor of master area size [0.05..0.95] */
static const int nmaster     = 1;    /* number of clients in master area */
static const int resizehints = 0;    /* 1 means respect size hints in tiled resizals */
static const int lockfullscreen = 1; /* 1 will force focus on the fullscreen window */
static const int refreshrate = 60;   /* refresh rate (per second) for client move/resize */

#include "doublecolumn.c"
static const Layout layouts[] = {
	/* symbol     arrange function */
	{ "I|I",      doublecolumn },    /* first entry is default */
	{ " * ",      NULL },    /* no layout function means floating behavior */
};

/* key definitions */
#define MODKEY Mod4Mask
#define TAGKEYS(KEY,TAG) \
	{ MODKEY,                       KEY,      view,           {.ui = 1 << TAG} }, \
	{ MODKEY|ControlMask,           KEY,      toggleview,     {.ui = 1 << TAG} }, \
	{ MODKEY|ShiftMask,             KEY,      tag,            {.ui = 1 << TAG} }, \

/* commands */
static char launchermon[2] = "0"; /* component of launchercmd, manipulated in spawn() */
static const char *termcmd[]        = { "st", NULL };
static const char *launchercmd[]    = { "dmenu_run", "-m", launchermon, NULL };
static const char *browsercmd[]     = { "firefox", "-P", "main", NULL };
static const char *screenshotcmd[]  = { "flameshot", "gui", NULL };

/* HOTKEYS TODO:
 *
 * apps:
 * [ ] launch app (mod + [1-2])
 *     [/] browser
 *     [ ] music
 * [/] launch terminal (mod + return)
 * [/] launch launcher (mod + q)
 * [/] launch screenshot util (mod + y)
 * [/] toggle bar (mod + b)
 *
 * move window:
 * [ ] move window [up/down] in stack (mod + [jk])
 * [ ] move window to [left/right] stack (mod + shift + [hl])
 *
 * tags:
 * [/] move view to [tag] (mod + [zaxsdcf])
 * [ ] toggle view to [tag] (mod + 
 * [ ] move window to [tag] (mod + shift + [zaxsdcf])
 * [ ] view all tags (mod + \)
 *
 * monitors:
 * [ ] focus other monitor (mod + tab)
 * [ ] move window to other monitor (mod + shift + tab)
*/

static const Key keys[] = {
    /* commands */
	{ MODKEY,             XK_w,      killclient,     {0} },
	{ MODKEY|ShiftMask,   XK_q,      quit,           {0} },
	{ MODKEY,             XK_t,      togglefloating, {0} },
	{ MODKEY,             XK_b,      togglebar,      {0} },
	{ MODKEY,             XK_space,  setlayout,      {0} },
    /* apps */
	{ MODKEY,             XK_1,      spawn,          {.v = browsercmd    } },
	{ MODKEY,             XK_Return, spawn,          {.v = termcmd       } },
	{ MODKEY,             XK_q,      spawn,          {.v = launchercmd   } },
	{ MODKEY,             XK_y,      spawn,          {.v = screenshotcmd } },
    /* focus window */
	{ MODKEY,             XK_j,      focusstack,     {.i = +1 } },
	{ MODKEY,             XK_k,      focusstack,     {.i = -1 } },
    /* grow window */
	{ MODKEY|ControlMask, XK_h,      setmfact,       {.f = -0.05} },
	{ MODKEY|ControlMask, XK_l,      setmfact,       {.f = +0.05} },
    { MODKEY|ControlMask, XK_k,      setcfact,       {.f = +0.25} },
    { MODKEY|ControlMask, XK_j,      setcfact,       {.f = -0.25} },
    /* monitors */
	{ MODKEY,             XK_Tab,    focusmon,       {.i = -1 } },
	{ MODKEY|ShiftMask,   XK_Tab,    tagmon,         {.i = -1 } },

    /* tags */
	TAGKEYS(XK_z, 0)
	TAGKEYS(XK_a, 1)
	TAGKEYS(XK_x, 2)
	TAGKEYS(XK_s, 3)
	TAGKEYS(XK_d, 4)
	TAGKEYS(XK_c, 5)
	TAGKEYS(XK_f, 6)
};

/* button definitions */
/* click can be:
 * ClkTagBar
 * ClkLtSymbol 
 * ClkStatusText 
 * ClkWinTitle 
 * ClkClientWin 
 * ClkRootWin 
*/
static const Button buttons[] = {
	/* click         event   button   function   argument */
	{ ClkLtSymbol,   0,      Button1, setlayout,   {0}                },
	{ ClkLtSymbol,   0,      Button3, setlayout,   {.v = &layouts[2]} },
	{ ClkStatusText, 0,      Button2, spawn,       {.v = termcmd }    },
	{ ClkClientWin,  MODKEY, Button1, movemouse,   {0}                },
	{ ClkClientWin,  MODKEY, Button3, resizemouse, {0} },
};

