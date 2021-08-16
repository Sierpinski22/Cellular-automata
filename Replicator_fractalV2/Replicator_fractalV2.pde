color [][] tab;
color [][] oldtab;
color [] palette;

int lato = 4;
int col;
int rows;

color dead;

void setup() {
  size(708, 708);
  noStroke();
  frameRate(10);
  //fullScreen();
  background(0);
  palette = new color[]{
    #502BCB, //blu
    #49F04A, //verde
    #F2810F, //arancione
    #DE60DC, //rosa
    #8533BC, //viola
  };
  dead = color(0);
  col = int(width / lato);
  rows = int(height / lato);

  tab = new color [col][rows];
  oldtab = new color [col][rows];

  tab[int(col / 2)][int(rows / 2)] = color(255);
  oldtab[int(col / 2)][int(rows / 2)] = color(255);
}

void draw() {

  for (int x = 0; x < col; x++) {
    for (int y = 0; y < rows; y++) {

      fill(tab[x][y]);

      square(x * lato, y * lato, lato);
      oldtab[x][y] = tab[x][y];
    }
  }

  update();
}

void update() {

  for (int x = 0; x < col; x++) {
    for (int y = 0; y < rows; y++) {

      int counter = 0;

      for (int lr = x - 1; lr <= x + 1; lr++) {
        for (int ud = y - 1; ud <= y + 1; ud++) {
          if (ud != y || lr != x) {

            if ((lr >= 0 && lr < col) && (ud >= 0 && ud < rows)) {
              if (oldtab[lr][ud] != dead) {
                counter++;
              }
              //} else {
              //  int outx = lr;
              //  int outy = ud;

              //  if (outx >= width / lato) {
              //    outx = 0;
              //  } else if (outx < 0) {
              //    outx = (width / lato) - 1;
              //  }

              //  if (outy >= height / lato) {
              //    outy = 0;
              //  } else if (outy < 0) {
              //    outy = (height / lato) - 1;
              //  }

              //  if (oldtab[outx][outy]) {
              //    counter++;
              //  }
            }
          }
        }
      }
      replicator(x, y, counter);
    }
  }
}

void replicator(int x, int y, int c) {
  if (c % 2 == 0) {
    tab[x][y] = palette[c / 2];
  }
  tab[x][y] = dead;
}
