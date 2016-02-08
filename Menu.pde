class Menu
{
  int mode;
  boolean pause;
  String textValue = "";
  String scores;



  void setup()
  {  
    PFont font = createFont("arial", 20);

    cp5.addTextfield("input")
      .setPosition(20, 100)
      .setSize(200, 40)
      .setFont(font)
      .setFocus(true)
      .setColor(color(255, 0, 0))
      ;
    cp5.addTextfield("Please Enter Your Name").setPosition(20, 170).setSize(200, 40).setAutoClear(false).setVisible(false);
    cp5.addBang("Submit").setPosition(240, 170).setSize(80, 40).setVisible(false);    

    cp5.addButton("Start Game").setValue(1).setPosition(200, 220).setSize(375, 50);
    cp5.addButton("View High Score").setValue(2).setPosition(200, 295).setSize(375, 50);
    cp5.addButton("Exit Game").setValue(3).setPosition(200, 370).setSize(375, 50);
  }

  void show_menu()
  {

    cp5.getController("Start Game").setVisible(true);
    cp5.getController("View High Score").setVisible(true);
    cp5.getController("Exit Game").setVisible(true);

    if (mousePressed)
    {
      if ( mouseX > 200 && mouseX < 575 && mouseY > 220 && mouseY < 270)
      {
        start = 1;
      }
    }
  }

  void hide_menu()
  {
    cp5.getController("Start Game").setVisible(false);
    cp5.getController("View High Score").setVisible(false);
    cp5.getController("Exit Game").setVisible(false);
  }


  void show_highscores()
  {
    cp5.getController("input").setVisible(true);
    textSize(35);
    textAlign(CENTER);
    text("Highscores", width / 2, height / 4);
  }

  void hide_highscores()
  {
    cp5.getController("input").setVisible(false);

    if (mousePressed)
    {
      if ( mouseX > 200 && mouseX < 575 && mouseY > 295 && mouseY < 345)
      {
        start = 3;
        highscores = 1;
      }
    }
  }

  void show_submit()
  {
    cp5.get(Textfield.class, "Please Enter Your Name").setVisible(true).getText(); 
    cp5.get(Bang.class, "Submit").setVisible(true);
  }
}