
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

//import controlP5
import controlP5.*;
ControlP5 cp5;
Slider abc;

//used for timed Circle object generator
int lastTimeCheck;
int timeIntervalFlag = 200;

ArrayList<Circle> circles;   //initiate an ArrayList of Circle objects
int numCircles = 10;         // number of Circle objects

ArrayList<Attractor> attractors;   //provision an ArrayList of Attractor objects
int maxPeople = 10;                // maximum number of people in the attractors ArrayList

Vec2D grav;
float gravY;
GravityBehavior gravityForce;


// ----------------------- SETUP -------------------------- 

void setup() {
  size(displayWidth, displayHeight, P2D);

  cp5 = new ControlP5(this);
  cp5.addSlider("gravY")
    .setPosition(10, 65)
      .setRange(0.0, 0.2)
        .setSize(200, 10);
  ;

  lastTimeCheck = millis();                                      //used for timer
  tspsReceiver= new TSPS(this, 12000);                           // set up TSPS port

  physics = new VerletPhysics2D();                               //set up physics "world"
  physics.setDrag(0.03);                 //drag force slows down gravity
  gravY = 0.07;
  grav= new Vec2D(0, gravY);
  gravityForce = new GravityBehavior(grav);
  physics.addBehavior(gravityForce);   //adds gravity to particle system

  //create the ArrayList of attractors
  attractors = new ArrayList<Attractor>();


  //create the ArrayList of circles
  circles = new ArrayList<Circle>();
}


//--------------------------- DRAW ---------------------------

void draw() {
  background(255);
  grav.set(0,gravY);
  gravityForce.setForce(grav);
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



