class LavaBomb extends Target{

  LavaBomb(float x, float y, float r, String orientation, float speed) {
    super(x, y, r, orientation, speed);
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
      case "BOTTOM":
        break;
      case "TOP":
        rotate(PI * 0.5);
        break;
      case "RIGHT":
        scale(-1, 1);
        break;
      case "LEFT":
        rotate(0 * PI);
        break;
    }
    image(lavaBombImage, 0, 0);
    popMatrix();
  }
  
    void update() {
    if (random(0, 100) < 10) {
 //     this.randomDirectionX = randomGaussian();
      this.randomDirectionX = 3 * noise(0.1) * randomGaussian();
    }
    if (random(0, 100) < 2) {
//      this.randomDirectionY = randomGaussian();
      this.randomDirectionY = noise(0.1) * 4 - 2;
    }
    
    if (this.orientation == "BOTTOM") {
      this.y += this.speed + this.randomDirectionY / 3;
      this.x += this.randomDirectionX;
      this.speed *= 1.013;
    } else if (this.orientation == "TOP") {
      this.y -= this.speed + this.randomDirectionY / 3;
      this.x += this.randomDirectionX;
      this.speed *= 1.013;
    } else if (this.orientation == "LEFT") {
      this.x -= this.speed + this.randomDirectionY / 3;
      this.y -= this.randomDirectionX;
      this.speed *= 1.013;
    } else if (this.orientation == "RIGHT") {
      this.x += this.speed + this.randomDirectionY / 3;
      this.y += this.randomDirectionX;
      this.speed *= 1.013;
    } 
  }
  
}
