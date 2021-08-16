int [][] tab;
int [][] oldtab;

color life = color(255);
color dying = color(0, 0, 255);
color off = color(0);

int lato = 3;

void setup() {

  fullScreen();
  noStroke();
  background(off);

  tab = new int [width / lato][height / lato];
  oldtab = new int [width / lato][height / lato];

  for (int x = 0; x < width / lato; x++) {
    for (int y = 0; y < height / lato; y++) {

      int r = int(random(1, 4));

      tab[x][y] = r;

      switch(tab[x][y]) {

      case 1:
        fill(off);
        break;

      case 2:
        fill(dying);
        break;

      case 3:
        fill(life);
        break;
      }

      rect(x * lato, y * lato, lato, lato);
      oldtab[x][y] = tab[x][y];
    }
  }
}

void restart(){
  
  
  for (int x = 0; x < width / lato; x++) {
    for (int y = 0; y < height / lato; y++) {

      int r = int(random(1, 4));

      tab[x][y] = r;

      switch(tab[x][y]) {

      case 1:
        fill(off);
        break;

      case 2:
        fill(dying);
        break;

      case 3:
        fill(life);
        break;
      }

      rect(x * lato, y * lato, lato, lato);
      oldtab[x][y] = tab[x][y];
    }
  }
}
  

void draw() {

  for (int x = 0; x < width / lato; x++) {
    for (int y = 0; y < height / lato; y++) {

      switch(tab[x][y]) {

      case 1:
        fill(off);
        break;

      case 2:
        fill(dying);
        break;

      case 3:
        fill(life);
        break;
      }

      rect(x * lato, y * lato, lato, lato);
      oldtab[x][y] = tab[x][y];
    }
  }

  
  update();
}

void update() {

int coun = 0;

  for (int x = 0; x < width / lato; x++) {
    for (int y = 0; y < height / lato; y++) {

      if (oldtab[x][y] != 1) {

        tab[x][y] = oldtab[x][y] - 1;
        
        if(oldtab[x][y] == 3){       
          coun++;       
        }
      
      } else {
       
        int counter = 0;

        for (int lr = x-1; lr <= x+1; lr++) {
          for (int ud = y-1; ud <= y+1; ud++) {

            //if(!(lr == x && ud == y)){
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
            //}
          }
        }

        if (counter == 2) {
          tab[x][y] = 3;
        }
      }
    }
  }
  
  if(coun < lato * 2 + 15){   
    restart();
  }
}
