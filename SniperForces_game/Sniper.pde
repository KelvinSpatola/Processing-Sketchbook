class SniperRifle {
  int numBullets;
  boolean fire;
  int timer;
  Crosshair crosshair;
  TargetListHandler targetList;
  AudioPlayer shotSFX, zoomSFX;// rewardSFX;


  // CONSTRUCTOR
  SniperRifle(PApplet app, TargetListHandler targetList) {
    myMinim = new Minim(app);
    shotSFX = myMinim.loadFile("Sniper_fire1.mp3");
    //rewardSFX = myMinim.loadFile("Reward.mp3");

    this.targetList = targetList;
    crosshair = new Crosshair();
  }

  void display() {
    if (fire) { 
      timer++;

      if (timer >= 5) {
        timer = 0;
        fire = false;
        return;
      } else  crosshair.recoil();
    } else crosshair.pos.set(mouseX, mouseY);

    crosshair.display();
  }

  void shoot() {    
    shotSFX.rewind();
    shotSFX.play();
    fire = true;

    if (crosshair.hasTargetOnSight()) {
      crosshair.getTargetOnSight().kill();
    }
  }

  void changeZoom() {
    crosshair.zoomIn();
  }


  // *************************************************************** //
  // **********              CROSSHAIR CLASS              ********** //
  // *************************************************************** //
  class Crosshair {
    PImage defaultCrosshair, telescopicSight;
    PVector pos;
    int zoomLevel;


    // CONSTRUCTOR
    Crosshair() {
      defaultCrosshair = loadImage("Crosshair_default.png");
      telescopicSight = loadImage("Sniper_scope1.png");
      //telescopicSight.resize(390, 390);
      textFont(createFont("Gotham light", 15));
      pos = new PVector();
    }

    void display() {
      pushStyle();
      imageMode(CENTER);

      if (zoomLevel == 0) image(defaultCrosshair, pos.x, pos.y, 100, 100);
      else {
        image(telescopicSight, pos.x, pos.y);
        fill(0);
        text("Zoom x"+zoomLevel*2, pos.x-140, pos.y-10);
      }
      popStyle();
    }

    boolean hasTargetOnSight() {
      for (Target t : targetList.getTargets()) {
        float d = dist(pos.x, pos.y, t.pos.x, t.pos.y);
        if (d <= t.size/2) return true;
      }
      return false;
    }

    Target getTargetOnSight() {
      for (Target t : targetList.getTargets()) {
        float d = dist(pos.x, pos.y, t.pos.x, t.pos.y);
        if (d <= t.size/2) return t;
      }
      return null;
    }

    void zoomIn() {
      if (zoomLevel >= 2) zoomLevel = 0;
      else zoomLevel++;
      println("Zoom Level: "+zoomLevel);
    }

    void recoil() {
      if (zoomLevel == 0)        pos.set(mouseX+random(-20, 20), mouseY+random(-20, 20));
      else if (zoomLevel == 1) pos.set(mouseX+random(-50, 50), mouseY+random(-50, 50));
      else if (zoomLevel == 2) pos.set(mouseX+random(-100, 100), mouseY+random(-100, 100));
    }
  }
}
