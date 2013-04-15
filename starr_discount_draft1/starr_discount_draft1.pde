Circle circle;


PVector location;
float circ1 = 5;
float circ2 = 10;
float circ3 = 12;
float circ4 = 13;

void setup(){
  size(600, 600);
  

  circle = new Circle();
}


void draw(){
  background(255);
 
 circle.display();
 circle.update();
 
}
  
  
  
