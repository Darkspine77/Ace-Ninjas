class Button {
  PImage img;
  float x;
  float y;
  float xsize, ysize, size;
  boolean flag;
  String text = "null";
  float C1, C2, C3;
  String image1 = "null";
  int timer = millis();
  Button(float X, float Y, String Text, float size1, float c1, float c2, float c3) {
    x = X;
    y = Y;
    size = size1;
    text = Text;
    C1 = c1;
    C2 = c2;
    C3 = c3;
    image1 = null;
    defineBounderies();
  }
  Button(float X, float Y, String image) {
    x = X;
    y = Y;
    image1 = image; 
    imageMode(CENTER); 
    img = loadImage(image1);
    defineBounderies();
  }
  
  void defineBounderies(){
  xsize = (text.length() * size)/4;
  ysize = (size)/4;
  }
  void drawMe() {
    //stroke(125,0,255);
    //line(0,(y + ysize/2) + ysize,width,(y + ysize/2) + ysize); 
    //line(x + xsize,0,x + xsize,height); 
    //stroke(0,125,255);
    //line(x - xsize,0,x - xsize,height); 
    //line(0,(y - ysize/2) - ysize,width,(y - ysize/2) - ysize);
    //Draws this instance of a button 
    textSize(size);  
    textAlign(CENTER);
    fill(C1, C2, C3); 
    if (text != "null") {
     text(text, x, y + ysize);
    }
    if (image1 != null) {
      image(img, x, y, xsize*2, ysize*2);
    } 
    
  }
  
  boolean buttonRange(float x, float y, float x2, float y2, float xz, float yz) {
  //Tests to see if a certain x and y coordinate is within another x and y coordiante range
  if (x <= (x2 - xz)+(xz * 2) && y <= (y2+ - yz)+(yz * 2) && x >= (x2+ xz)-(xz * 2) && y >= (y2+ yz)-(yz * 2)){
    return true;
  } else {
    return false;
  }
}
  boolean isClicked() {
    //Detects to see if this button is pressed
    flag = mousePressed && buttonRange(mouseX, mouseY, x, y, xsize, ysize);
    if (flag & timer <= millis()) {
      timer = millis() + 250;
      return true;
    } else {
      return false;
    }
  }
}