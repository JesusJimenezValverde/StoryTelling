class Boy {
  int posX = 0;
  int posY = 0;
  
  float lArmA = 135;
  float rArmA = 45;
  float lLegA = 260;
  float rLegA = 280;
  
  boolean happy = true;
  
  String text = "";
  
  Boy(int initX, int initY){
    posX = initX;
    posY = initY;
  }
  
  void draw(){
    pushMatrix();
    translate(posX,posY);
    
    strokeWeight(2);
    stroke(0);
    
    drawLine(-10, 37, 20, lArmA);
    drawLine(10, 37, 20, rArmA);
    drawLine(-5,73,30,lLegA);
    drawLine(5,73,30,rLegA);
    
    fill(#3232FF);
    ellipse(0,50,20,50);//cuerpo
    fill(255);
    ellipse(0,0,50,50);//cabeza
    
    fill(0);
    ellipse(-10,-3,6,6);//ojo izquierdo
    ellipse(10,-3,6,6);//ojo derecho
    fill(150);
    if (happy){
      arc(0, 10, 10, 10, 0, PI, OPEN);
    } else {
      arc(0, 10, 10, 10, PI, TWO_PI, OPEN);
    }
    
    textSize(20);
    fill(255);
    text(text, 35, -40); 
    
    popMatrix();
  }
  
  void setHappy(boolean happy){
    this.happy = happy; 
  }
  
  void showText(String text){
    this.text = text;
  }
  
  void hideText(){
    this.text = "";
  }
  
  void setPos(int posX, int posY){
    this.posX = posX;
    this.posY = posY;
  }
  
  void setLAR(int a){
    lArmA = a;
  } 
  void setRAR(int a){
    rArmA = a;
  }
}
