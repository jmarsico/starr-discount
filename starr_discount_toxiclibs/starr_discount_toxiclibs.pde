import toxi.physics2d.*;
import toxi.physics2d.behaviors.*;
import toxi.geom.*;

VerletPhysics2D physics;



ArrayList<Circle> circles;   //initiate an ArrayList of Circle objects
int numCircles = 10;         // number of circle objects


void setup() {
  size(800, 400);


  physics = new VerletPhysics2D();   //set up physics "world"
  physics.setWorldBounds(new Rect(0, 0, width, height));  // make the physics world match the pixel world

  //create the circles
  circles = new ArrayList<Circle>();
  for (int i = 0; i < numCircles; i ++) {
    circles.add(new Circle(new Vec2D(random(width), random(height))));
    
  }
}


void draw(){
  background(0);
  physics.update ();
  //for list with ArrayList
  for (Circle c: circles) { 
    //c.update();
    c.display();
  }
  
  for(Circle c: circles){
  if (mousePressed) {
    
    c.lock();
    c.set(mouseX,mouseY);
  } else {
    c.unlock();
  }
  }
}

