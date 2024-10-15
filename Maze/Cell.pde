class Cell {
  int i = 0;
  int j = 0;
  PVector tl = new PVector();
  PVector tr = new PVector();
  PVector br = new PVector();
  PVector bl = new PVector();
  boolean[] walls = {true, true, true, true};
  boolean visited = false;

  Cell(int i, int j) {
    this.i = i;
    this.j = j;
    this.tl.x = i*w;
    this.tl.y = j*w;
    this.tr.x = i*w+w;
    this.tr.y = j*w;
    this.br.x = i*w+w;
    this.br.y = j*w+w;
    this.bl.x = i*w;
    this.bl.y = j*w+w;
  }
  
  void highlight(){
    int x = this.i * w;
    int y = this.j * w;
    noStroke();
    fill(0, 0, 255);
    //rect(x, y, w, w);
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
    int x = this.i*w;
    int y = this.j*w;
    stroke(255);
    int spacing = 0;
    
    if (this.visited) {
      noStroke();
      fill(255, 0, 255, 100);
      //rect(x, y, w, w);
    }
    stroke(255);
    strokeWeight(sw);
    if (this.walls[0]) {
      //stroke(255);
      line(x+spacing, y+spacing, x+w-spacing, y+spacing); // Top
    }
    if (this.walls[1]) {
      //stroke(255,0,0);
      line(x+w-spacing, y+spacing, x+w-spacing, y+w-spacing); // Right
    }
    if (this.walls[2]) {
      //stroke(0,255,0);
      line(x+spacing, y+w-spacing, x+w-spacing, y+w-spacing); // Bottom
    }
    if (this.walls[3]) {
      //stroke(0,0,255);
      line(x+spacing, y+spacing, x+spacing, y+w-spacing); // Left
    }
    
  }
}
