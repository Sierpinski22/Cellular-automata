int [][] tab;
int [][] oldtab;
color [] palette;

int lato;
int col;
int rows;
int a;

color dead;

void setup() {
  size(700, 700);
  noStroke();
  frameRate(10);
  //fullScreen();
  background(0);

  a = 0;

  palette = new color[]{
    #502BCB, //blu
    #49F04A, //verde
    #F2810F, //arancione
    #DE60DC, //rosa
    #8533BC, //viola
    #F21827, //rosso
    #18EDF2, //azzurro
    #FAFF0D //giallo
  };

  dead = color(0);
  reset();
}

void draw() {

  for (int x = 0; x < col; x++) {
    for (int y = 0; y < rows; y++) {
      if (tab[x][y] > -1) {
        fill(palette[tab[x][y]]);
      } else {
        fill(dead);
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
              if (oldtab[lr][ud] >= 0) {
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
      if (a == 0) {
        replicator(x, y, counter);
      } else if (a == 1) {
        tootpick(x, y, counter);
      } else if (a == 2) {
        idontknow(x, y, counter);
      }
    }
  }
}

void replicator(int x, int y, int c) {
  if (c % 2 == 1) {
    tab[x][y] = (c - 1) / 2;
  } else {
    tab[x][y] = -1;
  }
}

void tootpick(int x, int y, int c) {
  if (tab[x][y] == -1 && (c == 1 || c == 6)) {
    tab[x][y] = c % 3;
  } else if (tab[x][y] != -1 && (c > 6)) {
    tab[x][y] = -1;
  }
}

void idontknow(int x, int y, int c) {
  if (tab[x][y] == -1 && c > 0) {
    tab[x][y] = c - 1;
  } else if (tab[x][y] != -1 && c != 1 && c != 4 && c != 5) {
    tab[x][y] = -1;
  }
}

void mousePressed() {
  a = a < 2 ? a + 1 : 0;
  reset();
}

void reset() {
  lato = a == 1 ? 2 : 4;  
  
  col = int(width / lato);
  rows = int(height / lato);

  tab = new int [col][rows];
  oldtab = new int [col][rows];
  
  for (int x = 0; x < col; x++) {
    for (int y = 0; y < rows; y++) {
      tab[x][y] = -1;
    }
  }

  tab[int(col / 2)][int(rows / 2)] = 0;
  oldtab[int(col / 2)][int(rows / 2)] = 0;
}
