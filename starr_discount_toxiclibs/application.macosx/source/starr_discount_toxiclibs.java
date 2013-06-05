import processing.core.*; 
import processing.data.*; 
import processing.event.*; 
import processing.opengl.*; 

import toxi.physics2d.*; 
import toxi.physics2d.behaviors.*; 
import toxi.geom.*; 
import java.util.Iterator; 
import tsps.*; 
import controlP5.*; 
import codeanticode.syphon.*; 

import java.util.HashMap; 
import java.util.ArrayList; 
import java.io.File; 
import java.io.BufferedReader; 
import java.io.PrintWriter; 
import java.io.InputStream; 
import java.io.OutputStream; 
import java.io.IOException; 

public class starr_discount_toxiclibs extends PApplet {

/*
before running, open OpenTSPS application and click "minimize" 
 */










PGraphics pg;
SyphonServer server;

VerletPhysics2D physics;      //initiate instance of physics library
TSPS tspsReceiver;            //initiate instance of TSPS library
ControlP5 cp5;                //initiate instance of ControlP5 library
ColorPicker cp;
//ColorPicker cp1;



//used for timed Circle object generator
int lastTimeCheck;
int timeIntervalFlag = 100;
int attractorKillTime = 6000;

ArrayList<Circle> circles;           //initiate an ArrayList of Circle objects
ArrayList<Attractor> attractors;     //initiate an ArrayList of Attractor objects

float gravY = 0.07f;                 //initial gravity coeff
float drag = 0.01f;                   //initial drag coeff
float attStrength = 0.1f;            //initial attraction coeff

GravityBehavior gravityForce;       //initiate gravityForce (toxiclibs)
Vec2D grav;                         //initiate gravity Vec2D (toxiclibs)

int peopleLength;

// ----------------------- SETUP -------------------------- 

public void setup() {
  size(displayWidth, displayWidth/2, P2D);
  pg = createGraphics(width, height, P2D);
  server = new SyphonServer(this, "Processing Mover");
  frameRate(30);
  controllers();                                           //comment this line out once force coefficients are determined
  lastTimeCheck = millis();                                //used for Circle production timer
  tspsReceiver= new TSPS(this, 12000);                     //set up UDP port for TSPS
  physics = new VerletPhysics2D();                         //set up physics "world"
  grav= new Vec2D(0, gravY);                               //set up gravity vector for gravityForce
  gravityForce = new GravityBehavior(grav);                //sets up the gravity force
  physics.addBehavior(gravityForce);                       //adds gravity force to particle system
  attractors = new ArrayList<Attractor>();                 //create arraylist of attractors
  circles = new ArrayList<Circle>();                       //create the ArrayList of circles
}


//--------------------------- DRAW ---------------------------


public void draw() {
  background(255);
  pg.beginDraw();
   pg.fill(255);
  pg.rect(0,0, width*2, height*2);
  pg.fill(cp.getColorValue());
  pg.rect(0, 0, width, height);
  gravityForce.setForce(grav.set(0, gravY));               //update gravityForce
  physics.setDrag(drag);                                   //update drag
  physics.update ();                                       //update the physics world

  //Circle creation 
  if (millis() > lastTimeCheck + timeIntervalFlag) {
    lastTimeCheck = millis();
    circles.add(new Circle(new Vec2D(random(0, width), random(-400, 0))));
  }

  //update and display circles
  for (Circle c: circles) { 
    c.circUpdate();
    c.display();
  }

  //remove circles that are off the screen or older than six seconds
  for (int i = circles.size() -1; i >=0; i --) {
    Circle c = circles.get(i);
    if (c.age > attractorKillTime) {
      circles.remove(c);
    }
    else if (c.y > height + 30) {
      circles.remove(c);
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
    personLoc = new Vec2D(person.centroid.x * width, person.centroid.y * height);
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
    a.update(person.centroid.x * width, person.centroid.y * height);
    a.display();          //comment out this line for display
  }

  //remove attractors
  for (int i = attractors.size() -1; i > people.length; i --) {
    Attractor a = attractors.get(i);
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

  
  pg.endDraw();
  image(pg, 640, 480);
  server.sendImage(pg);
  hideControls();
}


// use this function to calibrate force coefficients in real time 
public void controllers() {

  cp5 = new ControlP5(this);

  //slider control for gravity
  cp5.addSlider("gravY")
    .setPosition(10, 20)
      .setRange(0.0f, 0.2f)
        .setSize(200, 10)
          .setColorCaptionLabel(0)
            .setCaptionLabel("gravity")
              ;

  //slider control for drag 
  cp5.addSlider("drag")
    .setPosition(10, 35)
      .setRange(0.0f, 0.2f)
        .setSize(200, 10)
          .setColorCaptionLabel(0)
            ;

  //slider control for attractor strength
  cp5.addSlider("attStrength")
    .setPosition(10, 50)
      .setRange(0.0f, 0.2f)
        .setSize(200, 10)
          .setColorCaptionLabel(0)
            ;

  //background color        
  cp = cp5.addColorPicker("picker")
    .setPosition(10, 65)
      .setColorValue(color(255, 255, 255, 255))
        .hideBar()
          ;
}

//hide and show controls
public void hideControls() {
  if (keyPressed) {
    cp5.show();
    //stats and controls
    fill(255, 255, 0, 200);
    noStroke();
    rect(0, 0, 300, 300);

    fill(0);
    textSize(25 );
    text("people: " + peopleLength, 10, 180); 
    text ("behaviors: " + physics.behaviors.size(), 10, 210);
    text("circles: " + circles.size(), 10, 240);
    text ("framerate: " + frameRate, 10, 270);
  } 
  else {
    cp5.hide();
  }
}

class Attractor {
  Vec2D location;
  float reach;
  float strength;
  AttractionBehavior atta;

  // constructor requires all things to create an attraction behavior
  Attractor(Vec2D loc, float _reach, float _strength) {
    location = loc;
    reach = _reach;
    strength = _strength;
  }

  //create and return an attraction behavior
  public AttractionBehavior att() {
    atta = new AttractionBehavior(location, reach, strength);
    return atta;
  }

  //update the location of the attraction behavior
  public void update(float x, float y) {
    location.set(x, y);
  }

  //display the attraction behavior location (disable this function in the main draw() when presenting!!)
  public void display() {
    pg.fill(255, 0, 0);
    pg.ellipse(location.x, location.y, 10, 10);
  }
}


/* 
 this circle is based on a VerletParticle from toxiclibs VerletPhysics2D library. this means
 we can call any function from the VerletParticle class from the main program.
 */

class Circle extends VerletParticle2D {

  float angle = 0;
  float aVelocity = 0;
  float aAcceleration = 0.01f;
  float r;
  float strokewt= 0.3f;
  float pulseRate;
  float spacing = 20; 
  int c;
  float pulseAlpha, circAlpha, ringAlpha;
  int age;
  int fade;
  int ageThreshold = 5000;


  Circle(Vec2D loc) {
    super(loc);
    r = random(2,20);
    physics.addParticle(this);
    pulseRate = random(6, 10);
    float colorChoser = random(0, 1.0f);
    pulseAlpha = 200;
    circAlpha = 150;
    ringAlpha = 255;
    age = 0;

    if (colorChoser < 0.3f) {
      c = 0xff75D19D;
    } 
    else if (colorChoser >=0.3f && colorChoser < 0.6f) {
      c = 0xff4AB03B;
    }  
    else if (colorChoser >=0.6f) {
      c = 0xff732646;
    }
  }

  
  public void circUpdate() {
    //update the radius
    r = r + sin(frameCount/pulseRate);

    //update the age and fade coefficient
    age+=10;
    if (age > ageThreshold) {
      fade +=5;
    }
  }
  
  //draw the object
  public void display() {
    pg.ellipseMode(CENTER);


    //draw the circle of circles
    pg.fill(c, pulseAlpha - fade);
    pg.noStroke();
    for (int deg = 0; deg < 360; deg += spacing) {
      float ringAngle = radians(deg);
      float _x = x + (cos(ringAngle) * r);
      float _y = y + (sin(ringAngle) * r);
      pg.ellipse(_x, _y, 5, 5);
    }

    //inner circle
    pg.fill(c, circAlpha - fade);
    pg.noStroke();
    pg.ellipse(x, y, r, r);

    //rings
    pg.noFill();
    pg.stroke(0, ringAlpha - fade);
    pg.ellipse(x, y, r + 10, r + 10);

    pg.strokeWeight(strokewt);
    pg.ellipse(x, y, r + 12, r + 12);  
    pg.ellipse(x, y, r + 16, r +16);    
    pg.ellipse(x, y, r + 30, r + 30);
    pg.ellipse(x, y, r + 45, r + 45);
  }
}

  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "starr_discount_toxiclibs" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
