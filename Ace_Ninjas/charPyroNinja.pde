class PyroNinja extends unitPlayer {
  boolean exhaust = false;
  int jumpTimer;
  boolean canJump;
  PyroNinja(int team1, float x1, float y1, float xsize1, float ysize1) {
    team = team1;
    x = x1;
    y = y1;
    ysize = ysize1;
    xsize = xsize1;
    Hurtbox Box1 = new Hurtbox(xsize, ysize, this);
    Hurtboxes.add(Box1);
    Box = Box1;
    HashMap<String, Integer> frames = new HashMap<String, Integer>();
    frames.put("dash", 2);
    frames.put("down_air", 1);  
    frames.put("down_ground_special", 1);
    frames.put("neutral_ground_special", 1);
    frames.put("neutral_air_special", 1);
    frames.put("down_air_special", 2);
    frames.put("down_jab", 1);
    frames.put("falling", 1);
    frames.put("idle", 1);
    frames.put("jab", 1);
    frames.put("neutral_air", 1);
    frames.put("run", 2);
    frames.put("side_air", 1);
    frames.put("side_ground_special", 7);
    frames.put("up_air", 1);
    frames.put("wallcling", 1);
    loadAnimation(this, "Pyro_Ninja", selectFrames(frames));
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
    //if (exhaust) {
    //  inputDelay = gameTimer + 100;
    //}
    //if (onGround || wallR || wallL) {
    //  exhaust = false;
    //  canJump = true;
    //}
  }

  //void jump() {
  //  if (jumpTimer < gameTimer && canJump) {
  //    if (!onGround) {
  //      canJump = false;
  //    }
  //    yvel = -6;
  //    jumpTimer = 400 + gameTimer;
  //  }
  //}

  void attack() {
    if (!exhaust) {
      if (onGround) { 
        if (abs(xvel) < 1 && abs(yvel) < 1) { 
          if (facing == 'L' && keys[3] == false) {
            Hitbox Hit1 = new Hitbox(0, 1, 100, width/2 - xsize - x, height/2 - y, 5, 5, -2, 0, 100, this);
            Hitboxes.add(Hit1);
            inputDelay = gameTimer + 400;
          }
          if (facing == 'R' && keys[3] == false) { 
            Hitbox Hit1 = new Hitbox(0, 1, 100, width/2 + xsize/2 - x, height/2 -y, 5, 5, 2, 0, 100, this);
            Hitboxes.add(Hit1);
            inputDelay = gameTimer + 400;
          }
          if (keys[3] == true) { 
            if (facing == 'L') {
              Hitbox Hit1 = new Hitbox(0, .2, 100, width/2 - xsize*2 - x, height/2+ysize/4 - y, 25, 20, -2, -4, 150, this);
              Hitboxes.add(Hit1);
            }
            if (facing == 'R') { 
              Hitbox Hit1 = new Hitbox(0, .2, 100, width/2 + xsize/2 - x, height/2+ysize/4 - y, 25, 20, 2, -4, 150, this);
              Hitboxes.add(Hit1);
            }
          }
        }
        if (abs(xvel) > 1 && !keys[2] && !keys[3]) {
          if (facing == 'R') {
            Hitbox Hit1 = new Hitbox(0, .01, 10, width/2+15 - x, height/2-5 - y, 30, 15, xvel, 0, 250, this);
            Hitboxes.add(Hit1);
          }
          if (facing == 'L') {
            Hitbox Hit1 = new Hitbox(0, .01, 10, width/2-45 - x, height/2-5 - y, 30, 15, -xvel, 0, 250, this);
            Hitboxes.add(Hit1);
          }
        }
      }
      if (!onGround) {
        if (keys[2] == true && celling != true && keys[0] == false && keys[1] == false) {
          Hitbox Hit1 = new Hitbox(0, .2, 150, width/2 - xsize/2.5 - x, height/2 - 10 - y, 20, 10, 0, -5, 200, this);
          yvel += .3;
          Hitboxes.add(Hit1);
        }
        if (keys[3] == true && keys[0] == false && keys[1] == false) {
          yvel -= .3;
          Hitbox Hit1 = new Hitbox(0, .2, 100, width/2 - 5 - x, height/2+ysize/2 - y, 10, 10, -10, 2.5, 200, this);
          Hitboxes.add(Hit1);
        }
        if (keys[0] == false && keys[1] == false && keys[2] == false && keys[3] == false) {
          Hitbox Hit1 = new Hitbox(0, .1, 50, width/2 - xsize* 1.5 - x, height/2 - y, 30, 30, -10, 0, 200, this);
          Hitboxes.add(Hit1);
          Hitbox Hit2 = new Hitbox(0, .1, 50, width/2 - x, height/2 - y, 30, 30, 10, 0, 200, this);
          Hitboxes.add(Hit2);
          if (yvel > 0) {
            yvel = .5;
          }
        }
        if (abs(xvel) > 1) {
          if (facing == 'R' && keys[1]) {
            Hitbox Hit1 = new Hitbox(0, .25, 50, width/2+25 - x, height/2-10 - y, 10, 20, 4, 2, 150, this);
            Hitboxes.add(Hit1);
          }
          if (facing == 'L' && keys[0]) {
            Hitbox Hit1 = new Hitbox(0, .25, 50, width/2-35 - x, height/2-10 - y, 10, 20, -4, 2, 150, this);
            Hitboxes.add(Hit1);
          }
        }
      }
    }
  }

  void ability() {
    if (!exhaust) {
      if (!onGround) {
        if (!keys[3]) {
          statProfile stats2 = new statProfile(1, 1, stats.Strength * .25, 0, 0, 0);
          Projectile fireBall = new Fireball(true, false, 0, 10, 10, width/2 - Players.get(0).x, height/2 - Players.get(0).y, dir * 10, 0, stats2, this);
          fireBall.dir = dir;
          Units.add(fireBall);
          inputDelay = gameTimer + 500;
        }
        if (keys[3]) {
          statProfile stats2 = new statProfile(1, 1, stats.Strength * .25, 0, 0, 0);
          Projectile fireBall = new Fireball(true, false, 0, 10, 10, width/2 - Players.get(0).x, height/2 + ysize/2 - Players.get(0).y, dir * 1, 8, stats2, this);
          fireBall.dir = dir;
          Units.add(fireBall);
          Projectile fireBall1 = new Fireball(true, false, 0, 10, 10, width/2 - Players.get(0).x, height/2 + ysize/2 - Players.get(0).y, -dir * 1, 8, stats2, this);
          fireBall1.dir = -dir;
          Units.add(fireBall1);
          inputDelay = gameTimer + 500;
        }
      }
      if (onGround) {
        if (!keys[2] && keys[3] && !wallR && !wallL) {
          Hitbox Hit1 = new Hitbox(0, .25, 50, width/2 - 50 - x, height/2-10 - y, 30, 20, -4, 2, 150, this);
          Hitboxes.add(Hit1);
          Hitbox Hit2 = new Hitbox(0, .25, 50, width/2+20 - x, height/2-10 - y, 30, 20, 4, 2, 150, this);
          Hitboxes.add(Hit2);
          inputDelay = gameTimer + 500;
        }
        boolean flag = keys[0] || keys[1];
        if (flag && !keys[3] && !wallR && !wallL) {
          xvel = 0;
          Stun(450);
          if (facing == 'R') {
            Hitbox Hit1 = new Hitbox(0, .2, 400, width/2 + xsize/2 - x, height/2 - y, 30, 15, 3 * dir, -1, 200, this);
            Hitboxes.add(Hit1);
            Hitbox Hit2 = new Hitbox(200, .2, 200, width/2 + xsize*2 - x, height/2 - y, 30, 15, 3 * dir, -1, 200, this);
            Hitboxes.add(Hit2);
            Hitbox Hit3 = new Hitbox(250, .2, 150, width/2 + xsize*3 - x, height/2 - y, 30, 15, 3 * dir, -1, 200, this);
            Hitboxes.add(Hit3);
            Hitbox Hit4 = new Hitbox(300, .2, 100, width/2 + xsize*4 - x, height/2 - y, 30, 15, 3 * dir, -1, 200, this);
            Hitboxes.add(Hit4);
          }
          if (facing == 'L') {
            Hitbox Hit1 = new Hitbox(0, .2, 400, width/2 - xsize*2.5 - x, height/2 - y, 30, 15, 3 * dir, -1, 200, this);
            Hitboxes.add(Hit1);
            Hitbox Hit2 = new Hitbox(200, .2, 200, width/2 - xsize*3.5 - x, height/2 - y, 30, 15, 3 * dir, -1, 200, this);
            Hitboxes.add(Hit2);
            Hitbox Hit3 = new Hitbox(250, .2, 150, width/2 - xsize*4.5 - x, height/2 - y, 30, 15, 3 * dir, -1, 200, this);
            Hitboxes.add(Hit3);
            Hitbox Hit4 = new Hitbox(300, .2, 100, width/2 - xsize*5.5 - x, height/2 - y, 30, 15, 3 * dir, -1, 200, this);
            Hitboxes.add(Hit4);
          }
          inputDelay = gameTimer + 450;  
        }
        if (!flag && !keys[2] && !keys[3]) {
          statProfile stats2 = new statProfile(1, 1, stats.Strength * .25, 0, 0, 0);
          Projectile fireBall = new Fireball(true, false, 0, 10, 10, width/2 - Players.get(0).x, height/2 - Players.get(0).y, dir * 10, 0, stats2, this);
          fireBall.dir = dir;
          Units.add(fireBall);
          inputDelay = gameTimer + 500;
        }
      }
    }
  }


  void chooseSprite() {
    boolean walking = keys[0] || keys[1];
    if (!exhaust) {
      if (wallL || wallR) {
        playAnimation(this, "wallcling", 100, -1);
      }
      if (!onGround && !wallL && !wallR && !celling && !keys[4]) {
        playAnimation(this, "falling", 50, -1);
      }
      if (onGround && !keys[4] && !keys[5] && !walking) {
        playAnimation(this, "idle", 100, -1);
      }
      if (walking && onGround && !keys[4]) {
        playAnimation(this, "run", 300/3, -1);
      }
      if (!onGround && walking && keys[4]) {
        playAnimation(this, "side_air", 200/3, 4);
      }
      if (!onGround && !keys[0] && !keys[1] && !keys[2] && !keys[3] && keys[4]) {
        playAnimation(this, "neutral_air", 300/2, 4);
      }
      if (onGround && !keys[3] && keys[4] && !walking) {
        playAnimation(this, "jab", 200, 4);
      }
      if (onGround && keys[3] && keys[4]) { 
        playAnimation(this, "down_jab", 300/4, 4);
      }
      if (onGround && walking && keys[4]) {
        playAnimation(this, "dash", 100, 4);
      }
      if (!onGround && keys[2] && !celling && !walking & keys[4]) {
        playAnimation(this, "up_air", 100, 4);
      }
      if (!onGround && keys[3] && !walking && keys[4]) {
        playAnimation(this, "down_air", 5, 4);
      }
      if (onGround && keys[3] && keys[5] && !walking) { 
        playAnimation(this, "down_ground_special", 225, 5);
      }
      if (onGround && !keys[3] && keys[5] && !walking) {
        playAnimation(this, "neutral_ground_special", 250, 5);
      }
      if (!onGround && !keys[3] && keys[5] && !walking) {
        playAnimation(this, "neutral_air_special", 75, 5);
      }
      if (!onGround && keys[3] && keys[5] && !walking) { 
        playAnimation(this, "down_air_special", 200, 5);
      }
      if (onGround && !keys[3] && keys[5] && walking) {
        playAnimation(this, "side_ground_special", 50, 5);
      }
      if (!onGround && keys[5] && !keys[3] && !wallR && !wallL) {
        playAnimation(this, "neutral_air_special", 75, 5);
      }
    } else {
      playAnimation(this, "falling", 50, 5);
    }
  }
}