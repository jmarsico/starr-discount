
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
  }


  void circUpdate() {
    r = r + sin(frameCount/pulseRate);
  }

  void display(color _c) {
    c = _c; 
    fill(c);
    ellipse(x, y, 10, 10);

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

