class Text {
  String txt;
  PVector pos;
  float speed, size;
  final float minSpeed = 1;
  final float maxSpeed = 100;
  final float minSize  = 5;
  final float maxSize  = 65;


  // CONSTRUCTOR
  Text(String txt) { 
    this.txt = txt;
    pos = new PVector(random(-width*1.4, width*1.4), random(-height*1.4, height*1.4), -width);
  }

  void update() {
    speed = map(pos.z, -width, width, minSpeed, maxSpeed);
    pos.z += speed;     
    size = map(pos.z, -width, width, minSize, maxSize);
  }

  void display() {
    float alpha = map(pos.z, -width, 0, 0, 255);
    textSize(size);
    /*
    fill(fontColor, alpha/3);
     text(txt, pos.x, pos.y, pos.z - map(speed, minSpeed, maxSpeed, 0, 30));
     
     fill(fontColor, alpha/2);
     text(txt, pos.x, pos.y, pos.z - map(speed, minSpeed, maxSpeed, 0, 15));
     */
    fill(fontColor, alpha);
    text(txt, pos.x, pos.y, pos.z);
  }
}
