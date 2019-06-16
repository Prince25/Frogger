
class Car {
  PImage image;
  int width, height;
  int xpos, ypos;
  String heading;
  int distLeft;
  float speed;
  int lane;
  
  Car(PImage img, int resize_x, int resize_y, int start_x, int start_y, String dir, float spd, int strt){
    image = img;
    image.resize(resize_x,resize_y);
    width = resize_x; height = resize_y;  
    xpos = start_x; ypos = start_y;
    heading = dir;
    distLeft = WIDTH + width;
    speed = spd;
    lane = strt;
  }
  
  void display() {
    if (heading == "right") { xpos += speed; distLeft -= speed; displayRight(image, xpos, ypos, PI); }
    else if (heading == "left") { 
      xpos -= speed; 
      distLeft -= speed;
      imageMode(CENTER);
      image(image, xpos, ypos + 2);
      imageMode(CORNER);
    }
  }
  
  // Flips images horizontally
  private void displayRight(PImage pimage, float x, float y, float angle) {
    pushMatrix();
    imageMode(CENTER);
    translate(x, y);
    rotate(angle);
    image(pimage, 0, -9);
    popMatrix();
    imageMode(CORNER);
  }
  
  boolean isGone() { return distLeft <= 0; }

  // Getters
  int getLane() { return lane; }
  int getXpos() { return xpos; }
  int getYpos() {return ypos; }
  int getWidth() { return width; }
  int getHeight() {return height; }
}



// Spawns new cars and checks collision with frog
void handleCars() {
  float speed = random(5, 11);
  int carNum = (int) random(0, 7);
  IntList lanes = new IntList();
  int laneNum = 6;    // 6 lanes, ordered top to bottom
  
  // Add lanes of all cars into list
  for (Car curr : cars) {
    lanes.append(curr.getLane());
  }
  
  // Add cars
  for (int i = 1; i <= laneNum; i++) {  // For each lane
    if (lanes.hasValue(i)) continue;    // Skip if a car is already in this lane
    else {
      int w = round(2.1 * dx), h = round(dy * 2.4);                      // Normal Cars
      if (carNum == 5) { w = round(2.6 * dx); h = round(dy * 2.8); }     // Van
      else if (carNum == 6) { w =  round(4 * dx); h = round(dy * 4); }   // Truck
      
      int laneY = 420 + dy * (i - 1);
      if ((int) random(0, 2) == 0)
        cars.add(new Car(car_images[carNum], w, h, WIDTH, laneY, "left", speed, i));
      else {
        //rotate(HALF_PI);
        cars.add(new Car(car_images[carNum], w, h, 0, laneY, "right", speed, i));
      }
      speed = random(5, 11);
      carNum = (int) random(0, 7);
    }
  }
  
  // Remove off screen cars and display the rest
  for (int i = cars.size() - 1; i >= 0; i--) {
    Car curr = cars.get(i);
    if (curr.isGone()) {
      cars.remove(i);
    }
    else curr.display();
  }
  
  // Check collisions
  int frogX = frog.getXpos(), frogY = frog.getYpos();        // X = left side of frog, Y = top of frog
  if (frogY >= WIDTH / 2) {   // Frog is on the road
    
    for (Car curr : cars) {  // Check each car
      int carX = curr.getXpos() - curr.getWidth() / 2, carY = curr.getYpos() - 20; // X = left of car, Y = top of car
      if (carY == frogY) {  // Frog is in the car's lane
        if (frogX >= carX - 25 && frogX <= carX + curr.getWidth() - 25) loadFrog();  // Subtract for extra transparent space
      }
    }
  
  }
}



void loadCars() {
  String car_names[] = {"audi", "car", "mini_truck", "taxi", "viper", "van", "truck"};
  car_images = new PImage[car_names.length];
  cars = new ArrayList<Car>();

  for (int i = 0; i < car_names.length; i++)
    car_images[i] = loadImage("cars/" + car_names[i] + ".png");
}



void loadAnimatedCars() {
  PImage[] police_car, ambulance_pics;
  police_car = new PImage[3];
  ambulance_pics = new PImage[3];
  
  for (int i = 0; i < 3; i++) {
    police_car[i] = loadImage("police_car/" + (i+1) + ".png");
    //police_car[i].resize(round(2 * dx), round(dy * 2));
    ambulance_pics[i] = loadImage("ambulance/" + (i+1) + ".png");
    //ambulance_pics[i].resize(round(2.2 * dx), round(dy * 2.7));
  }

  police = new Animation(police_car, 3);
  ambulance = new Animation(ambulance_pics, 3); 
}



// Makes an animation loop from images 
class Animation {
  PImage[] images;
  int imageCount;
  int frame;
  
  Animation(PImage[] sprites, int count) {
    imageCount = count;
    images = sprites;
  }

  void display(float xpos, float ypos) {
    imageMode(CENTER);
    frame = (frame + 1) % imageCount;
    image(images[frame], xpos, ypos);
    imageMode(CORNER);
  }
  
  int getWidth() {
    return images[0].width;
  }
}
