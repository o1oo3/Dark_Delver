/*
gemaakt door:
  Oscar Oosterling 500775970
  Coen Veenker 500779784
  Tristan Derriks 500754707
  Hajk Grigorian 500741588
  IG101-3 2018/2019
  Project FastenYourSeatbelts
  
Dark Delver
dit is een spel waabij de player door een doolhof moet lopen om naar de uitgang te gaan. 
*/

import java.util.*;
import ddf.minim.*;
Minim minim;
LoadAssets assets;

MazeGeneration mazeGeneration;
Player player;
Monster monster;
Sleutel sleutel;
EindDeur eindDeur;
Schermen schermen;
ChangeScherm changeScherm;
SpriteSheet keySheet;
SpriteSheet playerSheet;
SpriteSheet monsterSheet;



void setup() {
  size(1280, 720);
  mazeGeneration = new MazeGeneration();
  player = new Player();
  monster = new Monster();
  sleutel= new Sleutel();
  eindDeur = new EindDeur();
  schermen = new Schermen();
  changeScherm = new ChangeScherm();
  minim = new Minim(this);
  assets = new LoadAssets();
  textFont(assets.pixeled);
  
}
void draw() {
  background(assets.backgroundDD);
  schermen.mainMenu();
  schermen.gameScherm();
  schermen.gameOverScherm();

}

void keyPressed() {
  player.movePlayer();
  changeScherm.changeMainMenu();
  changeScherm.changeGameoverScherm();
  player.playerBomb();
}
void keyReleased() {
  player.stopPlayer();
}