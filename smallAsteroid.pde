class smallAsteroid extends Asteroid
{
  smallAsteroid()
  {
    forward.x = random(-1,1);
    forward.y = random(-1,1);
    //sets the forward vector to 1
    forward.normalize();
    pos.x = random(0,width);
    pos.y = random(0,height); 
  }
  
  void render() 
  { 
    pushMatrix();
    translate(pos.x,pos.y);
    rotate(theta);
    //white
    stroke(255);
    ellipse(-halfW/2,-halfW/2,w/2,w/2);
    popMatrix();
  }
  
}