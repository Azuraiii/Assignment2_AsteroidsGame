class Powerup extends GameObject
{

  float points;
  float rotSpeed;
  float radius;
  float rot;
  float size;
  float x, y, a, v, r, w, s;

  Powerup()
  {
  }

  void update()
  {
  }

  void render()
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