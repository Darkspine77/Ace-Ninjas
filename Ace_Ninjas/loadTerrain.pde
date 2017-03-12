int levelLength = 3;
void loadTerrain() { 
  nodeList();
  Terrains.clear();
  Terrain backWall = new Terrain(0,-250,60,600,0,0,0,0);
  Terrain celling = new Terrain(0,-310,1000 * levelLength,60,0,0,0,0);
  Terrain floor = new Terrain(0,350,1000 * levelLength,60,0,0,0,0);
  Terrain endWall = new Terrain(1000 * levelLength,-310,60,720,0,0,0,0);
  Terrains.add(backWall);
  Terrains.add(endWall);
  Terrains.add(celling);
  Terrains.add(floor);
  String [] nodes = nodeList();
  for (int x = 0; x<levelLength; x++) {
    loadedStrings = loadStrings("data/Nodes/" + nodes[int(random(nodes.length))]);
    for (int i = 0; i<loadedStrings.length; i++) {
      data = int(split(loadedStrings[i], ','));
      Terrain Terrain1 = new Terrain((x * 1000) + data[0], data[1], data[2], data[3], data[4], data[5], data[6], data[7]);
      Terrains.add(Terrain1);
    }
  }
}

String [] nodeList() { 
  File dir = new File(dataPath("Nodes"));
  return dir.list();
}  