public abstract class Entity {
  protected PVector location;
  protected int _width, _height;
  protected int left, right, top, bottom;

  // CONSTRUCTOR
  Entity() {
  }
  Entity(int x, int y, int w, int h) {
    this.location = new PVector(x, y);
    this._width = w;
    this._height = h;
    updateEntitySides();
  }

  abstract void display();

  public void updateEntitySides() {
    this.left   = (int)location.x - _width/2;
    this.right  = (int)location.x + _width/2;
    this.top    = (int)location.y - _height/2;
    this.bottom = (int)location.y + _height/2;
  }

  public boolean contains(Entity other) {
    boolean horizontal = (this.left <= other.left && this.right >= other.right);
    boolean vertical   = (this.top <= other.top && this.bottom >= other.bottom);
    return (horizontal && vertical);
  }
  public boolean partiallyContains(Entity other) {
    boolean horizontal = (this.left <= other.location.x && this.right >= other.location.x);
    boolean vertical   = (this.top <= other.location.y && this.bottom >= other.location.y);
    return (horizontal && vertical);
  }
  public boolean touch(Entity other) {
    boolean horizontal = (this.right >= other.left) && (this.left <= other.right);
    boolean vertical   = (this.bottom >= other.top) && (this.top <= other.bottom);
    return (horizontal && vertical);
  }

  public String toString() {
    return ("x: "+location.x+" | y: "+location.y+" | w: "+_width+" | h: "+_height);
  }
}

public abstract class DynamicEntity extends Entity {
  protected PVector velocity;
  protected int speedX, speedY;

  // CONSTRUCTOR
  public DynamicEntity(int x, int y, int w, int h, int speedX, int speedY) {
    super(x, y, w, h);
    this.speedX = speedX;
    this.speedY = speedY;
  }

  public boolean interceptTop(Entity other) {
    return ((this.bottom >= other.top && this.location.y < other.top) && (this.right > other.left && this.left < other.right));
  }
  public boolean interceptBottom(Entity other) {
    return ((this.top <= other.bottom && this.location.y > other.bottom) && (this.right > other.left && this.left < other.right));
  }
  public boolean interceptLeft(Entity other) {
    return ((this.right >= other.left && this.location.x < other.left) && (this.bottom > other.top && this.top < other.bottom));
  }
  public boolean interceptRight(Entity other) {
    return ((this.left <= other.right && this.location.x > other.right) && (this.bottom > other.top && this.top < other.bottom));
  }
}

public abstract class StaticEntity extends Entity {
  StaticEntity() {
    location = new PVector();
  }
  StaticEntity(int x, int y, int w, int h) {
    super(x, y, w, h);
  }
}
