class Fireball extends Projectile {
  Fireball(boolean damaging1, boolean lengthLimit1, int length1, float xsize1, float ysize1, float x1, float y1, float xvel1, float yvel1, statProfile stats1, Unit maker1) {
    x = x1;
    y = y1;
    xsize = xsize1;
    ysize = ysize1;
    maker = maker1;
    team = maker.team;
    damaging = damaging1;
    stats = stats1;
    xvel = xvel1;
    yvel = yvel1;
    length = length1;
    Box = new Hurtbox(0, 0, this);
    lengthLimit = lengthLimit1;
    dur = length + gameTimer;
    HashMap<String, Integer> frames1 = new HashMap<String, Integer>();
    frames1.put("idle", 1);
    loadAnimation(this, "Fireball", selectFrames(frames1));
  }

  void run() {
    if (!Paused) {
      movement();
      chooseSprite();
      touchTerrain();
      checkLength();
      checkTerrain();
      checkCollision();
      Die();
      if (damaging) {
        Hitbox Hit1 = new Hitbox(0, 1, 1, x, y, xsize, ysize, 0, 0, 0, this);
        Hit1.kb = false;
        Hitboxes.add(Hit1);
      }
    }
    render();
  }

  void chooseSprite() {
    playAnimation(this,"idle", 100, -1);
  }
}