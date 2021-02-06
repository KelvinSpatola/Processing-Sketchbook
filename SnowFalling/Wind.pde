
import processing.sound.*;

class Wind {
  AudioIn input;
  Amplitude loudness;

  int micVolume, threshold = 65;

  Wind() {
    input = new AudioIn(app, 0);
    input.start();
    loudness = new Amplitude(app);
    loudness.input(input);
  }

  void update() {
    input.amp(0.5);
    float volume = loudness.analyze();
    micVolume = int(map(volume, 0, 0.5, 0, 100));
  }

  boolean blow() {
    return micVolume > threshold;
  }
}
