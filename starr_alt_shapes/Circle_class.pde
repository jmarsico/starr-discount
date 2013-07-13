
/* 
 this circle is based on a VerletParticle from toxiclibs VerletPhysics2D library. this means
 we can call any function from the VerletParticle class from the main program.
 */

class Circle extends VerletParticle2D {

  float angle = 0;
  float aVelocity = 0;
  float aAcceleration = 0.01;
  float r;
  float r1;
  float r2;
  float strokewt= 0.3;
  float pulseRate;
  float spacing = 20; 
  color c;
  float pulseAlpha, circAlpha, ringAlpha;
  int age;
  int fade;
  int ageThreshold = 7000;
  float v1, v2, v3, v4, v5, v6, v7, v8;


  Circle(Vec2D loc) {
    super(loc);
    r = random(2, 20);
    r1 = random(1, 30);
    r2 = random(1, 40);
    physics.addParticle(this);
    pulseRate = random(10, 15);
    float colorChoser = random(0, 1.0);
    pulseAlpha = 200;
    circAlpha = 150;
    ringAlpha = 255;
    age = 0;
    v1 = random(-4, 4);
    v2 = random(-4, 4);
    v3 = random(-4, 4);
    v4 = random(-4, 4);
    v5 = random(-4, 4);
    v6 = random(-4, 4);
    v7 = random(-4, 4);
    v8 = random(-4, 4);



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
    /* //update the radius
     r = r + sin(frameCount/pulseRate);
     r1 = r1 + cos(frameCount/(pulseRate+1));
     r2 = r2 +cos(frameCount/(pulseRate-2));
     //attempting to use perlin noise
     */
    float t = 0;
    float n = noise(t);
    r = map(n, 0, 1, 0, -20);
    t+= 0.5;


    float t1 = 0;
    float n1 = noise(t1);
    r2 = map(n1, 0, 1, 0, -20);
    t1 += 0.5;

    float t2 = 0;
    float n2 = noise(t);
    r1 = map(n2, 0, 1, 0, -20);
    t2 += 0.5;

    //update the age and fade coefficient
    age+=10;
    if (age > ageThreshold) {
      fade +=5;
    }
  }

  //draw the object
  void display() {
    noFill();


    stroke(c, ringAlpha - fade);


    beginShape(TRIANGLE_STRIP);
    vertex(x+r, y+r);
    vertex(x+(v1+r1), y +(v2+r));
    vertex(x+v3*r2, y + (v4+r1));
    vertex(x+v5*r, y +v6*r2);
    vertex(x+v7*r, y +v8*r2);
    vertex(x+v7*r+3, y +v8*r+20);
    endShape(CLOSE);


    //draw the circle of circles
  }
}

