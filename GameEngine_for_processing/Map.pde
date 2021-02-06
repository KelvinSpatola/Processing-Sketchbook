final class GameMap {
  private final int WIDTH;
  private final int HEIGHT;
  private final int HALF_WIDTH;
  private final int HALF_HEIGHT;

  private PVector upper_left = new PVector();
  private PVector upper_right = new PVector();
  private PVector lower_left = new PVector();
  private PVector lower_right = new PVector();

  private PVector center = new PVector();

  private float top, bottom, left_side, right_side;

  private PImage img;

  // CONSTRUCTOR
  public GameMap(String path) {
    img = loadImage(path);
    //img.resize(6000, 0);
    WIDTH = img.width;
    HEIGHT = img.height;
    HALF_WIDTH = img.width/2;
    HALF_HEIGHT = img.height/2;

    updateValues();
  }

  public void displayMap() {
    pushMatrix();
    translate(width/2, height/2);
    updateValues();
    imageMode(CENTER);
    image(img, center.x, center.y);
    popMatrix();
  }

  private void updateValues() {
    left_side  = center.x - HALF_WIDTH;
    right_side = center.x + HALF_WIDTH;
    top        = center.y - HALF_HEIGHT;
    bottom     = center.y + HALF_HEIGHT;

    center.x = (left_side + right_side)/2;
    center.y = (top + bottom)/2;

    upper_left.set(left_side, top);
    upper_right.set(right_side, top);
    lower_left.set(left_side, bottom);
    lower_right.set(right_side, bottom);
  }

  public boolean hitTop() {
    return this.top >= -height/2;
  }
  public boolean hitBottom() {
    return this.bottom <= height/2;
  }
  public boolean hitLeft() {
    return this.left_side >= -width/2;
  }
  public boolean hitRight() {
    return this.right_side <= width/2;
  }

  public float getUpperSide() {
    return top + height/2;
  }  
  public float getLowerSide() {
    return bottom + height/2;
  }  
  public float getLeftSide() {
    return left_side + width/2;
  }
  public float getRightSide() {
    return right_side + width/2;
  }
  public PVector getCenter() {
    return new PVector(center.x+width/2, center.y+height/2);
  }


  private PVector deploy(int latitude, int longitude) {
    return new PVector(center.x + latitude, center.y + longitude);
  }
  public void deploy(Coin c, int latitude, int longitude) {
    c.location = deploy(latitude + width/2, longitude + height/2);
  }
  public void deploy(GameObject o, int latitude, int longitude) {
    o.location = deploy(latitude + width/2, longitude + height/2);
    o.updateValues(latitude, longitude);
  }
  public void deploy(Player t, float latitude, float longitude, float x, float y) {
    if (latitude  <= left_side + width/2)  latitude = left_side + width/2;
    if (latitude  >= right_side - width/2) latitude = (right_side - width/2);
    if (longitude <= top + height/2)       longitude = top + height/2;
    if (longitude >= bottom - height/2)    longitude = bottom - height/2;
    center.set(-latitude, -longitude);
    t.location.set(x, y);
    updateValues();
  }
}
