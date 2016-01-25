class Asteroid extends GameObject
{
  float[] vertx = new float[16];
  float[] verty = new float[16];

  Asteroid()
  { 
    super(width * 0.5f, height  * 0.5f, 50);
  }

  Asteroid(float x, float y, float radius, color c, int points)
  {
    super(x, y, radius * 2);
    this.c = c;
    this.radius = radius;
    this.points = points;
    this.w = w; // Disambiguate w by using this
    this.halfW = w * 0.5f;
    this.theta = 0.0f;

    for (int i = 0; i < 16; i++) 
    { 
      // The vertices are generated radially 
      // A vertice is generated at an angle of 0 with a random distance from the center of the asteroid 
      // Then the next vertice is PI/8 radians rotated from the previous one and generated with a new random distance from the center 
      // Ask Lambert, it's a lot easier to explain in person 
      vertx[i] = sin(i*PI/8)*(s + random(-s/4, s/4)); 
      verty[i] = cos(i*PI/8)*(s + random(-s/4, s/4));
    }
  }
  void render() 
  { 
    // The color of the asteroid is determined by the type 
    fill(0); 
    switch(c) 
    { 
    case 0:  
      // White 
      stroke(255); 
      break; 
    case 1:  
      // Yellow 
      stroke(32, 255, 255); 
      break; 
    case 2:  
      // Purple 
      stroke(192, 255, 255); 
      break;
    } 
    // Renders the asteroid 
    strokeWeight(1); 
    rotate(r); 
    // Places the vertices of the polygon 
    beginShape(); 
    for (int i = 0; i < 16; i++) 
    { 
      vertex(vertx[i], verty[i]);
    } 
    vertex(vertx[0], verty[0]); 
    endShape(); 
    rotate(-r);
  }