
class Plane{
  int posX = 0;
  int posY = 0;
  
  boolean running = true;
  float runningSpeed = 0;
  float state = 0;
  
  Plane(int initX, int initY){
    posX = initX;
    posY = initY;
  }
  
  void start(){
     running = true;
  }
  
  void stop(){
     running = false; 
  }
  
  
  void draw(){
    pushMatrix();
    posX = mouseX;
    posY = mouseY;
    translate(posX, posY);
    
    //CHASIS
    stroke(#050096);
    strokeWeight(0);
    fill(#050096);
    rect(10,100,210,80,20,0,0,20);
    triangle(220,100,220,180,400,120);
    
    //
    fill(100);
    rect(0,135,10,10);
    fill(0);
    ellipse(5,140,8,max(100 * sin(radians(state)), 8));
    
    //WINDSHIELD
    fill(#92c5d1);
    arc(75, 100, 60, 50, PI, PI+HALF_PI, PIE);
    
    //WING
    fill(#2b24d6);
    rect(70,130,100,20,5);
    
    if(running){
      if(runningSpeed < 30.2)
        runningSpeed += 0.1;
    } else if(runningSpeed > 0) {
        runningSpeed -= 0.2;
    }
    state = (state + runningSpeed) % 180;
    
    popMatrix();
  }
  
  int getSeatXPos(){
    return posX;
  }
  
  int getSeatYPos(){
    return posY;
  }
  
}
