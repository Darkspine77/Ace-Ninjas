Unit User;
boolean Paused = false; 
String screenMode = "free";
int gameTimer;
int gameTimerDelay;
float Gxvel, Gyvel;
void Pause() { 
  if (!Paused) {
    Paused = true;
  } else if (Paused) {
    gameTimerDelay = millis() - gameTimer; 
    Paused = false;
  }
}

void runGameScreen() {
  pg.beginDraw();
  pg.background(255);
  image(pg, 0, 0);
  playerControl();
  pg.translate(Players.get(0).x, Players.get(0).y);
  if (!Paused) {
    gameTimer = millis()-gameTimerDelay;
  }
  for (int i = 0; i<Hitboxes.size (); i++) {
    Hitboxes.get(i).run();
  }
  for (int i = 0; i<Hurtboxes.size (); i++) {
    Hurtboxes.get(i).run();
  }
  for (int i = 0; i<AAnimations.size (); i++) {
    AAnimations.get(i).run();
  }
  for (int i = 0; i<Units.size (); i++) {
    Units.get(i).run();
  }
  for (int i = 0; i<Terrains.size (); i++) {
    Terrains.get(i).run();
  }
  for (int i = 0; i<SpawnBoxes.size (); i++) {
    SpawnBoxes.get(i).run();
  }
  pg.endDraw();
  gameHUD();
  if (Players.get(0).stats.Health <= 0) {
    scene = 1;
  }
}

void loadPlayer() {
  unitPlayer Player1 = new BladeNinja(1, 350, 350, 20, 40); 
  statProfile prof = new statProfile(50, 3, 3, 0, 0, 0);
  Player1.stats = prof;
  Players.add(Player1);
  Units.add(Player1);
  playerSelect(Player1);
  User = Player1;
}

void gameHUD() {
  //text(frameRate,width/2,30);
}