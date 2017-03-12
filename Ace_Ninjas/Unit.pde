class Unit { //<>// //<>// //<>// //<>// //<>// //<>// //<>//
  float x, y, xsize, ysize, xvel, yvel;
  char facing = 'R';
  int stun, dir = 1;    
  int inputDelay;
  int damageTimer;
  int team;
  boolean hit;
  String img;
  int inputdelay;
  statProfile stats;
  boolean damaged;
  float damageTaken;
  boolean[] keys = new boolean[6];
  HashMap<String, Animation> Animations = new HashMap<String, Animation>();
  Animation animation;
  //0=L,1=r,2=U,3=D,4=A,5=SPw
  boolean onGround, touchWall, cling, wallL, wallR, celling;
  Hurtbox Box;
  Terrain onTerrain;
  Unit target;

  void Stun(int stunD) {
    stun = gameTimer + stunD;
  }

  void run() {
  }

  void drawHealth() {
    //Draws the players health bar
    pg.strokeWeight(4);
    pg.stroke(255, 0, 0);
    pg.line(x-xsize, y-ysize, x+xsize, y-ysize); 
    pg.stroke(0, 255, 0);
    pg.line(x-xsize, y-ysize, (stats.Health*((x+xsize)-(x-xsize)))/stats.maxHealth + (x-xsize), y-ysize);  
    pg.stroke(0, 0, 0);
    pg.strokeWeight(1);
  }
  void Die() { 
    if (stats.Health <= 0) {
      entities -= 1;
      Units.remove(this);
      Hurtboxes.remove(Box);
    }
  }
  void touchTerrain() { 
    onTerrain = null;
    for (int i = 0; i<Terrains.size(); i++) {
      boolean withinX = x >= Terrains.get(i).x && x <= Terrains.get(i).x + Terrains.get(i).Length; 
      boolean onTop = y + ysize/2 >= Terrains.get(i).y && y + ysize/2 < Terrains.get(i).y + Terrains.get(i).Height*.75;
      boolean onBottom = y - ysize/2 <= Terrains.get(i).y + Terrains.get(i).Height && y - ysize/2 > Terrains.get(i).y +Terrains.get(i).Height*.25;
      boolean withinY = y <= Terrains.get(i).y +Terrains.get(i).Height && y >= Terrains.get(i).y;
      boolean onLeft = x - xsize/2 <= Terrains.get(i).x +Terrains.get(i).Length && x - xsize/2 > Terrains.get(i).x +Terrains.get(i).Length/2;
      boolean onRight = x + xsize/2 >= Terrains.get(i).x && x + xsize/2 < Terrains.get(i).x + Terrains.get(i).Length/2;
      if (onTop && withinX) {
        //TOP
        yvel = 0;
        onGround = true; 
        onTerrain = Terrains.get(i);
        y = onTerrain.y - ysize/2;
      }
      if (onBottom && withinX) {
        //BOTTOM
        celling = true; 
        touchWall = true;
        onTerrain = Terrains.get(i);
        y = onTerrain.y + onTerrain.Height + ysize/2;
      }
      if (onRight && withinY) {
        //LEFT
        wallR = true;
        touchWall = true;
        onTerrain = Terrains.get(i);
        x = onTerrain.x - xsize/2;
      }
      if (onLeft && withinY) {
        //RIGHT
        wallL = true;
        touchWall = true;
        onTerrain = Terrains.get(i);
        x = onTerrain.x + onTerrain.Length + xsize/2;
      }
    }
  }
  void actions() {
    if (stun < gameTimer) {
      if (keys[0]) {
        walkL();
      }
      if (keys[1]) {
        walkR();
      }
      if (keys[2]) {
        jump();
      }
      if (inputDelay < gameTimer) { 
        if (keys[4]) {
          attack();
        }
        if (keys[5]) {
          ability();
        }
      }
    }
  }

  void attack() {
  }
  
  void ability(){
    
  }
  
  void walkR() {
  }

  void walkL() {
  }

  void jump() {
  } 

  void render() {
    pg.imageMode(CORNER);
    pg.pushMatrix();
    pg.scale(dir, 1);
    //- xsize*.85 -ysize*1.1
    pg.image(animation.frame, dir * x  - animation.frame.width/2 + xsize/2, y - animation.frame.height/2 - ysize/3.3);
    pg.popMatrix();
    drawHealth();
  }
  void physics() {
    touchWall();
    gravity();
    friction();
  }

  void touchWall() { 
    celling = false;
    touchWall = false;
    wallR = false;
    wallL = false;
    cling = false;
    onGround = false;
  }
  void friction() {
    if (keys[0] != true && keys[1] != true) {
      xvel /= 1.25;
    }
  }
  void gravity() { 
    if (!onGround) { 
      yvel += .2;
    }
  }
  void movement() {
    x += xvel;
    y += yvel;
  }
  void takeDamage(float damage) {
    damaged = true;
    damageTaken = damage;
    damageTimer = gameTimer + 500;
  }

  void showDamage() {
    if (damaged) {
      if (gameTimer <= damageTimer) { 
        printTextPG(x,y - ysize/2,24,str(damageTaken),255,0,0);
      } else {
       damaged = false; 
      }
    }
  }
}