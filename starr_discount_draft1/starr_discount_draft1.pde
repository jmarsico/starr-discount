import org.openkinect.*;
import org.openkinect.processing.*;

Kinect kinect;
KinectTracker tracker;

int numCircles = 30;
Circle[] circles = new Circle[numCircles];


Attractor attractor;
float attX, attY;


void setup() {
  frameRate(30);
  size(displayWidth, displayHeight);
  attractor = new Attractor();
  for (int i =0; i < circles.length; i ++) {
    circles[i] = new Circle();
  }
}



void draw() {
  background(0);
  

  attractor.display();
  attractor.update();
  
   

  for (int i = 0; i < circles.length; i++) {
    PVector attForce = attractor.attract(circles[i]);
    circles[i].applyForce(attForce);
    circles[i].update();
    circles[i].display();
    circles[i].checkEdges();
  }
}



