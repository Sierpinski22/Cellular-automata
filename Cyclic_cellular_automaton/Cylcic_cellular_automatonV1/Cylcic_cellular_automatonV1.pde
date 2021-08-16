int [][] tab;
int [][] oldtab;

int lato = 4;
int maxn = 25;
int threshold = 0;

int col = int(255 / maxn);

void setup() {

  fullScreen();
  noStroke();
  colorMode(HSB);

  tab = new int [width / lato][height / lato];
  oldtab = new int [width / lato][height / lato];

  for (int x = 0; x < width / lato; x++) {
    for (int y = 0; y < height / lato; y++) {

      int r = int(random(maxn));

      tab[x][y] = r;
      oldtab[x][y] = tab[x][y];
    }
  }
}

void draw() {

  for (int x = 0; x < width / lato; x++) {
    for (int y = 0; y < height / lato; y++) {

      fill(col * tab[x][y], 300, 300);
      rect(lato * x, lato * y, lato, lato);

      oldtab[x][y] = tab[x][y];
    }
  }

  update();
}


void update() {

  for (int x = 0; x < width / lato; x++) {
    for (int y = 0; y < height / lato; y++) {

      int counter = 0;
      int endcount = 0;

      for (int lr = x - 1; lr <= x + 1; lr++) {
        for (int ud = y - 1; ud <= y + 1; ud++) {

          if ((lr >= 0 && lr < width / lato) && (ud >= 0 && ud < height / lato)) {

            if (oldtab[x][y] + 1 == maxn) {

              if (oldtab[lr][ud] == 0) {
                endcount++;
              }
            } else {

              if (oldtab[lr][ud] == oldtab[x][y] + 1) {
                counter++;
              }
            }
          } else {

            int outx = lr;
            int outy = ud;

            if (outx < 0) {
              outx = (width / lato) - 1;
            } else if (outx >= width / lato) {
              outx = 0;
            }

            if (outy < 0) {
              outy = (height / lato) - 1;
            } else if (outy >= height / lato) {
              outy = 0;
            }

            if (oldtab[x][y] + 1 == maxn) {

              if (oldtab[outx][outy] == 0) {
                endcount++;
               
              }
            } else {

              if (oldtab[outx][outy] == oldtab[x][y] + 1) {
                counter++;
              }
            }
          }
        }
      }

      if (counter > threshold) {
        tab[x][y] = oldtab[x][y] + 1;
      } else if (endcount > threshold) {
        tab[x][y] = 0;
      }
    }
  }
}
