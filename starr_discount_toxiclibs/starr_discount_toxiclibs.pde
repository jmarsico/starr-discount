import toxi.physics2d.*;
import toxi.physics2d.behaviors.*;
import toxi.geom.*;

VerletPhysics2D physics;

int lastTimeCheck;
int timeIntervalFlag = 50;

Vec2D mousePos;
AttractionBehavior mouseAttractor;




ArrayList<Circle> circles;   //initiate an ArrayList of Circle objects
int numCircles = 10;         // number of circle objects


void setup() {
  size(1000, 800);
  lastTimeCheck = millis(); //used for timer
  physics = new VerletPhysics2D();   //set up physics "world"
  //physics.setWorldBounds(new Rect(0, 0, width, height));  // make the physics world match the pixel world
  physics.setDrag(0.03);
  physics.addBehavior(new GravityBehavior(new Vec2D(0, 0.1)));
  
 


  //create the circles
  circles = new ArrayList<Circle>();
  for (int i = 0; i < numCircles; i ++) {
    circles.add(new Circle(new Vec2D(random(0, width), random(-400, 0))));
  }
}


void draw() {
  background(0);
  physics.update ();
  
  
  if(millis() > lastTimeCheck + timeIntervalFlag) {
    lastTimeCheck = millis();
    circles.add(new Circle(new Vec2D(random(0, width), random(-400, 0))));
  }



  //for list with ArrayList
  for (Circle c: circles) { 
    c.circUpdate();
    c.display();
  }
  
  //remove circles that are off the screen
  for(int i = circles.size() -1; i >=0; i --){
    Circle c = circles.get(i);
    if(c.y > height + 200){
      circles.remove(c);
    }
  }
}
  
  void mousePressed() {
  mousePos = new Vec2D(mouseX, mouseY);
  // create a new positive attraction force field around the mouse position (radius=250px)
  mouseAttractor = new AttractionBehavior(mousePos, 250, 0.3f);
  physics.addBehavior(mouseAttractor);
}

void mouseDragged() {
  // update mouse attraction focal point
  mousePos.set(mouseX, mouseY);
}

void mouseReleased() {
  // remove the mouse attraction when button has been released
  physics.removeBehavior(mouseAttractor);
}



