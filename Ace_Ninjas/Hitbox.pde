class Hitbox {
  float x, y, w, h, xkb, ykb;
  int delay, dur, stun;
  float DMod = 1;
  Unit Maker;
  boolean kb = true;
  ArrayList<Unit> hasHit = new ArrayList<Unit>();
  Hitbox(int delay1, float DMod1, int dur1, float x1, float y1, float w1, float h1, float xkb1, float ykb1, int stun1, Unit Maker1) {
    delay = gameTimer + delay1;
    dur = dur1 + delay;
    DMod = DMod1;
    Maker = Maker1;
    stun = stun1;
    xkb = xkb1;
    ykb = ykb1;
    x = x1;
    y = y1;
    if (Maker ==  Players.get(0)) {
      //x -=  Players.get(0).x;
      //y -=  Players.get(0).y;
    }
    w = w1;
    h = h1;
  }
  void run() {
    if (gameTimer > delay) {
      if(hitboxToggle){
      pg.rect(x,y,w,h);
      pg.fill(255,0,0);
      }
      if (!Paused) {
        Hit();
        End();
      }
    }
  }
  void Hit() {
    for (int i = 0; i<Units.size(); i++) {
      Unit z = Units.get(i);
      Hurtbox p = z.Box;
      if (inRange(p.x, p.y, x, y, p.w, p.h, w, h) && z.team != Maker.team) {
        boolean flag = hasHit.contains(z);
        if (!flag) {
          hasHit.add(z);
          Maker.hit = true;
          p.Hurt(DMod * Maker.stats.Strength);
          if(kb){
          z.xvel = xkb;
          z.yvel = ykb;
          }
          z.Stun(200);
        }
      }
    }
  }
  void End() {
    if (millis() >= dur) {
      Hitboxes.remove(this);
    }
  }
}