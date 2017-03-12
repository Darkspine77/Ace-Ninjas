class Animation {
  Unit Owner;
  int timer;
  PImage frame;
  int currentFrame;
  ArrayList<PImage> frames;
  boolean running;
  int delay;
  Animation(ArrayList<PImage> frames1) {
    frames = frames1;
  }
  Animation(PImage [] frames1) {
    ArrayList<PImage> frames2 = new ArrayList<PImage>();
    for(int i = 0;i<frames1.length;i++){
    frames2.add(frames1[i]);  
    }
  frames = frames2;
  }
  void run() {
    if (running) {
      Owner.animation = this;
      giveFrame();
    }
  }

  void giveFrame() {
    if (timer < gameTimer) {
      frame = frames.get(currentFrame);
      timer = gameTimer + delay;
      if (currentFrame == frames.size() - 1) {
        currentFrame = 0;
        running = false;
      } else {
        currentFrame += 1;
      }
    }
  }
}