class LastPage extends Page{

  LastPage(PApplet app, int id, String imgPath) {
    super(app, id, imgPath);
  }

  void display() {
    pushStyle();
    tint(255, alpha);
    image(bgImg, x, y, PAGE_W, PAGE_H);

    textAlign(CENTER, CENTER);
    textSize(30);
    fill(0);
    text(getId(), width - 30, height - 30);

    //previousPage.display();
  }
}
