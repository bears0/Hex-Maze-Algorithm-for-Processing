// Created by Andrew Cline (Based on a tutorial by The Coding Train)
// Feel free to use this code however you like.
// If you make money from it, at least buy me a coffee :)

import nervoussystem.obj.*;

import peasy.*;

boolean record = false;

PeasyCam cam;
color wallColor = color(235, 164, 0);
color wallStroke = color(0);
int cols = 0;
int rows = 0;
int w = 50; // Cell size
int thickness = ceil(float(w)/float(10)); // Wall thickness
int hi = w; // Wall Height;
int sw = 1;
ArrayList<Cell> cellList = new ArrayList<Cell>();
ArrayList<Wall> wallList = new ArrayList<Wall>();
Cell current;
ArrayList<Cell> stack = new ArrayList<Cell>();

void setup() {
  size(1000, 750, P3D);
  lights();
  cam = new PeasyCam(this, 800);
  cam.setMinimumDistance(200);
  cam.setMaximumDistance(1000);
  frameRate(1000);
  cols = floor(width/w);
  rows = floor(height/w);
  background(51);
  for (int j = 0; j < rows; j++) {
    for (int i = 0; i < cols; i++) {
      Cell cell = new Cell(i, j);
      cellList.add(cell);
    }
  }

  current = cellList.get(0);
  current.visited = true;
}

void draw() {
  if (record) {
    beginRecord("nervoussystem.obj.OBJExport", "maze1.obj");
  }
  background(51);
  push();
  translate(0, 0, -1);
  fill(wallColor);
  stroke(wallStroke);
  box(width+thickness, height+thickness, 2);
  pop();
  translate(-width/2, -height/2);

  //translate(-mazew/2, -mazeh/2, 0);
  //current.highlight();
  for (int i = 0; i < cellList.size(); i++) {
    cellList.get(i).show();
  }
  current.visited = true;
  Cell next = current.checkNeighbors();
  if (next != null) {
    next.visited = true;
    stack.add(current);
    removeWalls(current, next);
    current = next;
  } else if (stack.size() > 0) {
    current = stack.remove(stack.size()-1);
  } else {
    for (int i = 0; i < cellList.size(); i++) {
      PVector tl = cellList.get(i).tl;
      PVector tr = cellList.get(i).tr;
      PVector br = cellList.get(i).br;
      PVector bl = cellList.get(i).bl;
      if (cellList.get(i).walls[0]) {
        wallList.add(new Wall(tl, tr));
        wallList.get(wallList.size()-1).create(thickness);
      }
      if (cellList.get(i).walls[1]) {
        wallList.add(new Wall(tr, br));
        wallList.get(wallList.size()-1).create(thickness);
      }
      if (cellList.get(i).walls[2]) {
        wallList.add(new Wall(bl, br));
        wallList.get(wallList.size()-1).create(thickness);
      }
      if (cellList.get(i).walls[3]) {
        wallList.add(new Wall(tl, bl));
        wallList.get(wallList.size()-1).create(thickness);
      }
    }
  }
  if (record) {
    endRecord();
    record = false;
  }
}

void removeWalls(Cell a, Cell b) {
  int x = a.i - b.i;
  if (x == 1) {
    a.walls[3] = false;
    b.walls[1] = false;
  } else if (x == -1) {
    a.walls[1] = false;
    b.walls[3] = false;
  }
  int y = a.j - b.j;
  if (y == 1) {
    a.walls[0] = false;
    b.walls[2] = false;
  } else if (y == -1) {
    a.walls[2] = false;
    b.walls[0] = false;
  }
}

void keyPressed() {
  if (key == 's' || key == 'S') {
    record = true;
  }
}
