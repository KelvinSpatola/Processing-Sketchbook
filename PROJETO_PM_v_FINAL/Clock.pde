public class Clock {
  private int seconds, minutes;
  private int savedTime;  // increments the millis() value since the sketch starts running
  private int UNITY_OF_MEASUREMENT = 1000; 
  private int passedTime;
  private int[] initialState = new int[2];
  private boolean running = false;
  private boolean stopped = true;
  
  private boolean calculated_UOM() { // Check how much time has passed. "UOM" stands for "Unit of measurement"
    passedTime  =  millis() - savedTime;
    return (passedTime  >  UNITY_OF_MEASUREMENT);
  } 
  public void run() {
    if (minutes <= 0 && seconds <= 0) stop();
    if (running) {
      if (calculated_UOM()) {
        seconds--;
        start();
        if (seconds < 0) {
          seconds = 59;
          minutes--;
        }
        if (minutes == 0) {
          minutes -= 0;
        }
      }
    }
  }
  public void start() { // Start the clock 
    running = true;
    stopped = false;
    savedTime =  millis();
  } 
  public void stop() {
    running = false;
    stopped = true;
  }
  public void restart() {
    setClock(initialState[1], initialState[0]);
    stop();
  }
  public void setClock(int min, int sec) {
    this.seconds = sec;
    this.minutes = min;
    this.initialState[0] = sec;
    this.initialState[1] = min;
  }
  public String getTimer() {
    return str(getMinutes())+":"+str(getSeconds());
  }
  public boolean isRunning() {
    return running;
  }
  public boolean isStopped() {
    return stopped;
  }
  public int getSeconds() {
    return seconds;
  }
  public void setSeconds(int sec) {
    if (seconds > 0 && sec >= 0) this.seconds = sec;
  }
  public int getMinutes() {
    return minutes;
  }
  public void setMinutes(int min) {
    if (min >= 0) this.minutes = min;
  }
  public void displayClock(float x, float y, float size, color txtColor) {
    textAlign(CENTER);
    textSize(size);
    fill(txtColor);
    text(nf(getMinutes(), 2)+":"+nf(getSeconds(), 2), x, y);
  }
}
