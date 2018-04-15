class Target {
  float x;
  float y;
  float r;
  String orientation;
  float speed;
  int score;
  float randomDirectionX;
  float randomDirectionY;
  
 Target(float x, float y, float r, String orientation, float speed) {
   this.x = x;
   this.y = y;
   this.r = r;
   this.orientation = orientation;
   this.speed = speed;
   this.score = 100;
//   this.randomDirectionX = randomGaussian();
//   this.randomDirectionY = randomGaussian();
  this.randomDirectionX = noise(0.1) * sizeAdjust ;
  this.randomDirectionY = noise(0.1) * 4 * sizeAdjust;
 }
  
  void show() {
    imageMode(CENTER);
    fill(250);
    ellipseMode(CENTER);
//    ellipse(this.x, this.y, this.r, this.r);
    rectMode(CENTER);
//    rect(this.x, this.y, this.r, this.r);
    pushMatrix();
    translate(this.x, this.y);
    switch(this.orientation) {
      case "TOP":
        break;
      case "BOTTOM":
        rotate(PI);
        break;
      case "RIGHT":
        rotate(0.5 * PI);
        break;
      case "LEFT":
        rotate(1.5 * PI);
        break;
    }
    image(bomb, 0, 0);
    popMatrix();
  }
  
  void update() {
    if (random(0, 100) < 10) {
 //     this.randomDirectionX = randomGaussian();
      this.randomDirectionX = 3 * noise(0.1) * randomGaussian() * sizeAdjust;
    }
    if (random(0, 100) < 2) {
//      this.randomDirectionY = randomGaussian();
      this.randomDirectionY = noise(0.1) * 4 - 2 * sizeAdjust;
    }
    
    if (this.orientation == "TOP") {
      this.y += this.speed + this.randomDirectionY / 3;
      this.x += this.randomDirectionX;
      this.speed *= 1.013;
    } else if (this.orientation == "BOTTOM") {
      this.y -= this.speed + this.randomDirectionY / 3;
      this.x += this.randomDirectionX;
      this.speed *= 1.013;
    } else if (this.orientation == "RIGHT") {
      this.x -= this.speed + this.randomDirectionY / 3;
      this.y -= this.randomDirectionX;
      this.speed *= 1.013;
    } else if (this.orientation == "LEFT") {
      this.x += this.speed + this.randomDirectionY / 3;
      this.y += this.randomDirectionX;
      this.speed *= 1.013;
    } 
  }
  
}
