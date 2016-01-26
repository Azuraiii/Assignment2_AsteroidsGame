// A demo of abstract classes and interfaces
// The class name always starts with uppercase!!

ArrayList<GameObject> gameObjects = new ArrayList<GameObject>();

void setup()
{
  size(1000, 1000);
  Ship ship = new Ship('W', 'A', 'D', ' ', 200, height / 2, color(0, 255, 255));
  gameObjects.add(ship);
}

/*void bulletAsteroidCollision()
 {
 for (int i = gameObjects.size()-1; i >=0; i--)
 {
 //retrieves the game object from position i
 GameObject go = gameObjects.get(i); 
 //checks to see if instance is a ship
 //checks arraylist for ship
 if (go instanceof Bullet)
 {
 for (int j = gameObjects.size()-1; j >=0; j--)
 {
 GameObject other = gameObjects.get(j);
 //checks arraylist for powerup
 if (other instanceof Asteroid)
 {
 //bounding collisions
 if (go.pos.dist(go.pos)< other.halfW)
 {
 //casting
 ((Asteroid) other).applyTo((Bullet)go);
 }
 }
 }
 }
 }
 }*/

void shipAsteroidCollision()
{
  for (int i = gameObjects.size()-1; i >=0; i--)
  {
    //retrieves the game object from position i
    GameObject go = gameObjects.get(i); 
    //checks to see if instance is a ship
    //checks arraylist for ship
    if (go instanceof Ship)
    {
      for (int j = gameObjects.size()-1; j >=0; j--)
      {
        GameObject other = gameObjects.get(j);
        //checks arraylist for powerup
        if (other instanceof Asteroid)
        {
          //bounding collisions
          if (go.pos.dist(other.pos) < go.halfW + other.halfW)
          {
            
           // gameObjects.remove(other);
            //Gameover
            text("YOU DIED", width/2-160, height/2); 
            textSize(32); 
            text("'R' to retry", width/2-160, height/2+32);
          }
        }
      }
    }
  }

  for (int j = gameObjects.size()-1; j>=0; j--)
  {
    GameObject other = gameObjects.get(j);
    if (other instanceof Asteroid)
    {
      for (int k = gameObjects.size() - 1; k>=0; k--)
      {
        GameObject shot = gameObjects.get(k);

        if (shot instanceof Bullet)
        {

          if (other.pos.dist(shot.pos) < other.halfW)
          {
            gameObjects.remove(shot);
            gameObjects.remove(other);
          }
        }
      }
    }
  }
}

boolean[] keys = new boolean[512];

void keyPressed()
{
  keys[keyCode] = true;
}

void keyReleased()
{
  keys[keyCode] = false;
}

void draw()
{
  background(0);

  if (frameCount%120 ==0)
  {
    Asteroid a = new Asteroid();
    gameObjects.add(a);
  }

  for (int i = gameObjects.size() - 1; i >= 0; i --)
  {
    GameObject go = gameObjects.get(i);
    go.update();
    go.render();
  }

  //bulletAsteroidCollision();
  shipAsteroidCollision();
}