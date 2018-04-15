class Ninja {
  float x;
  float y;
  float r;
  float leftBorder;
  float rightBorder;
  float bottomBorder;
  float topBorder;
  int moveSpeed;
  
 Ninja(float x, float y, float r) {
   this.x = x;
   this.y = y;
   this.r = r;
   this.leftBorder = this.r / 2;
   this.rightBorder = width - this.r / 2;
   this.bottomBorder = height - this.r / 2;
   this.topBorder = this.r / 2;
   this.moveSpeed = (width + height) / 250;
 }
 
 void show() {
   fill(255, 200, 0, 255);
   noStroke();
   rectMode(CENTER);
//   rect(x, y, r, r);
  pushMatrix();
  translate(this.x, this.y);
  switch (this.dir()){
    case "DOWN":
      scale (1, -1);
      break;
    case "RIGHT":
      rotate (1.5 * PI);
      break;
    case "LEFT":
      rotate (0.5 * PI);
      break;
  }
  image(ninjaImage, 0 - ninja.r / 2, 0 - ninja.r / 2);
  popMatrix();

 }
 
 void update(int move) {

   if (move == -1 && this.x >= leftBorder && this.y >= bottomBorder) {
    ninja.x -= moveSpeed;
  } else if (move == -1 && this.x <= width / 2 && this.y > topBorder) {
    ninja.y -= moveSpeed;
  } else if (move == -1 && this.y <= bottomBorder && this.x >= rightBorder) {
    ninja.y += moveSpeed;
  } else if (move == 1 && this.x <= rightBorder && this.y >= bottomBorder && this.y > topBorder) {
    ninja.x += moveSpeed;
  } else if (move == 1 && this.x >= rightBorder && this.y > topBorder) {
    ninja.y -= moveSpeed;
  } else if (move == 1 && this.x <= leftBorder) {
    ninja.y += moveSpeed;
  } else if (move == -1 && this.y <= topBorder && this.x < rightBorder) {
    ninja.x += moveSpeed;
  } else if (move == 1 && this.y <= topBorder ) {
    ninja.x -= moveSpeed;
  }
 }
 
 String dir(){
   if (this.x >= leftBorder && this.y >= bottomBorder && this.y > topBorder) {
  return "UP";
   } else if (this.y <= topBorder){
   return "DOWN";
   } else if (this.x <= leftBorder){
   return "LEFT";
   } else {
   return "RIGHT";
 }
 }
 
 
 
  boolean collision(Target that){
    if (that == null){  //This was bugfixing, but probably un-needed
      return false;
    }
    if (dist(this.x, this.y, that.x, that.y) * 2 < (this.r + that.r)) {
      return true;
    } else {
      return false;
    }
  
  }
 
}
