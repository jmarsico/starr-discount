
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
  float v1, v2, v3, v4, v5, v6;


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
    v1 = random(-10, 10);
    v2 = random(-10, 10);
    v3 = random(-10, 10);
    v4 = random(-10, 10);
    v5 = random(-10, 10);
    v6 = random(-10, 10);
    
    

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
   noFill();
   
   
    stroke(0, ringAlpha - fade);

    
    beginShape();
    vertex(x,y);
    vertex(x+(v1*r), y +(v2+r));
    vertex(x+v3*r, y + (v4+r));
    vertex(x+v5, y +v6*r);
    endShape();


    //draw the circle of circles
    

   
    
  }
}

