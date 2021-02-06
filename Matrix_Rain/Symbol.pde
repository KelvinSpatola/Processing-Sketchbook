class Symbol {
  PVector pos;
  char symbol;
  color colour;
  boolean hasGlitch;

  // CONSTRUCTOR
  Symbol(int x, int y, boolean state) {
    pos = new PVector(x, y);
    symbol = (char)random(33, 127);
    hasGlitch = state;
  }

  void display() {
    if (hasGlitch) symbol = (char)random(33, 127);

     textSize(55);
     fill(colour, 20);
     text(symbol, pos.x, pos.y);

     textSize(40);
     fill(colour);
     text(symbol, pos.x, pos.y);
  }

  char getSymbol() {
    return symbol;
  }
  void setSymbol(char symbol) {
    this.symbol = symbol;
  }
}
