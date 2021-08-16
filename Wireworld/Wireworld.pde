int [][] tab, oldtab;
color dead, elec, etail, wire;
int lato, cols, rows;
boolean pause = false;

void setup() {
  size(600, 600);
  stroke(150);
  frameRate(10);
  lato = 20;
  cols = width / lato;
  rows = height / lato;

  tab = new int [cols][rows];
  oldtab = new int [cols][rows];

  dead = color(0);
  elec =  #69BBF7;
  etail = color(255, 0, 0);
  wire = #F6FF03;

  reset();
}

void draw() {
  for (int x = 0; x < cols; x++) {
    for (int y = 0; y < rows; y++) {

      switch(tab[x][y]) {
      case 0:
        fill(dead);
        break;

      case 1:
        fill(elec);
        break;

      case 2:
        fill(etail);
        break;

      case 3:
        fill(wire);
        break;
      }
      oldtab[x][y] = tab[x][y];
      rect(x * lato, y * lato, lato, lato);
    }
  }
  if (!pause) update();
}
//ctrl r
void update() {

  for (int x = 0; x < cols; x++) {
    for (int y = 0; y < rows; y++) {

      switch(oldtab[x][y]) {

      case 0:
        tab[x][y] = 0;
        break;

      case 1:
        tab[x][y] = 2; 
        break;

      case 2:
        tab[x][y] = 3;
        break;

      case 3: //qui
        int c = check(x, y);
        tab[x][y] = c == 2 || c == 1 ? 1 : 3; 
        break;
      }
    }
  }
}

int check(int x, int y) {

  int counter = 0;

  for (int lr = x - 1; lr <= x + 1; lr++) {
    for (int ud = y - 1; ud <= y + 1; ud++) {
      if (lr != x || ud != y) {
        if (lr >= 0 && lr < cols && ud >= 0 && ud < rows) {
          if (oldtab[lr][ud] == 1) {
            counter++;
          }
        }
      }
    }
  }
  return counter;
}

void keyPressed() {
  if (key ==  ' ') {
    pause = !pause;
  } else if (key == 'r' || key == 'R') {
    reset();
  }
}

void mousePressed() {
  int i = 0;
  if (mouseX < width && mouseX > 0 && mouseY < height && mouseY > 0) {
    if (mouseButton == LEFT) {
      switch (tab[mouseX / lato][mouseY / lato]) {

      case 0:
        i = 3;
        break;

      case 1:
        i = 2;
        break;

      case 3:
        i = 1;
        break;

      default:
        break;
      }
    }
    tab[mouseX / lato][mouseY / lato] = i;
  }
}

void reset() {
  for (int x = 0; x < cols; x++) {
    for (int y = 0; y < rows; y++) {
      tab[x][y] = 0;
    }
  }
}
