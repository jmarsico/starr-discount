class Circle {
  PVector location;
  PVector velocity;
  float rad;
  float strokewt;
  float pulseRate;
  int spacing = 18;


  //initiate the object
  Circle() {

    float rad = 20;
    float x = random(100, width - 100);
    float y = random(100, height - 100);
    location = new PVector(x, y);
    velocity = new PVector(random(-0.5, 0.5), random(-0.5, 0.5));
    strokewt = 0.5;
    pulseRate = random(6, 10);
  }

  //movement and pulsation
  void update() {

    //pulse the diameter of circle object
    rad = rad + sin(frameCount/pulseRate);

    //moving the object around
    location.add(velocity);
  }

  //draw the circle object
  void display() {
    
    //circle of circles 
    pg.fill(0);
    pg.noStroke();
    for (int deg = 0; deg < 360; deg += spacing) {
      float angle = radians(deg);
      float x = location.x + (cos(angle) * rad);
      float y = location.y + (sin(angle) * rad);
      pg.ellipse(x, y, 5, 5 );
    }

    pg.fill(0, 30);
    pg.noStroke();
    pg.ellipse(location.x, location.y, rad, rad);

    //rings
    pg.noFill();
    pg.stroke(1);
    pg.ellipse(location.x, location.y, rad + 10, rad + 10);

    pg.strokeWeight(strokewt);

    pg.ellipse(location.x, location.y, rad + 12, rad + 12);

    pg.strokeWeight(strokewt);

    pg.ellipse(location.x, location.y, rad + 16, rad +16);

    pg.strokeWeight(strokewt);

    pg.ellipse(location.x, location.y, rad + 30, rad + 30);

    pg.strokeWeight(strokewt);

    pg.ellipse(location.x, location.y, rad + 45, rad + 45);
  }
}

