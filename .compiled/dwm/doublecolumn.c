void
doublecolumn(Monitor *m) {
    unsigned int n, lrow, lw, rw, cx, cy, cw, ch, tyl, tyr;
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

    // Get each window's resize factor
    int i = 0;
    for(c = nexttiled(m->clients); c; i++, c = nexttiled(c->next)) {
        if(!(i >= lrow)) {
            lfacts += c->cfact;
        } else {
            rfacts += c->cfact;
        }
    }

    tyl = 0;
    tyr = 0; 
    rw = m->ww * (1 - m->mfact);
    lw = m->ww * m->mfact;
    i = 0;
    for(c = nexttiled(m->clients); c; i++, c = nexttiled(c->next)) {
        c->bw = borderpx; // Reset the border
    
        if(!(i >= lrow)) { // Left column
            cx = m->wx;
            cy = tyl;
            cw = lw;
            ch = m->wh * (c->cfact / lfacts);
            tyl += ch;
        } else { // Right column
            cx = m->wx + lw; 
            cy = tyr;
            cw = rw;
            ch = m->wh * (c->cfact / rfacts);
            tyr += ch;
        }

        // Place window on the screen
        resize(c, cx, cy, cw - 2 * c->bw, ch - 2 * c->bw, False);
    }
}
