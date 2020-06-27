class Plane{
  int posX = 0;
  int posY = 0;
  float rotation = 0;
  
  boolean running = false;
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
    translate(posX, posY);
    stroke(#050096);
    strokeWeight(0);
    fill(#2b24d6);
    triangle(320,120,370,80,370,120);
    rect(370,80,30,40);
    
    fill(20);
    rect(110,135,10,80);
    
    fill(0);
    ellipse(115,210,35,35);
    ellipse(300,210,35,35);
    fill(100);
    ellipse(115,210,25,25);
    ellipse(300,210,25,25);
   
    //CHASIS
    stroke(#050096);
    strokeWeight(0);
    fill(#050096);
    rect(10,100,210,80,20,0,0,20);
    triangle(220,100,220,180,400,120);
        
    //WHEELS
    fill(20);
    rect(110,135,10,80);
    stroke(#050096);
    strokeWeight(4);
    line(250,130,300,210);
    stroke(0);
    strokeWeight(0);
    
    fill(0);
    ellipse(115,210,35,35);
    ellipse(300,210,35,35);
    fill(100);
    ellipse(115,210,25,25);
    ellipse(300,210,25,25);
    
    
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
    rect(320,117,80,10,5);
    
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
    return posX + 110;
  }
  
  int getSeatYPos(){
    return posY + 60;
  }
  
  int getHeight(){
    return posY + 140;
  }
  
  void setPos(int x, int y){
    posX = x - 140;
    posY = 350 - y;
  }
  
  void setRotation(float degrees){
     rotation = degrees;
  }
  
}
