int numCircles = 40;
Circle[] circles = new Circle[numCircles];


void setup(){
  frameRate(30);
  size(displayWidth, displayHeight);
  for(int i =0; i < circles.length; i ++){
  circles[i] = new Circle();
  }
}


void draw(){
 background(234,142,115);
 /*
 float inc = 0.06;
 int density = 1;
 float znoise = 0.0;
 float xnoise = 0.0;
 float ynoise = 0.0;
 for (int y = 0; y < height; y += density){
   for (int x = 0; x < width; x += density){
     float n = noise(xnoise, ynoise, znoise) *256;
     fill(n, 70);
     rect(x,y,density,density);
     xnoise += inc;
   }
   xnoise = 0;
   ynoise += inc;
 }
 znoise += inc;
 
 */
 
 for(int i = 0; i < circles.length; i++){
 circles[i].update();
 circles[i].display();
 }
 
}
  
  
  
