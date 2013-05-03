import codeanticode.syphon.*;

int numCircles = 10;
Circle[] circles = new Circle[numCircles];
PGraphics pg;
SyphonServer server;


void setup() {
 // frameRate(30);
  size(640, 480, P2D);
  pg = createGraphics(width, height, P2D);
  server = new SyphonServer(this, "Processing Starr");
  for (int i =0; i < circles.length; i ++) {
    circles[i] = new Circle();
  }
}



void draw() {
  //background(234, 142, 115);
  
  pg.beginDraw();
  renderImage();
  pg.endDraw();
  image(pg,640,480);
  server.sendImage(pg);
}



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

  


void renderImage(){
  pg.fill(234, 142, 115);
  pg.rect(0,0,1280,960);
  
  for (int i = 0; i < circles.length; i++) {
    circles[i].update();
    circles[i].display();
  }
}



