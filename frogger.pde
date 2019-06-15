
final int WIDTH   = 600;
final int HEIGHT  = 800;
final int rows    = 16;
final int cols    = 10;
final int dx      = WIDTH / cols;
final int dy      = HEIGHT / rows;
final boolean DEBUG = true;

float waterSpeed;
PImage water, frog, goal;
Car[] cars;
Animation police, ambulance;


void setup() {
  surface.setSize(WIDTH, HEIGHT);
  background(0);  // Black background
  frameRate(30);
 
  waterSpeed = 0;
  water = loadImage("water.png");
  water.resize(300, 300);
  frog = loadImage("frog.png");
  frog.resize(dx, dy);
  goal = loadImage("heart.png");
  goal.resize(dx,dy);
  
  loadCars();
  loadAnimatedCars();
}


void generateBackground() {
  
  // The grass
  boolean alt = false;
  for (int i = 0; i <= WIDTH; i += dx) {
    if (alt) { 
      fill(27,255,0); rect(i, 700, dx, 100);   // Chartreuse
      fill(60,179,113); rect(i, 300, dx, 100); // Middle Grass -  Mediumseagreen
      alt = !alt;  
    } else { 
      fill(50,205,50); rect(i, 700, dx, 100);   // Limegreen
      fill(144,238,144); rect(i, 300, dx, 100); // Middle Grass - Lightgreen
      alt = !alt; 
    } 
  }
  
  // Goal
  image(goal, dx*1, 0); image(goal, dx*3, 0); image(goal, dx*6, 0); image(goal, dx*8, 0);
  
  // Road
  fill(169,169,169);
  rect(0, 400, WIDTH, 300);
  
  // Water
  waterSpeed += 1.5;
  for (int i = -1 * (WIDTH / 2); i <= (WIDTH / 2) * 3; i += (WIDTH / 2))
    image(water, i + waterSpeed, 0);;
  if (waterSpeed >= WIDTH / 2) waterSpeed = 0;
  
}


void draw() {
  noStroke();
  
  generateBackground();
  tint(150, 0, 75);
  image(frog, 300, 600);
  tint(255);
  
  if (mousePressed) {
    cars[6].display(mouseX, mouseY);
  }
  
  
  if (DEBUG) {
    stroke(255,20,147);
    line(0,000,WIDTH,000);
    line(0,300,WIDTH,300);
    line(0,400,WIDTH,400);
    line(0,700,WIDTH,700);
    
    for (int i = 0; i <= WIDTH; i += dx) {
      if (i == WIDTH / 2) stroke(0); else stroke(255,20,147);
      line(i, 0, i, HEIGHT);
    }
    
    for (int i = 0; i <= HEIGHT; i += dy) {
      if (i == HEIGHT / 2) stroke(0); else stroke(255,255,0);
      line(0, i, WIDTH, i);
    }
    
  }
  
}
