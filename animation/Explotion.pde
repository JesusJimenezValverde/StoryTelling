class Explotion {
  int posX = 0;
  int posY = 0;
  
  Explotion(int initX, int initY){
    posX = initX;
    posY = initY;
  }
  void draw() {
  
    pushMatrix();
    translate(posX, posY);
    for (int i = 6; i>0; i--){ 
      rotate(frameCount / -100.0+i*20);
      fill(color(255, random(255), random(255)));
      star(0, 0, 40+i*20, 70+i*20, 5+i*2); 
    }    
    popMatrix();
  }
  
  void star(float x, float y, float radius1, float radius2, int npoints) {
    float angle = TWO_PI / npoints;
    float halfAngle = angle/2.0;
    beginShape();
    for (float a = 0; a < TWO_PI; a += angle) {
      float sx = x + cos(a) * radius2;
      float sy = y + sin(a) * radius2;
      vertex(sx, sy);
      sx = x + cos(a+halfAngle) * radius1;
      sy = y + sin(a+halfAngle) * radius1;
      vertex(sx, sy);
    }
    endShape(CLOSE);
  }
}
