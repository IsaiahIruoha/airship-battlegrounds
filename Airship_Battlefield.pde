/*
Airship Battlefield:
 
 Time survived Mode, beat certain timed
 Ships Destroyed Mode, unlimited going for records
 */

//int declaration
int screen; //allows the use of the 5 screens
int liveCount; //tracks lives
int score; //tracks score
int laserMultiplier; //multiplier for laser beam speed
int roundTimer; //sets round spawn interval
int round; //sets the current number of planes spawning

//float declaration
float introShipx, introShipy, introShipspeedx, introShipspeedy; //the coordinates and speed for the floating ship image
float startWidth, startHeight; //start button height/width
float startX, startY; //start button x/y
float timeModeWidth, timeModeHeight, timeModeX, timeModeY; //timeMode button coordinates and dimensions
float scoreModeWidth, scoreModeHeight, scoreModeX, scoreModeY; //scoreMode button coordinates and dimensions
float hardWidth, hardHeight, hardX, hardY; //hard button coordinates and dimensions
float menubuttonX, menubuttonY, menubuttonWidth, menubuttonHeight; //menu button coordinates and dimensions
float pauseX, pauseY, pauseWidth, pauseHeight; //pause button coordinates and dimensions
float retryX, retryY; //retry button coordinates
float textCountDown; //countdown for effect
float gameSpeed; //changes the difficulty
float ShipX, ShipY, ShipW, ShipH, ShipSX, ShipSY; //main ship specifications
float enemyShipH, enemyShipW; //enemy ship specifications
float randomx, nonRandomy; //used to make sure that a random x value is found and a non random y is found for perfect spawning
float timer; //timer to allow 10 second intervals
float gameCountDown; //countdown function #1
float gameCountDown2; //countdown function #2
float nukeX, nukeY, nukeSX, nukeSY; //specifications for nuke image
float gameCountDown3; //countdown function #3
float gameCountDown4; //countdown function #4
float nukeTimer; //randomized time when the nuker spawns

//PImage declaration (images)
PImage airship;
PImage retry;
PImage pause;
PImage over;
PImage losebackground;
PImage backgroundmenu;
PImage difficultybackground;
PImage gameShip;
PImage lives;
PImage laserHits;
PImage enemyShip;
PImage nuke;

//String declaration
String start; //start button text
String timeMode; //timeMode button text
String welcome; //welcome text
String name; //games name text
String scoreMode; //scoreMode mode text
String choose; //choose difficulty text
String losetext; //lose game text
String menuText; //back to menu button text
String gameover; //win menu text

//declaring and defining arrays for the galaxy stars background
int arraySize = 100; //size of the background array
int [] galaxyX = new int[arraySize]; //cordinates and specifications of background array
int [] galaxyY = new int[arraySize];
int [] galaxyS = new int[arraySize];
float [] galaxySize = new float[arraySize];

ArrayList<Float> laserX = new ArrayList<Float>(); //laser array X coordinate
ArrayList<Float> laserY = new ArrayList<Float>(); //laser array Y coordinate
ArrayList<Float> laserSX = new ArrayList<Float>(); //laser array speed X coordinate
ArrayList<Float> laserSY = new ArrayList<Float>(); //laser array speed Y coordinate

ArrayList<Float> enemyShipX = new ArrayList<Float>(); //specifications for enemyShip arraylist
ArrayList<Float> enemyShipY= new ArrayList<Float>();
ArrayList<Float> enemyShipSY = new ArrayList<Float>();

boolean pausing; //true or false for pausing the game with single button
boolean outOfbounds; //determines if lasers are out of bounds
boolean spawning; //allows spawning to function correctly
boolean roundChange; //determines if a round change is necessaery
boolean nukeSpawn; //determines when a nuke powerup can spawn

void setup () { //run once

  size (640, 480); //scren dimensions

  frameRate (30); //framerate

  //declares what each individual array does, the loop makes it all happen in one linerounds ();
  for (int i = 0; i < arraySize; i++) {
    galaxyX[i] = floor(random(width));
    galaxyY[i] = floor(random(height));
    galaxyS[i] = 1 + floor(random(9));
  }

  //images being brought from sketch folder
  airship = loadImage("airship.png");
  backgroundmenu = loadImage("openbackground.png");
  difficultybackground = loadImage("difficultybackground.jpg");
  losebackground = loadImage("lose.jpg");
  retry = loadImage("retry.png");
  over = loadImage("over.jpg");
  pause = loadImage("pause.png");
  gameShip = loadImage("ship.png");
  lives = loadImage("heart.png");
  laserHits = loadImage("pews.png");
  enemyShip = loadImage("enemy.png");
  nuke = loadImage("nuke.png");

  //previously declared variables are matched with values
  screen = 0; //sets base screen to start screen
  welcome = "Welcome to";
  name = "Airship Battlefield";
  introShipspeedx = 3 + floor(random(6));
  introShipspeedy = 3 + floor(random(6));
  introShipx = floor(random(640));
  introShipy = floor(random(480));
  nukeSY = 1 + floor(random(2));
  nukeSX = 1 + floor(random(2));
  nukeX = floor(random(640 - 30));
  nukeY = floor(random(480 - 30));
  startWidth = 300;
  startHeight = 100;
  startX = 170;
  startY = 220;
  start = "START";
  timeModeWidth = 300;
  timeModeHeight = 90;
  timeModeX = 170;
  timeModeY = 130;
  timeMode = "Time";
  scoreModeWidth = 300;
  scoreModeHeight = 90;
  scoreModeX = 170;
  scoreModeY = 235;
  scoreMode = "Score";
  choose = "Choose Your Mode!";
  losetext = "You Lost!";
  retryX = 270;
  retryY = 270;
  gameover = "Game Over";
  menubuttonX = 12;
  menubuttonY = 420;
  menubuttonWidth = 90;
  menubuttonHeight = 50;
  menuText = "Menu";
  pauseX = 580;
  pauseY = 15;
  pauseWidth = 50;
  pauseHeight = 50;
  pausing = false;
  textCountDown = 40;
  ShipX = 288;
  ShipY= 360;
  ShipW = 64;
  ShipH = 80;
  ShipSX = 0;
  ShipSY = 0;
  liveCount = 3;
  score = 0;
  laserMultiplier = 10;
  enemyShipH = 60;
  enemyShipW = 60;
  timer = 100;
  gameCountDown = 30;
  roundTimer = 8;
  round = 3;
  roundChange = false;
  gameCountDown2 = 30;
  gameCountDown3 = 30;
  nukeSpawn = false;
  nukeTimer = 5 + floor(random(90)); //randomizes the time the nuke will spawn
  gameCountDown4 = 30;

  for (int i=0; i < arraySize; i++) galaxySize[i] = (1 + random(3)); //determines the size of each background star
  perfectSpawn(round); //function for perfect spawning and changes the amount of ships depending on the round
}

void draw () { //run continously in a loop

  if (screen == 0) { //starting menu screen

    background(backgroundmenu); //background image

    //welcome text with game name
    fill(#07e5f9);
    textSize(30);
    text(welcome, 80, 100);
    textSize(55);
    text(name, 130, 160);

    if (mouseX > startX && mouseX < startX + startWidth && mouseY > startY && mouseY < startY + startHeight) { //start button click registration
      fill(0, 260);
      rect(startX, startY, startWidth, startHeight, 8);
    }

    //start button
    fill(0, 120);
    rect(startX, startY, startWidth, startHeight, 8);
    fill(#18D7EA);
    text(start, startX + 72, startY + 70);

    //floating images given speeds
    image(airship, introShipx, introShipy, 150, 100);
    introShipx = introShipx + introShipspeedx;
    introShipy = introShipy + introShipspeedy;

    //floating images if statements to stay within width and height
    if (introShipx > 500) introShipspeedx = -5;
    if (introShipx < -20) introShipspeedx = 5;
    if (introShipy > 380) introShipspeedy = -5;
    if (introShipy < 0) introShipspeedy = 5;

    drawButton(menubuttonX, menubuttonY, menubuttonWidth, menubuttonHeight, 25, 0, "Exit"); //button draw function, drawing exit button
  }

  if (screen == 1) { //difficulty selector screen

    background(difficultybackground);

    if (mouseX > timeModeX && mouseX < timeModeX + timeModeWidth && mouseY > timeModeY && mouseY < timeModeY + timeModeHeight) { //start button colour dimmer
      fill(0, 260);
      rect(timeModeX, timeModeY, timeModeWidth, timeModeHeight, 8);
    }

    //timeMode button created
    fill(0, 120);
    drawButton(timeModeX, timeModeY, timeModeWidth, timeModeHeight, 50, 255, "Timed");

    if (mouseX > scoreModeX && mouseX < scoreModeX + scoreModeWidth && mouseY > scoreModeY && mouseY < scoreModeY + scoreModeHeight) { //scoreMode button dimmer
      fill(0, 260);
      rect(scoreModeX, scoreModeY, scoreModeWidth, scoreModeHeight, 8);
    }

    //scoreMode button created
    fill(0, 120);
    drawButton(scoreModeX, scoreModeY, scoreModeWidth, scoreModeHeight, 50, 255, "Scored");

    //text "choose difficulty"
    textSize(35);
    fill(255);
    text(choose, 175, 82);

    drawButton(menubuttonX, menubuttonY, menubuttonWidth, menubuttonHeight, 25, 0, "Menu"); //menu button created
  }




  if (screen == 2) { //main game screen

    if (!pausing) { //if game paused is false
      background(0);

      //loops the command to happen as long as there are more slots in the arragalaxyY,  fills, react create, speed applied
      for (int i=0; i < arraySize; i++) {
        fill(255);
        rect(galaxyX[i], galaxyY[i], galaxySize[i], galaxySize[i], 8);
        galaxyX[i] = galaxyX[i] - galaxyS[i];
        //if galaxyY galaxyX slot going out of bounds it teleports back and resets galaxyX galaxyY and galaxyS
        if (galaxyX[i] < 0) {
          galaxySize[i] = (1 + random(3));
          galaxyX[i] = 640 + floor(random(width));
          galaxyY[i] = floor(random(height));
          galaxyS[i] = 5 + floor(random(10));
        }
      }

      //creates enemy ship
      for (int i=0; i < enemyShipY.size(); i++) {
        enemyShipY.set(i, enemyShipY.get(i) + enemyShipSY.get(i));
        image(enemyShip, enemyShipX.get(i), enemyShipY.get(i), enemyShipW, enemyShipH);
      }

      //hit registration for enemy ship and laser contact
      for (int i=0; i < enemyShipX.size(); i++) {
        for (int j=0; j < laserX.size(); j++) {

          if (dist(laserX.get(j), laserY.get(j), enemyShipX.get(i) + enemyShipW/2, enemyShipY.get(i) + enemyShipH/2) < enemyShipW/5 + 20 ) {
            score = score + 1;
            laserX.set(j, -500.0);
            laserY.set(j, -500.0);
            laserSX.set(j, 0.0);
            laserSY.set(j, 0.0);
            enemyShipX.set(i, -500.0);
            enemyShipY.set(i, -500.0);
            enemyShipSY.set(i, 0.0);
          }
        }
      }

      //hit registration for enemyship and ship contact
      for (int i=0; i < enemyShipX.size(); i++) {
        if (dist(ShipX + ShipW/2, ShipY + ShipH/2, enemyShipX.get(i) + enemyShipW/2, enemyShipY.get(i) + enemyShipH/2) < enemyShipW/5 + 50 ) {
          liveCount = liveCount -1;
          enemyShipX.remove(i);
          enemyShipY.remove(i);
          enemyShipSY.remove(i);
        }
      }

      //allows removal of enemy ship
      for (int i=0; i < enemyShipX.size(); i++) {
        if (enemyShipX.get(i) == -500) {
          enemyShipX.remove(i);
          enemyShipY.remove(i);
          enemyShipSY.remove(i);
        }
      }

      //allows removal of ship
      for (int j=0; j < laserX.size(); j++) {
        if (laserX.get(j) == -500) {
          laserX.remove(j);
          laserY.remove(j);
          laserSY.remove(j);
          laserSX.remove(j);
        }
      }

      //sets the ship speed and allows it to have an ice acclerating and decelerating affect
      ShipX = ShipX + ShipSX;
      ShipY = ShipY + ShipSY;
      ShipSX = ShipSX * 0.98;
      ShipSY = ShipSY * 0.98;

      //sets ship boundaries
      if (ShipX > width) ShipX = 0 - ShipW;
      if (ShipX < 0 - ShipW) ShipX = width;
      if (ShipY + ShipH + 20> height) ShipSY = ShipSY * -1;
      if (ShipY - ShipH < 0 - ShipH) ShipSY = ShipSY * -1;

      //draws the lasers and sets their speeds
      for (int i=0; i < laserX.size(); i++) {
        fill(125 + random(130), 0, 0);
        ellipse(laserX.get(i), laserY.get(i), 6, 6);

        laserX.set(i, laserX.get(i) + laserSX.get(i));
        laserY.set(i, laserY.get(i) + laserSY.get(i));
      }

      //created to make the ship point in the direction of the mouse
      pushMatrix(); //saves previous values
      translate(ShipX + ShipW/2, ShipY + ShipH/2); //sets a new 0,0 position
      float ang; //declaring variable used to store angle
      ang = atan2(mouseY-(ShipY + ShipH/2), mouseX-(ShipX + ShipW/2)); //math used to determine angle needed to rotate
      rotate(ang + PI/2); //rotate ship based on the mouse coord variable
      image(gameShip, -32, -40, ShipW, ShipH); //draws shiop
      popMatrix(); //enables previous values

      //endzone text and block location
      fill(255, 0, 0);
      rect(-1, 464, 654, 30);
      fill(11);
      textSize(16);
      text("E     n      d     z     o     n     e", 230, 478);

      //determiens what will happen based on lives remaining
      if (liveCount == 3) {
        image(lives, 530, 20, 40, 40);
        image(lives, 490, 20, 40, 40);
        image(lives, 450, 20, 40, 40);
      }
      if (liveCount == 2) {
        image(lives, 530, 20, 40, 40);
        image(lives, 490, 20, 40, 40);
      }
      if (liveCount == 1) {
        image(lives, 530, 20, 40, 40);
      }
      if (liveCount == 0) {
        screen = 4;
      }

      //pause image
      image(pause, pauseX, pauseY, pauseWidth, pauseHeight);

      if (gameSpeed == 1) { //timeMode mode
        gameCountDown2--;
        if (gameCountDown2 == 1)timer--;
        if (gameCountDown2 ==0) gameCountDown2 = 30;
        if (timer == 0) screen = 4;
        rounds();
        fill(255);
        textSize(40);
        text(floor(timer) + "s", 23, 42);
      }

      if (gameSpeed == 2) { //scoreMode mode

        fill(255);
        textSize(30);
        text(score, 44, 35); //ship eliminations counter
        image(laserHits, 5, 8, 35, 35);
        rounds ();
        if (score >= 150) { //win condition for scoreMode
          screen = 4;
        }
      }

      for (int i=0; i < laserX.size(); i++) { //used to remove laser when out of bounds
        if (laserX.get(i) > width || laserX.get(i) < 0 || laserY.get(i) > height - 16 || laserY.get(i) < 0) {
          outOfbounds = true;
        } else {
          outOfbounds = false;
        }
        while (outOfbounds == true) {
          laserX.remove(i);
          laserY.remove(i);
          laserSX.remove(i);
          laserSY.remove(i);
          outOfbounds = false;
        }
      }
      for (int i=0; i < enemyShipY.size(); i++) { //if enemy ship goes into endzone
        if (enemyShipY.get(i) > 480 - enemyShipH - 8) {
          liveCount = liveCount -1;
          enemyShipX.remove(i);
          enemyShipY.remove(i);
          enemyShipSY.remove(i);
        }
      }

      //countdown for nuke spawning
      gameCountDown4--;
      if (gameCountDown4 == 1) nukeTimer--;
      if (gameCountDown4 == 0) gameCountDown4 = 30;
      if (nukeTimer == 0) nukeTimer = 5 + floor(random(90));
      if (nukeTimer == 1) {
        nukeSpawn = true;
      }
      if (nukeSpawn == true) {
        image(nuke, nukeX, nukeY, 60, 30); //nuke image creation and speed assignments

        nukeX = nukeX + nukeSX;
        nukeY = nukeY + nukeSY;

        //floating images if statements to stay within width and height
        if (nukeX > 580) nukeSX = -1 + floor(random(-2));
        if (nukeX < 0) nukeSX = 1 + floor(random(2));
        if (nukeY > 430) nukeSY = -1 + floor(random(-2));
        if (nukeY < 0) nukeSY = 1 + floor(random(2));

        //contact registration between laser and nuke
        for (int i=0; i < laserX.size(); i++) {
          if (dist(nukeX + 30, nukeY + 15, laserX.get(i) + 2, laserY.get(i) + 2) < 50 ) {
            nukeSX = 0;
            nukeSY = 0;
            laserSX.set(i, 0.0);
            laserSY.set(i, 0.0);
            if (nukeSY == 0 || nukeSX == 0) {
              gameCountDown3 = gameCountDown3 - 1;
              if (gameCountDown3 < 30) background(255);
              if (gameCountDown3 == 1) screen = 3;
              if (gameCountDown3 == 0) gameCountDown3 = 30;
            }
          }
        }
      }

      //contact registration between ship and nuke
      if (dist(ShipX + ShipW/2, ShipY + ShipH/2, nukeX + 30, nukeY + 15) < 50 ) {
        for (int i = 0; i < enemyShipX.size(); i++) {
          enemyShipX.remove(i);
          enemyShipY.remove(i);
          enemyShipSY.remove(i);
          nukeX = 700;
          nukeY = 700;
          nukeSX = 0;
          nukeSY = 0;
        }
      }
    }
  }

  if (screen == 3) { //gameover screen  (lose)

    background(losebackground); //background image

    textCountDown = textCountDown - 1; //countdown for flashing sentence feature

    //text setup for losing + transparent background
    fill(0, 160);
    rect(100, 100, 440, 280, 8);
    fill(#F00A0A);
    textSize(60);
    text(losetext, 209, 173);


    //flashing feature added
    if (textCountDown < 20) { //countdown less then 20 do
      textSize(30);
      fill(255);
      if (gameSpeed == 1) {
        text("Your Time Left Was " + floor(timer) + "s", 177, 237);
      }
      if (gameSpeed == 2) {
        text("Your Score Was " + score, 205, 237);
      }
    }
    if (textCountDown < 0) textCountDown = 40; //reset countdown if finished

    //retry button created
    image(retry, retryX, retryY, 100, 100);
  }

  if (screen == 4) { //game over (win)

    background(over); //background image

    //gameover text and transparent background
    fill(0, 160);
    rect(100, 100, 440, 280, 8);
    fill(#15cbdb);
    textSize(60);
    text(gameover, 178, 173);

    textCountDown = textCountDown - 1; //flashing sentence feature

    //flashing sentence feature setup
    if (textCountDown < 20) { //countdown less then 20 do
      textSize(30);
      fill(255);
      if (gameSpeed == 1) {
        text("You Lasted " + floor(timer) +  " Seconds", 177, 237);
      }
      if (gameSpeed == 2) {
        text("Your Score Was " + score, 205, 237);
      }
    }
    if (textCountDown < 0) textCountDown = 40; //reset countdown if finished

    image(retry, retryX, retryY, 100, 100); //retry button
  }
}

//if mouse is pressed the following will happen
void mousePressed() {

  if (screen == 2) {

    if (mouseX > pauseX && mouseX < pauseX + pauseWidth && mouseY > pauseY && mouseY < pauseY + pauseHeight) { //if pause button clicked, checks if pause it already in place
      if (pausing == false) {
        pausing = true;
      } else {
        pausing = false;
      }
    }
  } else if (screen == 1) {
    if (mouseX > timeModeX && mouseX < timeModeX + timeModeWidth && mouseY > timeModeY && mouseY < timeModeY + timeModeHeight) { //timeMode button click registration, customizes variables
      screen = 2;
      gameSpeed = 1;
    }

    if (mouseX > scoreModeX && mouseX < scoreModeX + scoreModeWidth && mouseY > scoreModeY && mouseY < scoreModeY + scoreModeHeight) { //scoreMode  button click registration, customizes variables
      screen = 2;
      gameSpeed = 2;
    }

    if (mouseX > menubuttonX && mouseX < menubuttonX + menubuttonWidth && mouseY > menubuttonY && mouseY < menubuttonY + menubuttonHeight) { //menu button, takes user back to starting screen
      screen = 0;
    }
  } else if (screen == 3 || screen == 4) {
    if (mouseX > retryX && mouseX < retryX + 100 && mouseY > retryY && mouseY < retryY + 100) { //retry button on screen 3 and 4, (lose and takeprofits screens) resets all necessary variables
      reset();
    }
  } else if (screen == 0) {
    if (mouseX > startX && mouseX < startX + startWidth && mouseY > startY && mouseY < startY + startHeight) { //start button click registration
      screen = 1;
    }

    if (mouseX > menubuttonX && mouseX < menubuttonX + menubuttonWidth && mouseY > menubuttonY && mouseY < menubuttonY + menubuttonHeight) { //exit button, out of the game
      exit();
    }
  }
}

//function used to create buttons
void drawButton (float x, float y, float w, float h, int size, int textColour, String s) {
  rect(x, y, w, h, 8);
  textSize(size);
  fill(textColour);
  text(s, x + w/2 - textWidth(s)/2, y + h/2 + size/3);
}

//if specific key is pressed the following will happen
void keyPressed () {

  if (ShipSX < 7.5 && ShipSX > -7.5) { //used to control the ships movements
    if (keyCode == RIGHT || keyCode == 'D') {
      ShipSX = ShipSX + 0.5;
    }
    if (keyCode == LEFT || keyCode == 'A') {
      ShipSX = ShipSX - 0.5;
    }
  } else if (ShipSX == 7.5) {
    ShipSX = 7;
  } else if (ShipSX == -7.5) {
    ShipSX = -7;
  }
  if (ShipSY < 7.5 && ShipSY > -7.5) {
    if (keyCode == DOWN || keyCode == 'S') {
      ShipSY = ShipSY + 0.5;
    }
    if (keyCode == UP || keyCode == 'W') {
      ShipSY = ShipSY - 0.5;
    }
  } else if (ShipSY == 7.5) {
    ShipSY = 7;
  } else if (ShipSY == -7.5) {
    ShipSY = -7;
  }

  //used to shoot lasers from the ship
  if (screen == 2) {
    if (keyCode == ' ') {
      if (laserX.size() < 5) {

        laserX.add(ShipX + ShipW/2); //laser is created on the player
        laserY.add(ShipY + ShipH/2);
        laserSX.add(laserMultiplier * (mouseX - (ShipX + ShipW/2)) / dist(ShipX + ShipW/2, ShipY + ShipH/2, mouseX, mouseY));
        laserSY.add(laserMultiplier * (mouseY - (ShipY + ShipH/2)) / dist(ShipX + ShipW/2, ShipY + ShipH/2, mouseX, mouseY));
      }
    }
  }
}

//function is used to reset the program with a button or whenever necessary
void reset () {
  screen = 1;
  ShipX = 288;
  ShipY= 360;
  ShipW = 64;
  ShipH = 80;
  ShipSX = 0;
  ShipSY = 0;
  liveCount = 3;
  score = 0;
  dispose();
  perfectSpawn(5);
  timer = 100;
  gameCountDown3 = 30;
  gameCountDown2 = 30;
  gameCountDown3 = 30;
  nukeSY = 1 + floor(random(2));
  nukeSX = 1 + floor(random(2));
  nukeX = floor(random(640 - 30));
  nukeY = floor(random(480 - 30));
  nukeTimer = 5 + random(90);
  nukeSpawn = false;
}

//function allowing the spawn of the ships to work flawlessly and save space
void perfectSpawn(int x) {
  for (int i=0; i < x; i++) { //perfect spawning system in place for after reset occurs
    spawning = false;
    while (spawning == false) { //game cannot continue until all spawned in and the conditions have been met
      randomx = 10 + random(630-enemyShipW);
      nonRandomy = 0.0 - enemyShipH;
      spawning = true;

      for (int j=0; j < i; j++) {
      }
    }
    enemyShipX.add(i, randomx); //assigns the found coordinates to the asteroid
    enemyShipY.add(i, nonRandomy);
    enemyShipSY.add(i, 1 + random(2));
  }
}

//smaller reset function used to specifically clear all enemy ships and lasers present
void dispose () {
  enemyShipX.clear();
  enemyShipY.clear();
  enemyShipSY.clear();
  laserX.clear();
  laserY.clear();
  laserSY.clear();
  laserSX.clear();
}

//function used to determine the amount of ships spawning every specific interval of seconds.
void rounds () {
  gameCountDown--;
  if (gameCountDown == 1) roundTimer--;
  if (gameCountDown == 0) gameCountDown = 30;
  if (roundTimer == 0) roundTimer = 8;
  if (roundTimer == 1) {
    round++;
    roundTimer = 8;
    roundChange = true;
    if (roundChange == true) {
      perfectSpawn(round);
      roundChange = false;
    }
  }
}
