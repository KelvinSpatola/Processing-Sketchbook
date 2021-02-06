class Indice extends Page {

  Indice(PApplet app, int id, String imgPath) {
    super(app, id, imgPath);

    //float hh = height - 200;
    //for (int i = 0; i < indexesBtns.length; i++) {
    //  indexesBtns[i] = new Button(app, width/2, (int)(100 + hh/indexesBtns.length * i), 200, 50);
    //  indexesBtns[i].setBackgroundColor(color(255, 0));
    //  indexesBtns[i].setText(pageNames[i], pageNames[i], 30, color(0), color(#FF2121));
    //}
  }

  void display() {
    //if (isSlidingIn) slideIn();

    pushStyle();
    tint(255, alpha);
    image(bgImg, x, y, PAGE_W, PAGE_H);

    textAlign(CENTER, CENTER);
    textSize(50);
    fill(0);
    text(getId(), width - 50, height - 50);

    popStyle();
    
    //previousPage.display();
    //nextPage.display();
  }
  //void resetPage() {
  //  isClicked = false;
  //}
}
