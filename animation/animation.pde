import themidibus.*;

Boy boy = new Boy(300,300);
Plane plane = new Plane(0,0);
Floor floor = new Floor();
Cloud cloud1 = new Cloud();
Cloud cloud2 = new Cloud();
Cloud cloud3 = new Cloud();
Explotion explotion = new Explotion(350,450);

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
  
  if (sceneNumber == 1){
    boy.showText("Qué tuanis un\n vuelito hoy!");
    floor.setCameraHeight(0);
    plane.setPos(200, 0);
    boy.setPos(600, 480);
    boy.setLAR(-100);
    boy.setRAR(-80);
    boy.setHappy(true);
  } else
  if (sceneNumber == 2){
    boy.showText("Vamo a darle");
    plane.setPos(350, 0);
    boy.setPos(int(plane.getSeatXPos()), int(plane.getSeatYPos()));
  } else
  if (sceneNumber == 3){
    cloud1.move();
    cloud2.move();
    cloud3.move();
    //Set plane height
    //plane.setPos(350, planeHeight);
    
    if (plane.getHeight() < planeHeight){
      plane.goUp();
    } else
    if (plane.getHeight() > planeHeight){
      plane.goDown();
    }
    
    boy.setPos(int(plane.getSeatXPos()), int(plane.getSeatYPos()));
  }
  
  
  
  cloud1.draw();
  cloud2.draw();
  cloud3.draw();
  
  floor.draw();
  boy.draw();
  plane.draw();
  
  if (sceneNumber == 4){
    plane.setPos(350, 0);
    boy.setPos(int(plane.getSeatXPos()), int(plane.getSeatYPos()));
    explotion.draw(); 
  }
  
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
  println("New note --> "+pitch);
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
      println("Crash");
    }
  } else 
  if (channel == 2){
    planeHeight = int(map(pitch, 62, 84, 0, 200));
    println("Plane High -->"+planeHeight);
  } else 
  if (channel == 3){
    if (pitch == 0){
      plane.stop();
      boy.setHappy(false);
      boy.showText("NOOOOOOOO!");
      boy.setLAR(130);
      boy.setRAR(50);
    } else {
      plane.start();
    }
  }
}
