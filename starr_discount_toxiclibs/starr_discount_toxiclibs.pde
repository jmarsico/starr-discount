import toxi.physics2d.*;
import toxi.physics2d.behaviors.*;
import toxi.geom.*;

VerletPhysics2D physics;



ArrayList<Circle> circles;   //initiate an ArrayList of Circle objects
int numCircles = 30;         // number of circle objects


void setup() {
  size(800, 400, P2D);


  physics = new VerletPhysics2D();   //set up physics "world"
  physics.setWorldBounds(new Rect(0, 0, width, height));  // make the physics world match the pixel world

  //create the circles
  circles = new ArrayList<Circle>();
  for (int i = 0; int < circles.length; int ++) {
    circles.add(new Circle());
  }
}

