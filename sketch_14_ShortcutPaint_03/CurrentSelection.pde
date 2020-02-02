public class CurrentSelection {
  
  public void showSelection(int line_weight, int line_color, int shape) {

    strokeWeight(1);
    stroke(200);
    rect(525, 0, 110, 50);

    currentSelection(line_weight, line_color, shape);
  }

  /* show selected features
  */
  private void currentSelection(int line_weight, int line_color, int shape) {
    strokeWeight(line_weight);
    stroke(line_color); //rectMode(RADIUS);
    
    //fill(230);
    if (shape == 0) {
        float x = 0;
        for (x=540; x<width-20; x++) {
            float y = (30) + 10.0 * (float) Math.sin(Math.toRadians((double)x) *5 ); // Math.sin(Math.toRadians(x) * 40.0
            point( x, y);
        }
    }
    else if (shape == 1) {
        line(540, 30, width-20, 30);
    }
    else if (shape == 2) {
        rect(540, 10, 80, 30);
    }
    else if (shape == 3) {
        ellipseMode(CENTER);
        ellipse(580, 25, 80, 30);
    }
  }
  
  /*check for shortcut keys
  */
  public void shortcut(char ip){
    
    if(ip == 'a') {
    line_weight = 1;
    }
    else if(ip == 's') {
      line_weight = 4;
    }
    else if(ip == 'd') {
      line_weight = 10;
    }
    
    else if(ip == 'z') { //black=0, red=FF0000, green=00FF00, blue=0000FF
      line_color = 0;
    }
    else if(ip == 'x') {
      line_color = #FF0000; //red=#FF0000
    }
    else if(ip == 'c') {
      line_color = #00FF00; //green=#00FF00
    }
    else if(ip == 'v') {
      line_color = #0000FF; //blue=0000FF
    }
    
    /* Shortcut: Undo functionality of free-form lines
    */
    if (ip == BACKSPACE) {
        
        if (!lines.isEmpty() && !undo_lines.isEmpty()) {
            for (int i=undo_lines.get(undo_lines.size()-1).ep; i>=undo_lines.get(undo_lines.size()-1).sp; i--) { //delete starting from last of undo_lines
                lines.remove(i);
                shape_tracker.remove(i);
            }
            
            undo_lines.remove(undo_lines.size()-1);
            //shape_tracker.remove(shape_tracker.size()-1);
        }
    }
    
    /* Shortcut: q = free form lines, w = straight lines, e = ellipse, r = rectangle
    */
    if (ip == 'q') {
        shape = 0;
    }
    if (ip == 'w') {
        shape = 1;
    }
    if (ip == 'r') {
        shape = 2;
    }
    if (ip == 'e') {
        shape = 3;
    }
  }
}
