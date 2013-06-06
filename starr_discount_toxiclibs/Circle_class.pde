
/* 
 this circle is based on a VerletParticle from toxiclibs VerletPhysics2D library. this means
 we can call any function from the VerletParticle class from the main program.
 */

class Circle extends VerletParticle2D {

  float angle = 0;
  float aVelocity = 0;
  float aAcceleration = 0.01;
  float r;
  float strokewt= 0.3;
  float pulseRate;
  float spacing = 20; 
  color c;
  float pulseAlpha, circAlpha, ringAlpha;
  int age;
  int fade;
  int ageThreshold = 5000;


  Circle(Vec2D loc) {
    super(loc);
    r = random(2,20);
    physics.addParticle(this);
    pulseRate = random(6, 10);
    float colorChoser = random(0, 1.0);
    pulseAlpha = 200;
    circAlpha = 150;
    ringAlpha = 255;
    age = 0;

    if (colorChoser < 0.3) {
      c = #75D19D;
    } 
    else if (colorChoser >=0.3 && colorChoser < 0.6) {
      c = #4AB03B;
    }  
    else if (colorChoser >=0.6) {
      c = #732646;
    }
  }

  
  void circUpdate() {
    //update the radius
    r = r + sin(frameCount/pulseRate);

    //update the age and fade coefficient
    age+=10;
    if (age > ageThreshold) {
      fade +=5;
    }
  }
  
  //draw the object
  void display() {
    pg.ellipseMode(CENTER);


    //draw the circle of circles
    pg.fill(c, pulseAlpha - fade);
    noStroke();
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

