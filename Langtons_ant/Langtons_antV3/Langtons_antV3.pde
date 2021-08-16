int lato = 5;
String rule;
int col;
PVector vel;
int [][] tab;
int angle;

int cols, rows, x1, y1;

void setup() {
  size(700, 700);
  colorMode(HSB);
  noStroke();
  //frameRate(5);
  cols = width / lato;
  rows = height / lato;
  x1 = cols / 2;
  y1 = rows / 2;
  tab = new int[cols][rows];

  rule = "LLLLLLLRRRLR";

  col = 300 / rule.length();

  for (int x = 0; x < cols; x++) {
    for (int y = 0; y < rows; y++) {
      tab[x][y] = 0;
    }
  }

  if (rule.charAt(tab[x1][y1]) == 'l') {
    angle = 1;
  } else {
    angle = 3;
    //print(cos(radians(angle)));
  }
  vel = radvec();
}


void draw() {

  x1 += vel.x;
  y1 += vel.y;

  if (x1 < 0) {
    x1 = cols - 1;
  } else if (x1 >= cols) {
    x1 = 0;
  }

  if (y1 < 0) {
    y1 = rows-1;
  } else if (y1 >= rows) {
    y1 = 0;
  }

  for (int x = 0; x < cols; x++) {
    for (int y = 0; y < rows; y++) {
      if (tab[x][y] == 0) {
        fill(0, 0, 300);
      } else {
        fill(col * tab[x][y], 300, 300);
      }
      rect(x * lato, y * lato, lato, lato);
    }
  }

  tab[x1][y1] = tab[x1][y1] < rule.length() - 1 ? tab[x1][y1] + 1 : 0;

  fill(0);
  rect(x1 * lato, y1 * lato, lato, lato);
  vel = update();
}


PVector update() {

  angle += rule.charAt(tab[x1][y1]) == 'L' ? -1 : 1;

  if (angle == 4) {
    angle = 0;
  } else if (angle == -1) {
    angle = 3;
  }

  return radvec();
}

PVector radvec() {
  if (angle == 0) {
    return new PVector(0, -1);
  } else if (angle == 1) {
    return new PVector(-1, 0);
  } else if (angle == 2) {
    return new PVector (0, 1);
  } else {
    return new PVector (1, 0);
  }
}
