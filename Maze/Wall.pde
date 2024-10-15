class Wall {
  float x1, y1, x2, y2 = 0;
  Wall(PVector p1, PVector p2) {
    this.x1 = p1.x;
    this.y1 = p1.y;
    this.x2 = p2.x;
    this.y2 = p2.y;
  }

  void create(float wi) {
    if (x1 == x2) { // vertical line
      fill(wallColor);
      stroke(wallStroke);
      push();
      translate(x1, y1, hi/2);
      box(wi, wi, hi);
      push();
      translate(0, w, 0);
      box(wi, wi, hi);
      pop();
      translate(0, w/2, 0);
      box(wi, abs(y2-y1), hi);
      pop();
    } else if (y1 == y2){
      fill(wallColor);
      stroke(wallStroke);
      push();
      translate(x1, y1, hi/2);
      box(wi, wi, hi);
      push();
      translate(w, 0, 0);
      box(wi, wi, hi);
      pop();
      translate(w/2, 0, 0);
      box(abs(x2-x1), wi, hi);
      pop();
    }
  }
}
