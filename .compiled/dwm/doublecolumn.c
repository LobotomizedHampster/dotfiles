void
doublecolumn(Monitor *m) {
    unsigned int n, row, lrow, rrow, cn, lw, rw, rn, cx, cy, cw, ch, i, cyn, tyl, tyr;
    const int col = 2;
    float rfacts = 0;
    float lfacts = 0;
    Client *c;

    // Get number of non-minimized and tiled windows
    for(n = 0, c = nexttiled(m->clients); c; c = nexttiled(c->next), n++);

    // Return if there is no windows to format
    if(n == 0) 
        return;

    // Remove the border on windows when there is only one 
    if(n == 1) {
        c = m->clients;
        c->bw = 0;
        resize(c, 0, 0, m->ww, m->wh, False);
        return;
    }
    
    // Get number of windows in left row
    lrow = n/col;

    // Get number of windows in right row (accounts for odd number of windows)
    if(n % 2 != 0) {
        rrow = lrow + 1;
    } else {
        rrow = lrow;
    }

    cn = 0; /* current column number */
    rn = 0; /* current row number */

    // Get each window's resize factor
    for(i = 0, c = nexttiled(m->clients); c; c = nexttiled(c->next), i++) {
        if(cn) {
            rfacts += c->cfact;
        } else {
            lfacts += c->cfact;
        }
        rn++;
        if((cn == 0 && rn >= lrow) || 

            rn = 0;
            cn = 1;
        }
    }


    cn = 0; /* current column number */
    rn = 0; /* current row number */
    tyl = 0; /* y pos for window placment */
    tyr = 0; 
    rw = m->ww * (1 - m->mfact);
    lw = m->ww * m->mfact;
    for(c = nexttiled(m->clients); c; c = nexttiled(c->next)) {
        c->bw = borderpx;
        /* determine which column the window is in */
        if(cn) { /* right column */
            row = rrow;
            cw = rw;
            cx = m->wx + lw; /* window col pos */
            ch = m->wh * (c->cfact / rfacts);
            cy = tyr;
        } else { /* left column */
            row = lrow;
            cw = lw;
            cx = m->wx; /* window col pos */
            ch = m->wh * (c->cfact / lfacts);
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
