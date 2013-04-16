class Circle{
  PVector location;
  PVector velocity;
  float rad;
  float strokewt;
  float pulseRate;
  
  
  Circle(){
    
    float rad = 20;
    float x = random(100, width - 100);
    float y = random(100, height - 100);
    location = new PVector(x,y);
    velocity = new PVector(random(-1,1), random(-1,1));
    strokewt = 0.5;
    pulseRate = random(6,10);
    

  }
  
  void update(){
    
    //pulse the diameter of circle object
    rad = rad + sin(frameCount/pulseRate);
    
    
    location.add(velocity);
    
  }
  
   //draw the circle object
  void display(){
   
    
   fill(0, 30);
   noStroke();
   ellipse(location.x, location.y, rad, rad);
  
   noFill();
   stroke(1);
   ellipse(location.x, location.y, rad + 10, rad + 10);
  
    strokeWeight(strokewt);
   
    ellipse(location.x, location.y,  rad + 12, rad + 12);
  
    strokeWeight(strokewt);
   
    ellipse(location.x, location.y,rad + 16, rad +16);
  
    strokeWeight(strokewt);
    
    ellipse(location.x, location.y, rad + 30, rad + 30);
  
    strokeWeight(strokewt);
   
    ellipse(location.x, location.y, rad + 45, rad + 45);
  
      
  }
}

