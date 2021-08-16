color [][] tab, oldtab;

int lato = 4;
int cols, rows;

final color alive = color(255);
final color half = #36EA2B;
final color dead = color(0);
float prob = 0.7;

void setup() {
  //size(600, 600);
  fullScreen();
  noStroke();
  frameRate(60);
  cols = width / lato;
  rows = height / lato;
  restart();
}


void draw() {
  background(dead);
  for (int x = 0; x < cols; x++) {
    for (int y = 0; y < rows; y++) {
      fill(tab[x][y]);
      rect(x * lato, y * lato, lato, lato);
      oldtab[x][y] = tab[x][y];
    }
  }
  update();
}

void update() {
  for (int x = 0; x < cols; x++) {
    for (int y = 0; y < rows; y++) {
      int counter = 0;
      for (int lr = x - 1; lr <= x + 1; lr++) {
        for (int ud = y - 1; ud <= y + 1; ud++) {
          if (lr != x || ud != y) {
            int outx = lr;
            int outy = ud;

            if (outx < 0) {
              outx = cols - 1;
            } else if (outx >= cols) {
              outx = 0;
            }

            if (outy < 0) {
              outy = rows - 1;
            } else if (outy >= rows) {
              outy = 0;
            }

            if (oldtab[x][y] != half) {
              if (oldtab[outx][outy] == alive) {
                counter++;
                //} else if (oldtab[outx][outy] == half) {
                //  if (random(1) < prob) {
                //    counter++;
                //  }
              }
            } else {
              if (oldtab[outx][outy] == half) {
                counter++;
              }
            }
          }
        }
      }
      act(x, y, counter);
    }
  }
}

void act(int x, int y, int c) {

  if (oldtab[x][y] == alive) {
    tab[x][y] = c > 3 || c < 2 ? half : alive;
  } else if (oldtab[x][y] == dead) {
    tab[x][y] = c == 3 ? alive : dead;
  } else {
    tab[x][y] = c == 4 || c == 3 ? alive: dead;
  }
}
//tab[x][y] = c < 5 ? half : alive;

void keyPressed() {
  restart();
}

void restart() {
  tab = new color [cols][rows];
  oldtab = new color [cols][rows];

  for (int x = 0; x < cols; x++) {
    for (int y = 0; y < rows; y++) {
      tab[x][y] = random(1) >= 0.8 ? alive : dead;
    }
  }
}
