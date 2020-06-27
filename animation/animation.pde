import themidibus.*;

Boy boy = new Boy(300,300);
Plane plane = new Plane(0,0);
Floor floor = new Floor();
Cloud cloud = new Cloud();

int planeHeight = 0;

int sceneNumber = 0;

MidiBus midiBus;
int mbChannel, mbNote, mbValue;

float time = 0;

void setup(){
  size(800,600);
  frameRate(60);
  MidiBus.list();
  midiBus = new MidiBus(this, 0, 1);
  
  
  //Animation Starting
  floor.setCameraHeight(planeHeight);
  plane.setPos(200, planeHeight);
  boy.setPos(600, 480);
  boy.setLAR(-100);
  boy.setRAR(-80);
  
  
  draw();
}

void draw(){
 
  pushMatrix();
  background(55, 175, 222);
  
  //If flying
  if (sceneNumber == 1){
    
  } else
  if (sceneNumber == 2){
    plane.setPos(350, 0);
    boy.setPos(plane.getSeatXPos(), plane.getSeatYPos());
  } else
  if (sceneNumber == 3){
    cloud.move();
    //Set plane height
    plane.setPos(350, planeHeight);
    /*
    if (plane.getHeight() < planeHeight - 1){
      plane.setPos(350, plane.getHeight() + (planeHeight - plane.getHeight()) / 60 ); 
    } else
    if (plane.getHeight() > planeHeight + 1){
      plane.setPos(350, plane.getHeight() - (plane.getHeight() - planeHeight) / 60 ); 
    }
    */
    boy.setPos(plane.getSeatXPos(), plane.getSeatYPos());
  }
  
  
  cloud.draw();
  floor.draw();
  boy.draw();
  plane.draw();
  
  
  popMatrix();
  time += 0.05;
}

void drawLine(int x, int y, int length, float angle){
  line(x, y, x + length * cos(radians(-angle)), y + length * sin(radians(-angle)));
}

void noteOn(int channel, int pitch, int velocity) {
  mbChannel = channel;
  mbNote = pitch;
  mbValue = velocity;
  if (channel == 1) {
    if (pitch == 60){
      sceneNumber = 1; 
    } else 
    if (pitch == 61){
      sceneNumber = 2;
    } else
    if (pitch == 62){
      sceneNumber = 3;
    } else 
    if (pitch == 10){
      sceneNumber = 4;
    }
  } else 
  if (channel == 2){
    planeHeight = int(map(pitch, 62, 84, 0, 300)); 
  } else 
  if (channel == 3){
    if (pitch == 0){
      plane.stop();
      boy.setHappy(false);
    } else {
      plane.start();
    }
  }
  
  println("Channel: " + str(mbChannel) + " Number: " + str(mbNote) + " Value: " + str(mbValue));
}
