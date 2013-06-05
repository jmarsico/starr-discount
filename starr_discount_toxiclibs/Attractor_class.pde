class Attractor {
  Vec2D location;
  float reach;
  float strength;
  AttractionBehavior atta;

  // constructor requires all things to create an attraction behavior
  Attractor(Vec2D loc, float _reach, float _strength) {
    location = loc;
    reach = _reach;
    strength = _strength;
  }

  //create and return an attraction behavior
  AttractionBehavior att() {
    atta = new AttractionBehavior(location, reach, strength);
    return atta;
  }

  void killBurst() {
    atta.setStrength(-100.0);
  }


  //update the location of the attraction behavior
  void update(float x, float y) {
    location.set(x, y);
  }

  //display the attraction behavior location (disable this function in the main draw() when presenting!!)
  void display() {
    pg.fill(255, 0, 0);
    pg.ellipse(location.x, location.y, 10, 10);
  }
}

