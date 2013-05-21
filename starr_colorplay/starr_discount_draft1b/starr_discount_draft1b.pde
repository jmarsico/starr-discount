int numCircles = 30;
Circle[] circles = new Circle[numCircles];

float attX, attY;


void setup() {
  frameRate(30);
  size(displayWidth, displayHeight);
  
  //build the circles
  for (int i =0; i < circles.length; i ++) {
    circles[i] = new Circle();
  }
}



void draw() {
  background(#e16a62);


  for (int i = 0; i < circles.length; i++) {
    circles[i].update();
    circles[i].display();
    circles[i].checkEdges();
  }
}

