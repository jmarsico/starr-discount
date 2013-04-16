int numCircles = 29;
Circle[] circles = new Circle[numCircles];


void setup(){
  frameRate(30);
  size(displayWidth, displayHeight);
  for(int i =0; i < circles.length; i ++){
  circles[i] = new Circle();
  }
}


void draw(){
  background(255);
 
 for(int i = 0; i < circles.length; i++){
 circles[i].update();
 circles[i].display();
 }
 
}
  
  
  
