

void keyPressed() {
  if (key == 'w') frog.move(0, -1 * dy);
  if (key == 'a') frog.move(-1 * dx, 0);
  if (key == 'd') frog.move(dx, 0);
  if (key == 's') frog.move(0, dy);
  if (key == 'r') loadFrog();
  if (DEBUG) println(frog.getXpos(), frog.getYpos());
}
