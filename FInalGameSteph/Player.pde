class Player {

  //variables
  int x;
  int y;

  int w;
  int h;

  boolean isMovingLeft;
  boolean isMovingRight;

  int speed;

  int left;
  int right;
  int top;
  int bottom;

  boolean shouldRemove;

PImage playerBike;

  //constructor
  Player(int startingX, int startingY, int startingW, int startingH) {
    x = startingX;
    y = startingY;
    w = startingW;
    h = startingH;

    isMovingLeft = false;
    isMovingRight = false;

    speed = 10;
  }

  //functions
  void render() {
   playerBike = loadImage ("playerRider.jpeg");
    image(playerBike, x, y, w, h);
    left = x - w/2;
    right = x + w/2;
    top = y - h/2;
    bottom = y + h/2;
  }


  void move() {
    if (isMovingLeft == true && x - w/2 > 0) {
      x -= speed; // x = x - speed
    }
    if (isMovingRight == true && x + w/2 < width) {
      x += speed;
    }
  }

  void hitPlayer(Enemy anEnemy) {
    //bullet enemy collision detection
    if (top <= anEnemy.bottom &&
      bottom >= anEnemy.top&&
      left <= anEnemy.right &&
      right >= anEnemy.left) {
      anEnemy.shouldRemove = true;
      shouldRemove = true;
      println("hit");
    }
  }
}
