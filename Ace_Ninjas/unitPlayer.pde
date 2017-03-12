class unitPlayer extends Unit { 

  void run() { 
  }
  void render() {
    imageMode(CORNER);
    pushMatrix();
    scale(dir, 1);
    //- xsize*.85 -ysize*1.1
    image(animation.frame, dir * width/2  - animation.frame.width/2 + xsize/1.4, height/2 - animation.frame.height/2 - ysize/3.3);
    popMatrix();
    drawHealth();
  }

  void showDamage() {
    if (damaged) {
      if (gameTimer <= damageTimer) { 
        printText(width/2, height/2 - ysize/2, 24, str(int(damageTaken)), 255, 0, 0);
      } else {
        damaged = false;
      }
    }
  }

  void touchTerrain() { 
    onTerrain = null;
    for (int i = 0; i<Terrains.size(); i++) {
      boolean withinX = width/2 >= Terrains.get(i).x + Players.get(0).x && width/2 <= Terrains.get(i).x + Terrains.get(i).Length + Players.get(0).x; 
      boolean onTop = height/2 + Players.get(0).ysize/2 >= Terrains.get(i).y + Players.get(0).y && height/2 + Players.get(0).ysize/2 < Terrains.get(i).y + Terrains.get(i).Height*.75 + Players.get(0).y ;
      boolean onBottom = height/2 - Players.get(0).ysize/2 <= Terrains.get(i).y + Terrains.get(i).Height + Players.get(0).y && height/2 - Players.get(0).ysize/2 > Terrains.get(i).y +Terrains.get(i).Height*.25 + Players.get(0).y;
      boolean withinY = height/2 <= Terrains.get(i).y +Terrains.get(i).Height + Players.get(0).y && height/2 >= Terrains.get(i).y + Players.get(0).y;
      boolean onLeft = width/2 - Players.get(0).xsize/2 <= Terrains.get(i).x +Terrains.get(i).Length + Players.get(0).x && width/2 - Players.get(0).xsize/2 > Terrains.get(i).x +Terrains.get(i).Length/2 + Players.get(0).x;
      boolean onRight = width/2 + Players.get(0).xsize/2 >= Terrains.get(i).x + Players.get(0).x && width/2 + Players.get(0).xsize/2 < Terrains.get(i).x + Terrains.get(i).Length/2 + Players.get(0).x;
      if (onTop && withinX) {
        //TOP
        yvel = 0;
        onGround = true; 
        onTerrain = Terrains.get(i);
        Players.get(0).y = height/2 + Players.get(0).ysize/2 - Terrains.get(i).y;
      }
      if (onBottom && withinX) {
        //BOTTOM
        celling = true; 
        touchWall = true;
        yvel = .1;
        onTerrain = Terrains.get(i);
        Players.get(0).y = height/2 - Players.get(0).ysize/2 - Terrains.get(i).y - Terrains.get(i).Height - 2;
      }
      if (onRight && withinY) {
        //LEFT
        wallR = true;
        touchWall = true;
        xvel = 0;
        yvel /= 2;
        onTerrain = Terrains.get(i);
        Players.get(0).x = width/2 + Players.get(0).xsize/2 - Terrains.get(i).x;
      }
      if (onLeft && withinY) {
        //RIGHT
        wallL = true;
        touchWall = true;
        xvel = 0;
        yvel /= 2;
        onTerrain = Terrains.get(i);
        Players.get(0).x =  width/2 - Players.get(0).xsize/2 - Terrains.get(i).x - Terrains.get(i).Length;
      }
    }
  }

  void drawHealth() {
    //Draws the players health bar
    strokeWeight(4);
    stroke(255, 0, 0);
    line(width/2-xsize, height/2-ysize, width/2+xsize, height/2-ysize); 
    stroke(0, 255, 0);
    line(width/2-xsize, height/2-ysize, (stats.Health*((width/2+xsize)-(width/2-xsize)))/stats.maxHealth + (width/2-xsize), height/2-ysize);  
    stroke(0, 0, 0);
    strokeWeight(1);
  }

  void walkL() {
    facing = 'L';
    dir = -1;
    if (!onGround && !celling) {
      if (wallL) {
        xvel = 0;
      }
      if (wallR) {
        xvel = stats.Speed;
        yvel = -4;
      }
      if (!wallL) {
        xvel = -stats.Speed;
      }
    }
    if (onGround) {
      xvel = -stats.Speed;
    }
  }
  void walkR() {
    facing = 'R';
    dir = 1;
    if (!onGround && !celling) {
      if (wallR) {
        xvel = 0;
      }
      if (wallL) {
        xvel = -stats.Speed;
        yvel = -4;
      }
      if (!wallR) {
        xvel = stats.Speed;
      }
    }
    if (onGround) {
      xvel = stats.Speed;
    }
  }

  void jump() {
    if (onGround) {
      yvel = -6;
    }
  }
} 