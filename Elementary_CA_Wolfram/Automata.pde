class automata {

  boolean [] rules;
  boolean [] gen;
  boolean rand;

  automata(boolean [] r, boolean ran) {
    rules = r;
    rand = ran;
    int mid = cols / 2;
    gen = new boolean [cols];

    if (!rand) {
      for (int i = 0; i < cols; i++) {
        gen[i] = i == mid;
      }
    } else {
      for (int i = 0; i < cols; i++) {
        gen[i] = random (1) >= 0.5;
      }
    }
    pass();
  }

  void run() {
    boolean [] newgen = new boolean [cols];
    for (int i = 0; i < cols; i++) {
      if (thoroidal) {
        int l = i - 1 < 0 ? cols - 1 : i - 1;
        int r = i + 1 >= cols ? 0 : i + 1;
        newgen [i] = check(gen[l], gen[i], gen[r]);
        //newgen [i] = check(gen[l], gen[i], gen[r]);
      }
    }
    gen = newgen;
    pass();
  }


  boolean check(boolean l, boolean u, boolean r) {
    if (l && u && r) {
      return rules[0];
    } else if (l && u && !r) {
      return rules[1];
    } else if (l && !u && r) {
      return  rules[2];
    } else if (l && !u && !r) {
      return  rules[3];
    } else if (!l && u && r) {
      return rules[4];
    } else if (!l && u && !r) {
      return rules[5];
    } else if (!l && !u && r) {
      return rules[6];
    } else {
      return rules[7];
    }
  }

  boolean [] pass() {
    return gen;
  }
}
