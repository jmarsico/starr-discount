/*
before running, open OpenTSPS application and set 
 background, desired threshold, etc. 
 */

import toxi.physics2d.*;
import toxi.physics2d.behaviors.*;
import toxi.geom.*;
import java.util.Iterator;
import tsps.*;
import controlP5.*;

VerletPhysics2D physics;      //initiate instance of physics library
TSPS tspsReceiver;            //initiate instance of TSPS library
ControlP5 cp5;                //initiate instance of ControlP5 library

//used for timed Circle object generator
int lastTimeCheck;
int timeIntervalFlag = 100;

ArrayList<Circle> circles;   //initiate an ArrayList of Circle objects
int numCircles = 10;         // number of Circle objects

ArrayList<Attractor> attractors;

//parameters used for Controls
Vec2D grav;
float gravY;
GravityBehavior gravityForce;
float drag;
float attStrength;


// ----------------------- SETUP -------------------------- 

void setup() {
  size(displayWidth, displayWidth/2, P2D);

  //slider control for gravity
  cp5 = new ControlP5(this);
  cp5.addSlider("gravY")
    .setPosition(400, 1)
      .setRange(0.0, 0.2)
        .setSize(200, 10)
          .setColorCaptionLabel(0)
            .setCaptionLabel("gravity")
              ;

  //slider control for drag
  cp5 = new ControlP5(this);
  cp5.addSlider("drag")
    .setPosition(400, 16)
      .setRange(0.0, 0.2)
        .setSize(200, 10)
          .setColorCaptionLabel(0)
            ;

  //slider control for attractor strength
  cp5 = new ControlP5(this);
  cp5.addSlider("attStrength")
    .setPosition(400, 27)
      .setRange(0.0, 0.2)
        .setSize(200, 10)
          .setColorCaptionLabel(0)
            ;

  lastTimeCheck = millis();                                      //used for timer
  tspsReceiver= new TSPS(this, 12000);                           // set up TSPS port

  physics = new VerletPhysics2D();                               //set up physics "world"
  gravY = 0.07;
  grav= new Vec2D(0, gravY);
  gravityForce = new GravityBehavior(grav);
  physics.addBehavior(gravityForce);   //adds gravity to particle system
  drag = 0.01;


  //create arraylist of attractors
  attractors = new ArrayList<Attractor>();

  //create the ArrayList of circles
  circles = new ArrayList<Circle>();
}


//--------------------------- DRAW ---------------------------

void draw() {
  //blue background
  background(0);

  //pink background
  //background(#e16a62);

  //other background
  //background(#d7eff4);

  gravityForce.setForce(grav.set(0, gravY));
  physics.setDrag(drag);                 //drag force slows down gravity

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
    if (c.y > height + 20) {
      circles.remove(c);
    }
  }

  // -------------------- person tracking section ---------------------


  TSPSPerson[] people = tspsReceiver.getPeopleArray();
  Vec2D personLoc = new Vec2D(0,0);
  //adding attractors
  for (int i = attractors.size(); i < people.length; i++){
    TSPSPerson person = people[i];
    personLoc = new Vec2D(person.centroid.x * width, person.centroid.y * height);
    attractors.add(new Attractor(personLoc, width, attStrength));
  }
  
  //adding behaviors
  for(int i = 0; i < attractors.size(); i ++){
    Attractor a = attractors.get(i);
    physics.addBehavior(a.att());
  }
<<<<<<< HEAD

  //comment out this for-loop once calibrated
  for (int i = 0; i < attractors.size(); i ++) {
=======
  
  
  //updating and displaying attractors
  for(int i = 0; i < attractors.size(); i++){
    TSPSPerson person = people[i];
>>>>>>> newbranch
    Attractor a = attractors.get(i);
    a.update(person.centroid.x * width, person.centroid.y * height);
    a.display();
  }
  
  
  
  
  
  
  
    

 

  //removing behaviors
  for (int i = physics.behaviors.size()-1; i > people.length  ; i --) {
    ParticleBehavior2D b = physics.behaviors.get(i);
    physics.removeBehavior(b);
  } 

  //playing it safe and removing everything if people array is empty
  if (people.length == 0) {
    for (int i = physics.behaviors.size()-1; i > 0  ; i --) {
      ParticleBehavior2D b = physics.behaviors.get(i);
      physics.removeBehavior(b);
    }  
  }

  


  //debugging
  println("people" + people.length); 
  println("behaviors" + physics.behaviors.size()); 

  fill(0, 255);
  text("people" + people.length, 10, 10); 
<<<<<<< HEAD
  text ("attractors: " + attractors.size(), 10, 25);
  text ("behaviors: " + physics.behaviors.size(), 200, 10);
  text ("framerate: " + frameRate, 200, 25);
=======
  text ("behaviors: " + physics.behaviors.size(), 10, 25);
  text ("framerate: " + frameRate, 10, 55);
>>>>>>> newbranch
}

