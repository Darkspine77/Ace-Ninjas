int pauseDelay;
int spawntimer;
Unit Controlled;
void playerSelect(Unit Unit) {
  Controlled = Unit;
}

void playerControl() {
  if (pauseDelay < millis()) { 
    if (downkey[80] == true) {
      println("paused");
      Pause();
      println(Paused);
      pauseDelay = millis() + 1000;
    }
  }
  if (Controlled.stun < gameTimer) {
    for (int i = 0; i<Controlled.keys.length - 2; i++) {
      Controlled.keys[i] = false;
    }
    //if (Controlled.xvel >= 3) {
    // Controlled.xvel = 3;
    //}
    //if (Controlled.xvel <= -3) {
    // Controlled.xvel = -3;
    //}
    if (downkey[65] == true || downkey[37]) { 
      Controlled.keys[0] = true;
    }
    if (downkey[68] == true || downkey[39]) {
      Controlled.keys[1] = true;
    }
    if (downkey[87] == true || downkey[38]) {   
      Controlled.keys[2] = true;
    } 
    if (downkey[83] == true) {
      Controlled.keys[3] = true;
    }
    if (downkey[82] == true) {
      Units.clear();
      Players.clear();
      Enemies.clear();
      SpawnBoxes.clear();
      loadPlayer();
      Players.get(0).x = 350;
      Players.get(0).y = 350;
      for (int i = 0; i<4; i++) {
        SpawnBox test = new SpawnBox(int(random(100, levelLength * 1000 - 100)), int(random(-210, 250)), 5000);
      }
      loadTerrain();
    }
    if (downkey[76] == true) {
      screenMode = "fixed";
    }
    if (downkey[75] == true) {
      SpawnBox test = new SpawnBox(mouseX -  Players.get(0).x, mouseY -  Players.get(0).y, 5000);
      //charDrone E = new charDrone(2,mouseX -  Players.get(0).x, mouseY -  Players.get(0).y, 20, 40, Players.get(0), 300, 1000); 
      //statProfile prof = new statProfile(10, 2, 1, 0, 0, 0);
      //E.stats = prof;
      //Enemies.add(E);
      //Units.add(E);
      //HashMap<String, PImage> Sprites = spriteLists.get("Drone");
      //PImage[] frames = new PImage[2];
      //frames[0] = Sprites.get("run_1");
      //frames[1] = Sprites.get("run_2");
      //Animation run = new Animation(frames);
      //run.Owner = E;
      //E.Animations.put("run", run);
      //AAnimations.add(run);
      ////1
      //frames = new PImage[1];
      //frames[0] = Sprites.get("falling");
      //Animation falling = new Animation(frames);
      //falling.Owner = E;
      //E.Animations.put("falling", falling);
      //AAnimations.add(falling);
      Controlled.Stun(200);
    }

    if (downkey[81] == true) {
      Units.remove(Players.get(0));
      Players.clear();
      unitPlayer Player1 = new BeastNinja(1, 350, 350, 20, 40);
      for (int i = 0; i<Enemies.size (); i++) {
        Enemies.get(i).target = Player1;
        println(Enemies.get(i).target);
      }
      statProfile prof = new statProfile(50, 6, 3, 0, 0, 0);
      Player1.stats = prof;
      Players.add(Player1);
      Units.add(Player1);
      playerSelect(Player1);
      User = Player1;
    }
    if (downkey[69] == true) {
      Units.remove(Players.get(0));
      Players.clear();
      unitPlayer Player1 = new ShadowNinja(1, 350, 350, 20, 40); 
      for (int i = 0; i<Enemies.size (); i++) {
        Enemies.get(i).target = Player1;
        println(Enemies.get(i).target);
      }
      statProfile prof = new statProfile(50, 4, 3, 0, 0, 0);
      Player1.stats = prof;
      Players.add(Player1);
      Units.add(Player1);
      playerSelect(Player1);
      User = Player1;
    }
    if (downkey[84] == true) {
      Units.remove(Players.get(0));
      Players.clear();
      unitPlayer Player1 = new PyroNinja(1, 350, 350, 20, 40); 
      for (int i = 0; i<Enemies.size (); i++) {
        Enemies.get(i).target = Player1;
        println(Enemies.get(i).target);
      }
      statProfile prof = new statProfile(50, 3, 3, 0, 0, 0);
      Player1.stats = prof;
      Players.add(Player1);
      Units.add(Player1);
      playerSelect(Player1);
      User = Player1;
    }

    if (downkey[74] == true) {
      screenMode = "free";
    }
    if (downkey[72] == true) {
      if(hitboxToggle){
        hitboxToggle = false;
      } else {
        hitboxToggle = true; 
      }
    }
    if (downkey[85] == true) {
      if (Controlled.inputDelay < gameTimer) { 
        Controlled.keys[4] = true;
      }
    }
    if (downkey[79] == true) { 
      if (Controlled.inputDelay < gameTimer) { 
        Controlled.keys[5] = true;
      }
    }
  }
}