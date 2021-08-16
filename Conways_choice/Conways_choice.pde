//(max + n) % max       n è lr o ud
boolean [][] tab, oldtab;
int cols, rows, lato;
patterns p = new patterns();

void setup() {
  size(1000, 600);
  lato = 5;
  noStroke();
  //frameRate(10);

  cols = width / lato;
  rows = height / lato;

  tab = new boolean [cols][rows];
  oldtab = new boolean [cols][rows];

  reset();
}

void draw() {
  background(0);
  for (int x = 0; x < cols; x++) {
    for (int y = 0; y < rows; y++) {

      if (tab[x][y]) {
        fill(255);
      } else {
        fill(0);
      }

      oldtab[x][y] = tab[x][y];
      rect(x * lato, y * lato, lato, lato);
    }
  }
  update();
}

void update() {
  for (int x = 0; x < cols; x++) {
    for (int y = 0; y < rows; y++) {
      int counter = 0;
      for (int lr = x - 1; lr <= x + 1; lr++) {
        for (int ud = y - 1; ud <= y +1; ud++) {
          if (x != lr || y != ud) {
            if (oldtab[(cols + lr) % cols][(rows + ud) % rows]) {// ottimizzato
              counter++;
            }
          }
        }
      }
      if (counter == 3) {
        tab[x][y] = true;
      } else if (counter < 2 || counter > 3) {
        tab[x][y] = false;
      }
    }
  }
}

void addshape(int x, int y, int c) {
  p.choose(c);
  for (int i = 0; i < p.pattern.length; i++) {
    tab[(x + cols + (i % p.latx)) % cols][(y + rows + floor(i / p.latx)) % rows] = p.pattern[i] == 1;
    //GIUSTO, se è un array 1d, non interessano due coordinate (laty è errato). per orientare le pattern aggiungere o sottrarre i % o / latx
  }
}

void keyPressed() {
  if (key == ' ') {
    reset();
  } else if (mouseX < width && mouseX > 0 && mouseY < height && mouseY > 0) {
    if (int(key) < 59 && int(key) >= 48) {
      addshape(mouseX / lato, mouseY / lato, int(key) % 49);
    }
  }
}
void reset() {
  for (int x = 0; x < cols; x++) {
    for (int y = 0; y < rows; y++) {
      tab[x][y] = random(1) < 0.1;
    }
  }
}
