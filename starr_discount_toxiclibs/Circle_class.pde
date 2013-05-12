class Circle extends VerletParticle2D {

  AttractionBehavior circBehav;
  Vec2D circLoc;
  Vec2D circVel;
  float pulseRate;
  float angle = 0;
  float aVelocity = 0;
  float aAcceleration = 0.01;
  float r;
  float spacing = 10;


  Circle(Vec2D loc) {
    super(loc);
    Vec2D circLoc = loc;
    r = 8;
    pulseRate = random(6, 10);

    circVel = new Vec2D(random(-10, 10), random(-10, 10));
    circBehav = new AttractionBehavior(this, r, -0.01);
    physics.addParticle(this);
  }



    void update() {
      r = r + sin(frameCount/pulseRate);

      this.add(circVel);
    }
    
    void display(){
      
    
        ellipse(x,y, 5, 5);
      
    }
  }







/*

    void addPhysics() {
      physics.addBehavior(circBehav);
    }

    void removePhysics() {
      physics.removeBehavior(circBehav);
    }

*/



