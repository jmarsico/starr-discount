
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


  Circle(Vec2D loc) {
    super(loc);
    r = 20;
    physics.addParticle(this);
    pulseRate = random(6, 10);
    
    float colorChoser = random(0,1.0);
    
    if(colorChoser < 0.3){
      c = #75D19D;
    } else if(colorChoser >=0.3 && colorChoser < 0.6){
      c = #4AB03B;
    } else if (colorChoser >=0.6){
      c = #732646;
    }

    
  }


  void circUpdate() {
    r = r + sin(frameCount/pulseRate);
  }

  void display(color _c) {
   // c = _c; 
    fill(c, 100);
    ellipse(x, y, 30, 30);

    fill(0, 100);
    noStroke();
    for (int deg = 0; deg < 360; deg += spacing) {
      float ringAngle = radians(deg);
      float _x = x + (cos(ringAngle) * r);
      float _y = y + (sin(ringAngle) * r);
      ellipse(_x, _y, 5, 5);
    }
  }
}

