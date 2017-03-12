class BeastNinja extends unitPlayer {
  boolean exhaust = false;
  int jumpTimer;
  boolean canJump;
  BeastNinja(int team1, float x1, float y1, float xsize1, float ysize1) {
    team = team1;
    x = x1;
    y = y1;
    ysize = ysize1;
    xsize = xsize1;
    Hurtbox Box1 = new Hurtbox(xsize, ysize, this);
    Hurtboxes.add(Box1);
    Box = Box1;
    HashMap<String, Integer> frames = new HashMap<String, Integer>();
    frames.put("dash", 1);
    frames.put("down_air", 1);  
    frames.put("down_ground_special", 1);
    frames.put("down_air_special", 1);
    frames.put("down_jab", 1);
    frames.put("falling", 4);
    frames.put("idle", 1);
    frames.put("jab", 1);
    frames.put("neutral_air", 3);
    frames.put("run", 2);
    frames.put("side_air", 3);
    frames.put("side_air_special", 8);
    frames.put("side_ground_special", 1);
    frames.put("up_air", 3);
    frames.put("wallcling", 1);
    loadAnimation(this, "Beast_Ninja", selectFrames(frames));
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
    if (onGround || wallR || wallL) {
      exhaust = false;
      canJump = true;
    }
  }

  void jump() {
    if (jumpTimer < gameTimer && canJump) {
      if (!onGround) {
        canJump = false;
      }
      yvel = -6;
      jumpTimer = 400 + gameTimer;
    }
  }

  void attack() {
    if (!exhaust) {
      if (onGround) { 
        if (abs(xvel) < 1 && abs(yvel) < 1) { 
          if (facing == 'L' && keys[3] == false) {
            Hitbox Hit1 = new Hitbox(0, 1, 100, width/2 - xsize - x, height/2 - y, 5, 5, -2, -3, 100, this);
            Hitboxes.add(Hit1);
            inputDelay = gameTimer + 200;
          }
          if (facing == 'R' && keys[3] == false) { 
            Hitbox Hit1 = new Hitbox(0, 1, 100, width/2 + xsize/2 - x, height/2 -y, 5, 5, 2, -3, 100, this);
            Hitboxes.add(Hit1);
            inputDelay = gameTimer + 200;
          }
          if (keys[3] == true) { 
            if (facing == 'L') {
              Hitbox Hit1 = new Hitbox(0, .8, 100, width/2 - xsize - x, height/2+ysize/4 - y, 25, 5, -.5, -4, 150, this);
              Hitboxes.add(Hit1);
              inputDelay = gameTimer + 300;
            }
            if (facing == 'R') { 
              Hitbox Hit1 = new Hitbox(0, .8, 100, width/2 + xsize/4 - x, height/2+ysize/4 - y, 25, 5, .5, -4, 150, this);
              Hitboxes.add(Hit1);
              inputDelay = gameTimer + 300;
            }
          }
        }
        if (abs(xvel) > 1 && !keys[2] && !keys[3]) {
          if (facing == 'R') {
            xvel *= 1.5;
            Stun(250);
            Hitbox Hit1 = new Hitbox(0, .6, 150, width/2+35 - x, height/2-5 - y, 30, 15, 7, -2, 250, this);
            Hitboxes.add(Hit1);
            Hitbox Hit2 = new Hitbox(50, .6, 150, width/2+70 - x, height/2-5 - y, 30, 15, 7, -2, 250, this);
            Hitboxes.add(Hit2);
            inputDelay = gameTimer + 650;
          }
          if (facing == 'L') {
            Stun(250);
            xvel *= 1.5;
            Hitbox Hit1 = new Hitbox(0, .6, 150, width/2-45 - x, height/2-5 - y, 30, 15, -7, -2, 250, this);
            Hitboxes.add(Hit1);
            Hitbox Hit2 = new Hitbox(50, .6, 150, width/2-90 - x, height/2-5 - y, 30, 15, -7, -2, 250, this);
            Hitboxes.add(Hit2);
            inputDelay = gameTimer + 650;
          }
        }
      }
      if (!onGround) {
        if (keys[2] == true && celling != true && keys[0] == false && keys[1] == false) {
          if (facing == 'L') {
            Hitbox Hit1 = new Hitbox(0, .8, 150, width/2 - xsize - x, height/2-ysize - 10 - y, 20, 10, 0, -5, 200, this);
            Hitboxes.add(Hit1);
            inputDelay = gameTimer + 400;
          }
          if (facing == 'R') {
            Hitbox Hit1 = new Hitbox(0, .8, 150, width/2 + xsize/3 - x, height/2-ysize - 10 - y, 20, 10, 0, -5, 200, this);
            Hitboxes.add(Hit1);
            inputDelay = gameTimer + 400;
          }
        }
        if (keys[3] == true && keys[0] == false && keys[1] == false) {
          if (yvel <0) {
            yvel = 6;
          }
          yvel += .2;
          Hitbox Hit1 = new Hitbox(0, .8, 100, width/2 - 5 - x, height/2+ysize/2 - y, 10, 10, -10, 2.5, 200, this);
          Hitboxes.add(Hit1);
        }
        if (keys[0] == false && keys[1] == false && keys[2] == false && keys[3] == false) {
          Hitbox Hit1 = new Hitbox(0, .4, 50, width/2 - xsize* 1.5 - x, height/2 + ysize/4 - y, 30, 10, -5, 0, 200, this);
          Hitboxes.add(Hit1);
          Hitbox Hit2 = new Hitbox(0, .4, 50, width/2 - x, height/2 + ysize/4 - y, 30, 10, 5, 0, 200, this);
          Hitboxes.add(Hit2);
          inputDelay = gameTimer + 300;
        }
        if (abs(xvel) > 1) {
          if (facing == 'R' && keys[1]) {
            Hitbox Hit1 = new Hitbox(0, 1.25, 50, width/2+25 - x, height/2-20 - y, 10, 30, 4, 2, 150, this);
            Hitboxes.add(Hit1);
            inputDelay = gameTimer + 200;
          }
          if (facing == 'L' && keys[0]) {
            Hitbox Hit1 = new Hitbox(0, 1.25, 50, width/2-35 - x, height/2-20 - y, 10, 30, -4, 2, 150, this);
            Hitboxes.add(Hit1);
            inputDelay = gameTimer + 200;
          }
        }
      }
    }
  }

  void ability() {
    if (!exhaust) {
      if (keys[3]) {
        if (!onGround) {
          Hitbox Hit1 = new Hitbox(0, .1, 50, width/2 - xsize - x, height/2 - y, xsize, ysize/2, 10 * dir, 0, 200, this);
          Hitboxes.add(Hit1);
          xvel = dir * 16;
          yvel = 6;
          inputDelay = gameTimer + 50;
        } else {
        Stun(400);
        Hitbox Hit1 = new Hitbox(0, .1, 50, width/2 - xsize - x, height/2 - y, xsize, ysize/2, 10 * dir, 0, 200, this);
        Hitboxes.add(Hit1);
        xvel = -dir * 16;
        yvel = -6;
        inputDelay = gameTimer + 400;
        }
      }
      if (!onGround) {
        if (!keys[3] && !wallR && !wallL) {
          Hitbox Hit1 = new Hitbox(0, .2, 50, width/2 - xsize - x, height/2 - ysize/2 - y, xsize*2, ysize, 10 * dir, 0, 200, this);
          Hitboxes.add(Hit1);
          inputDelay = gameTimer + 10;
        }
      }
      if (onGround) {
        boolean flag = keys[1] || keys[0];
        if (!keys[2] && !keys[3] && flag && !wallR && !wallL) {
          Stun(150);
          xvel = 3 * dir;
          if (facing == 'R') {
            Hitbox Hit1 = new Hitbox(0, .8, 100, width/2 + xsize - x, height/2+ysize/4 - y, 35, 5, dir, -5, 150, this);
            Hitboxes.add(Hit1);
          }
          if (facing == 'L') {
            Hitbox Hit1 = new Hitbox(0, .8, 100, width/2 - xsize*2.5 - x, height/2+ysize/4 - y, 35, 5, dir, -5, 150, this);
            Hitboxes.add(Hit1);
          }
          inputDelay = gameTimer + 650;
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
      if (!onGround && !wallL && !wallR && !celling && !keys[4] && !keys[5]) {
        playAnimation(this, "falling", 50, -1);
      }
      if (onGround && !keys[4] && !keys[5] && !walking) {
        playAnimation(this, "idle", 100, -1);
      }
      if (walking && onGround && !keys[4]) {
        playAnimation(this, "run", 350/3, -1);
      }
      if (!onGround && walking && keys[4]) {
        playAnimation(this, "side_air", 200/3, 4);
      }
      if (!onGround && !keys[0] && !keys[1] && !keys[2] && !keys[3] && keys[4]) {
        playAnimation(this, "neutral_air", 75, 4);
      }
      if (onGround && !keys[3] && keys[4] && !walking) {
        playAnimation(this, "jab", 100, 4);
      }
      if (onGround && keys[3] && keys[4]) { 
        playAnimation(this, "down_jab", 150, 4);
      }
      if (onGround && walking && keys[4]) {
        playAnimation(this, "dash", 150, 4);
      }
      if (!onGround && keys[2] && !celling && !walking & keys[4]) {
        playAnimation(this, "up_air", 100, 4);
      }
      if (!onGround && keys[3] && !walking && keys[4]) {
        playAnimation(this, "down_air", 5, 4);
      }
      if (onGround && keys[3] && keys[5] && !walking) { 
        playAnimation(this, "down_ground_special", 100, 5);
      }
      if (!onGround && keys[3] && keys[5] && !walking) { 
        playAnimation(this, "down_air_special", 100, 5);
      }
      if (onGround && !keys[3] && keys[5] && !walking) {
       keys[5] = false;
      }
      if (onGround && !keys[3] && keys[5] && walking) {
        playAnimation(this, "side_ground_special", 150, 5);
      }
      if (!onGround && keys[5] && !wallR && !wallL) {
        playAnimation(this, "side_air_special", 25, 5);
      }
    } else {
      playAnimation(this, "falling", 50, 5);
    }
  }
}