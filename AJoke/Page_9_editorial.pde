class Page_10 extends Page {
  PImage img;
  
  Page_10(int id) {
    super(id);

    img = loadImage("\\pag_10\\editorial.png");
  }

  void display() {
    background(255);
    push();
    tint(255);
    imageMode(CENTER);
    image(img, width/2, height/2);
    pop();
  }

}
