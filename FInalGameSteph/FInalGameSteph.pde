/// This is a racing and shooting game where player has to race and shoot all enemies.
/// The "villains" are villain anime characters and are trying to capter Chris,
/// my professor, and capture him into the AI world in order to take over the world.
/// Inspiration comes from the movie TRON, anime, and of course Hackberry lab 
/// featuring my professor Chris Whitmire. 




///////DECLARATION OF ALL VARS
//sound file for fun, not my final sound
import processing.sound.*;
SoundFile pewSound;
SoundFile raceCarSound;
SoundFile saveChrisSound;
SoundFile gameOver;
SoundFile tronSoundTrack;


PImage introBackground;
PImage trackBackground;
PImage gameOverBackground;
PImage saveChrisBackground;
PImage playerBike;
PImage enemyBike;
PImage chrisIsSaved;

 

// declaring class vars
Player p1;

int enemyCount = 6;

//////////////////////////////
//array lists
/////////////////////////////
ArrayList<Bullet> bulletList;
//ArrayList<Enemy> enemyList;
ArrayList<Enemy> enemyList;


//vars representing states
int state = 0;


void setup () {
  size(900, 700);
  textAlign(CENTER);
  textSize(30);

  //bullet arrayList
  bulletList = new ArrayList<Bullet>();
  enemyList = new ArrayList<Enemy>();

  //initialize vars
  p1 = new Player(width/2, height-100, 50, 50);
  
  //animation setup blue player
  
  
  //for loop for spawning enemies
  for (int i = 0; i < enemyCount; i++) {
    enemyList.add(new Enemy(int(random(20, 700)), 0, 50, 50));
  }


  //sound stuff:)
  pewSound = new SoundFile(this, "pew.wav");
  pewSound.rate(3);
  
  
  raceCarSound = new SoundFile(this, "raceCarSound.mp3");
  
  saveChrisSound = new SoundFile(this, "saveChrisSound.mp3");
  
  gameOver = new SoundFile(this, "gameOver.mp3");
  
  tronSoundTrack = new SoundFile(this, "tronSoundTrack.wav");
  
  ///image vars declaration
  introBackground = loadImage("tronBackground1.jpg");
  imageMode(CENTER);

  introBackground.resize(900, 700);

  trackBackground = loadImage("raceTrackTron.jpeg");
  trackBackground.resize(900, 700);
  
  gameOverBackground = loadImage("gameOver.jpg");
  gameOverBackground.resize(900,700);
  
  //saveChrisBackground = loadImage("cwhitmire.jpg");
  //saveChrisBackground.resize(900,700);
  
  chrisIsSaved = loadImage("chrisIsSaved.jpeg");
  chrisIsSaved.resize(900,700);
}




void draw() {
  switch(state) {
  case 0:
    background (introBackground);
    fill(255);
    textSize(30);
    text("Oh no! Chris is being captured into AI world!", width/2, 100);
    text("Shoot enemies to win the race, and save Chris!", width/2, 150);
    text("Good luck racer, and whatever you do... DON'T DIE", width/2, 250);
    fill(0);
    text("Press SPACEBAR to begin", 200, 550);
    
    if(tronSoundTrack.isPlaying() == false){
      tronSoundTrack.play();
    }

    p1.shouldRemove = false;
    
    //do not play game sound files in intro screen
    saveChrisSound.stop();
    gameOver.stop();
    pewSound.stop();
    raceCarSound.stop();

    break;

  case 1:
    background (trackBackground);
    fill(0, 255, 255);
    p1.render();
    p1.move();

    ////for loop for enemies
    fill(255, 255, 0);
    for (Enemy anEnemy : enemyList) {
      anEnemy.render();
      anEnemy.move();
      anEnemy.enemyHit(p1);
      anEnemy.reset();
      
      //anEnemy.wallDetect();

      ////////for loop that goes through all bullets
      for (Bullet aBullet : bulletList) {
        aBullet.render();
        aBullet.move();
        aBullet.checkRemove();
        aBullet.shootEnemy(anEnemy);
        
      }
    }

    /////for loop that removes unwanted bullets
    for (int i = bulletList.size()-1; i >= 0; i = i-1) {
      Bullet aBullet = bulletList.get(i);
      
      if (aBullet.shouldRemove == true) {
        bulletList.remove(aBullet);
      }
    }

    /////////// for loop that removes enemies after collision
    for (int i = enemyList.size()-1; i >= 0; i = i-1) {
      Enemy anEnemy = enemyList.get(i);

      if (anEnemy.shouldRemove == true) {
        enemyList.remove(anEnemy);
        enemyCount --;
      }
    }
    //switch to win screen when all enemies are removed
    if (enemyCount == 0) {
      state = 2;
    }
    if(p1.shouldRemove == true){
    state = 3;
    }
    break;

  case 2:
    background(chrisIsSaved);
    fill(255);
    textSize(70);
    text("You saved Chris!!", width/2, height/2);
    text("Press S to continue", width/2, 500);
    raceCarSound.stop();
    if(saveChrisSound.isPlaying() == false){
      saveChrisSound.play();
    }
    raceCarSound.stop();
    pewSound.stop();
    tronSoundTrack.stop();
    break;

  case 3:
    background(gameOverBackground);
    textSize(70);
    fill(255);
    text("GAME OVER", width/2, height/2);
    textSize(30);
    text("The villain has captured Chris", width/2, 400);
    text("Press S to try again", width/2, 450);
    enemyList.clear();
    raceCarSound.stop();
    if(gameOver.isPlaying() == false){
      gameOver.play();      
    }
    raceCarSound.stop();
    pewSound.stop();
    tronSoundTrack.stop();
    break;
    
    
  }

}



////////////////////////////////////////////////////////////////////////////
//// PLAYER MOVEMENT
///////////////////////////////////////////////////////////////////////////

void keyPressed() {
  if (key == ' ' && state == 0) {
    state += 1;
    //delay(2000);
  }
  if (key == ' ' ) {
    bulletList.add(new Bullet(p1.x, p1.y) );
   
  }
  
  if (key == ' ') {
    if (pewSound.isPlaying() == false) {
      pewSound.play();
       
    }
  }

  if (key == 's' && state >=2) {
    state = 0;
    enemyCount = 8;
    println("add enemies" + enemyCount);
    for (int i = 0; i < enemyCount; i++) {
      enemyList.add(new Enemy(int(random(20, 700)), 0, 50, 50));
    }
  }

  if (key == 'a') {
    p1.isMovingLeft = true;
  }
  
  if(key == 'a'){
    if(raceCarSound.isPlaying() == false){
      raceCarSound.play();
    }
  }
  
  if (key == 'd') {
    p1.isMovingRight = true;
  }
  
  if(key == 'd'){
    if(raceCarSound.isPlaying() == false){
      raceCarSound.play();
    }  
  } 
}

void keyReleased() {
  if (key == 'a') {
    p1.isMovingLeft = false; 
  }
   
  if (key == 'd') {
    p1.isMovingRight = false; 
  }
}
