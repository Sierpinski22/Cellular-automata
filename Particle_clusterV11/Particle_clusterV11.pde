ArrayList <particle> population = new ArrayList <particle> ();
float [][] rule; 
float [] coat;
float [] sight;
float [] minsig;
int n = 8;
float radius = 10;
final float maxpop = 750;
int maxv = 2;
float threshold = 0.1;
boolean boom = true;

void setup() {
  fullScreen();
  noStroke();
  rule = new float [n][n];
  coat = new float [n];
  sight = new float [n];
  minsig = new float [n];
  for (int w = 0; w < n; w++) {
    for (int t = 0; t < n; t++) {
      rule[w][t] = random(-maxv, maxv);
    }
    coat[w] = random(0.5, 1.5);
    while (coat[w] < 0.3 && coat[w] > -0.3) {
      coat[w] = random(-0.7, 1.5);
    }
    sight[w] = random(radius, radius * 2);
    minsig[w] =  random(0, radius / 2);
  }

  reseed();
}

void keyPressed() {
  if (key == ' ') {
    reseed();
  } else if (key == 'n' || key == 'N') {

    for (int w = 0; w < n; w++) {
      for (int t = 0; t < n; t++) {
        rule[w][t] = random(-maxv, maxv);
      }
      coat[w] = random(0.5, 1.5);
      while (coat[w] < 0.3 && coat[w] > -0.3) {
        coat[w] = random(-0.7, 1.5);
      }
      sight[w] = random(radius * 2, radius * 5);
      minsig[w] =  random(0, radius / 2);
    }
    reseed();
  } else if (key == 'b' || key == 'B') {

    boom = !boom;
    reseed();
  }
}

void reseed() {
  population.clear();

  for (int i = 0; i < maxpop; i++) {
    int r = int(random(n));

    if (r == 0) {
      population.add(new particle(rule[r], coat[r], sight[r], minsig[r]));
    } else if (r == 1) {
      population.add(new greenl(rule[r], coat[r], sight[r], minsig[r])); //esistono già funzioni con i nomi dei colori...
    } else if (r == 2) {
      population.add(new bluel(rule[r], coat[r], sight[r], minsig[r]));
    } else if (r == 3) {
      population.add(new redl(rule[r], coat[r], sight[r], minsig[r]));
    } else if (r == 4) {
      population.add(new purple(rule[r], coat[r], sight[r], minsig[r]));
    } else if (r == 5) {
      population.add(new orange(rule[r], coat[r], sight[r], minsig[r]));
    } else if (r == 6) {
      population.add(new lightblue(rule[r], coat[r], sight[r], minsig[r]));
    } else if (r == 7) {
      population.add(new brown(rule[r], coat[r], sight[r], minsig[r]));
    }
  }
}

void draw() {
  background(0);
  for (particle p : population) {
    p.move();
    p.create();
  }
}
