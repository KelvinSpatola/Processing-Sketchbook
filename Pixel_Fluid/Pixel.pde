
class Pixel {
  Particle particle;
  int cor;

  Pixel(float x, float y, int cor) {
    particle = physics.makeParticle(1, x, y, 0);
    this.cor = cor;
  }
  
  void display(){
    fill(cor);
    square(particle.position().x(), particle.position().y(), spacing);
  }
  
  void update(){
  
  }
}
