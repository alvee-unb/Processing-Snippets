ArrayList<PVector> initial_points = new ArrayList<PVector>();
ArrayList<PVector> free_points = new ArrayList<PVector>();

ArrayList<Line> lines = new ArrayList<Line>();

float x1, y1, x2, y2;

int shape = 0;

void setup() {

    size(500 , 500);
}

void mousePressed() {
    if(shape != 1) {
        initial_points.add(new PVector(mouseX, mouseY));
    }
    
}

void mouseReleased() {
    if(shape != 1) {
        initial_points.add(new PVector(mouseX, mouseY));
    }
}

void mouseDragged() {
    if (shape == 1) {
        free_points.add(new PVector(mouseX, mouseY));
    }
    
}

void keyPressed() {
    if(key == 'q') {
        shape = 1;
    }
    else if(key == 'w') {
        shape = 0;
    }
}

void draw() {

    background(0);
    stroke(255);
    if (shape == 0) {
        for (int i = 0; i < initial_points.size(); i += 2) {
            PVector p1 = initial_points.get(i);
            boolean even = i+1 < initial_points.size();
            PVector p2 = even ? initial_points.get(i+1) : new PVector(mouseX, mouseY);
            
            line(p1.x, p1.y, p2.x, p2.y);
            
            if(even) {
                x1 = p1.x;
                y1 = p1.y;
                x2 = p2.x;
                y2 = p2.y;
                lines.add(new Line (x1, y1, x2, y2));
            }
        }
    }
    
    else if(shape == 1) {
        for(int i=0; i<free_points.size(); i++) {
            PVector pxy = free_points.get(i);
            point (pxy.x, pxy.y);
        }
    }
    
    displayLines();

}

void displayLines(){
    for (int i=1; i<lines.size(); i++) {
        line(lines.get(i).x1, lines.get(i).y1, lines.get(i).x2, lines.get(i).y2);
    }
}
