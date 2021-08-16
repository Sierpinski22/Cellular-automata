ArrayList <PVector> ground;
int lato = 10;
String rule;
int col;
PVector oldvel;
int [][] tab;

int cols, rows, x1, y1;

void setup() {
  size(600, 600);
  colorMode(HSB);
  noStroke();
  cols = width / lato;
  rows = height / lato;
  x1 = cols / 2;
  y1 = rows / 2;
  tab = new int[cols][rows];
  ground = new ArrayList <PVector> ();


  rule = "LRRRRRLLR";
  ground.add(assign('n', 0));

  for (int i = 0; i < rule.length(); i++) {
    char k = rule.charAt(i);
    if (k == '2' && i < rule.length() - 1) {
      ground.add(assign(rule.charAt(i + 1), 2));
    } else if (k != '2') {
      ground.add(assign(k, 1));
    }
  }

  col = 300 / ground.size();
  //int ant = ground.size() + 1;

  for (int x = 0; x < cols; x++) {
    for (int y = 0; y < rows; y++) {
      tab[x][y] = 0;
    }
    oldvel = ground.get(tab[x1][y1]);
  }


  print(ground.size());
}


void draw() {
  PVector move = ground.get(tab[x1][y1]);
  oldvel.add(move);

  oldvel.x = constrain(oldvel.x, -1, 1);
  oldvel.y = constrain(oldvel.y, -1, 1);

   x1 += oldvel.x;
   y1 += oldvel.y;

  if (x1 < 0) {
    x1 = cols-1;
  } else if (x1 >= cols) {
    x1 = 0;
  }

  if (y1 < 0) {
    y1 = rows-1;
  } else if (y1 >= rows) {
    y1 = 0;
  }


  fill(0);
  rect(x1 * lato, y1 * lato, lato, lato);
  for (int x = 0; x < cols; x++) {
    for (int y = 0; y < rows; y++) {

      if (x == x1 && y == y1) {
        tab[x][y] = tab[x][y] < ground.size() - 1 ? tab[x][y] + 1 : 0;
      }

      if (tab[x][y] == 0) {
        fill(0, 0, 300);
      } else {
        fill(col * tab[x][y], 300, 300);
      }
      rect(x * lato, y * lato, lato, lato);
    }
  }
}

PVector assign(char l, int t) {
  if (l != 'n') {

    int p;

    if (l == 'U') {
      p = 0;
    } else if (l == 'L') {
      p = 1;
    } else if (l == 'S') {
      p = 2;
    } else {
      p = 3;
    }

    p += t - 1;
    p = p % 4;

    if (p == 0) {
      return new PVector(0, -1);
    } else if (p == 1) {
      return new PVector(-1, 0);
    } else if (p == 2) {
      return new PVector(0, 1);
    } else {
      return new PVector(1, 0);
    }
  } else {
    return new PVector(0, 0);
  }
}
