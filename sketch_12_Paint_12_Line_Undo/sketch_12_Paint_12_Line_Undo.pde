/* ArrayList of Line and UndoLine
*/
ArrayList<Line> lines = new ArrayList<Line>();
ArrayList<UndoLine> undo_lines = new ArrayList<UndoLine>();

/* Starting Points and End Points for the `undo_lines`
*/
int undo_sp, undo_ep;

/* Future functionality: shape = 0 means free-form line
*/
int shape = 0;

void mousePressed() {
    
    /* Set starting point of Undo point functionality
    */
    if (lines.size()>0) {
        undo_sp = undo_ep + 1;
    }
    else {
        undo_sp = 0;
    }
}

void mouseReleased () {
    
    /* Set ending point of Undo point functionality
    */
    if (shape == 0) {
        undo_ep = lines.size()-1;
        undo_lines.add(new UndoLine (undo_sp, undo_ep));
    }
}

void keyPressed() {
    
    /* Undo functionality of free-form lines
    */
    if (key == BACKSPACE) {
        if (!lines.isEmpty()) {
            for (int i=undo_lines.get(undo_lines.size()-1).ep; i>=undo_lines.get(undo_lines.size()-1).sp; i--) { //delete starting from last of undo_lines
                lines.remove(i);
            }
            
            undo_lines.remove(undo_lines.size()-1);
        }
    }
}

void setup() {
    size(640, 480);
    background(255);
}

void draw() {
    
    background(255);
    
    /* Draw instant free-form lines, but erases them later with `background(255);`
    */
    if(mousePressed) {
        lines.add(new Line (pmouseX, pmouseY, mouseX, mouseY));
    }
    
    /* Draw all the lines within the loop
    */
    displayLines();
}

void displayLines(){
    for (int i=0; i<lines.size(); i++) {
        line(lines.get(i).x1, lines.get(i).y1, lines.get(i).x2, lines.get(i).y2);
    }
}
