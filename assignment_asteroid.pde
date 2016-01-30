// A demo of abstract classes and interfaces
// The class name always starts with uppercase!!

ArrayList<GameObject> gameObjects = new ArrayList<GameObject>();
ArrayList<Asteroid> rocks = new ArrayList<Asteroid>();
ArrayList<smallAsteroid> smallRocks = new ArrayList<smallAsteroid>();

public int score = 0;
public int lives = 1;
public int launch = 0;

void setup()
{



  size(800, 800);
  Ship ship = new Ship('W', 'A', 'D', ' ', 200, height / 2, color(0, 255, 255));
  gameObjects.add(ship);

  //adds 8 starting asteroids
  for (int i = 0; i < 8; i++)
  {
    rocks.add(new Asteroid());
  }
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

            smallAsteroid sAsteroid = new smallAsteroid(other.pos);
            smallAsteroid sAsteroid2 = new smallAsteroid(other.pos);
            smallRocks.add(sAsteroid);
            smallRocks.add(sAsteroid2);

            rocks.remove(other);
            gameObjects.remove(go);

            score = score + 5;
          }
        }
      }
    }
  }
}

void bulletSmallAstCollision()
{
  for (int i = gameObjects.size()-1; i >=0; i--)
  {
    //retrieves the game object from position i
    GameObject go = gameObjects.get(i); 
    //checks to see if instance is a ship
    //checks arraylist for ship
    if (go instanceof Bullet)
    {
      for (int j = smallRocks.size()-1; j >=0; j--)
      {
        smallAsteroid smallAst1 = smallRocks.get(j);
        //checks arraylist for powerup
        if (smallAst1 instanceof Interface)
        {
          //bounding collisions
          if (go.pos.dist(smallAst1.pos) < go.halfW + smallAst1.halfW)
          {
            smallRocks.remove(smallAst1);
            gameObjects.remove(go);

            score = score + 5;
          }
        }
      }

      for (int k = smallRocks.size()-1; k >=0; k--)
      {
        smallAsteroid smallAst2 = smallRocks.get(k);
        //checks arraylist for powerup
        if (smallAst2 instanceof Interface)
        {
          //bounding collisions
          if (go.pos.dist(smallAst2.pos) < go.halfW + smallAst2.halfW)
          {
            smallRocks.remove(smallAst2);
            gameObjects.remove(go);

            score = score + 5;
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
  bulletSmallAstCollision();

  println(score);
  //generates more asteroids

  textSize(32); 
  fill(150, 255, 255); 
  text("Score:" + score, 8, 32); 

  if (launch > 0)
  {
    if (score%10== 0)
    {
      Asteroid a = new Asteroid();
      rocks.add(a);
    }
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

  for (int i = smallRocks.size()-1; i>=0; i--)
  {
    smallAsteroid smallRock = smallRocks.get(i);
    smallRock.render();
    smallRock.update();
  }
}