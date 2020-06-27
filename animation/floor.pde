class Floor{
  private int cameraHeight;
  
  public Floor(){
    cameraHeight = 0;  
  }
  
  void setCameraHeight(int cameraHeight){
    this.cameraHeight = cameraHeight;
  }
  
  void draw(){
    pushMatrix();
    stroke(0);
    fill(40);
    rect(0,550 - cameraHeight,width, height - 500 + cameraHeight);
    popMatrix();
  }
}
