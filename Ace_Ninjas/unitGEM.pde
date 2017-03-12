class unitGEM extends Unit {
  char dirC;
  int choiceD1, choiceD2, agroR;
  float DFT;
  boolean Agro;

  void run() {  
  }
  void findTarget() {
    DFT = sqrt(sq(width/2 - target.x - x) + sq(height/2 - target.y - y));
  }
  void Agro() {
    if (DFT <= agroR) {
      Agro = true;
    } else {
      Agro = false;
    }
  }
  void patrol() {
    if (!Agro) {
      if (choiceD1 < gameTimer) {
        if (dirC == 'L') {
          dirC = 'R';
        } else {
          dirC = 'L';
        }
        choiceD1 = gameTimer + choiceD2;
      }
      if (dirC == 'L') {
        keys[0] = true;
        keys[1] = false;
      }
      if (dirC == 'R') {
        keys[1] = true;
        keys[0] = false;
      }
    }
    if (Agro) {
      if (width/2 - target.x < x) {
        keys[0] = true;
        keys[1] = false;
      }
      if (width/2 - target.x > x) {
        keys[1] = true;
        keys[0] = false;
      }
    }
  }
  void walkL() {
      if (onGround) {
        xvel = -stats.Speed;
        facing = 'L';
      }
  }
  void walkR() {
      if (onGround) {
        xvel = stats.Speed;      
        facing = 'R';
      }
  }
  void jump() {
      if (onGround) {
        yvel = -6;
      }
  }
  void chooseSprite() {
  }
  void attack() {
  }
}