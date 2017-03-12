class Terrain {
  float x, y, sx, sy, xvel, yvel, Length, Height, xMax, yMax;
  int xrange, yrange;
  PImage img = loadImage("terrain_brick.png");;
  Terrain(float x1, float y1, float Length1, float Height1, float xvel1, float yvel1, int xrange1, int yrange1) {
    x = x1;
    y = y1;
    sx = x1;
    sy = y1;
    xvel = xvel1;
    yvel = yvel1;
    xrange = xrange1;
    yrange = yrange1;
    Length = Length1;
    Height = Height1;
  }

  void run() {
    render(); 
    if (!Paused) {
      redirect();
      movement();
    }
  }
  void redirect() {
    if (y >= sy + yrange || y <= sy - yrange) {
      yvel *= -1;
    }
    if (x >= sx + xrange || x <= sx - xrange) {
      xvel *= -1;
    }
  }
  void movement(){
   x += xvel;
   y += yvel;
  }
  void render() {
    pg.noStroke();
    pg.fill(0,0,255);
    pg.rect(x,y,Length,Height);
    //for(int i = 0;i<Length/img.width;i++){
    // for(int c = 0;c<Height/img.height;c++){
    // pg.image(img,x + i * img.width,y + c * img.height);
    // }
    //}
  }
}