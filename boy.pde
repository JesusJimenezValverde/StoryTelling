int armAngle = 0;
int angleChange = 1;
final int ANGLE_LIMIT = 25;
int spaceX = 300;
int spaceY = 200;

void draw(){
 
  pushMatrix();
  drawBoy();
  armAngle += angleChange;
  
  // if the arm has moved past its limit,
  // reverse direction and set within limits.
  if (armAngle > ANGLE_LIMIT || armAngle < 0)
  {
    angleChange = -angleChange;
    armAngle += angleChange;
  }
  popMatrix();
  
}

void drawBoy(){
  
  println("eje x "+spaceX+" eje y "+spaceY);
 background(255);
 
 line(spaceX-10,spaceY+37,spaceX-30,spaceY+50);//brazo izquierdo
 //line(spaceX+10,spaceY+37,spaceX+30,spaceY+30);//brazo derecho
 drawArm();
 line(spaceX+5,spaceY+75,spaceX+10,spaceY+105);//pierna derecha
 line(spaceX-5,spaceY+75,spaceX-10,spaceY+105);//pierna izquierda
 
 fill(#3232FF);
 ellipse(spaceX,spaceY+50,20,50);//cuerpo
 fill(255);
 ellipse(spaceX,spaceY,50,50);//cabeza
 
 fill(0);
 ellipse(spaceX-10,spaceY-3,6,6);//ojo izquierdo
 ellipse(spaceX+10,spaceY-3,6,6);//ojo derecho
 fill(150);
 arc(spaceX, spaceY+10, 10, 10, 0, PI, OPEN);
}

void drawArm(){
  pushMatrix();
  translate(spaceX+10, spaceY+37);
  rotate(radians(armAngle));
  line(0, 0,20,-7);//brazo derecho
  popMatrix();
}
