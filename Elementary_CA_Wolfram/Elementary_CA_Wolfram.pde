boolean [] [] rulesets;
ArrayList <boolean []> story;
automata a;

int lato = 4;
int rows, cols;
color on = color(0);
color off = #C9CED8;
int i = 0;

final int maxr = 11;

boolean thoroidal = true;

void setup() {
  size(500, 600); 
  noStroke();
  //frameRate(40);
  rows = height / lato;
  cols = width / lato;
  print(cols);

  story = new ArrayList <boolean[]>();
  rulesets = new boolean[maxr][maxr];

  write();
  a = new automata(rulesets[0], false);
}

void draw() {
  background(off);
  obtain();
  boolean [] now;
  for (int i = story.size() - 1; i >= 0; i--) {
    now = story.get(i);
    for (int w = 0; w < cols; w++) {
      if (now[w]) {
        fill(on);
      } else {
        fill(off);
      }
      rect(w * lato, i * lato, lato, lato);
    }
  }
  a.run();
}

void write() {
  rulesets[0] = new boolean [] {false, false, false, true, true, true, true, false}; //rule 30
  rulesets[1] = new boolean [] {false, false, true, true, false, true, true, false}; //rule 54
  rulesets[2] = new boolean [] {false, false, true, true, true, true, false, false}; //rule 60
  rulesets[3] = new boolean [] {false, true, true, true, true, true, true, false};//rule 126
  rulesets[4] = new boolean [] {false, false, true, false, true, true, false, true}; //rule 45
  rulesets[5] = new boolean [] {false, true, false, false, true, false, false, true};//rule 73
  rulesets[6] = new boolean [] {false, true, true, false, false, true, false, true};//rule 101
  rulesets[7] = new boolean [] {true, false, false, true, false, true, true, false};//rule 150
  rulesets[8] = new boolean [] {true, true, true, false, false, false, false, true};//rule 225
  rulesets[9] = new boolean [] {true, false, true, true, true, false, false, false};//rule 184
  rulesets[10] = new boolean [] {false, false, true, false, false, false, true, false};//rule 34
}

void mousePressed() {
  if (mouseButton == LEFT) {
    i = i >= maxr - 1? 0 : i + 1;
  } else if (mouseButton == RIGHT) {
    i = i > 0 ? i - 1 : maxr - 1;
  }

  a = new automata(rulesets[i], i > 8);
  story = new ArrayList <boolean[]>();
}

void obtain() {

  if (story.size() == rows) {
    story.remove(0);
  }

  story.add(a.pass());
}
