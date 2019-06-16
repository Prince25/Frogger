
class Frog {
 PImage image;
 int width, height;
 int xpos, ypos;
  
 Frog(int resize_x, int resize_y, int x, int y) {
  image = loadImage("frog.png");
  image.resize(resize_x, resize_y);
  width = resize_x; height = resize_y;
  xpos = x; ypos = y;
 }
 
 void display() {
    //imageMode(CENTER);
    image(image, xpos, ypos);
    //imageMode(CORNER);
  }
  
  void move(int x, int y) {
    if (withinBounds(x,y)) {
      xpos += x;
      ypos += y;
    }
  }
  
  private boolean withinBounds(int x, int y) {
    if (ypos + y >= 800 || ypos + y < 0) return false;
    if (xpos + x >= 600 || xpos + x < 0) return false;
    return true;
  }
 
 
 // Setters
 void setXpos(int x) { xpos = x; }
 void setYpos(int y) { ypos = y; }
 
 
 // Getters
 int getXpos() { return xpos; }
 int getYpos() {return ypos; }
 int getWidth() { return width; }
 int getHeight() {return height; }
}
