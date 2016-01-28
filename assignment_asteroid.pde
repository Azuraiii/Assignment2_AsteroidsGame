// A demo of abstract classes and interfaces
// The class name always starts with uppercase!!

ArrayList<GameObject> gameObjects = new ArrayList<GameObject>();
ArrayList<Asteroid> rocks = new ArrayList<Asteroid>();

void setup()
{
  size(1000, 1000);
  Ship ship = new Ship('W', 'A', 'D', ' ', 200, height / 2, color(0, 255, 255));
  gameObjects.add(ship);
}


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
      for (int j = rocks.size()-1; j >=0; j--)
      {
        Asteroid other = rocks.get(j);
        //checks arraylist for powerup
        if (other instanceof Interface)
        {
          //bounding collisions
          if (go.pos.dist(other.pos) < go.halfW + other.halfW)
          {
            rocks.remove(other);
            /*//Gameover
             text("YOU DIED", width/2-160, height/2); 
             textSize(32); 
             text("'R' to retry", width/2-160, height/2+32);*/
          }
        }
      }
    }
  }
}


void bulletAsteroidCollision()
{
  for (int i = gameObjects.size()-1; i >=0; i--)
  {
    //retrieves the game object from position i
    GameObject go = gameObjects.get(i); 
    //checks to see if instance is a ship
    //checks arraylist for ship
    if (go instanceof Bullet)
    {
      for (int j = rocks.size()-1; j >=0; j--)
      {
        Asteroid other = rocks.get(j);
        //checks arraylist for powerup
        if (other instanceof Interface)
        {
          //bounding collisions
          if (go.pos.dist(other.pos) < go.halfW + other.halfW)
          {
            rocks.remove(other);
            gameObjects.remove(go);
            
           // smallAsteroid smallA = new smallAsteroid();
            

            /*//Gameover
             text("YOU DIED", width/2-160, height/2); 
             textSize(32); 
             text("'R' to retry", width/2-160, height/2+32);*/
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
  bulletAsteroidCollision();
  shipAsteroidCollision();

  if (frameCount%120 ==0)
  {
    Asteroid a = new Asteroid();
    rocks.add(a);
  }

  for (int i = gameObjects.size() -1; i >= 0; i --)
  {
    GameObject go = gameObjects.get(i);
    go.update();
    go.render();
  }
  //displays the asteroids
  for (int i = rocks.size()- 1; i>=0; i--)
  {
    Asteroid rock = rocks.get(i);
    rock.render();
    rock.update();
  }
}