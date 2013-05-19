
/*
before running, open OpenTSPS application and set 
 background, desired threshold, etc. 
 */

import toxi.physics2d.*;
import toxi.physics2d.behaviors.*;
import toxi.geom.*;
import java.util.Iterator;
import tsps.*;

VerletPhysics2D physics;      //initiate instance of physics library
TSPS tspsReceiver;            //initiate instance of TSPS library

//used for timed Circle object generator
int lastTimeCheck;
int timeIntervalFlag = 200;

//used for mousePressed and mouseReleased functions
Vec2D mousePos;
AttractionBehavior mouseAttractor;


ArrayList<Circle> circles;   //initiate an ArrayList of Circle objects
int numCircles = 10;         // number of Circle objects

ArrayList<Attractor> attractors;   //provision an ArrayList of Attractor objects
int maxPeople = 10;                // maximum number of people in the attractors ArrayList



// ----------------------- SETUP -------------------------- 

void setup() {
  size(displayWidth, displayHeight, P2D);

  lastTimeCheck = millis();                                      //used for timer
  tspsReceiver= new TSPS(this, 12000);                           // set up TSPS port

  physics = new VerletPhysics2D();                               //set up physics "world"
  physics.setDrag(0.03);                                         //drag force slows down gravity
  physics.addBehavior(new GravityBehavior(new Vec2D(0, 0.07)));   //adds gravity to particle system

  //create the ArrayList of attractors
  attractors = new ArrayList<Attractor>();


  //create the ArrayList of circles
  circles = new ArrayList<Circle>();
  /*
  for (int i = 0; i < numCircles; i ++) {
   circles.add(new Circle(new Vec2D(random(0, width), random(-400, 0))));
   }
   */
}


//--------------------------- DRAW ---------------------------

void draw() {
  background(255);
  physics.update ();  //update the physics world

  //create new Circle object every interval
  if (millis() > lastTimeCheck + timeIntervalFlag) {
    lastTimeCheck = millis();
    circles.add(new Circle(new Vec2D(random(0, width), random(-400, 0))));
  }

  //update and display circles
  for (Circle c: circles) { 
    c.circUpdate();
    c.display(#75D19D);
  }

  //remove circles that are off the screen
  for (int i = circles.size() -1; i >=0; i --) {
    Circle c = circles.get(i);
    if (c.y > height + 200) {
      circles.remove(c);
    }
  }




  TSPSPerson[] people = tspsReceiver.getPeopleArray();
  for (int i = attractors.size(); i < people.length -1; i++) {
    TSPSPerson person = people[i];
    Vec2D personAtt = new Vec2D(person.centroid.x * width, person.centroid.y * height); 
    attractors.add(new Attractor(personAtt));
    Attractor a = attractors.get(i);
    //a.lock();
    // personAtt.set(person.centroid.x * width, person.centroid.y * height);
  }

  for (int i = 0; i < attractors.size(); i ++) {
    Attractor a = attractors.get(i);
    a.display();
    // a.update();
  }

  if (attractors.size() > 0) {
    for (int i = 0; i < people.length-1; i++) {
      TSPSPerson person = people[i];
      Attractor a = attractors.get(i);
      Vec2D personAtt = new Vec2D(person.centroid.x * width, person.centroid.y * height);
      //a.lock();
      a.update(personAtt);
    }
  }

  //playing it safe to clear out all attractors
  if (attractors.size() >= 0) {
    for (int i = attractors.size()-1; i > people.length +1; i--) {
      attractors.remove(i);
    }
  }

  //playing it safe to clear out all behaviors (except gravity)
  if (people.length == 0) {
    for (int i = physics.behaviors.size()-1; i > 0  ; i --) {
      ParticleBehavior2D b = physics.behaviors.get(i);
      physics.removeBehavior(b);
    }  
    attractors.clear();
  }



  //debugging
  println("people" + people.length); 
  println("attractors" + attractors.size());
  println("behaviors" + physics.behaviors.size()); 

  fill(0, 255);
  text("people" + people.length, 10, 10); 
  text ("attractors: " + attractors.size(), 10, 25);
  text ("behaviors: " + physics.behaviors.size(), 10, 40);
  text ("framerate: " + frameRate, 10, 55);
}



//****these sections are for troubleshooting *********



void mousePressed() {
  mousePos = new Vec2D(mouseX, mouseY);
  // create a new positive attraction force field around the mouse position
  mouseAttractor = new AttractionBehavior(mousePos, width, 0.09f);
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

