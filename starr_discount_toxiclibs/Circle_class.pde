class Circle extends VerletParticle2D {

  AttractionBehavior circBehav;

  float r;
  Vec2D force, velocity;



  Circle(Vec2D loc) {
    super(loc);
    r = 8;
    circBehav = new AttractionBehavior(this, width, -1);
    physics.addParticle(this);
   // physics.addBehavior(circBehav);
    velocity = new Vec2D(random(-0.1,0.1), random(-0.1, 0.1));
  }


  void display() {
    fill(255);
    this.addVelocity(velocity);
   // physics.update();
    ellipse(this.x, this.y, 5, 5);
  }
  
  void checkEdges(){
    if((this.x > width) || (this.x < 0)){
    velocity.x *=-1;
  } else if ((this.y > height) || (this.y < 0)){
    velocity.y *=-1;
  }
  }
 

}
 



