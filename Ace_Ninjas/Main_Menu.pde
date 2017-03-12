void drawMainMenu() {
  stroke(255, 0, 0); 
  printText(width/2, height/4, 48, "Ace Ninjas", 255, 0, 0);
  Button Start = new Button(width/2, height/2 - 20, "Start", 24, 0, 255, 0); 
  if (Start.isClicked()) {
    Units.clear();
    Players.clear();
    Enemies.clear();
    SpawnBoxes.clear();
    loadPlayer();
    loadTerrain();
    for (int i = 0; i<2 * levelLength; i++) {
        SpawnBox test = new SpawnBox(int(random(100, levelLength * 1000 - 100)), int(random(-210, 250)), 5000);
    }
    scene = 2;
  }
  Start.drawMe();
}