class Bullet extends GameObject
{
  
  Bullet()
  {
    speed = 10.0f;
  }
  
  void applyTo(Bullet bullet)
  {
    
  }
  
  
  void render()
  {
    stroke(c);
    // Just draw a small vertical line
    pushMatrix();
    translate(pos.x, pos.y);
    rotate(theta);
    noFill();
    ellipse(5,5,5,5);
    popMatrix();    
  }
  
  void update()
  {
    forward.x = sin(theta);
    forward.y = - cos(theta);
      
    forward.mult(speed);
    pos.add(forward);
    
    if (pos.x < 0 || pos.y < 0 || pos.x > width || pos.y > height)
    {
      // Im dead!
      gameObjects.remove(this);
    }
  }
}