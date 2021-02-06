class Star extends Mover {
  float rMaior, rMenor, N_pontas, alfa, rot;
  boolean clockwise;

  Star(float size) {
    super(size);
    xoff = 0;
    yoff = 10000;

    rMaior = size/2;
    rMenor= rMaior/2;
    N_pontas = 5;
    alfa = TAU/N_pontas;
    rot = random(TAU);
    clockwise = random(1) < 0.5;
    type = 1;
  }

  Mover display() { 
    if (dying) stroke(strokeLifespan);
    else {
      rot += clockwise ? radians(10) : -radians(10);
      noStroke();
    }
    fill(c, colorLifespan);

    push();
    translate(x, y);
    rotate(rot);
    beginShape();
    for (int i = 0; i<N_pontas; i++) {
      vertex(rMenor * cos(i * alfa), rMenor * sin(i * alfa));
      vertex(rMaior * cos(i * alfa + alfa/2), rMaior * sin(i * alfa + alfa/2));
    }
    endShape(CLOSE);
    pop();
    return this;
  }
}
