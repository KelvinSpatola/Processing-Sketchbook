class GameObject {
  protected PImage img;
  protected color colour;
  protected PVector location;
  protected float width_, height_;
  protected float X1, X2, Y1, Y2;

  GameObject(int w, int h) {
    this.location = new PVector();
    this.width_ = w;
    this.height_ = h;

    //X1 = location.x - w/2;
    //X2 = location.x + w/2;
    //Y1 = location.y - h/2;
    //Y2 = location.y + h/2;
  }

  public void display() {
    pushStyle();
    rectMode(CENTER);

    rect(location.x, location.y, width_, height_);
    popStyle();
  }

  //public boolean contains(Avatar t) {
  //  boolean h = (t.location.x > this.location.x - width_/2) && (t.location.x < this.location.x + width_/2);
  //  boolean v = (t.location.y > this.location.y - height_/2) && (t.location.y < this.location.y + height_/2);
  //  return (h && v);
  //}

  public boolean contains(Player t) {
    boolean up    = (t.location.y - t.size/2 > Y1);
    boolean down  = (t.location.y + t.size/2 < Y2);
    boolean left  = (t.location.x - t.size/2 > X1);
    boolean right = (t.location.x + t.size/2 < X2);
    return (up && down && left && right);
  }
  public boolean partiallyContains(Player t) {
    boolean up    = (t.location.y > Y1);
    boolean down  = (t.location.y < Y2);
    boolean left  = (t.location.x > X1);
    boolean right = (t.location.x < X2);
    return (up && down && left && right);
  }

  public boolean interceptTop(Player t) {
    return ((t.location.y + t.size/2 >= Y1 && t.location.y < Y1) && (t.location.x >= X1 - t.size/2 && t.location.x <= X2 + t.size/2));
  }
  public boolean interceptBottom(Player t) {
    if ((t.location.y - t.size/2 <= Y2 && t.location.y > Y2) && (t.location.x >= X1 - t.size/2 && t.location.x <= X2 + t.size/2)) {      
      println("bottom");
      return true;
    } else return false;
  }
  public boolean interceptLeft(Player t) {
    return ((t.location.x + t.size/2 >= X1 && t.location.x < X1) && (t.location.y >= Y1 - t.size/2 && t.location.y <= Y2 + t.size/2));
  }
  public boolean interceptRight(Player t) {
    return ((t.location.x - t.size/2 <= X2 && t.location.x > X2) && (t.location.y >= Y1 - t.size/2 && t.location.y <= Y2 + t.size/2));
  }

  public void updateValues(float x, float y) {
    X1 = x - width_/2;
    X2 = x + width_/2;
    Y1 = y - height_/2;
    Y2 = y + height_/2;
  }
}
