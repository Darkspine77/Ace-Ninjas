class Projectile extends Unit {
  Unit maker; 
  boolean lengthLimit;
  boolean damaging;
  int dur;
  int length;

  void checkCollision() {
    if (hit) {
      stats.Health = 0;
    }
  }

  void checkTerrain() {
    if (onGround || celling || touchWall) {
      stats.Health = 0;
    }
  }

  void drawHealth(){
  }

  void checkLength() {
    if (lengthLimit) {
      if (dur < gameTimer) {
        stats.Health = 0;
      }
    }
  }

  void movement() {
    x += xvel * stats.Speed;
    y += yvel * stats.Speed;
  }
}