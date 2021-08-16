int [][] tab;
int [][] oldtab;

color dead = color(0);
color dying = color(255, 0, 0);
color flame = color(255, 144, 0);
color alive = color(255);

int lato = 3;

void setup() {

  //size(600, 600);
  noStroke();
  fullScreen();
  tab = new int [width / lato][height / lato];
  oldtab = new int [width / lato][height / lato];

  for (int x = 0; x < width / lato; x++) {
    for (int y = 0; y < height / lato; y++) {

      if (random(1) >= 0.3) {
        tab[x][y] = 0;
      } else {
        tab[x][y] = 3;
      }

      oldtab[x][y] = tab[x][y];
    }
  }
}

void draw() {

  background(dead);

  for (int x = 0; x < width / lato; x++) {
    for (int y = 0; y < height / lato; y++) {

      switch(tab[x][y]) {

      case 3:
        fill(alive);
        break;

      case 2:
        fill(flame);
        break;

      case 1:
        fill(dying);
        break;

      case 0:
        fill(dead);
        break;
      }

      rect(lato * x, lato * y, lato, lato);

      oldtab[x][y] = tab[x][y];
    }
  }

  //arrayCopy(oldtab, tab); //non funziona
  update();
}

void update() {

  for (int x = 0; x < width / lato; x++) {
    for (int y = 0; y < height / lato; y++) {

      if (oldtab[x][y] == 1 || oldtab[x][y] == 2) {

        tab[x][y] = oldtab[x][y] - 1;
      } else {

        int counter = 0;

        for (int lr = x-1; lr <= x+1; lr++) {
          for (int ud = y-1; ud <= y+1; ud++) {

            if (lr != x || ud != y) {

              if ((lr >= 0 && lr < width / lato) && (ud >= 0 && ud < height / lato)) {

                if (oldtab[lr][ud] == 3) {
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

                if (oldtab[outx][outy] == 3) {
                  counter++;
                }
              }
            }
          }
        }

        if (counter == 2 && oldtab[x][y] == 0) {
          tab[x][y] = 3;
        } else if ((counter > 5 || counter < 3) && oldtab[x][y] == 3) {
          tab[x][y] = 2;
          //print(counter);
        }
      }
    }
  }
}

void keyPressed() {

  if (key == ' ') {
    for (int x = 0; x < width / lato; x++) {
      for (int y = 0; y < height / lato; y++) {

        if (random(1) >= 0.3) {
          tab[x][y] = 0;
        } else {
          tab[x][y] = 3;
        }

        oldtab[x][y] = tab[x][y];
      }
    }
  }
}
