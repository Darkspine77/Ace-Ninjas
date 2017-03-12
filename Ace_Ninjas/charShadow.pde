class Shadow extends Unit { 
  int dur;
  String action;
  Unit maker;
  Shadow(Unit maker1, int team1, float x1, float y1, float xsize1, float ysize1, statProfile stats1, int dur1, boolean onGround1,String action1) {
    onGround = onGround1;
    maker = maker1;
    team = team1;
    action = action1;
    x = x1;
    y = y1;
    dur = dur1 + gameTimer;
    stats = stats1;
    ysize = ysize1;
    xsize = xsize1;
    Box = new Hurtbox(0, 0, this);
    entities += 1;
    HashMap<String, Integer> frames = new HashMap<String, Integer>();
    frames.put("falling", 1);
    frames.put("run", 1);
    frames.put("dash",1);
    frames.put("down_air",1);
    loadAnimation(this, "Shadow", selectFrames(frames));
  }
  void run() {
    if (!Paused) {
      chooseSprite();
      Die();
    }
    fade();
    render();
  }

  void fade() {
    if (dur < gameTimer) {
      stats.Health = 0;
    }
  }

  void drawHealth() {
  }

  void chooseSprite() {
      playAnimation(this,action, 100, -1);
  }
}