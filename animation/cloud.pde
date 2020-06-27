

class Cloud{
  int posX = -150;
  int posYOffset = 100;
  public Cloud(){
    posX += int(random(-200,200));
    posYOffset += int(random(-100,100));
  }
  
  
  void draw(){
    pushMatrix();
    strokeWeight(0);
    stroke(255);
    fill(255);
    translate(posX, posYOffset);
    circle(5,15,30);
    circle(15,10,30);
    circle(20,20,30);
    circle(25,15,30);
    circle(25,5,30);
    circle(30,20,30);
    circle(35,10,30);
    circle(40,5,30);
    circle(45,15,30);
    circle(50,10,30);
    popMatrix();
  }
  
  void move(){
    posX++; 
  }
}
