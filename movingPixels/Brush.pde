
public static class Brush {
  static ArrayList<Pixel> movers;
  static ArrayList<PVector> originalPos;
  static int spacing = 3;

  Brush() {
  }

  public static Brush setupBrush(PImage source) {
    movers = new ArrayList();
    originalPos = new ArrayList();

    for (int x = 0; x < source.width; x++) {
      for (int y = 0; y < source.height; y++) {
        if (x % spacing == 0 && y % spacing == 0) {     
        //  movers.add(new Pixel(x, y, source.get(x, y)));
          originalPos.add(new PVector(x, y));
        }
      }
    }
    return new Brush();
  }

  int test() {
    return movers.size();
  }
}
