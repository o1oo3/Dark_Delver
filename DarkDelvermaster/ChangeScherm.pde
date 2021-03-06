/*
This class swaps between different screens and reloads the necessary functions
 */

class ChangeScherm {

  /*
This method loads the parts that are required for the first maze
   */

  void changeMainMenu() {
    if (schermen.welkScherm[0]) {
      //  z LOADS THE FIRST LEVEL
      if (key == 'z') {        
        assets.audiomenutheme.pause();
        assets.audiomenutheme.rewind();
        assets.audioleveltheme.rewind();
        assets.audioleveltheme.loop();
        schermen.welkScherm[0] = false;
        schermen.welkScherm[1] = true;

        mazeGeneration.changeMazeGeneration(72, 10, 10);
        mazeGeneration.setWalls();
        player.changePlayer();
        player.level = 1;
        sleutel.changeSleutel(); //UPDATES THE INFORMATION FOR INDIVIDUAL KEYS, SUCH AS LOCATION.
        sleutel2.changeSleutel(); 
        sleutel3.changeSleutel();
        monster.changeMonster(40); //UPDATES THE INFORMATION FOR INDIVIDUAL MONSTERS, SUCH AS START LOCATION AND PROXIMITY TO EACH OTHER AND THE PLAYER.
        monster2.changeMonster(60);
        monster3.changeMonster(45); // THE NUMBER BETWEEN THE CONSTRUCTOR IS THE FREQUENCY AT WHICH THE MONSTER MAKES DECISIONS, IN THIS CASE EVERY 45 FRAMES.
        eindDeur.changeEindDeur();
        startTimer.min = 0;
        startTimer.s= 0;
        startTimer.ms = 0;
      }
    }
  }
  /*
  This method is called when you beat a level.
   */
  void changeGameScherm() {
    if (schermen.welkScherm[1]) {
      assets.audiovictory.rewind();
      assets.audiovictory.play();
      startTimer.levelmin = 0;
      startTimer.levelms = 0;
      startTimer.levelsec = 0;

      if (player.level < 8) {
        mazeGeneration.changeMazeGeneration(72, 10+player.level-1, 10);
      } else {
        mazeGeneration.changeMazeGeneration(72, 17, 10);
      }
      mazeGeneration.setWalls();
      bomb.resetBomb();
      player.changePlayer();
      sleutel.changeSleutel(); //UPDATES THE INFORMATION FOR INDIVIDUAL KEYS, SUCH AS LOCATION.
      sleutel2.changeSleutel();
      sleutel3.changeSleutel();
      if (player.level > 15) {
        monster.changeMonster(15);
      } else {
        monster.changeMonster(60-player.level*3);
      }//UPDATES THE INFORMATION FOR INDIVIDUAL MONSTERS, SUCH AS START LOCATION AND PROXIMITY TO EACH OTHER AND THE PLAYER.
      if (player.level > 20) {
        monster2.changeMonster(15);
      } else {
        monster2.changeMonster(75-player.level*3);
      }
      if (player.level > 25) {
        monster3.changeMonster(15);
      } else {
        monster3.changeMonster(90-player.level*3);
      }// THE NUMBER BETWEEN THE CONSTRUCTOR IS THE FREQUENCY AT WHICH THE MONSTER MAKES DECISIONS, IN THIS CASE EVERY 45 FRAMES.
      eindDeur.changeEindDeur();
    }
  } 
  /*
  this method is called when you are gameover, it 
   */
  void changeGameoverScherm() {
    if (schermen.welkScherm[2]) {         
      player.level = 0;
      startTimer.min = 0;
      startTimer.s = 0;
      startTimer.ms = 0;
      startTimer.levelmin = 0;
      startTimer.levelms = 0;
      startTimer.levelsec = 0;
      scoreToevoegen.totalTime = "00:00";
      scoreToevoegen.totalScore = 0;
      if (key == 'z') { //z RETURNS THE USER TO THE TITLE SCREEN
        assets.audiomenutheme.loop();
        assets.audiogameovertheme.pause();
        assets.audiogameovertheme.rewind();
        schermen.welkScherm[2] = false;
        schermen.welkScherm[0] = true;
      }
    }
  }
}
