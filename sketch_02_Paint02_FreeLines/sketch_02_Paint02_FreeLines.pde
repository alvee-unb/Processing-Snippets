ArrayList<Line> lines = new ArrayList<Line>();

void setup() {
    size(640, 480);
    background(255);
}

void draw() {
    
    background(255);
    
    if(mousePressed) {
        lines.add(new Line (pmouseX, pmouseY, mouseX, mouseY));
    }
    
    displayLines();
}

void displayLines(){
    for (int i=0; i<lines.size(); i++) {
        line(lines.get(i).x1, lines.get(i).y1, lines.get(i).x2, lines.get(i).y2);
    }
}
