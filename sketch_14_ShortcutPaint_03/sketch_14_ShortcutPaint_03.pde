/* ArrayList of Line and UndoLine for free-form lines and Shape Tracker
*/
ArrayList<Line> lines = new ArrayList<Line>();
ArrayList<UndoLine> undo_lines = new ArrayList<UndoLine>();
ArrayList<ShapeTracker> shape_tracker = new ArrayList<ShapeTracker>();

/* ArrayList of Straight Line points
*/
ArrayList<PVector> straight_line_points = new ArrayList<PVector>();

/* Starting Points and End Points for the `undo_lines`
*/
int undo_sp, undo_ep;

/* Functionality: Line weight, color & shape = means free-form line(0), Straight line(1), Rectangle(2), Ellipse(3) 
*/
int line_weight = 4, line_color = 0, shape = 0;

/*cursor images
*/
Cursor cursor_obj;

/*initialize selection showing
*/
CurrentSelection select_obj;

void mousePressed() {
    
    /* Set starting point of Undo point functionality
    */
    if (lines.size()>0) {
        undo_sp = lines.size(); //undo_sp = undo_ep + 1;
    }
    else if (lines.size() == 0) {
        undo_sp = 0;
    }
    
    /* Track points for the straight line
    */
    if (shape != 0) {
        straight_line_points.add(new PVector(mouseX, mouseY));
    }
}

void mouseReleased () {
    
    /* For straight lines, adds the straight lines using the respective start and end points
    */
    if (shape != 0) {
        straight_line_points.add(new PVector(mouseX, mouseY));
        lines.add(new Line(straight_line_points.get(straight_line_points.size()-2).x, straight_line_points.get(straight_line_points.size()-2).y, straight_line_points.get(straight_line_points.size()-1).x, straight_line_points.get(straight_line_points.size()-1).y));
        
        /* Keeps track of the shapes used (i.e. straight lines, rect, ellipse etc.)
        */
        shape_tracker.add(new ShapeTracker(lines.size()-1, shape, line_weight, line_color));    /* ***************** SHAPE TRACKER for other than free lines ******************** */
        
        /* Remove the straight_line_points
        */
        for (int i=straight_line_points.size()-1; i>=0; i--) {
            straight_line_points.remove(i);
        }      
    }
    
    /* Set ending point of Undo point functionality and adds undo_lines
    */
    undo_ep = lines.size()-1;
    undo_lines.add(new UndoLine (undo_sp, undo_ep));
}

void keyPressed() {
    
    select_obj.shortcut(key);
}

void setup() {
    size(640, 480);
    background(255);
    
    /* Initialize cursor and selection
    */
    cursor_obj = new Cursor();
    select_obj = new CurrentSelection();
}

void draw() {
    
    background(255);
    
    /*show selection of features
    */
    select_obj.showSelection(line_weight, line_color, shape);
  
    /*show cursor
    */
    cursor_obj.cursorCheck(mousePressed);
      
    /* Draw instant free-form lines and adds traker
    */
    if(mousePressed && shape == 0) {
        lines.add(new Line (pmouseX, pmouseY, mouseX, mouseY));
        shape_tracker.add(new ShapeTracker(lines.size()-1, shape, line_weight, line_color));    /* ***************** SHAPE TRACKER for free lines ******************** */
        
    }
    
    /* Draw instant straight lines
    */
    else if (mousePressed && shape == 1) {
        for (int i = 0; i < straight_line_points.size(); i += 2) {
            PVector p1 = straight_line_points.get(i);
            boolean even = i+1 < straight_line_points.size();
            PVector p2 = even ? straight_line_points.get(i+1) : new PVector(mouseX, mouseY);
            line(p1.x, p1.y, p2.x, p2.y);
        }
    }
    
    /* Draw instant rectangles
    */
    else if (mousePressed && shape == 2) {
        for (int i = 0; i < straight_line_points.size(); i += 2) {
            PVector p1 = straight_line_points.get(i);
            boolean even = i+1 < straight_line_points.size();
            PVector p2 = even ? straight_line_points.get(i+1) : new PVector(mouseX, mouseY);
            rect(p1.x, p1.y, p2.x-p1.x, p2.y-p1.y);
        }
    }
    
    /* Draw instant ellipse
    */
    else if (mousePressed && shape == 3) {
        for (int i = 0; i < straight_line_points.size(); i += 2) {
            PVector p1 = straight_line_points.get(i);
            boolean even = i+1 < straight_line_points.size();
            PVector p2 = even ? straight_line_points.get(i+1) : new PVector(mouseX, mouseY);
            ellipseMode(CORNER);
            ellipse(p1.x, p1.y, p2.x-p1.x, p2.y-p1.y);
        }
    }
    
    
    
    /* Draw all the lines within the loop
    */
    displayLines();
}

void displayLines(){
    for (int i=0; i<lines.size(); i++) {
        
        if (shape_tracker.get(i).shape == 1 || shape_tracker.get(i).shape == 0) {
            
            //thickness and color
            strokeWeight(shape_tracker.get(i).line_weight);
            stroke(shape_tracker.get(i).line_color);
            
            //draw lines for shapes 0 and 1
            line(lines.get(i).x1, lines.get(i).y1, lines.get(i).x2, lines.get(i).y2);
        }
        
        else if (shape_tracker.get(i).shape == 2) {
            
            //thickness and color
            strokeWeight(shape_tracker.get(i).line_weight);
            stroke(shape_tracker.get(i).line_color);
            
            //draw rectangles for shape = 2
            rect(lines.get(i).x1, lines.get(i).y1, lines.get(i).x2-lines.get(i).x1, lines.get(i).y2-lines.get(i).y1);
        }
        
        else if (shape_tracker.get(i).shape == 3) {
            //thickness and color
            strokeWeight(shape_tracker.get(i).line_weight);
            stroke(shape_tracker.get(i).line_color);
            
            //draw ellipses for shape = 3
            ellipseMode(CORNER);
            ellipse(lines.get(i).x1, lines.get(i).y1, lines.get(i).x2-lines.get(i).x1, lines.get(i).y2-lines.get(i).y1);
        }
        
    }
}
