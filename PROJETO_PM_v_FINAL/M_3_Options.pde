// ############################################################################################################### //
// **************************************           OPTIONS MENU           *************************************** //
// ############################################################################################################### //
final class Options_Menu extends Menu {
  Options_Menu() {
    image  = new PImage[7];
    for (int i = 0; i<image.length; i++) {
      image[i] = loadImage("data/Menu Files/Images/options_"+i+".png");
    }
    image[0].resize(width, height);
    image[1].resize(220, 80);
    image[2].resize(220, 80);
    image[3].resize(220, 80);
    image[4].resize(220, 80);
    image[5].resize(150, 120);
    image[6].resize(150, 120);
  }  
  public void display() {
    surface.setTitle("FIFTEEN PUZZLE |                                                 Options");
    optionsVid.loop();

    imageMode(CORNER);
    image(optionsVid, 0, 0);
    image(image[0], 0, 0);

    image(clicked_1 ? image[1] : image[2], 190, 306);  //*******SFX button******//
    image(clicked_2 ? image[3] : image[4], 260, 406);  //*******Music button******//

    buttom(67, 60, image[5], image[6], 0.001);     //*******Return button******//
  }
}
