import java.util.List;

class TargetListHandler {
  List<Target> targetList = new ArrayList<Target>();

  TargetListHandler(int numTargets) {
    for (int i = 0; i < numTargets; i++) {
      targetList.add(new Target("Target.png", random(50, width-50), random(height/2-100, height-50), (int)random(5, 20), this));
    }
  }

  void display() {
    for (int i = 0; i < targetList.size(); i++) {
      targetList.get(i).display();
    }
  }

  void addTarget(int num) {
    for (int i = 0; i < num; i++) {
      targetList.add(new Target("Target.png", random(50, width-50), random(height/2-100, height-50), (int)random(5, 20), this));
    }
  }

  void removeTarget(Target t) {
    targetList.remove(t);
  }

  List<Target> getTargets() {
    return targetList;
  }
}
