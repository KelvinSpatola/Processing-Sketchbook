import com.thomasdiewald.pixelflow.java.sampling.*;
import com.hamoid.*;
VideoExport videoExport;

/*final char[] charTable = new char[]{
 '0', '1', '2', '3', '4', '5', '6', '7', '8', '9', 
 'a', 'b', 'c', 'd', 'e', 'f', 'g', 'h', 'i', 'j', 'k', 'l', 'm', 
 'n', 'o', 'p', 'q', 'r', 's', 't', 'u', 'v', 'w', 'x', 'y', 'z', 
 'A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I', 'J', 'K', 'L', 'M', 
 'N', 'O', 'P', 'Q', 'R', 'S', 'T', 'U', 'V', 'W', 'X', 'Y', 'Z', 
 'à', 'á', 'â', 'ã', 'é', 'ê', 'í', 'ó', 'ô', 'õ', 'ú', 'ç', 'ñ', 
 'À', 'Á', 'Â', 'Ã', 'É', 'Ê', 'Í', 'Ó', 'Ô', 'Õ', 'Ú', 'Ç', 'Ñ', 
 };*/

/*final char[] charTable = new char[]{
 '0', '1', '2', '3', '4', '5', '6', '7', '8', '9' 
 }; */

final char[] charTable = new char[]{
  'A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I', 'J', 'K', 'L', 'M', 
  'N', 'O', 'P', 'Q', 'R', 'S', 'T', 'U', 'V', 'W', 'X', 'Y', 'Z', 
};

ArrayList<PoissonSample> samples;
int index;
boolean colored;
PImage img;

public void setup() {
  fullScreen();
  hint(DISABLE_DEPTH_TEST);
  smooth(16);
  //colorMode(HSB, 1);

  //setupVideoExport("Walking_text_2.mp4", 60, 75);

  textFont(createFont("Space Mono Bold", 50));
  textAlign(CENTER, CENTER);

  img = loadImage("img4.jpg");
  img.resize(width, height);

  generatePoissonSampling();
  index = 0;
  background(0);
}

void draw() {
  for (int i = 0; i < 5; i++) {
    if (index < samples.size()) {
      float px = samples.get(index).x();
      float py = samples.get(index).y();
      float pr = samples.get(index).rad();

      textSize(2*pr*1.2);
      push();
      translate(px, py - pr*0.4f);
      float c = norm((index % (samples.size()/2)), 0, samples.size()/2);
      rotate(map(c, 0, 1, 0, TAU*2));

      fill(img.get((int)px, (int)py));

      text(charTable[(int)random(charTable.length)], 0, -pr*0.25f);
      pop();
      index++;
    } else {      colored = !colored;
      //saveFrame("output8-######.png");
      generatePoissonSampling();
      
      if(colored) img = loadImage("img2.jpg");
      else img = loadImage("img4.jpg");
      
      img.resize(width, height);

      index = 0;
      background(0);
    }
  }
  //videoExport.saveFrame();
}

void generatePoissonSampling() {
  PoissonDiscSamping2D<PoissonSample> pds = new PoissonDiscSamping2D<PoissonSample>() {
    @Override
      public PoissonSample newInstance(float x, float y, float r, float rcollision) {
      return new PoissonSample(x, y, r, rcollision);
    }
  };

  float[] bounds = {0, 0, 0, width, height, 0};
  float rmin = 2;
  float rmax = 15;
  float roff = 0.5f;
  int new_points = 300;

  pds.setRandomSeed((long)random(100000));
  pds.generatePoissonSampling2D(bounds, rmin, rmax, roff, new_points);
  samples = pds.samples;
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
