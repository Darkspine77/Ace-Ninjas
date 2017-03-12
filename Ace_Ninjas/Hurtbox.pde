class Hurtbox {
  float x, y, w, h;
  Unit Owner;
  ArrayList<Unit> hasHit = new ArrayList<Unit>();
  Hurtbox(float w1, float h1, Unit Owner1) {
    Owner = Owner1;
    w = w1;
    h = h1;
  }
  void run() {
    if(hitboxToggle){
    //pg.rect(x,y,w,h);
    //pg.fill(125,0,255);
    }
    if (!Paused) { //<>// //<>//
      Position();
    }
  }
  void Position() {
    x = Owner.x - Owner.xsize/2;
    y = Owner.y - Owner.ysize/2;
            if(Owner ==  Players.get(0)){
    x = width/2 -  Players.get(0).xsize/2 -  Players.get(0).x;
    y = height/2 -  Players.get(0).ysize/2 -  Players.get(0).y;
    }
  }
  void Hurt(float damage){
    float trueDamage = damage - (Owner.stats.Armor/200) * damage;
    Owner.takeDamage(trueDamage);
    Owner.stats.Health -= trueDamage;
  }
}