ArrayList<Line> lines = new ArrayList<Line>();
int undo = 0, undo_count = 0;

void setup() {
    size(640, 480);
    background(255);
}

void draw() {
    
    background(255);
    
    if(mousePressed) {
        lines.add(new Line (pmouseX, pmouseY, mouseX, mouseY));
        //line(pmouseX, pmouseY, mouseX, mouseY);
        undo++;
    }
    
    displayLines();
}

void displayLines(){
    for (int i=0; i<lines.size(); i++) {
        line(lines.get(i).x1, lines.get(i).y1, lines.get(i).x2, lines.get(i).y2);
    }
}

void keyPressed() {
    if (key == 'p') {
        if (!lines.isEmpty()) {
            lines.remove(lines.size()-1);
            System.out.println("Pressed P! Lines: " + (lines.size()));
        }
    }
    /*else if (key == 'l') {
        linesIf = true;
    }*/
}

void mouseReleased () {
    undo_count++;
}
