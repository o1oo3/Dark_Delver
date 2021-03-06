/*
This class is made for the movement of the monster.
The movement is based on the maze generation algorithm and is programmed as follows:
  1 -- An array is made with every possible (53)(0-52) situation a monster can find itself in when deciding where to move, with the condition that he will not move back unless unable to do so otherwise.
  2 -- The algorithm checks which mazeGeneration.{direction}Wall[monsterX][monsterY] variables are true or false 
  3 -- All situations in the array are either set to 0(false) or 1(true), depending on which mazeGeneration.{direction}Wall[monsterX][monsterY] and monsterCameFrom{Direction} are set to 0(false) or 1(true)
  3.1 -- All monsterCameFrom{Direction} variables are set to false, so that no two cells are marked as 'monsterCameFrom{Direction}' at the same time.
  3.2 -- monsterCameFrom{Direction} is one of four variables to denote where the monster came from, listed as the it just moved from, linked to the direction opposite of the direction it walked before.
  3.3 -- The algorithm will try to avoid selecting a situation where the monster moves in a direction that has monsterCameFrom{Direction} == true
  4 -- A random number out of 53 (0-52) possible numbers is chosen.
  4.1 -- The random number is linked to the situation with the corresponding number.
  4.2 -- If the situation was not set to 1(true), another number is chosen untill a situation with 1(true) has been selected.
  5 -- All situations are categorised in 4 directions, UP DOWN LEFT and RIGHT
  6 -- The algorithm checks which of the 4 directions is linked to it's currently chosen situation, and moves the monster in that respective direction.
  7 -- One of the monsterCameFrom{Direction} is set to true, this is the direction opposite of the direction the monster was selected to move.
  8 -- The algorithm sets all possible situations in the array to 0(false) via a for loop, so that no two situations can be set to 1(true) at the same time.
 */

class Monster {
  int monsterX;
  int monsterY;
  int monster2X;
  int monster2Y;

  boolean monsterCameFromTop;
  boolean monsterCameFromRight;
  boolean monsterCameFromDown;
  boolean monsterCameFromLeft;


  int[] monsterCurrentCellSituation;
  int monsterChosenDirection;
  int monsterAudioPicker;

  int monsterTimer;
  int monsterSpeed;



/*This method dictates the creation of a single monster whenever a new one is called upon in the DarkDelvermaster main*/
  void changeMonster(int monsterSpeed) {
    do { //DO WHILE LOOP THAT CHOOSES THE SPAWN LOCATION FOR A MONSTER, DEPENDING ON CONDITIONS IN THE LIST BELOW.
      monsterX = (int)random(0, mazeGeneration.mazeSizeX);
      monsterY = (int)random(0, mazeGeneration.mazeSizeY); 
      //VVVVVV LIST OF CONDITIONS THAT DESCRIBE THE PLAYER COORDINATES BEING A CERTAIN DISTANCE AWAY FROM ALL POSSIBLE MONSTE COORDINATES.
      // THESE CONDITIONS ARE USED TO SELECT THE MONSTER SPAWNING LOCATION, WHICH IS ATLEAST FOUR CELLS AWAY FROM THE PlAYER AND OTHER MONSTERS.
    } while (monsterX >= player.playerX-4 && monsterX <= player.playerX+4 && monsterY >= player.playerY-4 && monsterY <= player.playerY+4 
      && monster2.monsterX >= monster.monsterX-4 && monster2.monsterY >= monster.monsterY-4 && monster2.monsterX <= monster.monsterX+4 && monster2.monsterY <= monster.monsterY +4
      && monster3.monsterX >= monster.monsterX-4 && monster3.monsterY >= monster.monsterY-4 && monster3.monsterX <= monster.monsterX+4 && monster3.monsterY <= monster.monsterY +4
      && monster3.monsterX >= monster2.monsterX-4 && monster3.monsterY >= monster2.monsterY-4 && monster3.monsterX <= monster2.monsterX+4 && monster3.monsterY <= monster2.monsterY +4
      && monster.monsterX >= monster2.monsterX-4 && monster.monsterY >= monster2.monsterY-4 && monster.monsterX <= monster2.monsterX+4 && monster.monsterY <= monster2.monsterY +4
      && monster.monsterX >= monster3.monsterX-4 && monster.monsterY >= monster3.monsterY-4 && monster.monsterX <= monster3.monsterX+4 && monster.monsterY <= monster3.monsterY +4
      && monster2.monsterX >= monster3.monsterX-4 && monster2.monsterY >= monster3.monsterY-4 && monster2.monsterX <= monster3.monsterX+4 && monster2.monsterY <= monster3.monsterY +4);
    monsterCameFromTop=false; //SETS ALL monsterCameFrom VARIABLES TO FALSE SO AS TO ENABLE THE MONSTER TO PICK ANY DIRECTION WHEN IT SPAWNS
    monsterCameFromRight=false;
    monsterCameFromDown=false;
    monsterCameFromLeft=false;
    monsterCurrentCellSituation = new int [52]; //CREATES THE ARRAY FOR ALL POSSIBLE SITUATIONS
    monsterChosenDirection = 0; //SETS monsterChosenDirection to 0 SO A VALUE IS ATTACHED AND IT CAN BE USED.
    this.monsterSpeed = monsterSpeed; 
  }

  void makeMonster() {
    monsterTimer++;
    if (monsterTimer%monsterSpeed == 0) {
      
      /*CODE FOR ALL POSSIBLE SITUATIONS IN RELATION TO MONSTER LOCATION AND OPEN PATHS*/
      /*mazeGeneration.[direction]Wall[monsterX][monsterY] DENOTES WHICH SIDE IS CLOSED OFF WITH A WALL (TRUE) OR OPEN (FALSE)*/
      /*monsterCameFrom(x) DENOTES WHICH DIRECTION THE MONSTER CAME FROM AND IS NOT ALLOWED TO GO BACK TO UNLESS ALL OTHER DIRECTIONS ARE SET TO mazeGeneration.[direction]Wall[monsterX][monsterY] == true */
      if (mazeGeneration.amountOfCellsVisited>= (mazeGeneration.mazeSizeX*mazeGeneration.mazeSizeY)) {

        if (mazeGeneration.topWall[monsterX][monsterY] == false 
          && monsterCameFromTop == false) {
          monsterCurrentCellSituation[0] = 1;
        } else if (mazeGeneration.rightWall[monsterX][monsterY] == false 
          && monsterCameFromRight == false) {
          monsterCurrentCellSituation[1] = 1;
        } else if (mazeGeneration.bottomWall[monsterX][monsterY] == false 
          && monsterCameFromDown == false) {
          monsterCurrentCellSituation[2] = 1;
        } else if (mazeGeneration.leftWall[monsterX][monsterY] == false 
          && monsterCameFromLeft == false) {
          monsterCurrentCellSituation[3] = 1;
        } 
        if (mazeGeneration.topWall[monsterX][monsterY] == true 
          && mazeGeneration.leftWall[monsterX][monsterY] == true 
          && mazeGeneration.rightWall[monsterX][monsterY] == true 
          && monsterCameFromDown != false) {
          monsterCurrentCellSituation[4] = 1;
        } 
        if (mazeGeneration.rightWall[monsterX][monsterY] == true 
          && mazeGeneration.topWall[monsterX][monsterY] == true 
          && mazeGeneration.bottomWall[monsterX][monsterY] == true  
          && monsterCameFromLeft != false) {
          monsterCurrentCellSituation[5] = 1;
        } 
        if (mazeGeneration.bottomWall[monsterX][monsterY] == true 
          && mazeGeneration.leftWall[monsterX][monsterY] == true 
          && mazeGeneration.rightWall[monsterX][monsterY] == true  
          && monsterCameFromTop != false) {
          monsterCurrentCellSituation[6] = 1;
        } 
        if (mazeGeneration.leftWall[monsterX][monsterY] == true 
          && mazeGeneration.topWall[monsterX][monsterY] == true
          && mazeGeneration.bottomWall[monsterX][monsterY] == true 
          && monsterCameFromRight != false) {
          monsterCurrentCellSituation[7] = 1;
        }
        if (mazeGeneration.topWall[monsterX][monsterY] == true 
          && mazeGeneration.leftWall[monsterX][monsterY] == true
          && mazeGeneration.rightWall[monsterX][monsterY] == false 
          && monsterCameFromDown != false) {
          monsterCurrentCellSituation[8] = 1; //right
        } 
        if (mazeGeneration.topWall[monsterX][monsterY] == true 
          && mazeGeneration.leftWall[monsterX][monsterY] == false 
          && mazeGeneration.rightWall[monsterX][monsterY] == true 
          && monsterCameFromDown != false) {
          monsterCurrentCellSituation[9] = 1; //left
        } 
        if (mazeGeneration.rightWall[monsterX][monsterY] == true 
          && mazeGeneration.topWall[monsterX][monsterY] == true 
          && mazeGeneration.bottomWall[monsterX][monsterY] == false  
          && monsterCameFromLeft != false) {
          monsterCurrentCellSituation[10] = 1; //go down
        } 
        if (mazeGeneration.rightWall[monsterX][monsterY] == true 
          && mazeGeneration.topWall[monsterX][monsterY] == false 
          && mazeGeneration.bottomWall[monsterX][monsterY] == true  
          && monsterCameFromLeft != false) {
          monsterCurrentCellSituation[11] = 1; //up
        } 
        if (mazeGeneration.bottomWall[monsterX][monsterY] == true 
          && mazeGeneration.leftWall[monsterX][monsterY] == true
          && mazeGeneration.rightWall[monsterX][monsterY] == false  
          && monsterCameFromTop != false) {
          monsterCurrentCellSituation[12] = 1; //right
        } 
        if (mazeGeneration.bottomWall[monsterX][monsterY] == true 
          && mazeGeneration.leftWall[monsterX][monsterY] == false 
          && mazeGeneration.rightWall[monsterX][monsterY] == true  
          && monsterCameFromTop != false) {
          monsterCurrentCellSituation[13] = 1; //left
        } 
        if (mazeGeneration.leftWall[monsterX][monsterY] == true 
          && mazeGeneration.topWall[monsterX][monsterY] == true 
          && mazeGeneration.bottomWall[monsterX][monsterY] == false
          && monsterCameFromRight != false) {
          monsterCurrentCellSituation[14] = 1; //down
        } 
        if (mazeGeneration.leftWall[monsterX][monsterY] == true
          && mazeGeneration.topWall[monsterX][monsterY] == false
          && mazeGeneration.bottomWall[monsterX][monsterY] == true 
          && monsterCameFromRight != false) {
          monsterCurrentCellSituation[15] = 1; //up
        } 
        if (mazeGeneration.topWall[monsterX][monsterY] == true 
          && mazeGeneration.leftWall[monsterX][monsterY] == false 
          && mazeGeneration.rightWall[monsterX][monsterY] == false 
          && mazeGeneration.bottomWall[monsterX][monsterY] == false
          && monsterCameFromDown != false) {
          monsterCurrentCellSituation[16] = 1; //right crossroad wall top from bottom
        } 
        if (mazeGeneration.topWall[monsterX][monsterY] == true 
          && mazeGeneration.leftWall[monsterX][monsterY] == false 
          && mazeGeneration.rightWall[monsterX][monsterY] == false 
          && mazeGeneration.bottomWall[monsterX][monsterY] == false 
          && monsterCameFromDown != false) {
          monsterCurrentCellSituation[17] = 1; //left CrossRoad wall top from bottom
        } 
        if (mazeGeneration.rightWall[monsterX][monsterY] == true 
          && mazeGeneration.topWall[monsterX][monsterY] == false 
          && mazeGeneration.bottomWall[monsterX][monsterY] == false 
          && mazeGeneration.leftWall[monsterX][monsterY] == false  
          && monsterCameFromLeft != false) {
          monsterCurrentCellSituation[18] = 1; //go down CR wall right from left
        } 
        if (mazeGeneration.rightWall[monsterX][monsterY] == true 
          && mazeGeneration.topWall[monsterX][monsterY] == false 
          && mazeGeneration.bottomWall[monsterX][monsterY] == false 
          && mazeGeneration.leftWall[monsterX][monsterY] == false  
          && monsterCameFromLeft != false) {
          monsterCurrentCellSituation[19] = 1; //up CR wall right from left
        } 
        if (mazeGeneration.bottomWall[monsterX][monsterY] == true 
          && mazeGeneration.leftWall[monsterX][monsterY] == false 
          && mazeGeneration.rightWall[monsterX][monsterY] == false 
          && mazeGeneration.topWall[monsterX][monsterY] == false  
          && monsterCameFromTop != false) {
          monsterCurrentCellSituation[20] = 1; //right CR wall down from top
        } 
        if (mazeGeneration.bottomWall[monsterX][monsterY] == true 
          && mazeGeneration.leftWall[monsterX][monsterY] == false 
          && mazeGeneration.rightWall[monsterX][monsterY] == false 
          && mazeGeneration.topWall[monsterX][monsterY] == false 
          && monsterCameFromTop != false) {
          monsterCurrentCellSituation[21] = 1; //left CR wall down from top
        } 
        if (mazeGeneration.leftWall[monsterX][monsterY] == true 
          && mazeGeneration.topWall[monsterX][monsterY] == false
          && mazeGeneration.bottomWall[monsterX][monsterY] == false 
          && mazeGeneration.rightWall[monsterX][monsterY] == false 
          && monsterCameFromRight != false) {
          monsterCurrentCellSituation[22] = 1; //down CR wall left from right
        } 
        if (mazeGeneration.leftWall[monsterX][monsterY] == true 
          && mazeGeneration.topWall[monsterX][monsterY] == false
          && mazeGeneration.bottomWall[monsterX][monsterY] == false 
          && mazeGeneration.rightWall[monsterX][monsterY] == false 
          && monsterCameFromRight != false) {
          monsterCurrentCellSituation[23] = 1; //up CR wall left from right
        }
        if (mazeGeneration.topWall[monsterX][monsterY] == false
          && mazeGeneration.rightWall[monsterX][monsterY] == false
          && mazeGeneration.bottomWall[monsterX][monsterY] == false 
          && mazeGeneration.leftWall[monsterX][monsterY] == false 
          && monsterCameFromRight != false) {
          monsterCurrentCellSituation[24] = 1; //4way left fr
        } 
        if (mazeGeneration.topWall[monsterX][monsterY] == false 
          && mazeGeneration.rightWall[monsterX][monsterY] == false 
          && mazeGeneration.bottomWall[monsterX][monsterY] == false 
          && mazeGeneration.leftWall[monsterX][monsterY] == false 
          && monsterCameFromRight != false) {
          monsterCurrentCellSituation[25] = 1; //4way down fr
        } 
        if (mazeGeneration.topWall[monsterX][monsterY] == false 
          && mazeGeneration.rightWall[monsterX][monsterY] == false 
          && mazeGeneration.bottomWall[monsterX][monsterY] == false 
          && mazeGeneration.leftWall[monsterX][monsterY] == false 
          && monsterCameFromRight != false) {
          monsterCurrentCellSituation[26] = 1; //4way up fr
        }
        if (mazeGeneration.topWall[monsterX][monsterY] == false 
          && mazeGeneration.rightWall[monsterX][monsterY] == false 
          && mazeGeneration.bottomWall[monsterX][monsterY] == false 
          && mazeGeneration.leftWall[monsterX][monsterY] == false 
          && monsterCameFromLeft != false) {
          monsterCurrentCellSituation[27] = 1; //4way right fl
        } 
        if (mazeGeneration.topWall[monsterX][monsterY] == false 
          && mazeGeneration.rightWall[monsterX][monsterY] == false 
          && mazeGeneration.bottomWall[monsterX][monsterY] == false 
          && mazeGeneration.leftWall[monsterX][monsterY] == false 
          && monsterCameFromLeft != false) {
          monsterCurrentCellSituation[28] = 1; //4way down fl
        } 
        if (mazeGeneration.topWall[monsterX][monsterY] == false 
          && mazeGeneration.rightWall[monsterX][monsterY] == false 
          && mazeGeneration.bottomWall[monsterX][monsterY] == false 
          && mazeGeneration.leftWall[monsterX][monsterY] == false 
          && monsterCameFromLeft != false) {
          monsterCurrentCellSituation[29] = 1; //4way up fl
        }
        if (mazeGeneration.topWall[monsterX][monsterY] == false 
          && mazeGeneration.rightWall[monsterX][monsterY] == false 
          && mazeGeneration.bottomWall[monsterX][monsterY] == false 
          && mazeGeneration.leftWall[monsterX][monsterY] == false 
          && monsterCameFromDown != false) {
          monsterCurrentCellSituation[30] = 1; //4way right fd
        } 
        if (mazeGeneration.topWall[monsterX][monsterY] == false 
          && mazeGeneration.rightWall[monsterX][monsterY] == false 
          && mazeGeneration.bottomWall[monsterX][monsterY] == false 
          && mazeGeneration.leftWall[monsterX][monsterY] == false 
          && monsterCameFromDown != false) {
          monsterCurrentCellSituation[31] = 1; //4way left fd
        } 
        if (mazeGeneration.topWall[monsterX][monsterY] == false 
          && mazeGeneration.rightWall[monsterX][monsterY] == false
          && mazeGeneration.bottomWall[monsterX][monsterY] == false 
          && mazeGeneration.leftWall[monsterX][monsterY] == false 
          && monsterCameFromDown != false) {
          monsterCurrentCellSituation[32] = 1; //4way up fd
        }
        if (mazeGeneration.topWall[monsterX][monsterY] == false 
          && mazeGeneration.rightWall[monsterX][monsterY] == false 
          && mazeGeneration.bottomWall[monsterX][monsterY] == false 
          && mazeGeneration.leftWall[monsterX][monsterY] == false 
          && monsterCameFromTop != false) {
          monsterCurrentCellSituation[33] = 1; //4way right fu
        } 
        if (mazeGeneration.topWall[monsterX][monsterY] == false 
          && mazeGeneration.rightWall[monsterX][monsterY] == false 
          && mazeGeneration.bottomWall[monsterX][monsterY] == false 
          && mazeGeneration.leftWall[monsterX][monsterY] == false 
          && monsterCameFromTop != false) {
          monsterCurrentCellSituation[34] = 1; //4way left fu
        } 
        if (mazeGeneration.topWall[monsterX][monsterY] == false 
          && mazeGeneration.rightWall[monsterX][monsterY] == false 
          && mazeGeneration.bottomWall[monsterX][monsterY] == false 
          && mazeGeneration.leftWall[monsterX][monsterY] == false 
          && monsterCameFromTop != false) {
          monsterCurrentCellSituation[35] = 1; //4way down fu
        }     
        if (mazeGeneration.topWall[monsterX][monsterY] == true 
          && mazeGeneration.leftWall[monsterX][monsterY] == false 
          && mazeGeneration.bottomWall[monsterX][monsterY] == false 
          && mazeGeneration.rightWall[monsterX][monsterY] == false 
          && monsterCameFromRight != false) {
          monsterCurrentCellSituation[36] = 1; //left CR wall top from right
        }     
        if (mazeGeneration.topWall[monsterX][monsterY] == true 
          && mazeGeneration.leftWall[monsterX][monsterY] == false 
          && mazeGeneration.bottomWall[monsterX][monsterY] == false 
          && mazeGeneration.rightWall[monsterX][monsterY] == false 
          && monsterCameFromRight != false) {
          monsterCurrentCellSituation[37] = 1; //down CR wall top from right
        }         
        if (mazeGeneration.topWall[monsterX][monsterY] == true 
          && mazeGeneration.bottomWall[monsterX][monsterY] == false 
          && mazeGeneration.rightWall[monsterX][monsterY] == false 
          && mazeGeneration.leftWall[monsterX][monsterY] == false 
          && monsterCameFromLeft != false) {
          monsterCurrentCellSituation[38] = 1; //right CR wall top from left RCRWTFL
        }     
        if (mazeGeneration.topWall[monsterX][monsterY] == true 
          && mazeGeneration.bottomWall[monsterX][monsterY] == false 
          && mazeGeneration.rightWall[monsterX][monsterY] == false 
          && mazeGeneration.leftWall[monsterX][monsterY] == false 
          && monsterCameFromLeft != false) {
          monsterCurrentCellSituation[39] = 1; //down CR wall top from left
        }        
        if (mazeGeneration.rightWall[monsterX][monsterY] == true 
          && mazeGeneration.topWall[monsterX][monsterY] == false
          && mazeGeneration.leftWall[monsterX][monsterY] == false 
          && mazeGeneration.bottomWall[monsterX][monsterY] == false  
          && monsterCameFromDown != false) {
          monsterCurrentCellSituation[40] = 1; //left CR wall right from down LCRWRFD
        } 
        if (mazeGeneration.rightWall[monsterX][monsterY] == true 
          && mazeGeneration.topWall[monsterX][monsterY] == false 
          && mazeGeneration.leftWall[monsterX][monsterY] == false 
          && mazeGeneration.bottomWall[monsterX][monsterY] == false 
          && monsterCameFromDown != false) {
          monsterCurrentCellSituation[41] = 1; //up CR wall right from down UCRWRFD
        }     
        if (mazeGeneration.rightWall[monsterX][monsterY] == true 
          && mazeGeneration.leftWall[monsterX][monsterY] == false 
          && mazeGeneration.bottomWall[monsterX][monsterY] == false
          && mazeGeneration.topWall[monsterX][monsterY] == false  
          && monsterCameFromTop != false) {
          monsterCurrentCellSituation[42] = 1; //go down CR wall right from top DCRWRFT
        } 
        if (mazeGeneration.rightWall[monsterX][monsterY] == true
          && mazeGeneration.leftWall[monsterX][monsterY] == false 
          && mazeGeneration.bottomWall[monsterX][monsterY] == false 
          && mazeGeneration.topWall[monsterX][monsterY] == false  
          && monsterCameFromTop != false) {
          monsterCurrentCellSituation[43] = 1; //left CR wall right from top
        }     
        if (mazeGeneration.bottomWall[monsterX][monsterY] == true
          && mazeGeneration.topWall[monsterX][monsterY] == false
          && mazeGeneration.rightWall[monsterX][monsterY] == false
          && mazeGeneration.leftWall[monsterX][monsterY] == false 
          && monsterCameFromLeft != false) {
          monsterCurrentCellSituation[44] = 1; //right CR wall down from left RCWDFL
        } 
        if (mazeGeneration.bottomWall[monsterX][monsterY] == true 
          && mazeGeneration.topWall[monsterX][monsterY] == false 
          && mazeGeneration.rightWall[monsterX][monsterY] == false
          && mazeGeneration.leftWall[monsterX][monsterY] == false 
          && monsterCameFromLeft != false) {
          monsterCurrentCellSituation[45] = 1; //up CR wall down from left
        }     
        if (mazeGeneration.bottomWall[monsterX][monsterY] == true
          && mazeGeneration.leftWall[monsterX][monsterY] == false 
          && mazeGeneration.topWall[monsterX][monsterY] == false 
          && mazeGeneration.rightWall[monsterX][monsterY] == false  
          && monsterCameFromRight != false) {
          monsterCurrentCellSituation[46] = 1; //up CR wall down from right UCWDFR
        } 
        if (mazeGeneration.bottomWall[monsterX][monsterY] == true 
          && mazeGeneration.leftWall[monsterX][monsterY] == false 
          && mazeGeneration.topWall[monsterX][monsterY] == false 
          && mazeGeneration.rightWall[monsterX][monsterY] == false 
          && monsterCameFromRight != false) {
          monsterCurrentCellSituation[47] = 1; //left CR wall down from right
        }     
        if (mazeGeneration.leftWall[monsterX][monsterY] == true 
          && mazeGeneration.topWall[monsterX][monsterY] == false 
          && mazeGeneration.rightWall[monsterX][monsterY] == false 
          && mazeGeneration.bottomWall[monsterX][monsterY] == false 
          && monsterCameFromDown != false) {
          monsterCurrentCellSituation[48] = 1; //right CR wall left from down RCWLFD
        } 
        if (mazeGeneration.leftWall[monsterX][monsterY] == true 
          && mazeGeneration.topWall[monsterX][monsterY] == false 
          && mazeGeneration.rightWall[monsterX][monsterY] == false 
          && mazeGeneration.bottomWall[monsterX][monsterY] == false 
          && monsterCameFromDown != false) {
          monsterCurrentCellSituation[49] = 1; //up CR wall left from down
        }    
        if (mazeGeneration.leftWall[monsterX][monsterY] == true 
          && mazeGeneration.rightWall[monsterX][monsterY] == false 
          && mazeGeneration.bottomWall[monsterX][monsterY] == false 
          && mazeGeneration.topWall[monsterX][monsterY] == false 
          && monsterCameFromTop != false) {
          monsterCurrentCellSituation[50] = 1; //down CR wall left from top DCWLFT
        } 
        if (mazeGeneration.leftWall[monsterX][monsterY] == true 
          && mazeGeneration.rightWall[monsterX][monsterY] == false 
          && mazeGeneration.bottomWall[monsterX][monsterY] == false 
          && mazeGeneration.topWall[monsterX][monsterY] == false 
          && monsterCameFromTop != false) {
          monsterCurrentCellSituation[51] = 1; //up CR wall left top
        }
        monsterAudioPicker = round(random(3)); //PIECE OF CODE SELECTING A RANDOM OUT OF 4 NUMBERS TO DECIDE WHICH AUDIO IS PLAYED WHEN THE MONSTER TAKES A STEP
        monsterChosenDirection=round(random(51));              /*PIECE OF CODE SELECTING A RANDOM SITUATION FROM THE 52 PICKERS*/
        while (monsterCurrentCellSituation[monsterChosenDirection]!=1) {     /*LOOP THAT SELECTS A NEW PICKER UNTIL ONE HAS BEEN FOUND THAT IS AVAILABLE.*/
          monsterChosenDirection=round(random(51));
        }
        /*CODE FOR RESETTING ALL VISITED CELLS TO FALSE*/

        monsterCameFromTop=false;       /*PURPOSE: THE VISITED CELL VALUE IS RELEVANT WHEN PICKING A DIRECTION AS THE MONSTER IS NOT ALLOWED TO GO TO THOSE CELLS.*/
        monsterCameFromRight=false;       /*TO PREVENT THE MONSTER FROM BEING STUCK WITH THE ONLY OPEN WAY BEING A VISITED CELL, ALL CELLS ARE RESET AFTER A VIABLE PICKER HAS BEEN SELECTED.*/
        monsterCameFromDown=false;
        monsterCameFromLeft=false;

        /*CODE FOR THE MONSTER TO GO CERTAIN DIRECTIONS*/

        /*GOING UP*/
        if (monsterY != 0) {     /*POINTS TO THE OUT OF BOUNDS VALUE FOR UP*/
          if (monsterChosenDirection == 0     /*THE MONSTERP (OR PICKER) POINTS TO THE SPECIFIC SITUATION OF THE MONSTER"S LOCATION, DIRECTION OF ORIGIN AND POSSIBLE WAYS TO GO.*/
            || monsterChosenDirection == 6    /*BECAUSE THE MONSTER CAN ONLY EVER GO 4 WAYS EVERy SITUATION WHICH FORCES THE MONSTER TO GO THE SAME WAY CAN BE PUT TOGETHER IN THE IF STATEMENT*/
            || monsterChosenDirection == 11 
            || monsterChosenDirection == 15 
            || monsterChosenDirection == 19 
            || monsterChosenDirection == 23 
            || monsterChosenDirection == 26 
            || monsterChosenDirection == 29 
            || monsterChosenDirection == 32 
            || monsterChosenDirection == 41 
            || monsterChosenDirection == 45 
            || monsterChosenDirection == 46 
            || monsterChosenDirection == 49) {
            monsterY-=1;         /*THE STATEMENT WHICH MAKES THE MONSTER MOVE ONE TILE BASED ON X OR Y. (y- UP, y+ DOWN, x- LEFT, x+ RIGHT).*/
            monsterSheetDown.draw(monsterX*mazeGeneration.cellSize + mazeGeneration.offsetToCenterX, monsterY*mazeGeneration.cellSize);
            monsterCameFromDown = true;  /*THE CODE DENOTING WHICH DIRECTION THE MONSTER CAME FROM (3 DOWN, 1 UP, 2 RIGHT, 4 LEFT)*/
            if (monsterAudioPicker == 0) { //PLAYS THE SOUND ATTACHED TO THE monsterAudioPicker
              assets.audiomonsterstep1.trigger();
            } else if (monsterAudioPicker == 1) {
              assets.audiomonsterstep2.trigger();
            } else if (monsterAudioPicker == 2) {
              assets.audiomonsterstep3.trigger();
            } else if (monsterAudioPicker == 3) {
              assets.audiomonsterstep4.trigger();
            }
          }                      /*THE FORMULA FOR THE DIRECTIONS COMING FROM WHICH SIDE OF THE CELL WE START CHECKING AT, WHICH IS THE TOP SIDE (1)*/
        }
      }


      /*GOING DOWN*/
      if (monsterY != (mazeGeneration.mazeSizeY-1)) {   //POINTS TO THE OUT OF BOUNDS VALUE FOR DOWN 
        if (monsterChosenDirection == 2 
          || monsterChosenDirection == 4 
          || monsterChosenDirection == 10 
          || monsterChosenDirection == 14 
          || monsterChosenDirection == 18 
          || monsterChosenDirection == 22 
          || monsterChosenDirection == 25 
          || monsterChosenDirection == 28 
          || monsterChosenDirection == 30 
          || monsterChosenDirection == 35 
          || monsterChosenDirection == 37 
          || monsterChosenDirection == 39 
          || monsterChosenDirection == 42 
          || monsterChosenDirection == 50) {
          monsterY+=1;

          monsterCameFromTop=true;
          if (monsterAudioPicker == 0) {
            assets.audiomonsterstep1.trigger();
          } else if (monsterAudioPicker == 1) {
            assets.audiomonsterstep2.trigger();
          } else if (monsterAudioPicker == 2) {
            assets.audiomonsterstep3.trigger();
          } else if (monsterAudioPicker == 3) {
            assets.audiomonsterstep4.trigger();
          }
        }
      }


      /*GOING LEFT*/
      if (monsterX != 0) {  //POINTS TO THE OUT OF BOUNDS VALUE FOR LEFT

        if (monsterChosenDirection == 3 
          || monsterChosenDirection == 5 
          || monsterChosenDirection == 9 
          || monsterChosenDirection == 13 
          || monsterChosenDirection == 17 
          || monsterChosenDirection == 21 
          || monsterChosenDirection == 24 
          || monsterChosenDirection == 31 
          || monsterChosenDirection == 34 
          || monsterChosenDirection == 36 
          || monsterChosenDirection == 40 
          || monsterChosenDirection == 43 
          || monsterChosenDirection == 47 ) {
          monsterX-=1;
          monsterSheetLeft.draw(monsterX*mazeGeneration.cellSize + mazeGeneration.offsetToCenterX, monsterY*mazeGeneration.cellSize);
          monsterCameFromRight=true;
          if (monsterAudioPicker == 0) {
            assets.audiomonsterstep1.trigger();
          } else if (monsterAudioPicker == 1) {
            assets.audiomonsterstep2.trigger();
          } else if (monsterAudioPicker == 2) {
            assets.audiomonsterstep3.trigger();
          } else if (monsterAudioPicker == 3) {
            assets.audiomonsterstep4.trigger();
          }
        }
      }


      /*GOING RIGHT*/
      if (monsterX != (mazeGeneration.mazeSizeX-1)) {     //POINTS TO THE OUT OF BOUNDS VALUE FOR RIGHT

        if (monsterChosenDirection == 1 
          || monsterChosenDirection == 7 
          || monsterChosenDirection == 8 
          || monsterChosenDirection == 12 
          || monsterChosenDirection == 16 
          || monsterChosenDirection == 20 
          || monsterChosenDirection == 27 
          || monsterChosenDirection == 33 
          || monsterChosenDirection == 38 
          || monsterChosenDirection == 44 
          || monsterChosenDirection == 48 
          || monsterChosenDirection == 51) {
          monsterX+=1;
          monsterSheetRight.draw(monsterX*mazeGeneration.cellSize + mazeGeneration.offsetToCenterX, monsterY*mazeGeneration.cellSize);
          monsterCameFromLeft=true;
          if (monsterAudioPicker == 0) {
            assets.audiomonsterstep1.trigger();
          } else if (monsterAudioPicker == 1) {
            assets.audiomonsterstep2.trigger();
          } else if (monsterAudioPicker == 2) {
            assets.audiomonsterstep3.trigger();
          } else if (monsterAudioPicker == 3) {
            assets.audiomonsterstep4.trigger();
          }
        }
      }

      for (int k=0; k<52; k++) { /*MAKES SURE EVERY POSSIBLE SITUATION FOR THE MONSTER IS SET TO 0 (FALSE) BEFORE CHECKING FOR OTHER THE NEXT SITUATION*/
        monsterCurrentCellSituation[k] = 0;
      }
    }
  }
  void drawMonster() { //ATTACHES A SPRITE TO THE COORDINATES OF THE MONSTER BASED ON THE DIRECTION IT CAME FROM/WHICH CELL HAS 'monstercamefrom'
    if (monsterCameFromTop ==false && monsterCameFromLeft == false && monsterCameFromRight == false && monsterCameFromDown==false) {
      monsterSheetDown.draw(monsterX*mazeGeneration.cellSize + mazeGeneration.offsetToCenterX, monsterY*mazeGeneration.cellSize);
    }
    if (monsterCameFromTop == true) {
      monsterSheetDown.draw(monsterX*mazeGeneration.cellSize + mazeGeneration.offsetToCenterX, monsterY*mazeGeneration.cellSize);
    }
    if (monsterCameFromLeft == true) {
      monsterSheetRight.draw(monsterX*mazeGeneration.cellSize + mazeGeneration.offsetToCenterX, monsterY*mazeGeneration.cellSize);
    }
    if (monsterCameFromRight == true) {
      monsterSheetLeft.draw(monsterX*mazeGeneration.cellSize + mazeGeneration.offsetToCenterX, monsterY*mazeGeneration.cellSize);
    }
    if (monsterCameFromDown == true) {
      monsterSheetUp.draw(monsterX*mazeGeneration.cellSize + mazeGeneration.offsetToCenterX, monsterY*mazeGeneration.cellSize);
    }

    //fill(100, 0, 0);
    //ellipse(monsterX*mazeGeneration.cellSize+mazeGeneration.cellSize/2+mazeGeneration.offsetToCenterX, monsterY*mazeGeneration.cellSize+mazeGeneration.cellSize/2, mazeGeneration.cellSize, mazeGeneration.cellSize);
    //image(assets.monsterSprite, monsterX*mazeGeneration.cellSize + mazeGeneration.offsetToCenterX, monsterY*mazeGeneration.cellSize, mazeGeneration.cellSize, mazeGeneration.cellSize);
    //monsterSheetDown.draw(monsterX*mazeGeneration.cellSize + mazeGeneration.offsetToCenterX, monsterY*mazeGeneration.cellSize);
  }
}
