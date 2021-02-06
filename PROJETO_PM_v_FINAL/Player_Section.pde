public abstract class Person {
  // propriedades
  protected String name;
  protected PImage picture;

  // métodos
  abstract void setName(String name);
  abstract String getName();
  abstract String toString();
  abstract void play(Puzzle p);
}
final class Player extends Person {
  private boolean isPlaying;
  private boolean wins;

  // CONSTRUTOR
  public Player() {
    this.wins = false;
  }
  public void setName(String name) {
    this.name = name;
  }
  public String getName() {
    return this.name;
  }
  String toString() {
    return "Player name: "+getName()+" : ";
  }
  public void play(Puzzle puzzle) {
    puzzle.run();
  }
  public boolean isPlaying() {
    return this.isPlaying;
  }
  public void setState(boolean state) {
    this.isPlaying = state;
  }
  public boolean wins() {
    return this.wins;
  }
  public void setWins(boolean state) {
    this.wins = state;
  }
}