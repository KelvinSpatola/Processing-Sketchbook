
/*
 * TODO: 
 */

import com.hamoid.*;
VideoExport videoExport;

final char[] charTable = new char[]{
  '0', '1', '2', '3', '4', '5', '6', '7', '8', '9', 
  'a', 'b', 'c', 'd', 'e', 'f', 'g', 'h', 'i', 'j', 'k', 'l', 'm', 
  'n', 'o', 'p', 'q', 'r', 's', 't', 'u', 'v', 'w', 'x', 'y', 'z', 
  'A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I', 'J', 'K', 'L', 'M', 
  'N', 'O', 'P', 'Q', 'R', 'S', 'T', 'U', 'V', 'W', 'X', 'Y', 'Z', 
  'à', 'á', 'â', 'ã', 'é', 'ê', 'í', 'ó', 'ô', 'õ', 'ú', 'ç', 'ñ', 
  'À', 'Á', 'Â', 'Ã', 'É', 'Ê', 'Í', 'Ó', 'Ô', 'Õ', 'Ú', 'Ç', 'Ñ', 
};

int rows, cols;
int tileSize = 20;
int worldWidth, worldHeight;
float[][] terrain; // heights along the Z axis
char[][] letters;
float flyingSpeed;
float noiseDetail = 0.015;
int charSize = 20;

color bgColor = #FFFFFF;
color charColor = #000000;


void setup() {
  fullScreen(P3D);
  hint(DISABLE_DEPTH_TEST);

  worldWidth = 3200;
  worldHeight = 2500;
  cols = worldWidth / tileSize;
  rows = worldHeight / tileSize;

  terrain = new float[cols][rows];
  letters = new char[cols][rows];

  //String[] txt = loadStrings("texto.txt");
  for (int y = 0; y < rows; y++) 
    for (int x = 0; x < cols; x++) {
      //letters[x][y] = txt[y].charAt(x);
      letters[x][y] = charTable[(int)random(charTable.length)];
    }

  textFont(createFont("Space Mono Bold", charSize));
  textAlign(CENTER, CENTER);

  //setupVideoExport("Terrain_3D_v4_TEXT-c.mp4", 60, 60);
}

void draw() {
  float yoff = flyingSpeed;
  for (int y = 0; y < rows; y++) {
    float xoff = 0;
    for (int x = 0; x < cols; x++) {
      terrain[x][y] = map(noise(xoff, yoff), 0, 1, -200, 200);
      xoff += noiseDetail;
    }
    yoff += noiseDetail;
  }
  flyingSpeed -= noiseDetail/2; // use (noiseDetail/4) for recording

  background(bgColor);
  translate(width/2, height/2, width/4 + zView);
  //rotateX(PI/3.76); //y = 253
  //rotateZ(PI/9.95); //x = 767
  rotateX(map(mouseY, 0, height, PI/2, -PI/2)); //253
  rotateZ(map(mouseX, 0, width, PI/2, -PI/2)); //767
  translate(-worldWidth/2, -worldHeight/2);

  float alpha = 255;
  float waveSwing = cos(frameCount * 0.03) * 50;  

  for (int y = 0; y < rows-2; y++) {
    if (y <= rows/2) alpha = map(y, 0, rows/2, 0, 255);

    for (int x = 0; x < cols; x++) {
      float slope = terrain[x][y+2] - terrain[x][y];
      float tiltAngle = map(slope, -1, 1, -PI/40, PI/40);

      push();
      translate(tileSize * x, (tileSize * y + waveSwing), terrain[x][y]);
      rotateX(tiltAngle);
      fill(charColor, alpha);
      text(letters[x][y], 0, 0, 0);
      pop();
    }
  }

  //videoExport.saveFrame();
  println((int)frameRate);
 /* if (frameCount >= 3600) {
    videoExport.endMovie();
    exit();
  }*/
}

float zView = 0;
void mouseWheel(MouseEvent event) {
  zView -= event.getCount() * 20;
}


void keyPressed() {
  if (key == ' ') save("hi-res_output_"+frameCount+".png");
  if (key == 'q') {
    videoExport.endMovie();
    exit();
  }
}

void setupVideoExport(String fileName, int fps, int quality) {
  videoExport = new VideoExport(this, fileName);
  videoExport.setDebugging(false);
  videoExport.setFrameRate(fps);
  videoExport.setQuality(quality, 0);
  videoExport.startMovie();
}
