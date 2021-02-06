
class Heart {
  ArrayList<PVector> heart = new ArrayList();
  float radius;
  int dir;
  color colour;
  float size;

  Heart(int numPoints, float radius, int dir, color c, float s) {
    for (int i = 0; i < numPoints; i++) 
      heart.add(new PVector());
      
    this.radius = radius;
    this.dir = dir;
    colour = c;
    size = s;
  }

  void render() {
    push();
    stroke(colour);
    strokeWeight(size);
    for (PVector pv : heart) point(pv.x, pv.y);
    pop();
  }

  void update() {
    float ang = (frameCount*0.001) * dir;
    float offset = TWO_PI/heart.size();

    for (int i = 0; i < heart.size(); i++) {
      float x = radius * 16 * pow(sin(ang + i * offset), 3);
      float y = -radius * (13 * cos(ang+i*offset) - 5*cos((ang+i*offset)*2) - 2*cos((ang+i*offset)*3) - cos((ang+i*offset)*4));
      heart.get(i).set(x, y);
    }
  }
}
