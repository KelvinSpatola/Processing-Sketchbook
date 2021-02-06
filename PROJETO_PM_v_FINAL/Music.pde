public class Music {
  private AudioPlayer[] sound = new AudioPlayer[13];
  private int raffledSong;

  Music() {
    raffledSong = int(random(6, 9));

    for (int i = 0; i< sound.length; i++) {
      sound[i] = myMinim.loadFile("data/Sounds/sound_"+i+".mp3");
      sound[i].rewind();
    }
    sound[5].setGain(-10);
    sound[11].setGain(30);
  }

  public void unmuteSFX() {
    sound[0].unmute();
    sound[1].unmute();
    sound[5].unmute();
    sound[10].unmute();
    sound[11].unmute();
    sound[12].unmute();
  }
  public void muteSFX() {
    sound[0].mute();
    sound[1].mute();
    sound[5].mute();
    sound[10].mute();
    sound[11].mute();
    sound[12].mute();
  }
  public void unmuteSongs() {
    sound[2].unmute();
    sound[3].unmute();
    sound[4].unmute();
    sound[6].unmute();
    sound[7].unmute();
    sound[8].unmute();
  }
  public void muteSongs() {
    sound[2].mute();
    sound[3].mute();
    sound[4].mute();
    sound[6].mute();
    sound[7].mute();
    sound[8].mute();
  }

  public void playSFX(String song) { 
    if (song.equals("swap")) {     
      sound[0].rewind();
      sound[0].play();
    }
    if (song.equals("button")) {
      sound[5].rewind();
      sound[5].play();
    }
    if (song.equals("snap")) {
      sound[1].rewind();
      sound[1].play();
    }
    if (song.equals("error")) {  
      sound[10].rewind();
      sound[10].play();
    }
    if (song.equals("clapping")) {
      sound[11].rewind();
      sound[11].play();
    }
     if (song.equals("boo")) {
      sound[12].rewind();
      sound[12].play();
    }
  }
  int index = 0;

  public void stopSFX(String song) {
    if (song.equals("swap")) sound[0].mute();
    else if (song.equals("button")) sound[5].mute();
    else if (song.equals("snap")) sound[1].mute();
    else if (song.equals("error")) sound[10].mute();
    else if (song.equals("clapping")) sound[11].mute();
    else if (song.equals("playing")) {   
      sound[5].mute();    
      sound[1].mute();
    } else if (song.equals("all")) {
      sound[0].mute();    
      sound[5].mute();    
      sound[1].mute();   
      sound[10].mute();    
      sound[11].mute();
    }
  }

  public void stopSong(String song) {
    if (song.equals("all")) {
      sound[2].mute();    
      sound[3].mute();    
      sound[4].mute();   
      sound[6].mute();    
      sound[7].mute();
      sound[8].mute();
    }
    if (song.equals("menuSong")) {
      sound[2].mute();
      sound[2].rewind();
      sound[3].mute();
      sound[3].rewind();
      sound[4].mute();
      sound[4].rewind();
    }
  }

  public void playSong(String song) {
    if (song.equals("menuSong")) {
      if (sound[2].position() > 15000) {
        sound[2].rewind();
      } else {
        sound[2].setGain(-10);
        sound[2].play();
      }

      if (sound[2].position() > 4800) {    
        sound[3].play();
      }

      if (sound[3].position() > 4850) {
        sound[4].setGain(-10);
        sound[4].play();
      }
      if (sound[4].position() > 70000) {
        sound[4].rewind();
      }
    }
    if (song.equals("gameSong")) {

      if (sound[raffledSong].position() > 100000) {
        sound[raffledSong].rewind();
      } else {
        sound[raffledSong].setGain(-10);
        sound[raffledSong].play();
      }
    }
  }
}
