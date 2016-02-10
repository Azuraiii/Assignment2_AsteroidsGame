import controlP5.*;
ControlP5 cp5;
Menu m;

ArrayList<GameObject> gameObjects = new ArrayList<GameObject>();
ArrayList<Asteroid> rocks = new ArrayList<Asteroid>();
ArrayList<smallAsteroid> smallRocks = new ArrayList<smallAsteroid>();

public int start = 0;
public int highscores = 0;
public int score = 0;
public int lives = 0;
//counter for loop
public int check;
public boolean clear = false;

//background image
PImage bg;


boolean run = false;

PrintWriter output;
BufferedReader reader;


void setup()
{


  cp5 = new ControlP5(this);
  m = new Menu();
  m.setup();
  size(800, 600);
  bg = loadImage("img/background.gif");
  bg.resize(800, 600);
  Ship ship = new Ship('W', 'A', 'D', ' ', 400, height / 2, color(0, 255, 255));
  gameObjects.add(ship);



  //adds 8 starting asteroids
  for (int i = 0; i < 16; i++)
  {
    rocks.add(new Asteroid());
  }
}

void loadData()
{
  //reads the file
  reader = createReader("data/highscore.txt");
  //creates a new file in the sketch directory
  output = createWriter("data/highscore.txt");
  String line;

  try {
    line = reader.readLine();
  } 
  catch(IOException e) {
    e.printStackTrace();
    line=null;
  }

  //shows data
  if (highscores == 1)
  {
    for (int i=0; i < 10; i++) 
    {
      text("Highscores are:"+ line, (width / 2) - 95, (height / 4) + 25 + (i * 15));
      println(line);
    }
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
            lives = 1;
            //loadData();
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

  if (keyPressed)
  {
    //to pause the game
    if (key == 'P' || key == 'p')
    {
      run = false;
      fill(255);
      text("You have paused, move to continue", (width / 4), (height / 4));
      noLoop();
    } else {
      run = true;
      loop();
    }

    if (key == 'R' || key == 'r')
    {
      lives = 0;
      score = 0;
      highscores = 0;
      start = 0;
      rocks.clear();
      gameObjects.clear();
    }
  }
}

void keyReleased()
{
  keys[keyCode] = false;
}

void draw()
{
  //shows menu at the start
  if (start == 0)
  {
    m.show_menu();
  }

  //starts the game start game button is pressed
  if (start == 1 && run == true)
  {
    //clears the array list and adds 10 new asteroids, this method only happens once
    if (clear == true)
    {
      rocks.clear();
      for (int i = 0; i < 10; i++)
      {
        rocks.add(new Asteroid());
      }

      Ship ship = new Ship('W', 'A', 'D', ' ', 400, height / 2, color(0, 255, 255));
      gameObjects.add(ship);
      clear = false;
    }

    m.hide_menu();
    start_game();
    bulletAsteroidCollision();
    shipAsteroidCollision();
    bulletSmallAstCollision();
  }


  if (highscores == 0)
  {
    m.hide_highscores();
  }

  //calls the load data function when high score button is pressed
  if (highscores == 1)
  {
    m.hide_menu();
    m.show_highscores();
    loadData();
    background(0);
    textSize(35);
    textAlign(CENTER);
    fill(255);
    text("Highscores:", width / 2, height / 4);
  }


  // reads data
  if (lives == 1)
  {
    loadData();
    output.println(score);
    output.flush();
    output.close();
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

void gameOver()
{
  //Gameover
  fill(255, 0, 0);

  text("YOU DIED", width/2-40, height/2); 
  textSize(32); 
  text("'R' to retry", width/2-40, height/2+32);
}

void start_game()
{

  //universe background
  background(bg);
  //adds 10 starting asteroids

  //score
  println(score);
  textSize(32); 
  fill(150, 255, 255); 
  text("Score:" + score, 8, 32); 

  //this spawns more asteroids as the game progresses
  if (score%20 == 0 && score !=0 && score > check)
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
}