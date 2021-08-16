class particle {//la classe generale particle definisce la particella gialla

  PVector loc;
  PVector vel;
  PVector acc;
  float maxfor = 1;
  float maxvel = 0.5;
  float sight;
  float minsig;
  float coatt;
  int index;
  color specie;
  PVector pseudoloc;

  float [] diplomacy; //oppure un'array di float pieno di coefficienti

  particle(float [] d, float c, float s, float m) {

    if (!boom) {
      loc = new PVector (random(width), random(height));
    } else {
      loc = new PVector (random(width / 2 - 100, width / 2 + 100), random(height / 2 - 100, height / 2 + 100));
    }
    vel = new PVector (random(-5, 5), random(-5, 5));
    acc = new PVector ();
    pseudoloc = loc;

    coatt = c;
    specie = #EAEA0E;
    index = 0; 

    sight = s;
    minsig = m;

    diplomacy = d;
    // diplomacy = new float [] {0.4, -1.3, 1, 1, 1, -1, -1.4};
  }


  void move() {

    PVector crow = crowded();
    PVector inter = interact();

    inter.mult(coatt);

    acc.add(crow.mult(1.3));
    acc.add(inter);

    vel.add(acc);
    if (vel.mag() > threshold) {
      pseudoloc.add(vel);
    }
    vel.mult(0.999); //qui
    acc.mult(0);
  }

  PVector crowded() {//return PVector
    PVector closep = new PVector();
    int counter = 0;

    for (particle p : population) {
      if (p != this) {

        float d = dist(loc.x, loc.y, p.loc.x, p.loc.y);

        if (d <= minsig + radius && d != 0) {
          counter++;
          PVector diff = PVector.sub(loc, p.loc);
          diff.div(d * d);
          closep.add(diff);
        }
      }
    }

    if (counter > 0) {
      closep.setMag(maxvel * 1.5);
      closep.sub(vel);
      closep.limit(maxfor * 3);
      closep.div(counter);
    }
    return closep;
  }


  PVector interact() {
    int counter = 0;
    PVector inte = new PVector();
    for (particle p : population) {
      if (p != this) {

        float d = dist(loc.x, loc.y, p.loc.x, p.loc.y);

        if (d <= sight && d >= minsig + radius && d!= 0) {
          counter++;
          PVector diff = PVector.sub(p.loc, loc);
          diff.div(d * d);
          diff.mult(diplomacy[p.index]);
          inte.add(diff);
        }
      }
    }

    if (counter > 0) {
      inte.setMag(maxvel);
      inte.sub(vel);
      inte.limit(maxfor);
      inte.div(counter);
    }
    return inte;
  } 

  void edge() {
    if (loc.x < 0 || loc.x > width) {
      loc.x = random(width);
    }

    if (loc.y < 0 || loc.y > width) {
      loc.y = random(height);
    }

    //loc.x = constrain(loc.x, 0, width);
    //loc.y = constrain(loc.y, 0, height);
    //if (loc.x < 0) {
    //  loc.x = width;
    //} else if (loc.x > width) {
    //  loc.x = 0;
    //}

    //if (loc.y < 0) {
    //  loc.y = height;
    //} else if (loc.y > height) {
    //  loc.y = 0;
    //}

    //if ((loc.x < 0 || loc.x > width) || (loc.y < 0 || loc.y > width)) {
    // vel.x *= -1;
    // vel.y *= -1;
    //}
  }

  void create() {
    edge();
    loc = pseudoloc; 
    fill(specie);
    circle(loc.x, loc.y, radius);
  }
}
