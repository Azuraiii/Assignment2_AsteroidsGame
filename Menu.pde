class Menu
{
  int mode;
  boolean pause;
  String filename;
  File f;
  String[] highscores;

  void setup()
  {
    filename = "highscores.txt";
    f = new File(dataPath(filename));
    
    cp5.addButton("Start Game").setValue(1).setPosition(200, 220).setSize(375, 50);
    cp5.addButton("View High Score").setValue(2).setPosition(200, 295).setSize(375, 50);
    cp5.addButton("Exit Game").setValue(3).setPosition(200, 370).setSize(375, 50);

  }
  
  void show_menu()
  {
   
   cp5.getController("Start Game").setVisible(true);
   cp5.getController("View High Score").setVisible(true);
   cp5.getController("Exit Game").setVisible(true);
   
   if(mousePressed)
   {
     if( mouseX > 200 && mouseX < 575 && mouseY > 220 && mouseY < 270)
     {
       start = true;
     }
   }
  }
  
  void hide_menu()
  {
    cp5.getController("Start Game").setVisible(false);
    cp5.getController("View High Score").setVisible(false);
    cp5.getController("Exit Game").setVisible(false);
  }
  
  /*void controlEvent(ControlEvent ce)
  {
     if(mode ==1)
     {
       if(ce.getValue() == 1)
       {
         start_game();
         hide_menu();
       }
     }
  }*/
}