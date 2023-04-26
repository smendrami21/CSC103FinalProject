class Bullet {

  //variables
  int x;
  int y;
  int d;
  int speed;
  
  boolean shouldRemove;
  
  //collision detection vars
  int left;
  int right;
  int top;
  int bottom;
  
    
    
    
  //constructor
  Bullet(int startingX, int startingY) {
    x = startingX;
    y = startingY;

    d = 10;

    speed = 5;
    
    shouldRemove = false;
    
    
    left = x - d/2;
    right = x + d/2;
    top = y - d/2;
    bottom = y + d/2;
    
  }


  void render() {
    circle(x, y, d);
  }

  void move() {
    y -= speed;
    
    //updates hitbox
    left = x - d/2;
    right = x + d/2;
    top = y - d/2;
    bottom = y + d/2;
  }
  
 void checkRemove(){
   if(y < 0){
     shouldRemove = true;
   }
 }
 
 void shootEnemy(Enemy anEnemy){
   //bullet enemy collision detection
   if (top <= anEnemy.bottom &&
   left >= anEnemy.left &&
   right <= anEnemy.right){
     anEnemy.shouldRemove = true;
     shouldRemove = true;
     println("hit");
     
  }  
 }  
}
