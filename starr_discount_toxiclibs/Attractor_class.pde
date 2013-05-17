class Attractor extends VerletParticle2D{ 
  Vec2D location;
  float attStrength = 0.2;
  AttractionBehavior thisBehave;
 
  
  Attractor(Vec2D loc) {
    super(loc);
    location = new Vec2D(x,y);
    physics.addParticle(this);
    thisBehave = new AttractionBehavior (this,width,attStrength);
    physics.addBehavior(thisBehave);
  }
  
  void display(){
    fill(255,0,0);
    ellipse(x,y,10,10);
    text("x: " + x + " y: " + y, x, y);
  }
  
  void update(){
   // this.lock();
    this.set(location.x, location.y);
  }
  
  void deleteBehave(){
    physics.removeBehavior(thisBehave);
  }
}
  
  
  
  
    
