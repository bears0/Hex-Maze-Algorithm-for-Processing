// Created by Andrew Cline
// Feel free to use this code however you like.
// If you make money from it, at least buy me a coffee :)

int cellSize = 20;
int cols = 0;
int rows = 0;
float w = sqrt(3)*cellSize;
float h = 2*cellSize;
int sw = 3;
ArrayList<Cell> cellList = new ArrayList<Cell>(); // List of cells in the maze
Cell current;
ArrayList<Cell> stack = new ArrayList<Cell>(); // List of cells that have been visited. Used for backtracking
boolean start = false;
boolean svgGenerated = false;

void keyPressed()
{
  if (key == 's')
  {
    start = true;
    ;
  }
}

void setup() {
  size(601, 601);
  frameRate(120); // Set the framerate lower for animation.
  cols = floor(width/w)-1; // Determin the number of cell columns (Columns zigzag from top to bottom)
  rows = floor(height/h*4/3)-1; // Determine the number of cell rows (Rows go straight accross)
  background(51);

  // Create all the cells and add them to the cellList
  for (int j = 0; j < rows; j++) {
    for (int i = 0; i < cols; i++) {
      Cell cell = new Cell(i, j);
      if (i == 0 && j == 0)
        cell.setStart();
      if (i == cols-1 && j == rows-1)
        cell.setEnd();
      cellList.add(cell);
    }
  }

  // Set the first cell as the current cell (Top-Left)
  current = cellList.get(0);
  current.visited = true; // Set this cell as "visited"
}

// This function loops every frame. To speed up generation, the code in this section could be put in a while loop.
// I keep the marching algorithm in sync with the framerate so that the maze generation can be animated.
void draw() {

  if (start) {
    background(51);

    current.highlight(); // Draw the current cell with a highlighted color

    for (int i = 0; i < cellList.size(); i++) {
      cellList.get(i).show(); // Call the draw method for each cell
    }

    // Set the current cells visited value to true
    current.visited = true;

    // Retrieve a random neighboring cell
    Cell next = current.checkNeighbors();

    // If the cell exists
    if (next != null) {
      next.visited = true;           // Set it's visited bool true
      stack.add(current);            // Add the previous cell to the stack
      removeWalls(current, next);    // Remove the wall between the previous cell and the new cell
      current = next;                // This next cell then becomes the current cell
    } else if (stack.size() > 0) {   // If next was null, there are no neighboring cells. Remove a cell from the stack (Walk backwards)
      current = stack.remove(stack.size()-1);
    } else if (!svgGenerated){
      if(createSVG()){
        print("Generated SVG");
      }
      svgGenerated = true;
    }
  }
}

// This function takes the reference to neighboring cells,
// determines which sides touch, and removes the walls between them
void removeWalls(Cell a, Cell b) {
  int x = a.i - b.i;
  if (x == 1) {
    a.walls[3] = false;
    b.walls[0] = false;
  } else if (x == -1) {
    a.walls[0] = false;
    b.walls[3] = false;
  }
  int y = a.j - b.j;
  if (y == 1) {
    if (b.j % 2 == 0) {
      a.walls[4] = false;
      b.walls[1] = false;
    } else {
      a.walls[5] = false;
      b.walls[2] = false;
    }
  } else if (y == -1) {
    if (b.j % 2 == 0) {
      a.walls[2] = false;
      b.walls[5] = false;
    } else {
      a.walls[1] = false;
      b.walls[4] = false;
    }
  }
}

boolean createSVG() {
  try {
    String path = sketchPath("output.svg");
    SvgCreator svgCreator = new SvgCreator(path, width, height);
    svgCreator.initSvgFile();
    svgCreator.addMetadata("Test SVG", "This is a test SVG file");


    // For each cell in the maze, add walls to the svg
    // This is not the best way to do this, but I am testing functionality first
    ArrayList<Line> allLines = new ArrayList<Line>();
    for(int i = 0; i < cellList.size(); i++){
       ArrayList<Line> lines = cellList.get(i).getLines(); // Get a list of lines from each cell
       for(int j = 0; j < lines.size(); j++){
         allLines.add(lines.get(j)); // add these lines to a list containing all lines
       }
    }
    
    for(int i = 0; i < allLines.size(); i++){
      svgCreator.addLineList(allLines.get(i));
    }




    // Extra functions if needed
    // Add some shapes and lines
    //svgCreator.addLine(50, 50, 200, 200, "black", 2);
    //svgCreator.addRectangle(100, 100, 150, 100, "red", "black", 2);
    //svgCreator.addCircle(300, 300, 50, "blue", "black", 2);

    // Create a polygon (e.g., a triangle)
    //List<PVector> points = new ArrayList<>();
    //points.add(new PVector(100, 100));
    //points.add(new PVector(200, 100));
    //points.add(new PVector(150, 200));

    //svgCreator.addPolygon(points, "yellow", "black", 2);

    // Finish and save
    svgCreator.finishSvgFile();
    return true;
  }
  catch (IOException e) {
    e.printStackTrace();
    return false;
  }
}
