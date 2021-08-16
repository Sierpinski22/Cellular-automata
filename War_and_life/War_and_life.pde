boolean [][] ground;
boolean [][] oldground;

int [][] tab;
int [][] oldtab;

int lato = 5;

color sea = #1D1671;
color continent = #35931C;

color alive = color(255);
color flame = #FF9000;
color dying = color(255, 0, 0);

int load = 75;

void setup() {
  //frameRate(10);
  noStroke();
  fullScreen();
  //size(600, 600);

  ground = new boolean[width / lato][height / lato];
  oldground = new boolean[width / lato][height / lato];
  tab = new int [width / lato][height / lato];
  oldtab = new int [width / lato][height / lato];


  for (int x = 0; x < width / lato; x++) {
    for (int y = 0; y < height / lato; y++) {  

      ground[x][y] = random(1) < 0.4 ? true : false;
      tab[x][y] = random(1) < 0.5 ? 3 : 0;

      oldtab[x][y] = tab[x][y];
      oldground[x][y] = ground[x][y];
    }
  }
}

boolean done = false;

void draw() {
  background(sea);
  terrarian();

  if (done) {
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
          if (ground[x][y]) {
            fill(continent);
          } else {
            fill(sea);
          }
          break;
        }
        rect(x * lato, y * lato, lato, lato);
        oldtab[x][y] = tab[x][y];
      }
    }
    sorting();
  }
}

void keyPressed() {
  if (key == ' ') {

    for (int i = 0; i < 200; i++) {

      int x = int(random(0, width / lato));
      int y = int(random(0, height / lato));

      tab[x][y] = 3;
      oldtab[x][y] = 3;

    }
  }
}

void sorting() {

  for (int x = 0; x < width / lato; x++) {
    for (int y = 0; y < height / lato; y++) {

      switch(oldtab[x][y]) {

      case 1:
        tab[x][y] = 0;
        break;

      case 2:
        tab[x][y] = 1;
        break;

      case 3:
        if (ground[x][y]) {
          conway(x, y);
        } else {
          war(x, y);
        }
        break;

      case 0:
        if (ground[x][y]) {
          conway(x, y);
        } else {
          war(x, y);
        }
        break;
      }
    }
  }
}

void conway(int x, int y) {//funzionante
  //print(1);
  int counter = 0;
  //if(x == 3 && y == 3){
  for (int lr = x - 1; lr <= x + 1; lr++) {
    for (int ud = y - 1; ud <= y + 1; ud++) {
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



  if (counter == 3) {
    tab[x][y] = 3;
  } else if (counter < 2 || counter > 3) {
    tab[x][y] = 0;
  }
}

void war(int x, int y) {
  //print(1);
  int counter = 0;
  //if(x == 3 && y == 3){
  for (int lr = x - 1; lr <= x + 1; lr++) {
    for (int ud = y - 1; ud <= y + 1; ud++) {
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
  } else if ((counter < 3 || counter > 5) && oldtab[x][y] == 3) {
    tab[x][y] = 2;
  }
}

int gen = 0;

void terrarian() {

  if (gen < load && !done) {
    //print(3);
    for (int x = 0; x < width / lato; x++) {
      for (int y = 0; y < height / lato; y++) {

        int counter = 0;

        for (int lr = x-1; lr <= x+1; lr++) {
          for (int ud = y-1; ud <= y+1; ud++) {

            if (lr != x || ud != y) {
              if (lr < width / lato && lr >= 0 && ud < height / lato && ud >= 0) {

                if (oldground[lr][ud]) {
                  counter++;
                  //print(1);
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

                if (oldground[outx][outy]) {
                  counter++;
                }
              }
            }
          }
        }

        if (oldground[x][y] && counter < 4) {
          ground[x][y] = false;
        } else if ((!oldground[x][y]) && counter > 4) {
          ground[x][y] = true;
        }

        if (oldground[x][y] == ground[x][y]) {
        }

        //print(counter);
      }
    }

    gen++;
  } else {
    done = true;
  }

  for (int x = 0; x < width / lato; x++) {
    for (int y = 0; y < height / lato; y++) {

      if (ground[x][y]) {
        fill(continent);
      } else {
        fill(sea);
      }

      rect(lato * x, lato * y, lato, lato);

      oldground[x][y] = ground [x][y];
    }
  }
}
