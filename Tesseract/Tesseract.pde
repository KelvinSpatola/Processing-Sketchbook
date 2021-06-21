// Adapted from https://learnopengl.com/Advanced-OpenGL/Stencil-testing

Box[] box = new Box[200];

void setup() {
  fullScreen(P3D);
  for (int i = 0; i < box.length; i++) {
    int cor = color(0, map(i, 0, box.length-1, 255, 0), random(255));
    box[i] = new Box(cor);
  }
  noStroke();
}

void draw() {
  background(0);
  lights();

  PGL pgl = beginPGL();
  pgl.enable(PGL.STENCIL_TEST);
  pgl.stencilOp(PGL.KEEP, PGL.KEEP, PGL.REPLACE); 
  pgl.stencilMask(0);   

  pgl.stencilFunc(PGL.ALWAYS, 1, 255); 
  pgl.stencilMask(255);
  {
    box[0].draw(1);
  }
  flush(); // Flush the geometry drawn until now to the GPU 

  pgl.stencilFunc(PGL.NOTEQUAL, 1, 255);
  pgl.stencilMask(0);
  pgl.disable(PGL.DEPTH_TEST);
  noLights(); // Disable lights because the outline does not have lighting
  {
    for (int i = 1; i < box.length; i++) box[i].draw(i);
  }
  pgl.stencilMask(255);
  endPGL();

  println((int) frameRate);
}

class Box {
  int cor;

  Box(int cor) {
    this.cor = cor;
  }

  void draw(float scl) {
    push();
    translate(width/2, height/2);
    rotateX(0.01 * frameCount);
    rotateY(0.01 * frameCount);
    scale(scl);
    fill(cor);
    box(box.length/50);
    pop();
  }
}
