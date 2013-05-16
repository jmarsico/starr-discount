import toxi.physics2d.*;
import toxi.physics2d.behaviors.*;
import toxi.geom.*;

VerletPhysics2D physics;



ArrayList<Circle> circles;   //initiate an ArrayList of Circle objects
int numCircles = 100;         // number of circle objects


void setup() {
  size(1000, 800);
  physics = new VerletPhysics2D();   //set up physics "world"
  //physics.setWorldBounds(new Rect(0, 0, width, height));  // make the physics world match the pixel world
  physics.setDrag(0.03);
  physics.addBehavior(new GravityBehavior(new Vec2D(0,0.01)));
  //create the circles
  circles = new ArrayList<Circle>();
  for (int i = 0; i < numCircles; i ++) {
    circles.add(new Circle(new Vec2D(random(0,width), random(-400,0))));
    
  }
}


void draw(){
  background(0);
physics.update ();
  //for list with ArrayList
  for (Circle c: circles) { 
   c.circUpdate();
    c.display();
  }
    
}
  
  

