void
gaplessgrid(Monitor *m) {
	unsigned int n, col, lrow, rrow, cn, rn, /*i,*/ row, cx, cy, cw, ch, i, cyn, tyl, tyr;
    float rfacts = 0;
    float lfacts = 0;
	Client *c;

    /* number of non-minimized and tiled windows */
	for(n = 0, c = nexttiled(m->clients); c; c = nexttiled(c->next), n++); /*{
        afacts += c->cfiact;
    };*/
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

	cn = 0; /* current column number */
	rn = 0; /* current row number */

	for(i = 0, c = nexttiled(m->clients); c; c = nexttiled(c->next), i++) {
        if(cn) {
            rfacts += c->cfact;
        } else {
            lfacts += c->cfact;
        }
        rn++;
        if((cn == 0 && rn >= lrow) || 
           (cn == 1 && rn >= rrow)) {
            rn = 0;
            cn = 1;
        }
    }

	cw = m->ww / col; /* column width */


	cn = 0; /* current column number */
	rn = 0; /* current row number */
    tyl = 0; /* y pos for window placment */
    tyr = 0; 
	for(c = nexttiled(m->clients); c; c = nexttiled(c->next)) {
        /* determine which column the window is in */
        if(cn) {
            row = rrow;
            cx = m->wx + cw; /* window col pos */
            ch = m->wh * (c->cfact / rfacts);
            /*rfacts -= c->cfact;*/
            cy = tyr;
        } else {
            row = lrow;
            cx = m->wx; /* window col pos */
            ch = m->wh * (c->cfact / lfacts);
            /*lfacts -= c->cfact;*/
            cy = tyl;
        }

		/*cy = m->wy + rn*ch;*/
                              /* for border on either side */
		resize(c, cx, cy, cw - 2 * c->bw, ch - 2 * c->bw, False);

        if(cn) {
            tyr += ch;
        } else {
            tyl += ch;
        }


		rn++;
        
        /* check if either column is full, and reset rn */
        if((cn == 0 && rn >= lrow) || 
           (cn == 1 && rn >= rrow)) {
            rn = 0;
            cn = 1;
        }
	}
}
