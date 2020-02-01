ArrayList<PVector> initial_points = new ArrayList<PVector>();
ArrayList<PVector> free_points = new ArrayList<PVector>();

ArrayList<Line> lines = new ArrayList<Line>();

int shape = 1;

void setup() {

    size(500 , 500);
}

void mousePressed() {
    if(shape != 0) {
        initial_points.add(new PVector(mouseX, mouseY));
    }
    
}

void mouseReleased() {
    if(shape != 0) {
        initial_points.add(new PVector(mouseX, mouseY));
        lines.add(new Line(initial_points.get(initial_points.size()-2).x, initial_points.get(initial_points.size()-2).y, initial_points.get(initial_points.size()-1).x, initial_points.get(initial_points.size()-1).y));
    }
}

void mouseDragged() {
    if (shape == 0) {
        //free_points.add(new PVector(mouseX, mouseY));
        lines.add(new Line(pmouseX, pmouseY, mouseX, mouseY));
    }
    
}

void keyPressed() {
    if(key == 'q') {
        shape = 0;
    }
    else if(key == 'w') {
        shape = 1;
    }
}

void draw() {

    background(0);
    stroke(255);
    if (shape == 1) {
        for (int i = 0; i < initial_points.size(); i += 2) {
            PVector p1 = initial_points.get(i);
            boolean even = i+1 < initial_points.size();
            PVector p2 = even ? initial_points.get(i+1) : new PVector(mouseX, mouseY);
            
            line(p1.x, p1.y, p2.x, p2.y);
        }
    }
    
    else if(shape == 0) {
        for(int i=0; i<free_points.size(); i++) {
            PVector pxy = free_points.get(i);
            point (pxy.x, pxy.y);
        }
    }
    
    displayLines();
}

void displayLines(){
    for (int i=0; i<lines.size(); i++) {
        line(lines.get(i).x1, lines.get(i).y1, lines.get(i).x2, lines.get(i).y2);
    }
}
