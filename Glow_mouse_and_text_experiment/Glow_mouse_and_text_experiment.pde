import com.thomasdiewald.pixelflow.java.DwPixelFlow;
import com.thomasdiewald.pixelflow.java.imageprocessing.filter.DwFilter;
import com.hamoid.*;

VideoExport videoExport;

DwPixelFlow context;
DwFilter filter;

PGraphics2D pg_a, pg_b; // just another buffer for temporary results

ArrayList<Particle> particles;
int hueMaxValue = 900;

void setup() {
  fullScreen(P2D);
  //setupVideoExport("output4.mp4", 60, 95);

  colorMode(HSB, hueMaxValue, 1, 1);

  context = new DwPixelFlow(this);
  filter = DwFilter.get(context);

  pg_a = (PGraphics2D) createGraphics(width, height, P2D);
  pg_b = (PGraphics2D) createGraphics(width, height, P2D);

  particles = new ArrayList();

  pg_a.beginDraw();
  pg_a.textFont(createFont("Georgia", 50));
  pg_a.textAlign(CENTER, CENTER);
  pg_a.endDraw();
}

void draw() {
  pg_a.beginDraw();
  {
    pg_a.background(0);

    for (int i = particles.size()-1; i >= 0; i--) {
      particles.get(i).display();
      particles.get(i).update();
      if (particles.get(i).alpha < 0) particles.remove(i);
    }
  }
  pg_a.endDraw();

  pg_b.beginDraw();
  pg_b.clear();
  pg_b.endDraw();

  filter.bloom.param.mult   = 3;//map(mouseX, 0, width, 0, 10);
  filter.bloom.param.radius = 0.5f; //map(mouseY, 0, height, 0, 1);

  filter.luminance_threshold.param.threshold = 0;
  filter.luminance_threshold.param.exponent = 10;

  filter.luminance_threshold.apply(pg_a, pg_b);
  filter.bloom.apply(pg_b, pg_b, pg_a);

  image(pg_a, 0, 0);


 /* videoExport.saveFrame();
  if (frameCount >= 1800) {
    videoExport.endMovie();
    exit();
  }

  fill(255, 0, 0);
  text(frameCount, 50, 50); */

  //println((int)frameRate);
}

void mouseMoved() {
  if (frameCount > 10) particles.add(new Particle(mouseX, mouseY));
}

void keyPressed() {
  if (key == ' ') setup();
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
