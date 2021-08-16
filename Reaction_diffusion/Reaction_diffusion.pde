PVector [][] tab, oldtab;
int side = 2;
int rows, cols, cx, cy, dis;
boolean rand = true;
int n = 10;

void setup() {
  size(700, 700);
  colorMode(HSB, 100);
  noStroke();
  cols = int(width / side);
  rows = int(height / side);

  tab = new PVector [rows][cols];
  oldtab = new PVector [rows][cols];

  cx = int(width / 2);
  cy = int(height / 2);
  dis = side + 7;

  reseed();
}

float da = 1.0;
float db = 0.5;

float [] f = {0.055, 0.022, 0.03, 0.037};
float [] k = {0.062, 0.059, 0.063, 0.06};

int index = 2;
// 0: classico 1: bio 2: bio2 3: fingerprints

float t = 1;

float diagonal = 0.05;
float lateral = 0.2;
void keyPressed() {
  if (key == ' ') {
    saveFrame();
    print("saved");
  }
}


void draw() {
  update();
  for (int y=0; y<rows; y++) {
    for (int x=0; x<cols; x++) {

      fill(300 - 300 * tab[y][x].x, 200, 100 - 150 * tab[y][x].y);
      square(x * side, y * side, side);
      oldtab[y][x].x = tab[y][x].x;
      oldtab[y][x].y = tab[y][x].y;
    }
  }
}

void update() {
  for (int y=0; y<rows; y++) {
    for (int x=0; x<cols; x++) {
      float a = oldtab[y][x].x;
      float b = oldtab[y][x].y;
      float lx = -a;
      float ly = -b;
      for (int y1 = y-1; y1<=y+1; y1++) {
        for (int x1 = x-1; x1<=x+1; x1++) {
          if (x1 != x || y1 != y) {

            int y2 = (y1 + rows) % rows;
            int x2 = (x1 + cols) % cols;

            if (y2 == y || x2 == x) {
              lx += lateral * oldtab[y2][x2].x;
              ly += lateral * oldtab[y2][x2].y;
            } else {
              lx += diagonal * oldtab[y2][x2].x;
              ly += diagonal * oldtab[y2][x2].y;
            }
          }
        }
      }
      float new_x = a + (da*lx - a*b*b + f[index]*(1-a)) * t;  
      float new_y = b + (db*ly + a*b*b -b*(k[index] + f[index])) * t;

      new_x = constrain(new_x, 0, 1);
      new_y = constrain(new_y, 0, 1);

      tab[y][x].x = new_x;
      tab[y][x].y = new_y;
    }
  }
}

void reseed() {
  for (int y=0; y<rows; y++) {
    for (int x=0; x<cols; x++) {
      PVector p = dist(x * side, y * side, cx, cy) < dis && !rand ? new PVector(1, 1) : new PVector(1, 0);
      tab[y][x] = p.copy();
      oldtab[y][x] = p.copy();

      fill(300 - 300 * tab[y][x].x, 100, 100);
      square(x * side, y * side, side);
    }
  }
  
  int space = dis;

  if (rand) {
    for (int r=0; r<n; r++) {
      int xpos = int(random(space, cols - space));
      int ypos = int(random(space, rows - space));
      for (int y = ypos; y < ypos + space; y++) {
        for (int x = xpos; x < xpos + space; x++) {
          tab[y][x].x = 1;
          tab[y][x].y = 1;
          oldtab[y][x].x = tab[y][x].x;
          oldtab[y][x].y = tab[y][x].y;
          fill(300 - 300 * tab[y][x].x, 100, 100);
          square(x * side, y * side, side);
        }
      }
    }
  }
}
