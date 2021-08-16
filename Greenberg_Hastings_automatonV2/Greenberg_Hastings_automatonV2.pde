int [][] tab;
int [][] oldtab;

int lato = 3;
int maxlevel = 3;
int col = 255 / maxlevel;
int threshold = 0;
int cols, rows;

void setup() {
  fullScreen();
  // size(600, 600);
  noStroke();
  cols = width / lato;
  rows = height / lato;
  //frameRate(10);
  tab = new int[width / lato][height / lato];
  oldtab = new int[width / lato][height / lato];

  for (int x = 0; x < width / lato; x++) {
    for (int y = 0; y < height / lato; y++) {

      int r = int(random(maxlevel));
      tab[x][y] = r;
      oldtab[x][y] = tab[x][y];
    }
  }
}

void draw() {

  background(0);

  for (int x = 0; x < width / lato; x++) {
    for (int y = 0; y < height / lato; y++) {

      fill(0, 0, col * (1 + tab[x][y]));
      rect(x * lato, y * lato, lato, lato);  
      oldtab[x][y] = tab[x][y];
    }
  }

  update();
}

void update() {

  for (int x = 0; x < width / lato; x++) {
    for (int y = 0; y < height / lato; y++) {

      if (oldtab[x][y] != maxlevel - 1) {
        tab[x][y] = oldtab[x][y] + 1;
      } else {
        int counter = 0;

        counter += oldtab[(x + cols + 1) % cols][y] == 0? 1 : 0;
        counter += oldtab[(x + cols - 1) % cols][y] == 0? 1 : 0;
        counter += oldtab[x][(y + rows + 1) % rows] == 0? 1 : 0;
        counter += oldtab[x][(y + rows - 1) % rows] == 0? 1 : 0;

        tab[x][y] = counter > threshold ? 0 : oldtab[x][y];
      }
    }
  }
}
