int [][] tab;
int [][] oldtab;

int lato = 3;
int maxn = 27;
int threshold = 0;

int col = int(255 / maxn);

void setup() {
  size(600, 600);
  //fullScreen();
  noStroke();
  colorMode(HSB);

  restart();
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

      for (int lr = x - 1; lr <= x + 1; lr++) {
        for (int ud = y - 1; ud <= y + 1; ud++) {
          if (lr != x || ud != y) {
            //print(lr, ' ');

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

            if (oldtab[x][y] == maxn - 1 && oldtab[outx][outy] == 0) {
              counter++;
            } else if (oldtab[outx][outy] == oldtab[x][y] + 1) {
              counter++;
            }
          }
        }
        apprule(x, y, counter);
      }
    }
  }
}

void apprule(int x, int y, int c) {
  if (oldtab[x][y] == maxn - 1 && c > threshold) {
    tab[x][y] = 0;
  } else if (c > threshold) {
    tab[x][y] = oldtab[x][y] + 1;
  }
}

void keyPressed() {
  restart();
}

void restart() {
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
