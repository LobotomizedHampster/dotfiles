void
doublecolumn(Monitor *m) {
	unsigned int n, col, lrow, rrow, cn, rn, /*i,*/ row, cx, cy, cw, ch;
	Client *c;

    /* number of non-minimized and tiled windows */
	for(n = 0, c = nexttiled(m->clients); c; c = nexttiled(c->next), n++) ;
	if(n == 0) /* cancel if 0 */
		return;

    /* column is only ever 1 when there is one window, otherwise its 2 */
    if(n == 1) {
        col = 1;
    } else {
        col = 2;
    }

    lrow = n/col;
    
    /* when n is odd, set rrows to one higher than lrows, accounts for 
     * unbalanced windows */
    if(n % 2 != 0) {
        rrow = lrow + 1;
    } else {
        rrow = lrow;
    }


	cw = m->ww / col; /* column width */


	cn = 0; /* current column number */
	rn = 0; /* current row number */
	for(/*i = 0,*/ c = nexttiled(m->clients); c; /*i++,*/ c = nexttiled(c->next)) {
        /* determine which column the window is in */
        if(cn) {
            row = rrow;
            cx = m->wx + cw; /* window col pos */
        } else {
            row = lrow;
            cx = m->wx; /* window col pos */
        }
		ch = m->wh/row;
		cy = m->wy + rn*ch;
                              /* for border on either side */
		resize(c, cx, cy, cw - 2 * c->bw, ch - 2 * c->bw, False);
		rn++;
        
        /* check if either column is full, and reset rn */
        if((cn == 0 && rn >= lrow) || 
           (cn == 1 && rn >= rrow)) {
            rn = 0;
            cn = 1;
        }
	}
}
