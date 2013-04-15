class Circle{
  PVector location;
  float radius;
  float rad;
  float radgrow = 1;
  
  Circle(){
    
    float rad = 20;
    float x = width/2;
    float y = height/2;
    location = new PVector(x,y);
    

  }
  
  void update(){
    
    //pulse the diameter of circle object
    rad = rad + sin( frameCount/20);
    
  }
  
   //draw the circle object
  void display(){
   
    
   fill(0);
   noStroke();
   ellipse(location.x, location.y, rad, rad);
  
   noFill();
   stroke(1);
   ellipse(location.x, location.y, rad + 10, rad + 10);
  
    strokeWeight(1);
   
    ellipse(location.x, location.y,  rad + 12, rad + 12);
  
    strokeWeight(1);
   
    ellipse(location.x, location.y,rad + 16, rad +16);
  
    strokeWeight(1);
    
    ellipse(location.x, location.y, rad + 30, rad + 30);
  
    strokeWeight(1);
   
    ellipse(location.x, location.y, rad + 45, rad + 45);
  
      
  }
}

