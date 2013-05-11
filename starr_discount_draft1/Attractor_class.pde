class Attractor {
  float mass;
  float G;
  PVector location;
  PVector mouseLoc;

  Attractor(){
    location = new PVector(mouseX, mouseY);
    mass = 20;
    G = 0.4;
  }
  
  void update(){
    location = tracker.getPos();
   
  }
  
  PVector attract(Circle c) {
    PVector force = PVector.sub(location, c.location);
    float distance = force.mag();
    distance = constrain(distance,5.0, 25.0);
    
    force.normalize();
    float strength =  5/ distance;
    force.mult(strength);
    return force;
  }
  
 
  void display() {
    stroke(0);
    fill(100, 100, 255, 200);
    ellipse(location.x, location.y, mass*2, mass*2);
  }
}
