/*
before running, open OpenTSPS application and click "minimize" 
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
ColorPicker cp;


ArrayList<Circle> circles;           //initiate an ArrayList of Circle objects
ArrayList<Attractor> attractors;     //initiate an ArrayList of Attractor objects
int numCircles = 100;

float gravY = 0.06;                 //initial gravity coeff
float wind;
float windIncrement= 0.005;
float maxWind = 0.07;
float drag = 0.03;                   //initial drag coeff
float attStrength = 0.13;            //initial attraction coeff
float t = 0;
float yOff = 20;
float deathAge = 15000;

GravityBehavior gravityForce;       //initiate gravityForce (toxiclibs)
Vec2D grav;                         //initiate gravity Vec2D (toxiclibs)

int peopleLength;

// ----------------------- SETUP -------------------------- 

void setup() {
  size(displayWidth, displayHeight-100);
  frameRate(50);
  controllers();                                           //comment this line out once force coefficients are determined
  tspsReceiver= new TSPS(this, 12000);                     //set up UDP port for TSPS
  physics = new VerletPhysics2D();                         //set up physics "world"
  wind = 0;
  grav= new Vec2D(wind, gravY);                               //set up gravity vector for gravityForce
  gravityForce = new GravityBehavior(grav);                //sets up the gravity force
  physics.addBehavior(gravityForce);                       //adds gravity force to particle system
  attractors = new ArrayList<Attractor>();                 //create arraylist of attractors
  circles = new ArrayList<Circle>();                       //create the ArrayList of circles
  for (int i = 0; i < numCircles; i++) {
    circles.add(new Circle(new Vec2D(random(0, width), random(-height, height))));
  }
}


//--------------------------- DRAW ---------------------------


void draw() {
  background(255);
  fill(cp.getColorValue());
  rect(0, 0, width, height);
  windUpdate();
  gravityForce.setForce(grav.set(wind, gravY));               //update gravityForce
  physics.setDrag(drag);                                   //update drag
  physics.update ();                                       //update the physics world


  //update and display circles
  for (Circle c: circles) { 
    c.circUpdate();
    c.display();
    if (c.y > (height + 20)) {
      c.lock();
      c.set(random(width), random(-height, -40));
      c.unlock();
    } 
    else if (c.age > deathAge) {
      c.lock();
      c.set(random(width), random(-height, -40));
      c.unlock();
    }
  }

 

  // -------------------- person tracking section ---------------------

  //set up array of people from TSPS
  TSPSPerson[] people = tspsReceiver.getPeopleArray();

  Vec2D personLoc = new Vec2D(0, 0);
  peopleLength = people.length;

  //add attractors
  for (int i = attractors.size(); i < people.length; i++) {
    TSPSPerson person = people[i];
    personLoc = new Vec2D(person.centroid.x * width, (person.centroid.y * height+yOff));
    attractors.add(new Attractor(personLoc, width, attStrength));
  }

  //add behaviors
  for (int i = 0; i < attractors.size(); i ++) {
    Attractor a = attractors.get(i);
    physics.addBehavior(a.att());
  }

  //update and display attractors
  for (int i = 0; i < people.length; i++) {
    TSPSPerson person = people[i];
    Attractor a = attractors.get(i);
    a.update(person.centroid.x * width, (person.centroid.y * height+ yOff));
    //a.display();          //comment out this line for display
  }

  //remove attractors
  for (int i = attractors.size() -1; i > people.length; i --) {
    Attractor a = attractors.get(i);
    a.killBurst();
    attractors.remove(a);
  }

  //remove behaviors
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
    attractors.clear();
  }

  //debugging
  println("people: " + people.length); 
  println("behaviors" + physics.behaviors.size()); 
  println("framerate: " + frameRate);


  hideControls();
}


// use this function to calibrate force coefficients in real time 
void controllers() {

  cp5 = new ControlP5(this);

  //slider control for gravity
  cp5.addSlider("gravY")
    .setPosition(10, height - 60)
      .setRange(0.0, 0.2)
        .setSize(200, 10)
          .setColorCaptionLabel(0)
            .setCaptionLabel("gravity")
              ;

  //slider control for drag 
  cp5.addSlider("drag")
    .setPosition(10, height - 50)
      .setRange(0.0, 0.2)
        .setSize(200, 10)
          .setColorCaptionLabel(0)
            ;

  //slider control for attractor strength
  cp5.addSlider("attStrength")
    .setPosition(10, height - 35)
      .setRange(0.0, 0.2)
        .setSize(200, 10)
          .setColorCaptionLabel(0)
            ;

  //slider control for max wind speed
  cp5.addSlider("maxWind")
    .setPosition(10, height-10)
      .setRange(0.0, 0.25)
        .setSize(200, 10)
          .setColorCaptionLabel(0)
            ;

  //background color        
  cp = cp5.addColorPicker("picker")
    .setPosition(10, 65)
      .setColorValue(color(#40B785, 255))
        .hideBar()
          ;
}

//hide and show controls
void hideControls() {

  if (keyPressed && (key == ' ')) {



    cp5.show();
    //stats and controls
    fill(0, 100);
    noStroke();
    rect(0, 0, 300, 300);

    fill(255);
    textSize(25 );
    text("windSpeed: " + String.format("%.2f", wind), 10, 150);
    text("people: " + peopleLength, 10, 180); 
    text ("behaviors: " + physics.behaviors.size(), 10, 210);
    text("circles: " + circles.size(), 10, 240);
    text ("framerate: " + frameRate, 10, 270);
  }

  else {
    cp5.hide();
  }
}


//changes wind direction 
void windUpdate() {

  float n = noise(t);
  wind = map(n, 0, 1, maxWind*-1, maxWind);
  t+=windIncrement;

  println(wind);
}

