class SpawnBox { 
  float x, y;
  int timer;
  int spawnDelay;
  SpawnBox(float x1, float y1, int spawnDelay1) {
    x = x1;
    y = y1;
    timer = spawnDelay1/5;
    spawnDelay = spawnDelay1;
    SpawnBoxes.add(this);
  }
  void run() {
    if (timer <  gameTimer && Enemies.size() < maxEnemies) {
      spawnEnemy();
    }
  }

  void spawnEnemy() {
    int choice = int(random(0,2));
    if(choice == 0){
    charWasp E = new charWasp(2, x, y, 20, 40, Players.get(0), 300, 1000); 
    statProfile prof = new statProfile(10, 2, 1, 0, 0, 0);
    E.stats = prof;
    Enemies.add(E);
    Units.add(E);
    timer = spawnDelay + gameTimer;
    }
    if(choice == 1){
    charDrone E = new charDrone(2, x, y, 20, 40, Players.get(0), 300, 1000); 
    statProfile prof = new statProfile(10, 2, 1, 0, 0, 0);
    E.stats = prof;
    Enemies.add(E);
    Units.add(E);
    timer = spawnDelay + gameTimer;  
    }
  }
}