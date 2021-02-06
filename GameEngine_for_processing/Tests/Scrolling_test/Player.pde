public class Player {
  PVector pos;
  int size, speed;
  boolean top, bottom, l_side, r_side;

  Player() {
    pos = new PVector(width/2, height/2);
    size = 60;
    speed = 5;
  }

  public void display() {
    pushMatrix();
    translate(pos.x, pos.y);
    strokeWeight(5);
    fill(255, 0, 0);
    ellipse(0, 0, size, size);
    popMatrix();
  }

  public void move() {
    if (keyPressed) {

      if (keyCode == UP) {
        if (pos.y - size/2 <= 0) pos.add(0, 0);  // checking for borders. Restricting the top side of the canvas
        // otherwise...
        else {
          // the following line of code checks if the player is still inside the opposite border zone, meaning that if it is true,
          // then it should move the player's position instead of moving the map. This is only true while the player is in between 
          // the margin of the map - opposite to the direction chosen by the player -, and the middle of the canvas perpendicular to the same direction.
          if (fundo.hitBottom() && pos.y >= height/2) pos.sub(0, speed);
          // otherwise, if the player's position is not inside the opposite margin, then...
          else {
            //check if the player is NOT inside the margin zone related to the direction chosen by the player. 
            // If so, then move the map.
            if (!fundo.hitTop()) fundo.pos.add(0, speed);
            // otherwise, move the player's position.
            else pos.sub(0, speed);
          }
        }
      }
      if (keyCode == DOWN) {
        if (pos.y + size/2 >= height) pos.add(0, 0);  // checking for borders. Restricting the bottom side of the canvas
        // otherwise...
        else {
          if (fundo.hitTop() && pos.y <= height/2) pos.add(0, speed);
          else {
            if (!fundo.hitBottom()) fundo.pos.sub(0, speed);
            else pos.add(0, speed);
          }
        }
      }
      if (keyCode == LEFT) {
        if (pos.x - size/2 <= 0) pos.add(0, 0);  // checking for borders. Restricting the left side of the canvas
        // otherwise...
        else {
          if (fundo.hitRight() && pos.x >= width/2) pos.sub(speed, 0);
          else {
            if (!fundo.hitLeft()) fundo.pos.add(speed, 0);
            else pos.sub(speed, 0);
          }
        }
      }
      if (keyCode == RIGHT) {
        if (pos.x + size/2 >= width) pos.add(0, 0);  // checking for borders. Restricting the right side of the canvas
        // otherwise...
        else {
          if (fundo.hitLeft() && pos.x <= width/2) pos.add(speed, 0);
          else {
            if (!fundo.hitRight()) fundo.pos.sub(speed, 0);
            else pos.add(speed, 0);
          }
        }
      }
    }
  }
}
