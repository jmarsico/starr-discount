/*

 ********  NOTES  ********
 
 when working within the people array, add behaviors  to the object
 directly from the array "physics.removeBehaviors...."
 
 try this link for setting strength: 
 http://forum.processing.org/topic/toxiclibs-adjusting-a-behavior-within-a-live-particle-system-using-setstrength
 
 also... watch these shiffman videos on toxiclibs verletphysics:
 https://vimeo.com/62395895
 
 */


import toxi.physics2d.*;
import toxi.physics2d.behaviors.*;
import toxi.geom.*;
import java.util.Iterator;
import tsps.*;

VerletPhysics2D physics;      //initiate instance of physics library
TSPS tspsReceiver;            //initiate instance of TSPS library

//used for timer 
int lastTimeCheck;
int timeIntervalFlag = 50;

//used for mousePressed and mouseReleased functions
Vec2D mousePos;
AttractionBehavior mouseAttractor;

//might want to have a generic AttractionBehavior that can be added 
// or removed from each particle
AttractionBehavior personAttractor;   

ArrayList<Circle> circles;   //initiate an ArrayList of Circle objects
int numCircles = 10;         // number of Circle objects

ArrayList<Attractor> attractors;   //provision an ArrayList of Attractor objects
int maxPeople = 10;                // maximum number of people in the attractors ArrayList




void setup() {
  size(displayWidth, displayHeight);
  lastTimeCheck = millis();                                      //used for timer
  tspsReceiver= new TSPS(this, 12000);                           // set up TSPS port
  physics = new VerletPhysics2D();                               //set up physics "world"
  // not currently needed: sets the boundaries of the physics world
  //physics.setWorldBounds(new Rect(0, 0, width, height)); 
  physics.setDrag(0.03);                                         //drag force slows down gravity
  physics.addBehavior(new GravityBehavior(new Vec2D(0, 0.1)));   //adds gravity to particle system

  //create the ArrayList of attractors
  attractors = new ArrayList<Attractor>();
  for (int i = 0; i < maxPeople; i ++) {
    attractors.add(new Attractor(new Vec2D(0, 0)));
  }


  //create the ArrayList of circles
  circles = new ArrayList<Circle>();
  for (int i = 0; i < numCircles; i ++) {
    circles.add(new Circle(new Vec2D(random(0, width), random(-400, 0))));
  }

}


void draw() {
  background(0);
  physics.update ();  //update the physics world

  //create new Circle object every interval
  if (millis() > lastTimeCheck + timeIntervalFlag) {
    lastTimeCheck = millis();
    circles.add(new Circle(new Vec2D(random(0, width), random(-400, 0))));
  }

  //update and display circles
  for (Circle c: circles) { 
    c.circUpdate();
    c.display();
  }

  //remove circles that are off the screen
  for (int i = circles.size() -1; i >=0; i --) {
    Circle c = circles.get(i);
    if (c.y > height + 200) {
      circles.remove(c);
    }
  }
}





















//****these sections are for troubleshooting *********



void mousePressed() {
  mousePos = new Vec2D(mouseX, mouseY);
  // create a new positive attraction force field around the mouse position (radius=250px)
  mouseAttractor = new AttractionBehavior(mousePos, width, 0.1f);
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


