boolean [][] tab;
boolean [][] oldtab;

int lato = 4;
int col;
int rows;

void setup() {
  size(708, 708);
  noStroke();
  frameRate(10);
  //fullScreen();
  background(0);

  col = int(width / lato);
  rows = int(height / lato);

  tab = new boolean [col][rows];
  oldtab = new boolean [col][rows];

  tab[int(col / 2)][int(rows / 2)] = true;
  oldtab[int(col / 2)][int(rows / 2)] = true;
}

void draw() {
  
  for (int x = 0; x < col; x++) {
    for (int y = 0; y < rows; y++) {

      if (tab[x][y]) {
        fill(#1A2B95);
      } else {
        fill(0);
      }

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
              if (oldtab[lr][ud]) {
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
      tab[x][y] = counter % 2 == 1;
    }
  }
}
