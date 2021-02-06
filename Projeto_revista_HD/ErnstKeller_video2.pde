class Ernst extends Prologo2 {

  Ernst(PApplet app, int id, String imgPath, String videoPath, int x, int y, int w, int h) {
    super(app, id, imgPath, videoPath);

    videoBtn = new Button(app, x, y, w, h);
    videoBtn.setBackgroundImage("/botoes/videoNormal.png", "/botoes/videoClicked.png");
  }
}
