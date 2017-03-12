HashMap<String, ArrayList<String>> selectFrames(HashMap<String, Integer> frames) {
  HashMap<String, ArrayList<String>> hash = new HashMap<String, ArrayList<String>>();
  for (Map.Entry entry : frames.entrySet()) {
    ArrayList<String> array = new ArrayList<String>();
    int index = (Integer)entry.getValue();
    String name = (String)entry.getKey();
    for (int i = 1; i<=index; i++) {
      array.add(name + "_" + (i));
    }
    hash.put(name, array);
  }
  return hash;
}

void loadAnimation(Unit owner, String character, HashMap<String, ArrayList<String>> pics) {
  HashMap<String, PImage> Sprites = spriteLists.get(character);
  for (Map.Entry entry : pics.entrySet()) {
    ArrayList<PImage> frames= new ArrayList<PImage>();
    ArrayList<String> paths = (ArrayList<String>)entry.getValue();
    for (int b = 0; b<paths.size(); b++) {
      frames.add(Sprites.get(paths.get(b)));
      if (paths.size() == 1) {
        frames.add(Sprites.get(paths.get(b)));
      }
    }
    Animation anim = new Animation(frames);
    anim.Owner = owner;
    owner.Animations.put((String)entry.getKey(), anim);
    AAnimations.add(anim);
  }
}

void playAnimation(Unit unit, String name, int delay, int k) {
  unit.Animations.get(name).giveFrame();
  unit.Animations.get(name).running = true;
  unit.Animations.get(name).delay = delay;
  unit.animation = unit.Animations.get(name);
  if (unit.Animations.get(name).currentFrame == 0) {
    if(k != -1){
    unit.keys[k] = false;
    }
  }
}