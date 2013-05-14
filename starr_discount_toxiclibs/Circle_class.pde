class Circle extends VerletParticle2D {

  AttractionBehavior circBehav;

  float r;



  Circle(Vec2D loc) {
    super(loc);
    r = 8;
    circBehav = new AttractionBehavior(this, width, -1);
    physics.addParticle(this);
    physics.addBehavior(circBehav);
  }


  void display() {
    fill(255);
    ellipse(x, y, 5, 5);
  }
 

}
 



