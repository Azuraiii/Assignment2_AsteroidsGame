class smallAsteroid extends Asteroid implements Interface
{
  smallAsteroid(PVector position)
  {
    forward.x = random(-1, 1);
    forward.y = random(-1, 1);
    //sets the forward vector to 1
    forward.normalize();
    pos.x = position.x;
    pos.y = position.y;
  }
  
  void applyTo3(smallAsteroid smallAst)
  {
    
  }

  void render() 
  { 
    pushMatrix();
    translate(pos.x, pos.y);
    //rotate(theta);
    //white 
    fill(0);
    stroke(255);
    strokeWeight(1); 
    rotate(r); 
    // Places the vertices of the polygon 
    int[] xpts = {
      -10, 0, 9, 11, 2, 10, 8, -1, -8, -9, -13, -10                    };
    int[] ypts = {
      -7, -12, -10, -2, 0, 5, 10, 13, 11, 7, 4, -7                    };

    beginShape(POLYGON);
    for (int i = 0; i < 12; i++) 
    {
      vertex(xpts[i], ypts[i]);
    }
    endShape(); 
    rotate(-r);

    //ellipse(-halfW,-halfW,w,w);

    popMatrix();
  }

  void update()
  {
    pos.add(forward);
    //powerup rotation
    theta += 0.01f;
    //wrap around
    if (pos.x < 0)
    {
      pos.x = width;
    }

    if (pos.y < 0)
    {

      pos.y = height;
    }

    if (pos.x > width)
    {
      pos.x = 0;
    }
  }
}