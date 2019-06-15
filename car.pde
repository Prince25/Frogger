
class Car {
  PImage image;
  int width, height;
  
  Car(PImage img, int x, int y){
    image = img;
    image.resize(x,y);
    width = x;
    height = y;
  }
  
  void display(float xpos, float ypos) {
    image(image, xpos, ypos);
  }
  
  int getWidth() { return width; }
  int getHeight() {return height; }
}




void loadCars() {
  String car_names[] = {"audi", "car", "mini_truck", "taxi", "viper", "van", "truck"};
  cars = new Car[car_names.length];
  PImage car;
  
  // Normal Cars
  for (int i = 0; i < 5; i++) {
    car = loadImage("cars/" + car_names[i] + ".png");
    cars[i] = new Car(car, round(2.1 * dx), round(dy * 2.4));
  }
  
  // Van
  car = loadImage("cars/" + car_names[5] + ".png");
  cars[5] = new Car(car, round(2.6 * dx), round(dy * 2.8));
  
  // Truck
  car = loadImage("cars/" + car_names[6] + ".png");
  cars[6] = new Car(car, round(4 * dx), round(dy * 4));
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
