// ############################################################################################################### //
// ****************************************           MAIN MENU           **************************************** //
// ############################################################################################################### //
final class MainMenu_Menu extends Menu {
  
  MainMenu_Menu() {
    image  = new PImage[7];
    for (int i = 0; i<image.length; i++) {
      image[i] = loadImage("data/Menu Files/Images/mainMenu_"+i+".png");
    }
    image[0].resize(width, height);
    image[1].resize(200, 80);
    image[2].resize(200, 80);
    image[3].resize(220, 90);
    image[4].resize(220, 90);
    image[5].resize(190, 75);
    image[6].resize(190, 75);
  }
  public void display() {
    surface.setTitle("FIFTEEN PUZZLE |     Main menu");
    imageMode(CORNER);
    image(image[0], 0, 0);

    buttom(300, 313, image[1], image[2], 0.01);
    buttom(275, 410, image[3], image[4], 0);
    buttom(355, 507, image[5], image[6], 0);
  }
}