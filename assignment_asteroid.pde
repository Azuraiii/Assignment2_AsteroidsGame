// A demo of abstract classes and interfaces


void setup()
{
  size(1000, 1000);
  Ship shipz = new Ship('W', 'A', 'D', ' ', 200, height / 2, color(0, 255, 255));
  shipz.add(ship);
}

// The class name always starts with uppercase!!

ArrayList<Ship> shipz = new ArrayList<Ship>();
ArrayList<Bullet> laserz = new ArrayList<Bullet>();
ArrayList<Asteroid> rocks = new ArrayList<Asteroid>();


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

  for (int i = ship.size() - 1; i >= 0; i --)
  {
    Ship go = shipz.get(i);
    go.update();
    go.render();
  }
  
  for (int i = rocks.size() - 1; i >= 0; i --)
  {
    Asteroid go1 = rocks.get(i);
    //go1.update();
    go1.render();
  }

}