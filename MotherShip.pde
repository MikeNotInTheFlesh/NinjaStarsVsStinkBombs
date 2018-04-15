class MotherShip {
  float x;
  float y;
  float r;
  float direction;
  float leftBorder;
  float rightBorder;
  float bottomBorder;
  float topBorder;
  float moveSpeed;
  String orientation;
  int fudgeFactor;
  int mhealth;
  
 MotherShip(float x, float y, float r) {
   this.x = x;
   this.y = y;
   this.r = r;
   this.leftBorder = this.r;
   this.rightBorder = width - this.r;
   this.bottomBorder = height - this.r;
   this.topBorder = this.r;
   this.moveSpeed = targetSpeed * 2;
   this.direction = 1;
   this.orientation = "TOP";
   this.mhealth = motherShipHealthLevel[level];

   
 }
 
 void show() {
   fill(100, 255, 100, 255);
   noStroke();
   rectMode(CENTER);
//   rect(this.x, this.y, this.r, this.r);
   
   pushMatrix();
   translate(motherShip.x , motherShip.y);
   if (this.orientation == "BOTTOM" && direction < 0) {
     rotate(1.0 * PI);
   } else if (this.orientation == "BOTTOM") {
     rotate(1 * PI);
     scale(-1, 1);
   } else if (this.orientation == "RIGHT" && direction < 0) {
     rotate(0.4 * PI);
   } else if (this.orientation == "RIGHT") {
     rotate(0.55 * PI);
   } else if (this.orientation == "LEFT" && direction < 0) {
     rotate(1.55 * PI);
   } else if (this.orientation == "LEFT") {
     rotate(1.40 * PI);
   } else if (this.orientation == "TOP" && direction < 0) {
     rotate(-0.1 * PI);
   }
   if (level == 1) {
     image(balloon, -balloonW / 2, - balloonH / 2);
   } else if (level == 2) {
     image(balloon5, - balloonW / 2, - balloonH / 2);
   } else if (level == 3) {
     image(blackBalloon, - balloonW / 2, - balloonH / 2);
   }
//  rect(motherShip.x, motherShip.y, 2, 2);
   popMatrix();
 }
 
 void update() {

   if (this.orientation == "TOP" || this.orientation == "BOTTOM") {
   this.x += this.direction * this.moveSpeed;
   if (this.x - this.r / 2 < 0 || this.x + this.r / 2 > width){
     if (random(0,4) < 1) {
       this.fudgeFactor = 0;
       if (this.x < width / 2) {
       this.orientation = "LEFT";
       this.x = this.r / 2;
       if (this.y > height / 2) {
         this.direction *= -1; 
       }
       } else {
         this.orientation = "RIGHT";
         this.x = width - this.r / 2;
         if (this.y < height / 2) {
           this.direction *= -1; 
         }
       }
     }
     this.direction *= -1;
   }
   } else if (this.orientation == "RIGHT" || this.orientation == "LEFT") {
   this.y += this.direction * this.moveSpeed;
   if (this.y - this.r / 2 < 0 || this.y + this.r / 2 > height){
     if (random(0,4) < 1) {
       this.fudgeFactor = 0;
       if (this.y < height / 2) {
       this.orientation = "TOP";
       this.y = this.r / 2;
       if (this.x > width / 2) {
       this.direction *= -1;
       }
       } else {
         this.orientation = "BOTTOM";
         this.y = height - this.r / 2;
         if (this.x < width / 2) {
         this.direction *= -1;
         }
       }
     }
     this.direction *= -1;
   }
   }
 }
 


String dir(){
   if (this.x >= leftBorder && this.y >= bottomBorder && this.y > topBorder) {
  return "UP";
   } else if (this.y < topBorder){
   return "DOWN";
   } else if (this.x < leftBorder){
   return "LEFT";
   } else {
   return "RIGHT";
 }
 }
 
boolean collision(Star that){
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
