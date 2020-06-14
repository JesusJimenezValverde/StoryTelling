Boy boy = new Boy(300,300);
Plane plane = new Plane(0,0);

void setup(){
  size(800,600);
  frameRate(60);
  draw();
}

void draw(){
 
  pushMatrix();
  background(55, 175, 222);
  
  boy.setPos(plane.getSeatXPos(), plane.getSeatYPos());
  boy.draw();
  plane.draw();
  
  popMatrix();
  
}

void drawLine(int x, int y, int length, float angle){
  line(x, y, x + length * cos(radians(-angle)), y + length * sin(radians(-angle)));
}
