class Piece {
  private PImage img, empImg;
  private PVector pos;
  private boolean exist;
  private int index;
  public int size;

  // CONSTRUTORES
  public Piece() {
  }
  public Piece (PImage slice, float x, float y, int index, boolean exist) {
    empImg = loadImage("data/Menu Files/Images/emptySpace.png");
    this.img = slice;
    this.pos = new PVector(x, y);
    this.index = index;
    this.exist = exist;
    this.size = img.width;
  }
  public Piece copy() {    
    Piece p = new Piece();
    p.img = this.img.copy();
    p.pos = this.pos.copy();
    p.index = this.index;
    p.exist = this.exist;
    p.size = this.size;
    p.empImg = this.empImg;
    return p;
  }
  public void setImage(PImage img) {
    this.img = img;
  }
  public PImage getImage() {
    return this.img;
  }
  public void setExist(boolean exist) {
    this.exist = exist;
  }
  public boolean getExist() {
    return this.exist;
  }
  public void setPosition(PVector pos) {
    this.pos = pos;
  }
  public PVector getPosition() {
    return this.pos;
  }
  public void setIndex(int index) {
    this.index = index;
  }
  public int getIndex() {
    return this.index;
  }
  public void setSize(int size) {
    this.size = size;
  }
  public int getSize() {
    return this.size;
  }
  float ang = 0;
  boolean rotate =false;
  void display() {
    rectMode(CORNER);
    imageMode(CENTER);
    if (exist) {     
      pushMatrix();
      translate(pos.x+img.width/2, pos.y+img.height/2);
      rotate(ang);
      image(img, 0, 0, size, size);
      popMatrix();
      if (rotate) ang+=radians(20);
      else ang = 0;

      stroke(0);
      strokeWeight(3);
      noFill();
      rect(pos.x, pos.y, img.width, img.height);
    } else {
      imageMode(CORNER);
      image(empImg, pos.x, pos.y, size, size);
    }
  }
}