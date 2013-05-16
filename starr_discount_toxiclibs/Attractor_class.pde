class Attractor extends VerletParticle2D {
  
  float r;
  float distance = 200;
  float strength = 0.01;
  
  AttractionBehavior attBehavior;
  
  Attractor(Vec2D loc) {
    super(loc);
    r = 24;
    //attBehavior = new AttractionBehavior(this, distance, strength);
    physics.addParticle(this);
  }
}
  
  
  
  
    
