import java.util.Map;

String [] loadedStrings = new String[4];
int [] data = new int[8];
int scene;
int entities;
PGraphics pg;
boolean keyReleased,hitboxToggle;
ArrayList<SpawnBox> SpawnBoxes = new ArrayList<SpawnBox>();
ArrayList<Animation> AAnimations = new ArrayList<Animation>();
ArrayList<Hurtbox> Hurtboxes= new ArrayList<Hurtbox>();
ArrayList<Hitbox> Hitboxes= new ArrayList<Hitbox>();
ArrayList<Unit> Units= new ArrayList<Unit>();
ArrayList<Unit> Players= new ArrayList<Unit>();
ArrayList<Terrain> Terrains= new ArrayList<Terrain>();
ArrayList<Unit> Enemies = new ArrayList<Unit>();
HashMap<String, HashMap> spriteLists = new HashMap<String, HashMap>();
int nrkey = 0;
PFont font;
boolean[] downkey = new boolean[256];


void printText(float x, float y, float size, String text, float c1, float c2, float c3) {
  //prints text with variations in size, color and position
  textSize(size);   
  textAlign(CENTER);
  fill(c1, c2, c3);
  text(text, x, y);
}

void printTextPG(float x, float y, float size, String text, float c1, float c2, float c3) {
  //prints text with variations in size, color and position
  pg.textSize(size);   
  pg.textAlign(CENTER);
  pg.fill(c1, c2, c3);
  pg.text(text, x, y);
}

void Multi_Key_Handle() {
  nrkey = 0;
  for (int i=0; i<downkey.length; i++) {
    if (downkey[i]) {
      nrkey++;
    }
  }
}

void keyPressed() {
  keyReleased = false; 
  if (keyCode<256) {
    downkey[keyCode] = true;
  }
}

void keyReleased() {
  keyReleased = true; 
  if (keyCode<256) {
    downkey[keyCode] = false;
  }
}

boolean inRange(float x1, float y1, float x2, float y2, float xz1, float yz1, float xz2, float yz2) {
  //Tests to see if a certain x and y coordinate is within another x and y coordiante range
  boolean flag1 = x1 < x2 + xz2 && x1 + xz1 > x2;
  boolean flag2 = y1 < y2 + yz2 && y1 + yz1 > y2; 
  if (flag1 && flag2) {
    return true;
  } else {
    return false;
  }
}

boolean checkTerrain(Terrain t1, float x, float y,float xsize,float ysize) {
  boolean withinX = x >= t1.x && x <= t1.x + t1.Length; 
  boolean onTop = y + ysize/2 >= t1.y && y + ysize/2 < t1.y + t1.Height*.75;
  boolean onBottom = y - ysize/2 <= t1.y + t1.Height && y - ysize/2 > t1.y +t1.Height*.25;
  boolean withinY = y <= t1.y +t1.Height && y >= t1.y;
  boolean onLeft = x - xsize/2 <= t1.x +t1.Length && x - xsize/2 > t1.x +t1.Length/2;
  boolean onRight = x + xsize/2 >= t1.x && x + xsize/2 < t1.x + t1.Length/2;
  if(withinX && withinY){
   return true; 
  } else {
   return false;  
  }
}

void setup() { 
  pg = createGraphics(1080, 600);
  loadImages();
  frameRate(60);
  scene = 1;
  background(90); 
  size(1080, 600);
}

void draw() {
  Multi_Key_Handle();
  background(90);
  drawScene();
}

void drawScene() {
  if (scene == 1) {
    drawMainMenu();
  }
  if (scene == 2) {
    runGameScreen();
  }
}