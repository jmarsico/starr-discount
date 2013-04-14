
PVector location;
float circ1 = 5;
float circ2 = 10;
float circ3 = 12;
float circ4 = 13;

void setup(){
  size(600, 600);
  background(255);
  noLoop();
}


void draw(){
  float rad = 20;
  float x = width/2;
  float y = height/2;
  
  location = new PVector(x,y);
  
 
 
 
  
  fill(0);
  ellipse(location.x, location.y, rad, rad);
  
  noFill();
   stroke(random(0, 3.0));
   float radius = random(20, 100);
  ellipse(location.x, location.y, rad + radius, rad +radius);
  
    stroke(random(0, 3.0));
    radius = random(20, 200);
  ellipse(location.x, location.y,  rad + radius, rad +radius);
  
    stroke(random(0, 3.0));
    radius = random(20, 200);
  ellipse(location.x, location.y,rad + radius, rad +radius);
  
    stroke(random(0, 3.0));
    radius = random(20, 200);
  ellipse(location.x, location.y, rad + radius, rad +radius);
  
    stroke(random(0, 3.0));
    radius = random(20, 200);
  ellipse(location.x, location.y, rad + radius, rad +radius);
 
}
  
  
  
