/* ****************************************
 *             FALLING LEAVES             *
 *        by Kelvin Clark Spátola         *
 *             December 2018              *
 **************************************** */

ArrayList <Leaf> leaves = new ArrayList();

void setup() {
  fullScreen(FX2D);
  for (int i = 0; i < 15; i++) 
    leaves.add(new Leaf());
}

void draw() {
  background(255);

  for (int i = 0; i < leaves.size(); i++) {
    leaves.get(i).update();
    leaves.get(i).display();

    if (leaves.get(i).disappear()) {
      if (leaves.get(i).isDefault) leaves.add(new Leaf());
      leaves.remove(i);
    }
  }
  if (mousePressed) leaves.add(new Leaf(mouseX, mouseY));
}
