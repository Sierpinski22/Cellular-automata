int [][] tab;
int [][] newtab;
int side = 2;

color [] palette = new color[]{#FFFFFF, #0000FF, #FF0000};
float full_prob = 0.3;

int move = 1;

int rows, cols;

void setup() {
  // frameRate(60);
  // size(800, 800); 
  fullScreen();
  rows = height / side;
  cols = width / side;
  tab = new int [rows][cols];
  newtab = new int [rows][cols];
  //background(palette[0]);
  noStroke();

  for (int y=0; y<rows; y+=1) {
    for (int x=0; x<cols; x+=1) {
      int r = random(1) < full_prob ? int(random(2)) +1 : 0;
      tab[y][x] = r;
      newtab[y][x] = r;
    }
  }
}

void keyPressed(){
  saveFrame();
  println("saved");
}

void draw() {
  background(palette[0]);
  for (int y=0; y<rows; y+=1) {
    for (int x=0; x<cols; x+=1) {
      tab[y][x] = newtab[y][x];
      if (newtab[y][x] != 0) {
        fill(palette[tab[y][x]]);
        square(x * side, y * side, side);
      }
    }
  }
  update();
  move = move == 1? 2 : 1;
}

void update() {
  for (int y=0; y<rows; y+=1) {
    for (int x=0; x<cols; x+=1) {
      switch(tab[y][x]) {
      case 0:
        break;

      case 1:
        int y1 = (y + 1 + rows) % rows;
        if (newtab[y1][x] == 0 && move == 1) {
          newtab[y1][x] = 1;
          newtab[y][x] = 0;
        }
        break;

      case 2:
        int x1 = (x + 1 + cols) % cols;
        if (newtab[y][x1] == 0 && move == 2) {
          newtab[y][x1] = 2;
          newtab[y][x] = 0;
        }
        break;
      }
    }
  }
}
