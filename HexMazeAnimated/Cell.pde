// This class contains data for each individual cell, as well as methods for drawing each cell
// Wall order: Right side, bottom right, bottom left, left, top left, top right
// The right wall is first (index 0) and goes in a clockwise direction


class Cell {
  int i = 0;
  int j = 0;
  boolean[] walls = {true, true, true, true, true, true};
  boolean visited = false;
  PVector point = new PVector();
  PVector[] points = new PVector[6];
  boolean mazeStart = false;
  boolean mazeEnd = false;

  Cell(int i, int j) {
    this.i = i;
    this.j = j;
  }

  void highlight() {
    for (int i = 0; i < 6; i++) {
      points[i] = pointy_hex_corner(point, cellSize, i);
    }
    for (int i = 0; i < 6; i++) {
      noStroke();
      fill(255,0,0);
      beginShape(TRIANGLES);
      vertex(this.point.x, this.point.y);
      vertex(points[i].x, points[i].y);
      vertex(points[(i+1) % 6].x, points[(i+1) % 6].y);
      endShape();
    }
  }
  
  void fillColor(color c) {
    for (int i = 0; i < 6; i++) {
      points[i] = pointy_hex_corner(point, cellSize, i);
    }
    for (int i = 0; i < 6; i++) {
      noStroke();
      fill(c);
      beginShape(TRIANGLES);
      vertex(this.point.x, this.point.y);
      vertex(points[i].x, points[i].y);
      vertex(points[(i+1) % 6].x, points[(i+1) % 6].y);
      endShape();
    }
  }

  int index(int i_, int j_) {
    if (i_ < 0 || j_ < 0 || i_ > cols-1 || j_ > rows-1) {
      return -1;
    }
    return i_+(j_*cols);
  }

  Cell checkNeighbors() {
    ArrayList<Cell> neighbors = new ArrayList<Cell>();

    int ind = index(i, j-1);
    if (ind != -1 && !cellList.get(ind).visited) { // Top
      neighbors.add(cellList.get(ind));
    }
    ind = index(i+1, j);
    if (ind != -1 && !cellList.get(ind).visited) { // Right
      neighbors.add(cellList.get(ind));
    }
    ind = index(i, j+1);
    if (ind != -1 && !cellList.get(ind).visited) { // Bottom
      neighbors.add(cellList.get(ind));
    }
    ind = index(i-1, j);
    if (ind != -1 && !cellList.get(ind).visited) { // Left
      neighbors.add(cellList.get(ind));
    }

    if (neighbors.size() > 0) {
      int r = floor(random(0, neighbors.size()));
      return neighbors.get(r);
    } else {
      return null;
    }
  }

  void show() {
    int x = round(this.i*w);
    int y = round(this.j*h*3/4);
    if (this.j % 2 != 0) {
      x += round(w/2);
    }
    x += w/2 + ((width - (cols*w) - (w/2))/2);
    y += cellSize+5;
    stroke(255);

    if (this.visited) {
      for (int i = 0; i < 6; i++) {
        points[i] = pointy_hex_corner(point, cellSize, i);
      }
      for (int i = 0; i < 6; i++) {
        noStroke();
        fill(0,0,255,100);
        beginShape(TRIANGLES);
        vertex(this.point.x, this.point.y);
        vertex(points[i].x, points[i].y);
        vertex(points[(i+1) % 6].x, points[(i+1) % 6].y);
        endShape();
      }
    }
    stroke(255);
    strokeWeight(sw);
    point.x = x;
    point.y = y;


    for (int i = 0; i < 6; i++) {
      points[i] = pointy_hex_corner(point, cellSize, i);
    }

    /*
    for(int i = 0; i < 6; i++){
     if(this.walls[i]){
     
     }
     }
     */
    if (this.walls[0]) { // Right wall
      //stroke(255);
      line(points[0].x, points[0].y, points[1].x, points[1].y); // Right wall
    }
    
    if (this.walls[1]) { // Bottom right wall
      //stroke(255,0,0);
      line(points[1].x, points[1].y, points[2].x, points[2].y); // Bottom right wall
    }
    
    if (this.walls[2]) { // Bottom left wall
      //stroke(0,255,0);
      line(points[2].x, points[2].y, points[3].x, points[3].y); // Bottom left wall
    }
    
    if (this.walls[3]) { // Left wall
      //stroke(0,0,255);
      line(points[3].x, points[3].y, points[4].x, points[4].y); // Left wall
    }
    
    if (this.walls[4]) { // Top left wall
      //stroke(0,0,255);
      line(points[4].x, points[4].y, points[5].x, points[5].y); // Top left wall
    }
    
    if (this.walls[5]) { // Top right wall
      //stroke(0,0,255);
      line(points[5].x, points[5].y, points[0].x, points[0].y); // Top right wall
    }
    
    if(this.mazeStart)
      fillColor(color(0,255,0));
      
    if(this.mazeEnd)
      fillColor(color(255,0,0));
  }

  PVector pointy_hex_corner(PVector center, int size, int i) {
    var angle_deg = 60 * i - 30;
    var angle_rad = PI / 180 * angle_deg;
    return new PVector(center.x + size * cos(angle_rad),
      center.y + size * sin(angle_rad));
  }
  
  void setStart(){
    this.mazeStart = true;
  }
  void setEnd(){
    this.mazeEnd = true;
  }
  
  ArrayList<Line> getLines(){
    ArrayList<Line> lines = new ArrayList<Line>();
    for(int i = 0; i < 6; i++){ // For each wall, create a line based on the position of the walls.
      if(walls[i]){
        float x1 = points[i].x;
        float y1 = points[i].y;
        float x2 = points[(i+1)%6].x;
        float y2 = points[(i+1)%6].y;
        Line l = new Line(x1,y1,x2,y2,3,"black");
        lines.add(l);
      }
    }
    return lines;
  }
}
