class Star {
  float x;
  float y;
  float r;
  String direction;
  float speed;
  float angle;
  
 Star(float x, float y, float r, String direction) {
   this.x = x;
   this.y = y;
   this.r = r;
   this.direction = direction;
   this.speed = border / 3;
   this.angle = 0;
 }
  
  void show() {
    fill(255);
    ellipseMode(CENTER);
//    ellipse(this.x, this.y, this.r, this.r);
    pushMatrix();
    translate(this.x, this.y);
    rotate(angle);
    image(throwingStar, 0 - this.r / 2, 0 - this.r / 2);
    popMatrix();
    this.angle += 0.5;
  }
  
  void update() {
    switch (this.direction) {
      case "UP":
        this.y -= this.speed;
        break;
      case "DOWN":
        this.y += this.speed;
        break;
      case "LEFT":
        this.x += this.speed;
        break;
      case "RIGHT":
        this.x -= this.speed;
        break;
  }
  }
  
  boolean collision(Target that){
    if (dist(this.x, this.y, that.x, that.y) * 2 < (this.r + that.r)) {
      return true;
    } else {
      return false;
    }
  
  }
  
}
