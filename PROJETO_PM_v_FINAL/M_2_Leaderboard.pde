// ############################################################################################################### //
// ************************************           LEADERBOARD MENU           ************************************* //
// ############################################################################################################### //
final class Leaderboard_Menu extends Menu {
  private ArrayList<String> player_A = new ArrayList();
  private ArrayList<String> player_B = new ArrayList();
  private ArrayList<String> player_C = new ArrayList();

  private String name_A, name_B, name_C;
  private PImage img_A, img_B, img_C;
  private String mode_A, mode_B, mode_C;
  private String grid_A, grid_B, grid_C;
  private String moves_A, moves_B, moves_C;
  private String timer_A, timer_B, timer_C;

  private String winner_3x3, winner_4x4, winner_5x5;

  private int[] sec = new int[3];
  private int[] min = new int[3];

  private boolean infoState;

  Leaderboard_Menu() {
    image = new PImage[3];

    for (int i = 0; i<image.length; i++) {
      image[i] = loadImage("data/Menu Files/Images/leaderBoard_"+i+".png");
    }
    image[0].resize(width, height);
    image[1].resize(150, 120);
    image[2].resize(150, 120);

    infoState = true;

    mode_A = "";
    mode_B = "";
    mode_C = "";

    winner_3x3 = "---";
    winner_4x4 = "---";
    winner_5x5 = "---";
  }
  public void display() {
    surface.setTitle("FIFTEEN PUZZLE |                                                 Leaderboard");

    if (infoState) setInfo();
    if (game.data.profileFinalised && game.data.firstProfileExist || game.data.profileFinalised && game.data.secondProfileExist 
      || game.data.profileFinalised && game.data.thirdProfileExist || game.data.profileFinalised ) 
      findFirstPlace();

    imageMode(CORNER);
    image(image[0], 0, 0);
    buttom(67, 60, image[1], image[2], 0.001);  //********Return button*******//

    textSize(20);
    textAlign(CENTER);
    imageMode(CENTER);

    text("3x3", width/2, 315);
    text("4x4", width/2, 408);
    text("5x5", width/2, 495);

    textSize(13);
    textAlign(CORNER);
    fill(0);

    if (game.data.firstProfileExist && game.data.secondProfileExist && game.data.thirdProfileExist) {
      if (winner_3x3.equals(timer_A)) {
        image(img_A, 232, 347);
        text(name_A, 270, 344);
      } else if (winner_3x3.equals(timer_B)) {
        image(img_B, 232, 347);
        text(name_B, 270, 344);
      } else if (winner_3x3.equals(timer_C)) {
        image(img_C, 232, 347);
        text(name_C, 270, 344);
      }
      text(winner_3x3, 270, 366);

      if (winner_4x4.equals(timer_A)) {
        image(img_A, 232, 440);
        text(name_A, 270, 437);
      } else if (winner_4x4.equals(timer_B)) {
        image(img_B, 232, 440);
        text(name_B, 270, 437);
      } else if (winner_4x4.equals(timer_C)) {
        image(img_C, 232, 440);
        text(name_C, 270, 437);
      }
      text(winner_4x4, 270, 459);  

      if (winner_5x5.equals(timer_A)) {
        image(img_A, 232, 527);
        text(name_A, 270, 525);
      } else if (winner_5x5.equals(timer_B)) {
        image(img_B, 232, 527);
        text(name_B, 270, 525);
      } else if (winner_5x5.equals(timer_C)) {
        image(img_C, 232, 527);
        text(name_C, 270, 525);
      }
      text(winner_5x5, 270, 546);
    } else {
      textAlign(CENTER);
      text("No data found", width/2, height/2+50);
    }

    textSize(30);
  }

  void setInfo() {
    infoState = false;   
    if (game.data.firstProfileExist && game.data.profileFinalised) {
      player_A = game.data.get_Player('A');
      name_A = player_A.get(0);
      img_A = loadImage(player_A.get(1));
      img_A.resize(50, 50);
      mode_A = player_A.get(2);
      grid_A = player_A.get(3);
      moves_A = player_A.get(4);
      timer_A = player_A.get(5);

      String[] temp1 = new String[2];
      temp1 = split(timer_A, ":");
      min[0] = int(temp1[0]);
      sec[0] = int(temp1[1]);
    }
    if (game.data.secondProfileExist && game.data.profileFinalised) {
      player_B = game.data.get_Player('B');
      name_B = player_B.get(0);
      img_B = loadImage(player_B.get(1));
      img_B.resize(50, 50);
      mode_B = player_B.get(2);
      grid_B = player_B.get(3);
      moves_B = player_B.get(4);
      timer_B = player_B.get(5);

      String[] temp2 = new String[2];
      temp2 = split(timer_B, ":");
      min[1] = int(temp2[0]);
      sec[1] = int(temp2[1]);
    }
    if (game.data.thirdProfileExist && game.data.profileFinalised) {
      player_C = game.data.get_Player('C');
      name_C = player_C.get(0);
      img_C = loadImage(player_C.get(1));
      img_C.resize(50, 50);
      mode_C = player_C.get(2);
      grid_C = player_C.get(3);
      moves_C = player_C.get(4);
      timer_C = player_C.get(5);

      String[] temp3 = new String[2];
      temp3 = split(timer_C, ":");
      min[2] = int(temp3[0]);
      sec[2] = int(temp3[1]);
    }
  }

  public void findFirstPlace() {
    // ************************** CASO APENAS UM JOGADOR TENHA ESCOLHIDO O MODO TIME TRIAL ************************** //
    if (mode_A.equals("timeTrial") && !mode_B.equals("timeTrial") && !mode_C.equals("timeTrial")) {
      if (grid_A.equals("3")) winner_3x3 = timer_A;
      else if (grid_A.equals("4")) winner_4x4 = timer_A;
      else winner_5x5 = timer_A;
    } else if (mode_B.equals("timeTrial") && !mode_A.equals("timeTrial") && !mode_C.equals("timeTrial")) {
      if (grid_B.equals("3")) winner_3x3 = timer_B;
      else if (grid_B.equals("4")) winner_4x4 = timer_B;
      else winner_5x5 = timer_B;
    } else if (mode_C.equals("timeTrial") && !mode_B.equals("timeTrial") && !mode_A.equals("timeTrial")) {
      if (grid_C.equals("3")) winner_3x3 = timer_C;
      else if (grid_C.equals("4")) winner_4x4 = timer_C;
      else winner_5x5 = timer_C;
    } else {
      // ************************** CASO DOIS JOGADORES TENHAM ESCOLHIDO O MODO TIME TRIAL ************************** //
      if (mode_A.equals("timeTrial") && mode_B.equals("timeTrial") && !mode_C.equals("timeTrial")) { // CASO A/B

        if (grid_A.equals("3") && grid_B.equals("3")) { // CASO 3X3
          if (min[0] > min[1]) winner_3x3 = timer_A;
          else if (min[0] < min[1]) winner_3x3 = timer_B;
          else {
            if (sec[0] > sec[1]) winner_3x3 = timer_A;
            else winner_3x3 = timer_B;
          }
        } else if (grid_A.equals("4") && grid_B.equals("4")) { // CASO 4X4
          if (min[0] > min[1]) winner_4x4 = timer_A;
          else if (min[0] < min[1]) winner_4x4 = timer_B;
          else {
            if (sec[0] > sec[1]) winner_4x4 = timer_A;
            else winner_4x4 = timer_B;
          }
        } else if (grid_A.equals("5") && grid_B.equals("5")) { // CASO 5X5
          if (min[0] > min[1]) winner_5x5 = timer_A;
          else if (min[0] < min[1]) winner_5x5 = timer_B;
          else {
            if (sec[0] > sec[1]) winner_5x5 = timer_A;
            else winner_5x5 = timer_B;
          }
        } else {  // CASO GRIDS DIFERENTES

          if (grid_A.equals("3")) winner_3x3 = timer_A;
          else if (grid_A.equals("4")) winner_4x4 = timer_A;
          else winner_5x5 = timer_A;

          if (grid_B.equals("3")) winner_3x3 = timer_B;
          else if (grid_B.equals("4")) winner_4x4 = timer_B;
          else winner_5x5 = timer_B;
        }
      } else if (mode_A.equals("timeTrial") && !mode_B.equals("timeTrial") && mode_C.equals("timeTrial")) { // CASO A/C

        if (grid_A.equals("3") && grid_C.equals("3")) { // CASO 3X3
          if (min[0] > min[2]) winner_3x3 = timer_A;
          else if (min[0] < min[2]) winner_3x3 = timer_C;
          else {
            if (sec[0] > sec[2]) winner_3x3 = timer_A;
            else winner_3x3 = timer_C;
          }
        } else if (grid_A.equals("4") && grid_B.equals("4")) { // CASO 4X4
          if (min[0] > min[2]) winner_4x4 = timer_A;
          else if (min[0] < min[2]) winner_4x4 = timer_C;
          else {
            if (sec[0] > sec[2]) winner_4x4 = timer_A;
            else winner_4x4 = timer_C;
          }
        } else if (grid_A.equals("5") && grid_C.equals("5")) { // CASO 5X5
          if (min[0] > min[2]) winner_5x5 = timer_A;
          else if (min[0] < min[2]) winner_5x5 = timer_C;
          else {
            if (sec[0] > sec[2]) winner_5x5 = timer_A;
            else winner_5x5 = timer_C;
          }
        } else {  // CASO GRIDS DIFERENTES
          if (grid_A.equals("3")) winner_3x3 = timer_A;
          else if (grid_A.equals("4")) winner_4x4 = timer_A;
          else winner_5x5 = timer_A;

          if (grid_C.equals("3")) winner_3x3 = timer_C;
          else if (grid_B.equals("4")) winner_4x4 = timer_C;
          else winner_5x5 = timer_C;
        }
      } else if (!mode_A.equals("timeTrial") && mode_B.equals("timeTrial") && mode_C.equals("timeTrial")) { // CASO B/C

        if (grid_B.equals("3") && grid_C.equals("3")) { // CASO 3X3
          if (min[1] > min[2]) winner_3x3 = timer_B;
          else if (min[0] < min[2]) winner_3x3 = timer_C;
          else {
            if (sec[1] > sec[2]) winner_3x3 = timer_B;
            else winner_3x3 = timer_C;
          }
        } else if (grid_B.equals("4") && grid_C.equals("4")) { // CASO 4X4
          if (min[1] > min[2]) winner_4x4 = timer_B;
          else if (min[1] < min[2]) winner_4x4 = timer_C;
          else {
            if (sec[1] > sec[2]) winner_4x4 = timer_B;
            else winner_4x4 = timer_C;
          }
        } else if (grid_B.equals("5") && grid_C.equals("5")) { // CASO 5X5
          if (min[1] > min[2]) winner_5x5 = timer_B;
          else if (min[1] < min[2]) winner_5x5 = timer_C;
          else {
            if (sec[1] > sec[2]) winner_5x5 = timer_B;
            else winner_5x5 = timer_C;
          }
        } else {  // CASO GRIDS DIFERENTES
          if (grid_B.equals("3")) winner_3x3 = timer_B;
          else if (grid_A.equals("4")) winner_4x4 = timer_B;
          else winner_5x5 = timer_B;

          if (grid_C.equals("3")) winner_3x3 = timer_C;
          else if (grid_B.equals("4")) winner_4x4 = timer_C;
          else winner_5x5 = timer_C;
        }
      } else {
        // ************************** CASO OS TRÊS JOGADORES TENHAM ESCOLHIDO O MODO TIME TRIAL ************************** //
        // ############################# CASO OS TRÊS TENHAM A GRID IGUAL ############################# //
        if (grid_A.equals("3") && grid_B.equals("3") && grid_C.equals("3")) { // CASO 3X3 && A=B=C
          if (min[0] > min[1] && min[0] > min[2]) winner_3x3 = timer_A;
          else if (min[1] > min[0] && min[1] > min[2]) winner_3x3 = timer_B;
          else if (min[2] > min[0] && min[2] > min[1]) winner_3x3 = timer_C;
          else {
            if (min[0] == min[1] && min[0] > min[2]) { // CASO A=B && C<A/B
              if (sec[0] > sec[1]) winner_3x3 = timer_A;
              else winner_3x3 = timer_B;
            } else if (min[0] == min[2] && min[0] > min[1]) {  // CASO A=C && B<A/C
              if (sec[0] > sec[2]) winner_3x3 = timer_A;
              else winner_3x3 = timer_C;
            } else if (min[1] == min[2] && min[1] > min[0]) {  // CASO B=C && A<B/C
              if (sec[1] > sec[2]) winner_3x3 = timer_B;
              else winner_3x3 = timer_C;
            } else {
              if (min[0] == min[1] && min[0] == min[2]) { // CASO A=B=C
                if (sec[0] > sec[1] && sec[0] > sec[2]) winner_3x3 = timer_A;
                else if (sec[1] > sec[0] && sec[1] > sec[2]) winner_3x3 = timer_B;
                else if (sec[2] > sec[0] && sec[2] > sec[1]) winner_3x3 = timer_C;            
                else {
                  int shuffle = int(random(2));
                  if (shuffle == 0) winner_3x3 = timer_A;
                  else if (shuffle == 1) winner_3x3 = timer_B;
                  else winner_3x3 = timer_C;
                }
              }
            }
          }
        }
        if (grid_A.equals("4") && grid_B.equals("4") && grid_C.equals("4")) { // CASO 4X4 && A=B=C
          if (min[0] > min[1] && min[0] > min[2]) winner_4x4 = timer_A;
          else if (min[1] > min[0] && min[1] > min[2]) winner_4x4 = timer_B;
          else if (min[2] > min[0] && min[2] > min[1]) winner_4x4 = timer_C;
          else {
            if (min[0] == min[1] && min[0] > min[2]) { // CASO A=B && C<A/B
              if (sec[0] > sec[1]) winner_4x4 = timer_A;
              else winner_4x4 = timer_B;
            } else if (min[0] == min[2] && min[0] > min[1]) {  // CASO A=C && B<A/C
              if (sec[0] > sec[2]) winner_4x4 = timer_A;
              else winner_4x4 = timer_C;
            } else if (min[1] == min[2] && min[1] > min[0]) {  // CASO B=C && A<B/C
              if (sec[1] > sec[2]) winner_4x4 = timer_B;
              else winner_4x4 = timer_C;
            } else {
              if (min[0] == min[1] && min[0] == min[2]) { // CASO A=B=C
                if (sec[0] > sec[1] && sec[0] > sec[2]) winner_4x4 = timer_A;
                else if (sec[1] > sec[0] && sec[1] > sec[2]) winner_4x4 = timer_B;
                else if (sec[2] > sec[0] && sec[2] > sec[1]) winner_4x4 = timer_C;            
                else {
                  int shuffle = int(random(2));
                  if (shuffle == 0) winner_4x4 = timer_A;
                  else if (shuffle == 1) winner_4x4 = timer_B;
                  else winner_4x4 = timer_C;
                }
              }
            }
          }
        }
        if (grid_A.equals("5") && grid_B.equals("5") && grid_C.equals("5")) { // CASO 5X5 && A=B=C
          if (min[0] > min[1] && min[0] > min[2]) winner_5x5 = timer_A;
          else if (min[1] > min[0] && min[1] > min[2]) winner_5x5 = timer_B;
          else if (min[2] > min[0] && min[2] > min[1]) winner_5x5 = timer_C;
          else {
            if (min[0] == min[1] && min[0] > min[2]) { // CASO A=B && C<A/B
              if (sec[0] > sec[1]) winner_5x5 = timer_A;
              else winner_5x5 = timer_B;
            } else if (min[0] == min[2] && min[0] > min[1]) {  // CASO A=C && B<A/C
              if (sec[0] > sec[2]) winner_5x5 = timer_A;
              else winner_5x5 = timer_C;
            } else if (min[1] == min[2] && min[1] > min[0]) {  // CASO B=C && A<B/C
              if (sec[1] > sec[2]) winner_5x5 = timer_B;
              else winner_5x5 = timer_C;
            } else {
              if (min[0] == min[1] && min[0] == min[2]) { // CASO A=B=C
                if (sec[0] > sec[1] && sec[0] > sec[2]) winner_5x5 = timer_A;
                else if (sec[1] > sec[0] && sec[1] > sec[2]) winner_5x5 = timer_B;
                else if (sec[2] > sec[0] && sec[2] > sec[1]) winner_5x5 = timer_C;            
                else {
                  int shuffle = int(random(2));
                  if (shuffle == 0) winner_5x5 = timer_A;
                  else if (shuffle == 1) winner_5x5 = timer_B;
                  else winner_5x5 = timer_C;
                }
              }
            }
          }
        }
        // ############################# CASO DOIS TENHAM A GRID IGUAL ############################# //
        // ##################################### CASO 3X3 ##################################### //
        if (grid_A.equals("3") && grid_B.equals("3") && !grid_C.equals("3")) { // CASO 3X3 && A/B
          if (min[0] > min[1]) winner_3x3 = timer_A;
          else if (min[1] > min[0]) winner_3x3 = timer_B;
          else {
            if (sec[0] > sec[1]) winner_3x3 = timer_A;
            else winner_3x3 = timer_B;
          }
        } else if (grid_A.equals("3") && !grid_B.equals("3") && grid_C.equals("3")) { // CASO 3X3 && A/C
          if (min[0] > min[2]) winner_3x3 = timer_A;
          else if (min[2] > min[0]) winner_3x3 = timer_C;
          else {
            if (sec[0] > sec[2]) winner_3x3 = timer_A;
            else winner_3x3 = timer_C;
          }
        } else if (!grid_A.equals("3") && grid_B.equals("3") && grid_C.equals("3")) {  // CASO 3X3 && B/C
          if (min[1] > min[2]) winner_3x3 = timer_B;
          else if (min[2] > min[1]) winner_3x3 = timer_C;
          else {
            if (sec[1] > sec[2]) winner_3x3 = timer_B;
            else winner_3x3 = timer_C;
          }
        } 
        // ##################################### CASO 4X4 ##################################### // 
        if (grid_A.equals("4") && grid_B.equals("4") && !grid_C.equals("4")) { // CASO 4X4 && A/B
          if (min[0] > min[1]) winner_4x4 = timer_A;
          else if (min[1] > min[0]) winner_4x4 = timer_B;
          else {
            if (sec[0] > sec[1]) winner_4x4 = timer_A;
            else winner_4x4 = timer_B;
          }
        } else if (grid_A.equals("4") && !grid_B.equals("4") && grid_C.equals("4")) { // CASO 4X4 && A/C
          if (min[0] > min[2]) winner_4x4 = timer_A;
          else if (min[2] > min[0]) winner_4x4 = timer_C;
          else {
            if (sec[0] > sec[2]) winner_4x4 = timer_A;
            else winner_4x4 = timer_C;
          }
        } else if (!grid_A.equals("4") && grid_B.equals("4") && grid_C.equals("4")) {  // CASO 4X4 && B/C
          if (min[1] > min[2]) winner_4x4 = timer_B;
          else if (min[2] > min[1]) winner_4x4 = timer_C;
          else {
            if (sec[1] > sec[2]) winner_4x4 = timer_B;
            else winner_4x4 = timer_C;
          }
        } 
        // ##################################### CASO 5X5 ##################################### // 
        if (grid_A.equals("5") && grid_B.equals("5") && !grid_C.equals("5")) { // CASO 5X5 && A/B
          if (min[0] > min[1]) winner_5x5 = timer_A;
          else if (min[1] > min[0]) winner_5x5 = timer_B;
          else {
            if (sec[0] > sec[1]) winner_5x5 = timer_A;
            else winner_5x5 = timer_B;
          }
        } else if (grid_A.equals("5") && !grid_B.equals("5") && grid_C.equals("5")) { // CASO 5X5 && A/C
          if (min[0] > min[2]) winner_5x5 = timer_A;
          else if (min[2] > min[0]) winner_5x5 = timer_C;
          else {
            if (sec[0] > sec[2]) winner_5x5 = timer_A;
            else winner_5x5 = timer_C;
          }
        } else if (!grid_A.equals("5") && grid_B.equals("5") && grid_C.equals("5")) {  // CASO 5X5 && B/C
          if (min[1] > min[2]) winner_5x5 = timer_B;
          else if (min[2] > min[1]) winner_5x5 = timer_C;
          else {
            if (sec[1] > sec[2]) winner_5x5 = timer_B;
            else winner_5x5 = timer_C;
          }
        } 
        // ############################# CASO OS TRÊS TENHAM GRIDS DIFERENTES ############################# //
        if (grid_A.equals("3")) winner_3x3 = timer_A;
        else if (grid_A.equals("4")) winner_4x4 = timer_A;
        else winner_5x5 = timer_A;

        if (grid_B.equals("3")) winner_3x3 = timer_B;
        else if (grid_B.equals("4")) winner_4x4 = timer_B;
        else winner_5x5 = timer_B;

        if (grid_C.equals("3")) winner_3x3 = timer_C;
        else if (grid_B.equals("5")) winner_4x4 = timer_C;
        else winner_5x5 = timer_C;
      }
    }
  }
}