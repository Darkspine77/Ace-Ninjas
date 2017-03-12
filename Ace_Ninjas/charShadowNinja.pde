class ShadowNinja extends unitPlayer {
  boolean exhaust = false;
  int jumps = 0;
  ShadowNinja(int team1, float x1, float y1, float xsize1, float ysize1) {
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
    frames.put("exhaust", 4);
    frames.put("down_air", 1);  
    frames.put("down_ground_special", 1);
    frames.put("down_air_special", 1);
    frames.put("down_jab", 1);
    frames.put("falling", 1);
    frames.put("idle", 1);
    frames.put("jab", 1);
    frames.put("neutral_air", 6);
    frames.put("neutral_air_special", 1);
    frames.put("neutral_ground_special", 1);
    frames.put("run", 2);
    frames.put("side_air", 3);
    frames.put("side_air_special", 1);
    frames.put("side_ground_special", 1);
    frames.put("up_air", 3);
    frames.put("wallcling", 1);
    loadAnimation(this, "Shadow_Ninja", selectFrames(frames));
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
    if (!exhaust) {
      if (onGround) { 
        if (abs(xvel) < 1 && abs(yvel) < 1) { 
          if (facing == 'L' && keys[3] == false) {
            Hitbox Hit1 = new Hitbox(0, 1, 100, width/2 - xsize*1.75 - x, height/2 - y, 20, 5, -6, 0, 100, this);
            Hitboxes.add(Hit1);
            inputDelay = gameTimer + 350;
          }
          if (facing == 'R' && keys[3] == false) { 
            Hitbox Hit1 = new Hitbox(0, 1, 100, width/2 + xsize*1.75/2 - x, height/2 -y, 20, 5, 6, 0, 100, this);
            Hitboxes.add(Hit1);
            inputDelay = gameTimer + 350;
          }
          if (keys[3] == true) { 
            if (facing == 'L') {
              Hitbox Hit1 = new Hitbox(0, .8, 100, width/2 - xsize*1.75 - x, height/2+ysize/4 - y, 30, 5, -2, -2, 200, this);
              Hitboxes.add(Hit1);
              inputDelay = gameTimer + 300;
            }
            if (facing == 'R') { 
              Hitbox Hit1 = new Hitbox(0, .8, 100, width/2 - x, height/2+ysize/4 - y, 30, 5, 2, -2, 200, this);
              Hitboxes.add(Hit1);
              inputDelay = gameTimer + 300;
            }
          }
        }
        if (abs(xvel) > 1 && !keys[2] && !keys[3]) {
          if (facing == 'R') {
            xvel += 14;
            Hitbox Hit1 = new Hitbox(0, .6, 150, width/2+35 - x, height/2-5 - y, 30, 15, 7, -2, 250, this);
            Hitboxes.add(Hit1);
            inputDelay = gameTimer + 650;
          }
          if (facing == 'L') {
            xvel += -14;
            Hitbox Hit1 = new Hitbox(0, .6, 150, width/2-45 - x, height/2-5 - y, 30, 15, -7, -2, 250, this);
            Hitboxes.add(Hit1);
            inputDelay = gameTimer + 650;
          }
        }
      }
      if (!onGround) {
        if (keys[2] == true && celling != true && keys[0] == false && keys[1] == false) {
          Hitbox Hit1 = new Hitbox(0, .8, 150, width/2 - xsize/2 - x, height/2-ysize - 10 - y, 20, 10, 0, -5, 200, this);
          Hitboxes.add(Hit1);
          inputDelay = gameTimer + 400;
        }
        if (keys[3] == true && keys[0] == false && keys[1] == false) {
          if (yvel <0) {
            yvel = 0;
          }
          yvel += .2;
          if (facing == 'L') {
            Hitbox Hit1 = new Hitbox(0, .8, 100, width/2 - 5 - x, height/2+ysize/2 - y, 5, 5, -10, 2.5, 200, this);
            Hitboxes.add(Hit1);
            inputDelay = gameTimer + 200;
          }
          if (facing == 'R') {
            Hitbox Hit1 = new Hitbox(0, .8, 100, width/2 - 5 - x, height/2+ysize/2 - y, 5, 5, 10, 2.5, 200, this);
            Hitboxes.add(Hit1);
            inputDelay = gameTimer + 200;
          }
        }
        if (keys[0] == false && keys[1] == false && keys[2] == false && keys[3] == false) {
          Hitbox Hit1 = new Hitbox(0, .4, 50, width/2 - xsize - x, height/2 - ysize/2 - y, xsize*2, ysize, int(random(-10, 10)), int(random(-3, 3)), 200, this);
          Hitboxes.add(Hit1);
          inputDelay = gameTimer + 50;
        }
        if (abs(xvel) > 1) {
          if (facing == 'R' && keys[1]) {
            Hitbox Hit1 = new Hitbox(0, 1.25, 200, width/2+35 - x, height/2-20 - y, 15, 60, 4, 2, 150, this);
            Hitboxes.add(Hit1);
            inputDelay = gameTimer + 600;
          }
          if (facing == 'L' && keys[0]) {
            Hitbox Hit1 = new Hitbox(0, 1.25, 200, width/2-45 - x, height/2-20 - y, 15, 60, -4, 2, 150, this);
            Hitboxes.add(Hit1);
            inputDelay = gameTimer + 600;
          }
        }
      }
    }
  }

  void ability() {
    if (!exhaust) {
      if (onGround) {
        if (abs(xvel) < 1) {
          if (keys[3] == false) {
            statProfile stats2 = new statProfile(1, 1, stats.Strength * .25, 0, 0, 0);
            Projectile shuriken = new Shuriken(true, false, 0, 10, 10, width/2 - Players.get(0).x, height/2 - Players.get(0).y, dir * 10, 0, stats2, this);
            shuriken.dir = dir;
            Units.add(shuriken);
            inputDelay = gameTimer + 350;
          }
          if (facing == 'R' && keys[3]) {
            Hitbox Hit1 = new Hitbox(0, .1, 60, width/2+95 - x, height/2 - y, 20, 10, -2, -4, 500, this);
            Hitboxes.add(Hit1);
            statProfile stats2 = new statProfile(1, 1, stats.Strength * .25, 0, 0, 0);
            Shadow shadow = new Shadow(this, team, width/2 - Players.get(0).x + 135, height/2 - Players.get(0).y, xsize, ysize, stats2, 1000, onGround, "dash");
            shadow.dir = -dir;
            Units.add(shadow);
            inputDelay = gameTimer + 480;
          }
          if (facing == 'L' && keys[3]) {
            Hitbox Hit1 = new Hitbox(0, .1, 60, width/2-115 - x, height/2 - y, 20, 10, 2, -4, 500, this);
            Hitboxes.add(Hit1);
            statProfile stats2 = new statProfile(1, 1, stats.Strength * .25, 0, 0, 0);
            Shadow shadow = new Shadow(this, team, width/2 - Players.get(0).x -135, height/2 - Players.get(0).y, xsize, ysize, stats2, 1000, onGround, "dash");
            shadow.dir = -dir;
            Units.add(shadow);
            inputDelay = gameTimer + 480;
          }
        }
      }
      if (abs(xvel) > 1) {
        statProfile stats2 = new statProfile(1, 1, stats.Strength * .25, 0, 0, 0);
        String action;
        if (onGround) {
          action = "run";
          inputDelay = gameTimer + 750;
        } else {
          action = "falling";
          inputDelay = gameTimer + 250;
        }
        Shadow shadow = new Shadow(this, team, width/2 - Players.get(0).x, height/2 - Players.get(0).y, xsize, ysize, stats2, 1000, onGround, action); 
        shadow.dir = dir;
        Units.add(shadow);
        x -= dir * 120;

        keys[5] = false;
        jumps += 1;
        if (jumps >= 2) {
          exhaust = true;
        }
      }
      if (!onGround) {
        if (abs(xvel) < 1 && !keys[3] && !keys[2]) {
          statProfile stats2 = new statProfile(1, 1, stats.Strength * .125, 0, 0, 0);
          Projectile shuriken = new Shuriken(true, false, 0, 10, 10, width/2 - Players.get(0).x, height/2 - Players.get(0).y, dir * 8, 8, stats2, this);
          shuriken.dir = -1;
          Units.add(shuriken);
          Projectile shuriken1 = new Shuriken(true, false, 0, 10, 10, width/2 - Players.get(0).x, height/2 - Players.get(0).y, dir * 4, 8, stats2, this);
          shuriken1.dir = -1;
          Units.add(shuriken1);
          inputDelay = gameTimer + 350;
        }
        if (keys[3] && abs(xvel) < 1) {
          Hitbox Hit1 = new Hitbox(0, .1, 60, width/2+20- x - 10, height/2 - y + 20, 20, 20, 10, 2.5, 500, this);
          Hitboxes.add(Hit1);
          Hitbox Hit2 = new Hitbox(0, .1, 60, width/2-20- x - 10, height/2 - y + 20, 20, 20, -10, 2.5, 500, this);
          Hitboxes.add(Hit2);
          statProfile stats1 = new statProfile(1, 1, stats.Strength * .25, 0, 0, 0);
          Shadow shadow1 = new Shadow(this, team, width/2 - x - 20, height/2 - y + 10, xsize, ysize, stats1, 1000, onGround, "down_air");
          Shadow shadow2 = new Shadow(this, team, width/2 - x + 20, height/2 - y + 10, xsize, ysize, stats1, 1000, onGround, "down_air");
          shadow1.dir = -dir;
          shadow2.dir = -dir;
          Units.add(shadow1);
          Units.add(shadow2);
          if (abs(yvel) < 4) {
            yvel = 7;
          }
          inputDelay = gameTimer + 100;
        }
        if (keys[2]) {
          statProfile stats1 = new statProfile(1, 1, stats.Strength * .25, 0, 0, 0);
          Shadow shadow1 = new Shadow(this, team, width/2 - x, height/2 - y, xsize, ysize, stats1, 1000, onGround, "falling");
          shadow1.dir = -dir;
          y += 120;
          yvel = 0;
          statProfile stats2 = new statProfile(1, 1, stats.Strength * .125, 0, 0, 0);
          Projectile shuriken = new Shuriken(true, false, 0, 10, 10, width/2 - Players.get(0).x, height/2 - Players.get(0).y, -dir * 1, 8, stats2, this);
          shuriken.dir = -1;
          Units.add(shuriken);
          Projectile shuriken1 = new Shuriken(true, false, 0, 10, 10, width/2 - Players.get(0).x, height/2 - Players.get(0).y, dir * 1, 8, stats2, this);
          shuriken1.dir = -1;
          Units.add(shuriken1);
          Units.add(shadow1);
          exhaust = true;
          inputDelay = gameTimer + 1000;
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
        playAnimation(this, "side_air", 50, 4);
      }
      if (!onGround && !keys[0] && !keys[1] && !keys[2] && !keys[3] && keys[4]) {
        playAnimation(this, "neutral_air", 50, 4);
      }
      if (onGround && !keys[3] && keys[4] && !walking) {
        playAnimation(this, "jab", 75, 4);
      }
      if (onGround && keys[3] && keys[4]) { 
        playAnimation(this, "down_jab", 62, 4);
      }
      if (onGround && walking && keys[4]) {
        playAnimation(this, "dash", 150, 4);
      }
      if (!onGround && keys[2] && !celling && !walking & keys[4]) {
        playAnimation(this, "up_air", 60, 4);
      }
      if (!onGround && keys[3] && !walking && keys[4]) {
        playAnimation(this, "down_air", 60, 4);
      }
      if (onGround && keys[3] && keys[5] && !walking) { 
        playAnimation(this, "down_ground_special", 30, 5);
      }
      if (!onGround && keys[3] && keys[5] && !walking) { 
        playAnimation(this,"down_air_special", 30, 5);
      }
      if (onGround && !keys[3] && keys[5] && !walking) {
        playAnimation(this,"neutral_ground_special", 75, 5);
      }
      if (onGround && !keys[3] && keys[5] && walking) {
        playAnimation(this,"side_ground_special", 75, 5);
      }
      if (!onGround && !keys[3] && keys[5] && walking) {
        playAnimation(this,"side_air_special", 75, 5);
      }
      if (!onGround && !keys[3] && keys[5] && !walking) {
        playAnimation(this,"neutral_air_special", 75, 5);
      }
    } else {
      playAnimation(this,"exhaust", 50, 5);
    }
  }
}