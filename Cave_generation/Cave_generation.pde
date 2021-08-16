boolean [][] tab;
boolean [][] oldtab;

int lato = 4;

color sea = #110086;
color ground = #37C102;

int n = 0;

void setup() {

  noStroke();
  fullScreen();
  //size(600, 600);

  tab = new boolean[width / lato][height / lato];
  oldtab = new boolean[width / lato][height / lato];

  for (int x = 0; x < width / lato; x++) {
    for (int y = 0; y < height / lato; y++) {  

      tab[x][y] = (random(1) < 0.5) ? true : false;

      //if(random(1) < 0.5){
      //  tab[x][y] = true; 
      //}else{
      //  tab[x][y] = false; 
      //}


      oldtab[x][y] = tab [x][y];
    }
  }
}

boolean done = false;

void draw() {



  if (!done) {
    background(sea);
    for (int x = 0; x < width / lato; x++) {
      for (int y = 0; y < height / lato; y++) {

        if (tab[x][y]) {
          fill(ground);
        } else {
          fill(sea);
        }

        rect(lato * x, lato * y, lato, lato);

        oldtab[x][y] = tab [x][y];
      }
    }

    update();
  } else {
    print("done"); 
    noLoop();
  }
}

void update() {

  int check = 0;

  for (int x = 0; x < width / lato; x++) {
    for (int y = 0; y < height / lato; y++) {

      int counter = 0;

      for (int lr = x-1; lr <= x+1; lr++) {
        for (int ud = y-1; ud <= y+1; ud++) {

          if (lr != x || ud != y) {
            if (lr < width / lato && lr >= 0 && ud < height / lato && ud >= 0) {

              if (oldtab[lr][ud]) {
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

              if (oldtab[outx][outy]) {
                counter++;
              }
            }
          }
        }
      }

      if (oldtab[x][y] && counter < 4) {
        tab[x][y] = false;
      } else if ((!oldtab[x][y]) && counter > 4) {
        tab[x][y] = true;
      }

      if (oldtab[x][y] == tab[x][y]) {    
        check++;
      }

      //print(counter);
    }
  }

  if (check == (width / lato) * (height / lato)) {
    done = true;
  }
}
