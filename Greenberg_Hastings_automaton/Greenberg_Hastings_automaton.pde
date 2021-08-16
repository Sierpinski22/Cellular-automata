int [][] tab;
int [][] oldtab;

int lato = 3;
int maxlevel = 5;
int col = 300 / maxlevel;
int threshold = 5;


void setup() {
  colorMode(HSB);
  fullScreen();
  // size(600, 600);
  noStroke();
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

      fill(col * (1 + tab[x][y]), 200, 300);
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

        for (int lr = x - 1; lr <= x + 1; lr++) {
          for (int ud = y - 1; ud <= y + 1; ud++) {
            if (!(lr == x && ud == y)) {

              if ((lr < width / lato && lr >= 0) && (ud < height / lato && ud >= 0)) {

                if (oldtab[lr][ud] == maxlevel - 1) {
                  counter++;
                }
              } else {

                int outx = lr;
                int outy = ud;

                if (outx >= width / lato) {
                  outx = 0;
                } else if (outx < 0) {
                  outx = (width / lato) - 1;
                }

                if (outy >= height / lato) {
                  outy = 0;
                } else if (outy < 0) {
                  outy = (height / lato) - 1;
                }

                if (oldtab[outx][outy] == maxlevel - 1) {
                  counter++;
                }
              }
            }
          }

          if (counter >= threshold) {
            tab[x][y] = 0;
          }
        }
      }
    }
  }
}
