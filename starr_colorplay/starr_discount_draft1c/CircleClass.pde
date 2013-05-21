class Circle {
  PVector location;
  PVector velocity;
  PVector acceleration;
  float angle = 0;
  float aVelocity = 0;
  float aAcceleration = 0.01;
  float radX;
  float strokewt;
  float pulseRate;
  float spacing = 20;


  //initiate the object
  Circle() {

    float radX = 20;
    float x = random(100, width - 100);
    float y = random(100, height - 100);
    location = new PVector(x, y);
    velocity = new PVector(random(-0.5, 0.5), random(-0.5, 0.5));
    acceleration = new PVector(0,0);
    strokewt = 0.3;
    pulseRate = random(6, 10);
  }
  
  
  void applyForce(PVector force){
   //this might change if we make different size circles have different forces
    PVector f = force;
    acceleration.add(f);
    
  }

  //movement and pulsation
  void update() {

    //pulse the diameter of circle object
    radX = radX + sin(frameCount/pulseRate);

    //moving the object around
    velocity.add(acceleration);
    location.add(velocity);
    
    aAcceleration = acceleration.x;
    aVelocity += aAcceleration;
    angle = aVelocity;
    
    acceleration.mult(0);
  }

  //draw the circle object
  void display() {
    
    
    float angle = velocity.heading();
    
    pushMatrix();
    ellipseMode(CENTER);
    translate(location.x, location.y);
    rotate(angle);
    
    //circle of circles 
    fill(0, 220);
    noStroke();
    for (int deg = 0; deg < 360; deg += spacing) {
      float ringAngle = radians(deg);
      float x = 0 + (cos(ringAngle) * radX);
      float y = 0 + (sin(ringAngle) * radX);
      ellipse(x, y, 5, 5 );
    }
    
    

    //inner circle
    fill(#e1c49a, 200);
    noStroke();
    ellipse(0, 0, radX, radX);

    //rings
    noFill();
    smooth();
    stroke(255, 150);
    ellipse(0, 0, radX + 10, radX + 10);
    
    strokeWeight(strokewt);
    ellipse(0, 0, radX + 12, radX + 12);

    strokeWeight(strokewt);
    ellipse(0, 0, radX + 16, radX +16);

    strokeWeight(strokewt);
    ellipse(0, 0, radX + 30, radX + 30);

    strokeWeight(strokewt);
    ellipse(0, 0, radX + 45, radX + 45);
    popMatrix();
  }
  
  void checkEdges(){
  if((location.x > width) || (location.x < 0)){
    velocity.x*= -0.5;
  }
  if((location.y > height) || (location.y < 0)){
    velocity.y *= -0.8;
  }
}
}


