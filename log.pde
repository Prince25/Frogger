
class Log {
  PImage image;
  int width, height;
  int xpos, ypos;
  String heading;
  int distLeft;
  float speed;
  int lane;
  
  Log(PImage img, int resize_x, int resize_y, int start_x, int start_y, String dir, float spd, int strt){
    image = img.copy();
    image.resize(resize_x, resize_y);
    width = resize_x; height = resize_y;  
    xpos = start_x; ypos = start_y;
    heading = dir;
    distLeft = WIDTH + 2 * width;
    speed = spd;
    lane = strt;
  }
  
  void display() {
    if (heading == "right") { xpos += speed; distLeft -= speed; displayRight(image, xpos, ypos, PI); }
    else if (heading == "left") { 
      xpos -= speed; 
      distLeft -= speed;
      imageMode(CENTER);
      image(image, xpos, ypos);
      imageMode(CORNER);
    }
  }
  
  // Flips images horizontally
  private void displayRight(PImage pimage, float x, float y, float angle) {
    pushMatrix();
    imageMode(CENTER);
    translate(x, y);
    rotate(angle);
    image(pimage, 0, 0);
    popMatrix();
    imageMode(CORNER);
  }
  
  boolean isGone() { return distLeft <= 0; }

  // Getters
  int getLane()    { return lane; }
  int getXpos()    { return xpos; }
  int getYpos()    { return ypos; }
  int getWidth()   { return width; }
  int getHeight()  { return height; }
  float getSpeed() { return speed; }
  String getHeading() { return heading; }
}



// Spawns new logs and checks collision with frog
void handleLogs() {
  float speed = random(3, 8);
  IntList lanes = new IntList();
  int laneNum = 5;    // 6 lanes, ordered top to bottom
  int logPic = (int) random(0, 3);
  
  // Add lanes of all logs into list
  for (Log curr : logs) {
    lanes.append(curr.getLane());
  }
  
  // Add logs
  for (int i = 1; i <= laneNum; i++) {  // For each lane
    if (lanes.hasValue(i)) continue;    // Skip if a log is already in this lane
    else {
      String dir = "left"; int start = WIDTH; int w; 
      int laneY = 25 + dy * i;
      if (i == 5) { w = dx * (int) random(2, 6); start += w; }
      else if (i == 4 || i == 2) { dir = "right"; w = dx * (int) random(2, 5); start = -1 * w; }
      else if (i == 3) { w = dx * (int) random(1, 3); start += w; }
      else { 
        w = dx * (int) random(1, 5);  
        if ((int) random(0, 2) == 0) { dir = "right"; start = -1 * w; }
        else { start += w; }
      }
      
      logs.add(new Log(log_images[logPic], w, dy, start, laneY, dir, speed, i));
      
      speed = random(3, 8);
      logPic = (int) random(0, 3);
    }
  }
  
  // Remove off screen logs and display the rest
  for (int i = logs.size() - 1; i >= 0; i--) {
    Log curr = logs.get(i);
    if (curr.isGone()) logs.remove(i);
    else curr.display();
  }
  
  // Check collisions
  float frogX = frog.getXpos(), frogY = frog.getYpos();        // X = left side of frog, Y = top of frog
  if (frogY < HEIGHT / 2) {   // Frog is on the water
    
    for (Log curr : logs) {  // Check each car
      int logX = curr.getXpos() - curr.getWidth() / 2, logY = curr.getYpos() - 25; // X = left of log, Y = top of log
      if (logY == frogY) {  // Frog is in the car's lane
        if (frogX < logX || frogX > logX + curr.getWidth()) loadFrog();  // Subtract for extra transparent space
        else {
          switch (curr.getLane()) {
           case 2:
           case 4: frog.setXpos(frogX + curr.getSpeed()); break;
           
           case 3:
           case 5: frog.setXpos(frogX - curr.getSpeed()); break;
           
           case 1:
             if (curr.getHeading() == "left") frog.setXpos(frogX + curr.getSpeed());
             else if (curr.getHeading() == "right") frog.setXpos(frogX - curr.getSpeed());
             break;
          }
          
        }
      }
    }
  }
  
}



void loadLogs() {
  log_images = new PImage[3];
  logs = new ArrayList<Log>();

  for (int i = 0; i < 3; i++)
    log_images[i] = loadImage("logs/" + (i+1) + ".png");
}
