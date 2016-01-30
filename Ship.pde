// The class name starts with uppercase
class Ship extends GameObject
{
  // Fields!
  char move;
  char left;
  char right;
  char fire;
  int score;

  // Constructor!!
  // HAS NO RETURN TYPE
  // Name is always the same as the class

  void applyTo()
  {
  }

  Ship()
  {
    // Constructor chaining. Call a constructor in the super class
    super(width * 0.5f, height  * 0.5f, 50);
  }

  Ship(char move, char left, char right, char fire, float startX, float startY, color c)
  {
    super(startX, startY, 50);
    this.move = move;
    this.left = left;
    this.right = right;
    this.fire = fire;
    this.c = c;
    this.score = 0;
  }

  int elapsed = 12;

  void update()
  {
    forward.x = sin(theta);
    forward.y = - cos(theta);
    forward.mult(speed);

    if (keys[move])
    {
      pos.add(forward);
    }      
    if (keys[left])
    {
      theta -= 0.1f;
    }
    if (keys[right])
    {
      theta += 0.1f;
    }      
    if (keys[fire]  && elapsed > 12)
    {
      // Create a new bullet instance and add it to the arraylist of bullets
      Bullet bullet = new Bullet();
      bullet.pos.x = pos.x;
      bullet.pos.y = pos.y;
      bullet.pos.add(PVector.mult(forward, 6));
      bullet.c = c;
      bullet.theta = theta;
      gameObjects.add(bullet);
      elapsed = 0;
    }

    if (pos.x < 0)
    {
      pos.x = width;
    }

    if (pos.x > width)
    {
      pos.x = 0;
    }

    if (pos.y < 0)
    {
      pos.y = height;
    }

    if (pos.y > height)
    {
      pos.y = 0;
    }
    elapsed ++;
  }

  void render()
  {
    pushMatrix(); // reset the translation and rotation
    translate(pos.x, pos.y);
    stroke(c);
    fill(c);
    rotate(theta); // We want rotate to happen first, so you make the call AFTER translate    
    /*line(- halfW*0.8, halfW*0.8, 0, - halfW*0.8);
     line(0, - halfW*0.8, halfW*0.8, halfW*0.8);
     line(halfW*0.8, halfW*0.8, 0, 0);
     line(- halfW*0.8, halfW*0.8, 0, 0);*/
     
    // Places the vertices of the polygon 
      
      int[] xpts = {
      0, 10, 30, 30, 5, 5, 2, 2, -2, -2, -5, -5, -30, -30, -10, 0                    };
    int[] ypts = {
      -40, -5, 10, 13, 5, 10,10, 15,15, 10, 10, 5, 10, 8, -5, -40                };
    beginShape(POLYGON);
    for (int i = 0; i < 16; i++) {
      vertex(xpts[i], ypts[i]);
    }
    endShape(); 
    popMatrix();
  }
}