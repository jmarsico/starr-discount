class KinectTracker {
  
  //size of the kinect image
  int kw = 640;
  int kh = 480;
  int threshold = 745;
  
  
 // raw location
  PVector loc;
  
  //interpolated location
  PVector lerpedLoc;
  
  
  //array of depth data, filled later in the track function
  int[] depth;
  
  PImage display;
  
  
  KinectTracker(){
    kinect.start();
    kinect.enableDepth(true);
    
    //make this true to see the greyscale image, false to turn it off
    kinect.processDepthImage(true);
    
    display = createImage(640, 480, PConstants.RGB);
    loc = new PVector(0,0);
    lerpedLoc = new PVector(0,0);
  }
  
  void track(){
    
    //get the raw depth as an array of integers
    depth = kinect.getRawDepth();
    
    //being overly cautious here
    if (depth == null) return;
    
    float sumX = 0;
    float sumY = 0;
    float count = 0;

    
    for (int x = 0; x < kw; x++){
      for( int y = 0; y < kh; y ++){
       // mirroring the image
        int offset = kw-x-1+y*kw;
        //grabbing the raw depth 
        int rawDepth = depth[offset];
        
        //testing against threshold
        if (rawDepth < threshold) {
          sumX += x;
          sumY += y;
          count++;
        }
      }
    }
    
    //as long as we found something for longer than time threshold
    
    if (count > 30) {
      loc = new PVector(sumX/count, sumY/count);
    } else if (count <= 30) { loc = new PVector (0,0);
  }
    
    //interpolating the location, doing it arbitrarily for now
    lerpedLoc.x = PApplet.lerp(lerpedLoc.x, loc.x, 0.3f);
    lerpedLoc.y = PApplet.lerp(lerpedLoc.y, loc.y, 0.3f);
  }
  
  PVector getLerpedPos() {
    return lerpedLoc;
  }
  
  PVector getPos(){
    return loc;
  }
  
  
  void display(){
    PImage img = kinect.getDepthImage();
    
    //being very cautious 
    if (depth == null || img == null) return;
    
    //this rewrites the depth image to show which pixels are in the threshold
    display.loadPixels();
    for(int x = 0; x < kw; x++){
      for(int y = 0; y < kh; y++) {
    //mirroring image
      int offset = kw-x-1+y*kw;
      //raw depth
      int rawDepth = depth[offset];
  
      int pix = x+y*display.width;
      if (rawDepth < threshold) {
        //a red color instead
      display.pixels[pix] = color(200, 200, 255, 50);
      }
      else {
        display.pixels[pix] = img.pixels[offset];
      }
      }
    }
    display.updatePixels();

    //draw the image
    image(display,0,0);
  }

void quit(){
kinect.quit();
}

int getThreshold(){
  return threshold;
}

void setThreshold(int t) {
  threshold = t;
}
}


  
  
