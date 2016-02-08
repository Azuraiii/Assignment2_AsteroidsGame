import controlP5.*;
ControlP5 cp5;
Menu m;

ArrayList<GameObject> gameObjects = new ArrayList<GameObject>();
ArrayList<Asteroid> rocks = new ArrayList<Asteroid>();
ArrayList<smallAsteroid> smallRocks = new ArrayList<smallAsteroid>();

public int score = 0;
public int lives = 1;
//counter for loop
public int check;

PImage bg;
boolean start = false;
void setup()
{
  cp5 = new ControlP5(this);
  m = new Menu();
  m.setup();

  size(800, 600);
  bg = loadImage("img/background.gif");
  bg.resize(800, 600);
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
            gameObjects.remove(go);
            /*//Gameover
             text("YOU DIED", width/2-160, height/2); 
             textSize(32); 
             text("'R' to retry", width/2-160, height/2+32);*/
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
            gameObjects.remove(go);
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

  if (start == true)
  {
    m.hide_menu();
    start_game();
    bulletAsteroidCollision();
    shipAsteroidCollision();
    bulletSmallAstCollision();
  } else
  {
    m.show_menu();
  }

  /* switch(m.mode)
   {
   //default
   case 0: 
   default:
   m.show_menu();
   break;
   //starts the game
   case 1:
   m.hide_menu();
   break;
   }*/
}

void start_game()
{

  //universe background
  background(bg);

  //score
  println(score);
  textSize(32); 
  fill(150, 255, 255); 
  text("Score:" + score, 8, 32); 



  if (score%5 == 10 && score !=0 && score > check)
  {
    check = score;
    rocks.add(new Asteroid());
  }

  //displays the ship and bullets
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

  //displays the smaller asteroids
  for (int i = smallRocks.size()-1; i>=0; i--)
  {
    smallAsteroid smallRock = smallRocks.get(i);
    smallRock.render();
    smallRock.update();
  }
}