boolean [][] tabella;
boolean [][] oldtab;

color vita = color(255);
color morte = color(0);

int x1, y1, x2, y2;
int r;
int lato = 5; //in pixel

void setup() {

  size(600, 600);
  //fullScreen();

  tabella = new boolean [width / lato][height / lato];
  oldtab = new boolean [width / lato][height / lato];

  for (int x = 0; x < width / lato; x++) {                                      
    for (int y = 0; y < height / lato; y++) {

      r = int(random(2));

      if (r == 1) {
        tabella[x][y] = true;
      } else {
        tabella[x][y] = false;
      }
    }
  }
}

int gradient = 0;
boolean secret = false;

void draw() {
  background(0);
  gradient++;

  if (gradient >= 99) {
    gradient = 0;
  }

  if (secret) {

    vita = color(abs(gradient - 100), 100, 100);
  }

  noStroke();
  for (x1 = 0; x1 < width / lato; x1++) {                                      
    for (y1 = 0; y1 < height / lato; y1++) {

      if (tabella[x1][y1]) {
        fill(vita);
      } else {
        fill(morte);
      }

      square(x1 * lato, y1 * lato, lato);
      oldtab[x1][y1] = tabella[x1][y1];

    }
  }
  
      check();
}

void keyPressed() {
  if (key == ' ') {

    for (int x = 0; x < width / lato; x++) {                                      
      for (int y = 0; y < height / lato; y++) {

        r = int(random(2));

        if (r == 1) {
          tabella[x][y] = true;
        } else {
          tabella[x][y] = false;
        }

        oldtab[x][y] = tabella[x][y];

        //key = '?';
      }
    }
  } else if (key == 's' || key == 'S') {
    colorMode(HSB, 100);
    secret = true;
    println("party time!");
  }
}

int outx;
int outy;


void check() {


  for (int x = 0; x < width / lato; x++) {                                      
    for (int y = 0; y < height / lato; y++) {

      int counter = 0;

      for (int lr = x - 1; lr <= x + 1; lr++) {                                      
        for (int ud = y - 1; ud <= y + 1; ud++) {

          //if((lr >= 0 && lr < width / lato) && (ud >= 0 && ud < height / lato) && (lr != x || ud != y)){
          if (lr != x || ud != y) {

            if ((lr >= 0 && lr < width / lato) && (ud >= 0 && ud < height / lato)) {

              if (oldtab[lr][ud]) {
                counter++;
              }
            } else {

              outx = lr;
              outy = ud;


              if (lr < 0) {
                outx = (width / lato) - 1;
              } else if (lr >= width / lato) {
                outx = 0;
              }

              if (ud < 0) {
                outy = (height / lato) - 1;
              } else if (ud >= height / lato) {
                outy = 0;
              }

              if (oldtab[outx][outy]) {
                counter++;
              }
            }
          }
        }
      }  
      //------------------------------------------Check zone----------------------------------------------------------------  
      if (oldtab[x][y] && (counter < 2 || counter > 3)) {
        tabella[x][y] = false;
      } else if (!oldtab[x][y] && counter == 3) {
        tabella[x][y] = true;
      }
    }
  }
}
