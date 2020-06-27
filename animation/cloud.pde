

class Cloud{
  int posX = -100;
  public Cloud(){}
  
  
  void draw(){
    pushMatrix();
    strokeWeight(0);
    stroke(255);
    fill(255);
    translate(posX, 100);
    circle(10,20,30);
    circle(30,20,30);
    circle(60,20,30);
    circle(0,0,30);
    circle(20,0,30);
    circle(40,0,30);
    circle(10,40,30);
    circle(30,40,30);
    circle(60,40,30);
    popMatrix();
  }
  
  void move(){
    posX++; 
  }
}
