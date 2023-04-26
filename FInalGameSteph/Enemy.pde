class Enemy {
  //variables
  int x;
  int y;
  int w;
  int h;
    
  int ySpeed;
  //int xSpeed;
  
  int left;
  int right;
  int top;
  int bottom;
  
 boolean shouldRemove;
  
  PImage enemyBike;
  
  
  Enemy(int startingX, int startingY, int startingW, int startingH){
    x = startingX;
    y = startingY;
    w = startingW;
    h = startingH;
    
    left = x - w/2;
    right = x + w/2;
    top = y - h/2;
    bottom = y + h/2;
 
 
  //xSpeed = int(random(5,10));
  ySpeed = int(random(8,15));
  
  shouldRemove = false;
 
   
  }
  void render(){
    rectMode(CENTER);
    enemyBike = loadImage("riderEnemy.jpeg");
    image(enemyBike, x, y, w, h);
  }
  
  void move() {
   // x += xSpeed;
    y += ySpeed;
    
    //updates hitbox
    left = x - w/2;
    right = x + w/2;
    top = y - h/2;
    bottom = y + h/2;
  }
  
  
  //player enemy collision detection--player dies
  void enemyHit(Player aPlayer){
    if (top <= aPlayer.bottom &&
   bottom >= aPlayer.top &&
   left <= aPlayer.right &&
   right >= aPlayer.left){
     aPlayer.shouldRemove = true;
     shouldRemove = true;
     println("hit Player");   
     }
  }
  
   void reset() {
    
    //wall detection for left wall
    if (y+h/2 >= height+h) {
      y=0;
    }
 
   } 
}

  
