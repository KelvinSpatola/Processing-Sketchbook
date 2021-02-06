class Stream {
  Symbol[] symbols;
  PImage light;
  int x;
  color low = color(0, 255, 65);
  int high = color(200, 255, 200);
  int symbolHeight = ceil(38 * 0.8);
  int randFps;

  // CONSTRUCTOR
  Stream(int numSymbols, int x, int y, int randFps) {
    symbols = new Symbol[numSymbols];
    this.x = x;
    this.randFps = randFps;

    for (int i = 0; i < symbols.length; i++) {
      symbols[i] = new Symbol(x, (i * -symbolHeight)+y, (i%15 == 0));
      symbols[i].colour = low;
    }
    for (int i = symbols.length-15; i < symbols.length; i++) 
      symbols[i].colour = lerpColor(low, color(0, 0), map(i, symbols.length-15, symbols.length, 0, 1));

    for (int i = 0; i < 5; i++) symbols[i].colour = lerpColor(high, low, map(i, 0, 4, 0, .6));

    light = loadImage("light.png");
    light.resize(symbolHeight+15, 0);
  }


  boolean change;
  void scroll() {
    for (int i = 1; i < symbols.length; i++) {
      tint(lerpColor(color(0, 143, 17, 40), color(0, 0), map(i, 1, symbols.length, 0, .5)));
      image(light, symbols[i].pos.x, symbols[i].pos.y, light.width-20, light.height-5);

      tint(lerpColor(color(0, 143, 17, 20), color(0, 0), map(i, 1, symbols.length, 0, .5)));
      image(light, symbols[i].pos.x, symbols[i].pos.y, light.width-10, light.height-5);
    }

    if (frameCount % randFps == 0) change = !change;
    if (change) {
      tint(color(200, 255, 200, random(255)));
      image(light, symbols[0].pos.x, symbols[0].pos.y, light.width-15, light.height-5);
    }

    for (int i = 0; i < symbols.length; i++) {
      symbols[i].display();
      if (frameCount % 3 == 0) symbols[i].pos.y += symbolHeight ;
    }
    if (frameCount % 3 == 0) swapSymbols();
  }

  boolean isFinished() {
    return (symbols[symbols.length-1].pos.y >  height);
  }

  void swapSymbols() {
    char[] tempChar = new char[symbols.length];

    for (int i = 0; i < tempChar.length; i++) {
      if (i == 0) tempChar[0] = (char)random(33, 127);
      else tempChar[i] = symbols[i-1].getSymbol();
    }

    for (int i = 0; i < symbols.length; i++) symbols[i].setSymbol(tempChar[i]);
  }
}
