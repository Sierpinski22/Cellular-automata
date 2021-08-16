boolean [][] tab;
boolean [][] oldtab;

//l = life, a = amoeba... ok è così, 

int lato = 4;
int col;
int rows;

char choice = 'l';

void setup() {
  //size(600, 600);
  noStroke();
  //frameRate(10);
  fullScreen();

  col = int(width / lato);
  rows = int(height / lato);

  tab = new boolean [col][rows];
  oldtab = new boolean [col][rows];

  for (int x = 0; x < col; x++) {
    for (int y = 0; y < rows; y++) {

      tab[x][y] = random(1) < 0.1;
      oldtab[x][y] = tab[x][y];
    }
  }
}

void draw() {
  background(0);
  for (int x = 0; x < col; x++) {
    for (int y = 0; y < rows; y++) {

      if (tab[x][y]) {
        fill(255);
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

              if (oldtab[outx][outy]) {
                counter++;
              }
            }
          }
        }
      }

      if (choice == 'l' || choice == 'L') {
        life(x, y, counter);
      } else if (choice == 'a' || choice == 'A') {
        amoeba(x, y, counter);
      } else if (choice == 's' || choice == 'S') {
        seeds(x, y, counter);
      } else if (choice == 'h' || choice == 'H') {
        half_life(x, y, counter);
      } else if (choice == 'w' || choice == 'W') {
        life_without_death(x, y, counter);
      } else if (choice == 'm' || choice == 'M') {
        maze(x, y, counter);
      } else if (choice == 'r' || choice == 'R') {
        replicator(x, y, counter);
      } else if (choice == 'u' || choice == 'U') {
        unnamed(x, y, counter);
      } else if (choice == 'i' || choice == 'I') {
        life_34(x, y, counter);
      } else if (choice == 'd' || choice == 'D') {
        diamoeba(x, y, counter);
      } else if (choice == '2') {
        _2x2(x, y, counter);
      } else if (choice == 'n' || choice == 'N') {
        day_night(x, y, counter);
      } else if (choice == 'o' || choice == 'O') {
        morley(x, y, counter);
      } else if (choice == 'j' || choice == 'J') {
        anneal(x, y, counter);
      }
    }
  }
}

void keyPressed() {

  if ((key == 'l' || key == 'L')
    || (key == 'a' || key == 'A')
    || (key == 's' || key == 'S')
    || (key == 'h' || key == 'H')
    || (key == 'w' || key == 'W')
    || (key == 'm' || key == 'M')
    || (key == 'r' || key == 'R')
    || (key == 'u' || key == 'U')
    || (key == 'i' || key == 'I')
    || (key == 'd' || key == 'D')
    || (key == '2')
    || (key == 'n' || key == 'N')
    || (key == 'o' || key == 'O')
    || (key == 'j' || key == 'J')) {
    choice = key;
  } else if (key == ' ') {

    for (int x = 0; x < col; x++) {
      for (int y = 0; y < rows; y++) {

        tab[x][y] = random(1) < 0.2;
        oldtab[x][y] = tab[x][y];
      }
    }
  }
}

void amoeba(int x, int y, int counter) {
  if (counter != 1 && counter % 2 == 1) {
    tab[x][y] = true;
  } else if (counter != 8 && counter % 2 == 0 || counter == 7) {
    tab[x][y] = false;
  }
}

void life(int x, int y, int counter) {
  if (counter == 3) {
    tab[x][y] = true;
  } else if (counter < 2 || counter > 3) {
    tab[x][y] = false;
  }
}

void seeds(int x, int y, int counter) {
  tab[x][y] = !oldtab[x][y] && counter == 2;
}

void half_life(int x, int y, int counter) {
  if (counter == 3 || counter == 6) {
    tab[x][y] = true;
  } else if (counter != 2 && counter != 3) {
    tab[x][y] = false;
  }
}

void life_without_death(int x, int y, int counter) {
  tab[x][y] = counter == 3 ? true : oldtab[x][y];
}

void maze(int x, int y, int counter) {
  if (counter == 3) {
    tab[x][y] = true;
  } else if (counter < 1 || counter > 5) {
    tab[x][y] = false;
  }
}

void replicator(int x, int y, int counter) {
  //if (counter % 2 == 1) {
  //  tab[x][y] = !oldtab[x][y];
  //}

  tab[x][y] = counter % 2 == 1;
}

void unnamed(int x, int y, int counter) {
  if ((counter == 2 || counter == 5) && !oldtab[x][y]) {
    tab[x][y] = true;
  } else if (counter != 4 && oldtab[x][y]) {
    tab[x][y] = false;
  }
}

void life_34(int x, int y, int counter) {
  tab[x][y] = counter == 3 || counter == 4;
}

void diamoeba(int x, int y, int counter) {
  if (counter == 3 || counter >= 5) {
    tab[x][y] = true;
  } else if (counter < 5) {
    tab[x][y] = false;
  }
}

void _2x2(int x, int y, int counter) {
  if ((counter == 3 || counter == 6) && !oldtab[x][y]) {
    tab[x][y] = true;
  } else if ((counter != 1 && counter != 2 && counter != 5) && oldtab[x][y]) {
    tab[x][y] = false;
  }
}

void day_night(int x, int y, int counter) {//
  if (!oldtab[x][y] && (counter == 3 || counter >= 6)) {
    tab[x][y] = true;
  } else if (oldtab[x][y] && (counter < 6 && counter != 3 && counter != 4)) {
    tab[x][y] = false;
  }
}

void morley(int x, int y, int counter) {
  if (!oldtab[x][y] && (counter == 3 || counter == 6 || counter == 8)) {
    tab[x][y] = true;
  } else if (oldtab[x][y] && (counter != 2 && counter != 4 && counter != 5)) {
    tab[x][y] = false;
  }
}

void anneal(int x, int y, int counter) {
  if (!oldtab[x][y] && (counter == 4 ||counter >= 6)) {
    tab[x][y] = true;
  } else if (oldtab[x][y] && (counter != 3 && counter < 5)) {
    tab[x][y] = false;
  }
}
