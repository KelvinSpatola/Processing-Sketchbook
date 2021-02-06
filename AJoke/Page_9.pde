class Page_9 extends Page {
  PImage img;
  
  Page_9(int id) {
    super(id);

    img = loadImage("\\pag_9\\the end.png");
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
