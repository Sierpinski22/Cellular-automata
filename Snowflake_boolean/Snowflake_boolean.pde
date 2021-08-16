boolean [][] tab, oldtab;
int lato, cols, rows;

void setup() {
  size(600, 600);
  noStroke();
  lato = 2;
  cols = width / lato;
  rows = height / lato;

  tab = new boolean [cols][rows];
  oldtab = new boolean [cols][rows];

 reset();
}

void draw() {
  for (int x = 0; x < cols; x++) {
    for (int y = 0; y < rows; y++) {

      if (tab[x][y]) {
        fill(0);
      } else {
        fill(255);
      }
      oldtab[x][y] = tab[x][y];
      rect(lato * x, lato * y, lato, lato);
    }
  }
  update();
}

void update() {
  for (int x = 0; x < cols; x++) {
    for (int y = 0; y < rows; y++) {
      if (!oldtab[x][y]) {
        int counter = 0;
        if (x - 1 >= 0) {
          if (oldtab[x-1][y]) {
            counter++;
          }
        } 
        if (x + 1 < cols) {
          if (oldtab[x+1][y]) {
            counter++;
          }
        }
        if (y + 1 < rows) {
          if (oldtab[x][y+1]) {
            counter++;
          }
        }

        if (y - 1 >= 0) {
          if (oldtab[x][y-1]) {
            counter++;
          }
        }

        if (counter == 1) {
          tab[x][y] = true;
        }
      }
    }
  }
}

void reset(){
  for (int x = 0; x < cols; x++) {
    for (int y = 0; y < rows; y++) {
      tab[x][y] = false;
    }
  }
  tab[cols / 2][rows / 2] = true; 
}

void keyPressed(){
  reset();
}
