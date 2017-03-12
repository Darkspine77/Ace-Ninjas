void loadImages() {
  spriteList("Shadow_Ninja");
  spriteList("Blade_Ninja");
  spriteList("Drone");
  spriteList("Shuriken");
  spriteList("Shadow");
  spriteList("Beast_Ninja");
  spriteList("Pyro_Ninja");
  spriteList("Fireball");
  spriteList("Wasp");
} 
void spriteList(String directoryName) { 
  File dir = new File(dataPath(directoryName));
  String[] list = dir.list();
   HashMap<String,PImage> spriteList = new HashMap<String,PImage>();
  for (int i = 0; i<list.length; i++) {
    spriteList.put(list[i].substring(0,list[i].length() - 4),loadImage(directoryName + "/" + list[i]));
  }
  spriteLists.put(directoryName,spriteList);
}