public class GameSystem {
  private boolean isUp, isDown, isLeft, isRight;

  //public void run() {
  //  update(player, walls);
  //}

  public void setMove(int k, boolean state) {
    if (k == 'w' || k == 'W' || (k == CODED && keyCode == UP))          isUp = state;
    else if (k == 's' || k == 'S' || (k == CODED && keyCode == DOWN))   isDown = state;
    else if (k == 'a' || k == 'A' || (k == CODED && keyCode == LEFT))   isLeft = state;
    else if (k == 'd' || k == 'D' || (k == CODED && keyCode == RIGHT))  isRight = state;
  }

  public void update(DynamicEntity player, ArrayList<Entity> entities) {
    boolean hitTop = false, hitBottom = false, hitLeft = false, hitRight = false;
    int x = 0, y = 0;

    player.updateEntitySides();

    //restrainWithinCanvas(player);

    for (Entity e : entities) {
      e.updateEntitySides();

      if (player.interceptTop(e)) {
        hitTop = true;
        y = e.top - player._height/2;
        //continue;
      }
      if (player.interceptBottom(e)) {
        hitBottom = true;
        y = e.bottom + player._height/2;
        //continue;
      }
      if (player.interceptLeft(e)) {
        hitLeft = true;
        x = e.left - player._width/2;
        //continue;
      }
      if (player.interceptRight(e)) {
        hitRight = true;
        x = e.right + player._width/2;
        //continue;
      }
    }
    
    if (isUp) {
      if (hitBottom) player.location.y = y;
      else player.location.add(0, -player.speedY);
    }
    if (isDown) {
      if (hitTop) player.location.y = y;
      else player.location.add(0, player.speedY);
    }
    if (isLeft) {
      if (hitRight) player.location.x = x;
      else player.location.add(-player.speedX, 0);
    }
    if (isRight) {
      if (hitLeft) player.location.x = x;
      else player.location.add(player.speedX, 0);
    }
  }

  public void restrainWithinCanvas(DynamicEntity dEnt) {
    if (dEnt.top <= 0)         isUp = false;
    if (dEnt.bottom >= height) isDown = false;
    if (dEnt.left <= 0)        isLeft = false;
    if (dEnt.right >= width)   isRight = false;
    return;
  }

  public void setEntitiesLocation (String mapPath, ArrayList<Entity> entityList, int colour) {
    PImage mapImg = loadImage(mapPath);
    int filterColor = colour; // This is the color we want to filter from the image

    int mapLength = mapImg.pixels.length;
    int mapW = mapImg.width;
    int mapH = mapImg.height;

    int w_length = 0;
    int h_length = 0;

    int entX = 0;
    int entY = 0;
    int entW = 0;
    int entH = 0;

    ArrayList existingPixels = new ArrayList();

    mapImg.loadPixels();
    for (int currentPixel = 0; currentPixel < mapLength; currentPixel++) { // LOOP THROUGH ALL THE PIXELS IN THE MAP 

      if (mapImg.pixels[currentPixel] == filterColor && !(existingPixels.contains(currentPixel))) {  // THEN, WHEN YOU FIRST FIND A WHITE PIXEL, PAUSE THE LOOP AND START SEARCHING FOR THE NEXT WHITE PIXEL ...

        w_length = 1; // if we got here, it's because there's at least one pixel width
        for (int nextWhitePixel = (currentPixel + 1); nextWhitePixel < mapLength; nextWhitePixel++) { // HORIZONTALLY ...

          if (mapImg.pixels[nextWhitePixel] == filterColor) { // if the next pixel is white, add it to the ...          
            w_length++;
          } else {   
            entW = (w_length * width) / mapW; // resizing the calculated width to the "real world" width
            int entX_map = (currentPixel % mapW) + (w_length/2); // this is the actual x-axis coordinate of the entity in the image
            entX = (entX_map * width) / mapW; // and this is the resized and final value of the x-axis coordinate of the entity, in the "real world".
            break; // width fully calculated so, get out of this loop
          }
          // END OF CALCULATING THE ENTITY'S WIDTH.
        }


        // Because we are using only one huge for-loop to loop throgh all the pixel array, the only way to jump from one pixel to the next, vertically,
        // is by adding a whole mapImg.width (mapW). So, the nextWhitePixel will always be the currentPixel + mapW
        h_length = 1;
        for (int nextWhitePixel = (currentPixel + mapW); nextWhitePixel < mapLength; nextWhitePixel += mapW) { // VERTICALLY ...

          if (mapImg.pixels[nextWhitePixel] == filterColor) {

            int next = nextWhitePixel;
            for (int i = 0; i < w_length; i++) {
              existingPixels.add(next);
              next++;
            }

            h_length++;
          } else {
            entH = (h_length * height) / mapH;
            int entY_map = (currentPixel / mapW) + (h_length/2); 
            entY = (entY_map * height) / mapH;   
            break;
          }
          // END OF CALCULATING THE ENTITY'S HEIGHT
        }

        // FINALLY, LET'S ADD A NEW ENTITY TO THE LIST WITH ALL IT'S DATA, AND GET THE HELL OUTTA THIS METHOD
        entityList.add(new Wall(entX, entY, entW, entH));

        currentPixel += w_length;
      }
    }
  }
}
