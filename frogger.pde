
final int WIDTH   = 600;
final int HEIGHT  = 800;
final int rows    = 16;
final int cols    = 10;
final int dx      = WIDTH / cols;
final int dy      = HEIGHT / rows;
final boolean DEBUG = false;

float waterSpeed;
PImage water, goal;
PImage[] car_images;
PImage[] log_images;
Frog frog;
Animation police, ambulance;
ArrayList<Car> cars;
ArrayList<Log> logs;



void setup() {
  surface.setSize(WIDTH, HEIGHT);
  background(0);  // Black background
  frameRate(30);
 
  waterSpeed = 0;
  water = loadImage("water.png");
  water.resize(300, 300);
  goal = loadImage("heart.png");
  goal.resize(dx,dy);
  
  loadFrog();
  loadCars();
  loadAnimatedCars();
  loadLogs();
}



void draw() {
  noStroke();
  
  generateBackground();
  handleLogs();
  frog.display();
  handleCars();
  

  if (DEBUG && mousePressed) {
    police.display(mouseX, mouseY);
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



void loadFrog() {
  frog = new Frog(dx - 5, dy - 5, dx * (int) random(1, 10), 750 - dy * (int) random(0, 1.9));
  if (DEBUG) println(frog.getXpos(), frog.getYpos());
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
    
  // Road
  fill(169,169,169);
  rect(0, 400, WIDTH, 300);
  
  // Water
  waterSpeed += 1.5;
  for (int i = -1 * (WIDTH / 2); i <= (WIDTH / 2) * 3; i += (WIDTH / 2))
    image(water, i + waterSpeed, 0);;
  if (waterSpeed >= WIDTH / 2) waterSpeed = 0;
  
  // Goal
  image(goal, dx*1, interpolate(0, 4, 2500, 0.5)); image(goal, dx*3, interpolate(0, 6, 2000, 0.5)); 
  image(goal, dx*6, interpolate(0, 5, 2500, 0.5)); image(goal, dx*8, interpolate(0, 3, 2500, 0.5));
}



void keyPressed() {
  if (key == 'w') frog.move(0, -1 * dy);
  if (key == 'a') frog.move(-1 * dx, 0);
  if (key == 'd') frog.move(dx, 0);
  if (key == 's') frog.move(0, dy);
  if (key == 'r') loadFrog();
  if (DEBUG) println(frog.getXpos(), frog.getYpos());
}



/* Interpolates between two values
   Interval - Changes the duration between initial and final
   verticalOffset - Increases initial and final by the same amount */
int interpolate(int initial_val, int final_val, int interval, float verticalOffset) {
  float function = sin(PI * round(millis()) / interval) + verticalOffset;
  return floor(initial_val + function * (final_val - initial_val));
}
