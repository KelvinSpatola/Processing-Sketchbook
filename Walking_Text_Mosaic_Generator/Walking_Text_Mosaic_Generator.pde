import com.thomasdiewald.pixelflow.java.sampling.*;
import kelvinclark.utils.SaveHiRes;


final char[] charTable = new char[]{
  'A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I', 'J', 'K', 'L', 'M', 
  'N', 'O', 'P', 'Q', 'R', 'S', 'T', 'U', 'V', 'W', 'X', 'Y', 'Z', 
};

ArrayList<PoissonSample> samples;
SaveHiRes hires;
float sclSrcImg = 1f;
float OUTPUT_SCL = 5f;


void setup() {
  PImage img = loadImage("QUA - Kelvin Spátola.png");
  img.resize(int(img.width * sclSrcImg), int(img.height * sclSrcImg));
  width = img.width;
  height = img.height;
  //width = displayWidth;
  //height = displayHeight;

  hires = SaveHiRes.createRecord(this, OUTPUT_SCL);
  smooth(16);

  if (!hires.isReady()) {
    hint(DISABLE_DEPTH_TEST);

    textFont(createFont("Space Mono Bold", 50));
    textAlign(CENTER, CENTER);

    generatePoissonSampling();

    hires.beginRecord();
    background(0);
    for (int i = 0; i < samples.size(); i++) {
      float px = samples.get(i).x();
      float py = samples.get(i).y();
      float pr = samples.get(i).rad();

      textSize(2*pr*1.2);
      push();
      translate(px, py - pr*0.4f);
      float c = norm((i % (samples.size()/2)), 0, samples.size()/2);
      rotate(map(c, 0, 1, 0, TAU*2));

      fill(img.get((int)px, (int)py));

      text(charTable[(int)random(charTable.length)], 0, -pr*0.25f);
      pop();
      
      float val = i * 100f / (samples.size()-1);
      String report = String.format("> %.2f %s\ttotal: %d\ti: %d", val, "%", samples.size(), i+1);
      println(report);
    }
    hires.endRecord();

    println("SAVING...");
    hires.saveRecord();
    launch(sketchPath(hires.getFileName()));
    System.exit(0);
  }
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
