class Attractor extends VerletParticle2D{ 
  Vec2D location;
  float attractorStrength = 0.1;
  AttractionBehavior thisBehave;
  
 
  
  Attractor(Vec2D loc) {
    super(loc);
    
    physics.addParticle(this);
    thisBehave = new AttractionBehavior (this,width,attractorStrength);
    physics.addBehavior(thisBehave);
    
    
    
  }
  
  void display(){
    fill(255,0,0);
    ellipse(x,y,10,10);
    text("x: " + x + " y: " + y, x + 10, y);
  }
  
  void update(Vec2D _loc, float _attractorStrength){
    location = _loc;
    this.lock();
    this.set(location.x, location.y);
    thisBehave.setStrength(_attractorStrength);
  }
  
  void deleteBehave(){
    physics.removeBehavior(thisBehave);
  }
}
  
  
  
  
    
