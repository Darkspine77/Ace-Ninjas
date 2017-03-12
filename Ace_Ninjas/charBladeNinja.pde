class BladeNinja extends unitPlayer {
  boolean exhaust = false;
  int jumps = 0;
  BladeNinja(int team1, float x1, float y1, float xsize1, float ysize1) {
    team = team1;
    x = x1;
    y = y1;
    ysize = ysize1;
    xsize = xsize1;
    Hurtbox Box1 = new Hurtbox(xsize, ysize, this);
    Hurtboxes.add(Box1);
    Box = Box1;
    HashMap<String, Integer> frames = new HashMap<String, Integer>();
    frames.put("dash", 4);
    frames.put("down_air", 1);  
    frames.put("down_jab", 4);
    frames.put("falling", 1);
    frames.put("idle", 1);
    frames.put("jab", 2);
    frames.put("neutral_air", 4);
    frames.put("neutral_ground_special", 2);
    frames.put("neutral_air_special", 4);
    frames.put("run", 2);
    frames.put("side_air", 3);
    frames.put("side_air_special", 3);
    frames.put("side_ground_special", 4);
    frames.put("wallcling", 1);
    loadAnimation(this, "Blade_Ninja", selectFrames(frames));
    this.animation = this.Animations.get("falling");
  }

  void run() {

    if (!Paused) {
      if (onTerrain != null) {
        y -= yvel + onTerrain.yvel;
        x -= xvel + onTerrain.xvel;
      } else {
        y -= yvel;
        x -= xvel;
      }
      showDamage();
      physics();
      touchTerrain();
      actions();
      Die();  
      chooseSprite();
      exhaust();
    }
    render();
  }

  void exhaust() {
    if (exhaust) {
      inputDelay = gameTimer + 100;
    }
    if (onGround || touchWall) {
      exhaust = false;
      jumps = 0;
    }
  }

  void attack() {
    
  }

  void ability() {
  }


  void chooseSprite() {
    boolean walking = keys[0] || keys[1];
      if (wallL || wallR) {
        playAnimation(this, "wallcling", 100, -1);
      }
      if (!onGround && !wallL && !wallR && !celling && !keys[4] && !keys[3]) {
        playAnimation(this, "falling", 100, -1);
      }
      if (onGround && !keys[4] && !keys[5] && !walking) {
        playAnimation(this, "idle", 100, -1);
      }
      if (walking && onGround && !keys[4]) {
        playAnimation(this, "run", 100, -1);
      }
      if (!onGround && walking && keys[4]) {
        playAnimation(this, "side_air", 85, 4);
      }
      if (!onGround && !keys[0] && !keys[1] && !keys[2] && !keys[3] && keys[4]) {
        playAnimation(this, "neutral_air", 70, 4);
      }
      if (onGround && !keys[3] && keys[4] && !walking) {
        playAnimation(this, "jab", 125, 4);
      }
      if (onGround && keys[3] && keys[4]) { 
        playAnimation(this, "down_jab", 80, 4);
      }
      if (onGround && walking && keys[4]) {
        playAnimation(this, "dash", 75, 4);
      }
      if (!onGround && keys[3] && !walking && keys[4]) {
        playAnimation(this, "down_air", 60, 4);
      }
      if (onGround && !keys[3] && keys[5] && !walking) {
        playAnimation(this,"neutral_ground_special", 125, 5);
      }
      if (onGround && !keys[3] && keys[5] && walking) {
        playAnimation(this,"side_ground_special", 75, 5);
      }
      if (!onGround && !keys[3] && keys[5] && walking) {
        playAnimation(this,"side_air_special", 85, 5);
      }
      if (!onGround && !keys[3] && keys[5] && !walking) {
        playAnimation(this,"neutral_air_special", 70, 5);
      }
  }
}