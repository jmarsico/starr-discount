int numCircles = 30;
Circle[] circles = new Circle[numCircles];


void setup() {
  frameRate(30);
  size(displayWidth, displayHeight);
  for (int i =0; i < circles.length; i ++) {
    circles[i] = new Circle();
  }
}



void draw() {
  background(0);


  // this is colored perlin noise gradient background
 /*
 loadPixels();
   float xoff = 0.0;
   
   for (int x = 0; x < width; x++){
   float yoff = 0.0;
   
   for(int y = 0; y < height; y++){
   float bright = map(noise(xoff,yoff), 0, 1, 0, 255);
   pixels[x+y*width] = color(234, 145, bright, 10);
   yoff += 0.001;
   }
   xoff += 0.001;
   }
   
   updatePixels();
*/   

  for (int i = 0; i < circles.length; i++) {
    circles[i].update();
    circles[i].display();
    circles[i].checkEdges();
  }
}



