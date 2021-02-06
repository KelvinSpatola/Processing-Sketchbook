public class EndAnimation {
  private PImage[] img;
  private boolean show, displayButtom;
  private int index;
  private ArrayList<File> imageFolder = new ArrayList();
  private int timer = 0;

  // CONSTRUTOR
  public EndAnimation(int num) {
    game.status2 = false;
    img = new PImage[num+1];
    index = 0;
    load();
  }
  public void run() {
    surface.setSize(600, 600);
    imageMode(CORNER);

    if (show) {
      if (index == img.length-1) timer+=3;
      else timer += 10;

      if (index == 0) image(img[0], 0, 0);
      else image(img[index-1], 0, 0);

      tint(255, timer);
      image(img[index], 0, 0);
      tint(255);

      if (index == img.length-1 && timer >= 600) {
        index = 0;
        displayButtom = true;
      } else {
        if (index < img.length-1 && timer >= 255) {
          index++;
          game.music.playSFX("swap");
          timer = 0;
        }
      }
      if (displayButtom) {
        textSize(24);
        fill(isInside(545, 565, 89, 30)? color(255, 180) : color(255, 80));
        text("Continue", 519, 575);
      }
    }
  }
  public boolean isInside(float x, float y, float w, float h) {
    return (mouseX > x-w/2 && mouseX < x+w/2 && mouseY > y-h/2 && mouseY < y+h/2);
  }
  public void load() {
    for (int i = 0; i<img.length; i++) {
      String fileName = dataPath(sketchPath()+"/data/Menu Files/Saved Files/Puzzle Files/Video/img_"+i+".jpg");
      img[i] = loadImage(fileName);
      imageFolder.add(new File(fileName));
    }
    println("*************************\nLOAD FINSHED\n*************************");
    show = true;
  }
  public void eraseImgeFolder() {
    for (File f : imageFolder) {
      if (f.exists()) {
        f.delete();
      }
    }
  }
}
