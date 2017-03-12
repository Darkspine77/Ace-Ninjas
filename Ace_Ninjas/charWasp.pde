class charWasp extends unitAEM { 
  charWasp(int team1, float x1, float y1, float xsize1, float ysize1, Unit target1, int agroR1, int choiceD) {
    team = team1;
    x = x1;
    y = y1;
    agroR = agroR1;
    choiceD1 = choiceD;
    choiceD2 = choiceD;
    ysize = ysize1;
    xsize = xsize1;
    target = target1;
    Hurtbox Box1 = new Hurtbox(xsize, ysize, this);
    Hurtboxes.add(Box1);
    Box = Box1;
    entities += 1;
    HashMap<String, Integer> frames = new HashMap<String, Integer>();
    frames.put("idle", 2);
    loadAnimation(this, "Wasp", selectFrames(frames));
  }
  void run() {
    //println(target);
    if (!Paused) {
      if (inputDelay < gameTimer) {
        if (facing == 'L') {
          Hitbox Hit1 = new Hitbox(0, 1, 50, x - xsize/2, y, xsize, ysize/2, -5, -4, 300, this); 
          Hitboxes.add(Hit1);
        }
        if (facing == 'R') {
          Hitbox Hit1 = new Hitbox(0, 1, 50, x - xsize/2, y, xsize, ysize/2, 5, -4, 300, this); 
          Hitboxes.add(Hit1);
        }
        inputDelay = gameTimer + 150;
      }
      if(stun < gameTimer){
        yvel = 0;
      }
      showDamage();
      Agro();
      findTarget();
      movement();
      chooseSprite();
      actions();
      patrol();
      Die();
      touchTerrain();
    }
    render();
  }

  void Die() { 
    if (stats.Health <= 0) {
      entities -= 1;
      Units.remove(this);
      Enemies.remove(this);
      Hurtboxes.remove(Box);
    }
  }
  
  void chooseSprite() {
      playAnimation(this, "idle", 150, -1);
  }
}