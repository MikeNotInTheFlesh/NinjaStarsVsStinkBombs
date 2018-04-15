import java.util.*;
//import processing.sound.*;

import java.io.IOException;
import android.media.AudioManager;
import android.media.SoundPool;
import android.content.Context;
import android.content.res.AssetFileDescriptor;
import android.content.res.AssetManager;
import android.content.Context;
import android.app.Activity;
import android.media.SoundPool.OnLoadCompleteListener;

///////////////////////// Android Soundpool Builder Stuff
private SoundPool soundPool;
//int gameSong;
int explosionSound; // replacing gameSong
int bombSound; // replacing gameSong
int gameOver;
int winSound;
int throwingStarSound;
int level_up;
int beginGame;
//AssetManager am;
Context context;
Activity act;
///////////////////// end

Ninja ninja;
ArrayList<Target> targets = new ArrayList<Target>();
ArrayList<Star> stars = new ArrayList<Star>();
Target target;
int time = 0;
Star star;
int move = 0;
int throwStar = 0;
int border;
int newTargetFrequency = 90;
PImage balloon;
PImage ninjaImage;
PImage throwingStar;
PImage bomb;
PImage ninjaBackground;
PImage lava1;
int lavaWhere = -1; // 0 = bottom, 1 = left, 2 = top, 3 = right
int lavaNext = -1; // same as lavaWhere
int lavaTimer;
PImage lavaTop;
PImage lavaBottom;
PImage lavaRight;
PImage lavaLeft;
PImage explosion;
PImage stink1;
PImage stink2;
PImage stink3;
PImage stink0;
ArrayList<Float> stinkies;
//SoundFile explosionSound;
//SoundFile music1;
//SoundFile bombSound;
PImage blackBalloon;
PImage balloon5;
//SoundFile gameOver;
//SoundFile winSound;
//SoundFile music2;
//SoundFile music3;
PFont font1;
boolean pause = false;
//float targetSpeed = 0.9;
//float targetSpeed = height / 50;
float targetSpeed;
float sizeAdjust;

MotherShip motherShip;
int score;
int health;
int inventory;
int balloonW;
int balloonH;
int level = 1;
int[] motherShipHealthLevel = {0, 15, 30, 50, 80};
LavaBomb lavaBomb;
PImage lavaBombImage;
boolean isLavaBomb = false;

//void settings() {
//  fullScreen();
//}

void setup() {
  sizeAdjust = min(height, width) / 450.0;
  targetSpeed = sizeAdjust;
  
////////////////////////////// SoundPoolBuilder Stuff  
    act = this.getActivity();
  context = act.getApplicationContext();
  soundPool = new SoundPool(20, AudioManager.STREAM_MUSIC, 0);
 
  try {

  AssetFileDescriptor descriptor;
  AssetFileDescriptor descriptor2;
  AssetFileDescriptor descriptor3;
  AssetFileDescriptor descriptor4;
  AssetFileDescriptor descriptor5;
  AssetFileDescriptor descriptor6;
  AssetFileDescriptor descriptor7;
 
  descriptor = context.getAssets().openFd("ContraSFX(14).wav");
  descriptor2 = context.getAssets().openFd("Contra SFX (9).wav");
  descriptor3 = context.getAssets().openFd("13_Game Over.wav");
  descriptor4 = context.getAssets().openFd("19 - beat final boss.wav");
  descriptor5 = context.getAssets().openFd("throwingStar.wav");
  descriptor6 = context.getAssets().openFd("level_up.wav");
  descriptor7 = context.getAssets().openFd("StageOpening.wav");
 
  explosionSound = soundPool.load(descriptor, 1);
  bombSound = soundPool.load(descriptor2, 1);
  gameOver = soundPool.load(descriptor3, 1);
  winSound = soundPool.load(descriptor4, 1);
  throwingStarSound = soundPool.load(descriptor5, 1);
  level_up = soundPool.load(descriptor6, 1);
  beginGame = soundPool.load(descriptor7, 1);
  
  
 
  } catch (IOException e) {
  }
  // added because your code fires "sample not ready"...
 
   soundPool.setOnLoadCompleteListener(new OnLoadCompleteListener(){
 
      public void onLoadComplete(SoundPool soundPool, int sampleId,
          int status) {
 
        soundPool.play(beginGame, 0.9f, 0.9f, 2, 0, 1.0);
      }}); 
//////////////////////// end SoundPool Builder Stuff
  
fullScreen();
//  size(displayWidth, displayHeight);
//  size(800, 450);
//  size(1600, 900);
//  size (1600, 1200);
  frameRate(60);
  lavaWhere = -1;
  lavaTimer = (int) frameRate * 10;
  target = new Target(200, 100, 50, "TOP", targetSpeed);   /////////// Can I delete this yet??
  border = (int) Math.floor((width + height) / 35);
  ninja = new Ninja(width / 2, height - border, border * 2);
  ninjaImage = loadImage("ninja2.png");
  ninjaImage.resize((int)ninja.r, (int)ninja.r);
  
  motherShip = new MotherShip(width / 2, 2.5 * border, 5 * border);
  balloon = loadImage("balloon3.png");
  balloonW = (int) (motherShip.r * .63);
  balloonH = (int) (balloonW * 1.65);
  balloon.resize(balloonW, balloonH);
  blackBalloon = loadImage("blackBalloon.png");
  blackBalloon.resize(balloonW, balloonW * blackBalloon.height / blackBalloon.width);
  balloon5 = loadImage("balloon5.png");
  balloon5.resize(balloonW, balloonW * balloon5.height / balloon5.width);
  throwingStar = loadImage("throwingStar.png");
  throwingStar.resize((int)(2 * border / 3), (int)(2 * border / 3));
  bomb = loadImage("bomb2.png");
  bomb.resize((int)(1.2 * border), (int) (1.2 * 1.8 * border));
  lavaBombImage = loadImage("lavaBomb.png");
  lavaBombImage.resize((int)(2.5 * border), (int) (2.5 * border));
  ninjaBackground = loadImage("ninja-background-6.jpg");
  ninjaBackground.resize(width, height);
  lavaTop = loadImage("lavaTop.jpg");
  lavaTop.resize(width, height);
  lavaBottom = loadImage("lavaBottom.jpg");
  lavaBottom.resize(width, height);
  lavaLeft = loadImage("lavaLeft.jpg");
  lavaLeft.resize(width, height);
  lavaRight = loadImage("lavaRight.jpg");
  lavaRight.resize(width, height);
  explosion = loadImage("explosion.png");
  explosion.resize(border * 2, border * 2);
  stink0 = loadImage("stink0.png");
  stink0.resize(border * 3, border * 3 * stink0.height / stink0.width);
  stink1 = loadImage("stink1.png");
  stink1.resize(border * 3, border * 3 * stink1.height / stink1.width);
  stink2 = loadImage("stink2.png");
  stink2.resize(border * 3, border * 3 * stink2.height / stink2.width);
  stink3 = loadImage("stink3.png");
  stink3.resize(border * 3, border * 3 * stink3.height / stink3.width);
  stinkies = new ArrayList<Float>();
  
  //explosionSound = new SoundFile(this, "ContraSFX(14).wav");
  //explosionSound.amp(0.4);
  //music1 = new SoundFile(this, "HighGround.mp3");
  //music1.amp(0.2);
  //music2 = new SoundFile(this, "08 - snake man.mp3");
  //music2.amp(0.2);
  //music3 = new SoundFile(this, "23 - Prison of the Dead.mp3");
  //music3.amp(0.2);
  //music1.loop();
  //bombSound = new SoundFile(this, "Contra SFX (9).wav");
  //gameOver = new SoundFile(this, "13_Game Over.mp3");
  //gameOver.amp(0.2);
  //winSound = new SoundFile(this, "19 - beat final boss.mp3");
  //winSound.amp(0.5);
  //winSound.rate(0.5);
//  font1 = loadFont ("SegoeUIBlack-Italic-48.vlw");
  
  score = 0;
  targets.add(target);
  health = 10;
  inventory = 100;

  
}

void draw() {
  time += 1;
  background(0, 200, 0, 255);
  imageMode(CORNER);
  image(ninjaBackground, 0, 0);
  
  switch (lavaWhere) {
    case -1:
      image(ninjaBackground, 0, 0);
      break;
    case 0:
      image(lavaBottom, 0, 0);
      break;
    case 1:
      image (lavaLeft, 0, 0);
      break;
    case 2:
      image(lavaTop, 0, 0);
      break;
    case 3:
      image(lavaRight, 0, 0);
      break;
  }
  
  ninja.show();
  throwingStarStuff();
  checkCollisions();
  motherShip.show();
  motherShip.update();
  ninja.update(move);  
  targetStuff();
  lava();
  if (health < 1) {
    gameOver();
  }
  if (motherShip.mhealth < 1){
    levelUp();
  }
  if (isLavaBomb) {
    lavaBomb.show();
    lavaBomb.update();
  }
  
  textAlign(LEFT);
  textSize(32);
  fill(200);
  text("Health: " + health, width / 25, height / 10);
  textAlign(RIGHT);
  text("Stars: " + inventory, width - width / 25, height / 10);
  textAlign(CENTER);
  fill(180, 0, 0, 200);
  textSize(48);
  text(score, width / 2, height / 10);
  
  // Opening message
  if (time < 120) {
    pushStyle();
//    textFont(font1);
    fill(0, 255, 0, 155);
    textSize(1.7 * 0.90 * border);
    textAlign(CENTER, CENTER);
    text("Taste my Stink Bombs!!!", width / 2, height / 2 - 2 * border);
    text("I think You'll agree...", width / 2, height / 2);
    text("They're 'PUtiful'!", width / 2, height / 2 + 2 * border);
    textSize(0.90 * border);
    text("Bwahahaha, ahahah, wahahah", width / 2, height / 2 + 4 * border);
    popStyle();
  }
  
  // Display Boss health
  pushStyle();
  rectMode(CORNER);
  fill(255, 0, 0, 255);
  rect(border, border * 2, width / 4, height / 25);
  fill(0, 255, 0, 255);
  rect(border, border * 2, (width / 4) *  ((float)motherShip.mhealth / (float)motherShipHealthLevel[level]), height / 25);
  textAlign(CORNER);
  textSize(border / 2);
  fill(0);
  text("Boss", border + border / 4, 2 * border +  height / 29);
  popStyle();

  
  ////////////////////////////////////// PRINTING STUFF
  //if (time % 100 == 0) {
  //  for (Star i: stars) {
  //    System.out.println("star (x, y) (" + i.x + ", " + i.y + ")");
  //  }
  //}
  //if (time % 50 == 0) {
  //  System.out.println("time: " + time);
  //}
  /////////////////////////////////////
}

void mousePressed() {
  mousePressed2();
  if (mouseX < width / 2) {
    move = -1;
    //stars.add(new Star(ninja.x, ninja.y, border / 2, ninja.dir()));
    //throwStar += 1; // This makes it stop at one per button push
    //inventory -= 1;
  } else if (mouseX > width / 2) {
    move = 1;
    //stars.add(new Star(ninja.x, ninja.y, border / 2, ninja.dir()));
    //throwStar += 1; // This makes it stop at one per button push
    //inventory -= 1;
  } 
}
void mouseReleased() {
  move = 0;
  if (inventory > 0 && (dist(ninja.x, ninja.y, motherShip.x, motherShip.y) > (ninja.r / 2 + motherShip.r / 2))) {
  stars.add(new Star(ninja.x, ninja.y, border / 2, ninja.dir()));
  soundPool.play(throwingStarSound, 0.9f, 0.9f, 1, 0, 1.0);
    throwStar += 1; // This makes it stop at one per button push
    inventory -= 1;
  }
}

void keyPressed() {
  if (keyCode == 32 || mousePressed) {
    throwStar += 1;
  } else if (keyCode == LEFT || keyCode == 65) {
    move = -1;
  } else if (keyCode == RIGHT || keyCode == 68) {
    move = 1;
  } else if (keyCode == 80) {
    pause();
  } else if (keyCode == 67) {     // Check what's in 'targets' and 'stars' arrays (Debugging) ('C' key)
    System.out.println("----------------------------------------");
    System.out.println("Ninja (x, y): " + ninja.x + ", " + ninja.y);
    for (Target tar : targets){
      System.out.println("Target x, y: " + tar.x + ", " + tar.y);
    }
    for (Star sta : stars) {
      System.out.println("Star x, y: " + sta.x + ", " + sta.y);
    }
    System.out.println("Score: " + score);
    System.out.println("Health: " + health);
    System.out.println("Inventory: " + inventory);
    System.out.println("Mothership x, y: " + motherShip.x + ", " + motherShip.y);
    System.out.println("fudgeFactor: " + motherShip.fudgeFactor);
  }
}

// Stop keyPressed() action
void keyReleased() {
  if (keyCode == 32) {
    throwStar = 0;
  } else if (move == -1 && (keyCode == LEFT || keyCode == 65)) {
    move = 0;
  } else if (move == 1 && (keyCode == RIGHT || keyCode == 68)) {
    move = 0;
  } 
}

void throwingStarStuff(){
  
  // Throw throwing star. Increment it so it only throws one.
  if (throwStar == 1 
  && inventory > 0
  && (dist(ninja.x, ninja.y, motherShip.x, motherShip.y) > (ninja.r / 2 + motherShip.r / 2))
  ) {
    stars.add(new Star(ninja.x, ninja.y, border / 2, ninja.dir()));
    throwStar += 1; // This makes it stop at one per button push
    inventory -= 1;
  }
  
  // Display throwing stars.
  for (Star i : stars) {
    i.show();
    i.update();
  }
  
  // Remove offscreen stars
  if (stars.size() > 0) {
    for (int i = stars.size() - 1; i >= 0; i--) {
      if (stars.get(i).x < 0 || stars.get(i).x > width || stars.get(i).y < 0 || stars.get(i).y > height){
        stars.remove(i);
      }
    }
  }
}

void checkCollisions() {
  
  // If ninja and mother ship collide: reduce throwing star inventory
  if (time % 3 == 0 
  && dist(ninja.x, ninja.y, motherShip.x, motherShip.y) < ninja.r / 2 + motherShip.r / 2
  ) {
    inventory += 1;
  }
  
  if (stars.size() == 0 || targets.size() == 0) {
    return;
  }
  for (int i = stars.size() - 1; i >= 0; i--) {
    // Check if the stars hit the MotherShip
    if (motherShip.collision(stars.get(i))){
      motherShip.mhealth -= 2;
      stars.remove(i);
      break;
    }
    // Check if the stars hit the targets
    for (int j = targets.size() - 1; j >= 0; j--) {
      if (stars.get(i).collision(targets.get(j))){
        score += targets.get(j).score;
        motherShip.mhealth -= 1;
//        System.out.println("boom: x, y " + stars.get(i).x + ", " + stars.get(i).y);
        imageMode(CENTER);
        image(explosion, stars.get(i).x, stars.get(i).y);
        soundPool.play(explosionSound, 0.9f, 0.9f, 2, 0, 1.0);
//        explosionSound.play();
        targets.remove(j);
        stars.remove(i);
        break;
      }
    }
  }
}

void targetStuff(){
  
  // Add new targets
  if (time % newTargetFrequency == 10) {
    switch (motherShip.orientation) {
      case "TOP":
        targets.add(new Target(motherShip.x, motherShip.y + motherShip.r / 2, 1.5 * border, motherShip.orientation, targetSpeed));
        break;
      case "BOTTOM":
        targets.add(new Target(motherShip.x, motherShip.y - motherShip.r / 2, 1.5 * border, motherShip.orientation, targetSpeed));
        break;
      case "LEFT":
        targets.add(new Target(motherShip.x + motherShip.r / 2, motherShip.y, 1.5 * border, motherShip.orientation, targetSpeed));
        break;
      case "RIGHT":
        targets.add(new Target(motherShip.x - motherShip.r / 2, motherShip.y, 1.5 * border, motherShip.orientation, targetSpeed));
        
    }
  }
  // Lose stars for standing on bombs
  if (targets.size() > 0) {
    for (Target tar: targets){
      if (ninja.collision(tar)){
        inventory -= 1;
      }
    }
  
    // Remove offscreen targets
    for (int i = targets.size() - 1; i >= 0; i--){
      if (
      (targets.get(i).y + targets.get(i).r * 3/8 > height && targets.get(i).orientation == "TOP")
      || (targets.get(i).y - targets.get(i).r * 3/8 < 0 && targets.get(i).orientation == "BOTTOM")
      || (targets.get(i).x - targets.get(i).r * 3/8 < 0 && targets.get(i).orientation == "RIGHT")
      || (targets.get(i).x + targets.get(i).r * 3/8 > width && targets.get(i).orientation == "LEFT")
      ) {
        
        // Information for bomb image effect and when it can be removed
        stinkies.add((float) time + 0.5 * frameRate);
        stinkies.add(targets.get(i).x);
        stinkies.add(targets.get(i).y);
        
        targets.remove(i);
        health -= 1;
        soundPool.play(bombSound, 0.9f, 0.9f, 2, 0, 1.0);
        //bombSound.amp(0.4);
        //bombSound.play();
        continue;
      }
      targets.get(i).show();
      targets.get(i).update();
    }
  }
  // Draw stinkies
  for (int i = 0; i < stinkies.size(); i += 3) {
   if (time < stinkies.get(i)) {
     if (time % 16 < 4) {
       image(stink0, stinkies.get(i + 1), stinkies.get(i + 2));
     } else if (time % 16 < 8) {
       image(stink1, stinkies.get(i + 1), stinkies.get(i + 2));
     } else if (time % 16 < 12) {
       image(stink2, stinkies.get(i + 1), stinkies.get(i + 2));
     } else if (time % 16 < 16) {
       image(stink3, stinkies.get(i + 1), stinkies.get(i + 2));
     }
     
   }
  }
}
  
void lava() {
  lavaTimer -= 1;
  
  // Get rid of old lava
  if (lavaTimer < 1){
    lavaWhere = -1;
    lavaNext = -1;
  }
  
  // Add new lava
  if (random(0, 2000) > 2000 + lavaTimer) {
    lavaNext = (int) random(0,4);
    lavaTimer = (int) frameRate * 10;
    lavaBomb = new LavaBomb(width / 2, height / 2, 2 * border, convert(lavaNext), targetSpeed / 5);/////////////////////////
    isLavaBomb = true;
  }
  
  if (isLavaBomb 
      &&((lavaBomb.y + lavaBomb.r * 3/8 > height && lavaBomb.orientation == "BOTTOM")
      || (lavaBomb.y - lavaBomb.r * 3/8 < 0 && lavaBomb.orientation == "TOP")
      || (lavaBomb.x - lavaBomb.r * 3/8 < 0 && lavaBomb.orientation == "LEFT")
      || (lavaBomb.x + lavaBomb.r * 3/8 > width && lavaBomb.orientation == "RIGHT")
      )) {
        lavaWhere = lavaNext;
      }
 switch (lavaWhere){
   case -1:
     return;
   case 2:
     if (time % 15 == 0 && ninja.dir() == "DOWN") {health -= 1;}
     break;
   case 0:
     if (time % 15 == 0 && ninja.dir() == "UP") {health -= 1;}
     break;
   case 1:
     if (time % 15 == 0 && ninja.dir() == "LEFT") {health -= 1;}
     break;
   case 3:
     if (time % 15 == 0 && ninja.dir() == "RIGHT") {health -= 1;}
     break;
 }
 }
 
 String convert(int direction_) {
   switch (direction_) {
     case 0:
       return "BOTTOM";
     case 1:
       return "LEFT";
     case 2:
       return "TOP";
     case 3:
       return "RIGHT";
   }
   return "None";
 }
 
   
void gameOver() {
  //music1.stop();
  //music2.stop();
  //music3.stop();
  textSize(border * 3);
  fill(255, 0, 0, 255);
  textAlign(CENTER, CENTER);
  rectMode(CENTER);
  
  if (level < 4){
    soundPool.play(gameOver, 0.9f, 0.9f, 2, 0, 1.0);
    //gameOver.play();
    text("GAME OVER", width / 2, height / 2 - height / 10);
  }  else {
    soundPool.play(winSound, 0.9f, 0.9f, 2, 0, 1.0);
    //winSound.play();
    text("YOU WIN!!!!!", width / 2, height / 2 - height / 5);
    textSize(border * 1.25);
    textLeading(border * 1.25);
    text("The Stink Bomber has been defeated\nand the dojo saved", width / 2, 1.05 * height / 2);
  }
  
  textSize(border);
  fill(255);
  text("Play Again?", width / 2, height * 3/4 - border / 2);
  
  fill(0, 255, 0, 255);
  rect(width * 1 / 3, height * 3 / 4 + border, border * 3, border * 1.5);
  fill(255);
  text("YES", width * 1 / 3, height * 3 / 4 + border);
  fill(255, 0, 0, 255);
  rect(width * 2 / 3, height * 3/ 4 + border, border * 3, border * 1.5);
  fill(255);
  text("QUIT", width * 2 / 3, height * 3 / 4 + border);

  noLoop();
  }
 
 // Start new game or exit program
 void mousePressed2() {
   if (health <= 0 || level == 4) {
     if (mouseY > (height * 3/4 + border) - (border * 1.5 / 2) && mouseY < (height * 3/4 + border) + (border * 1.5 / 2)) {
       if (mouseX > (width * 1 / 3 - border * 3 / 2) && (mouseX < (width * 1 / 3 + border * 3 / 2))) {
         stinkies.clear();
         if (level < 4) {
           score = 0;
         }
         level = 1;
         health = 10;
         inventory = 100;
         motherShip.x = width/2;
         motherShip.y = 2 * border;
         motherShip.orientation = "TOP";
         motherShip.mhealth = motherShipHealthLevel[level];
         ninja.x = width / 2;
         ninja.y = height - border;
         targets.clear();
         stars.clear();
         System.out.println("Start new game");
         lavaWhere = -1;
         lavaNext = -1;
         lavaTimer = 0;
         newTargetFrequency = 90;
         //music1.play();
         time = 0;
         targetSpeed = height / 450;
         soundPool.play(beginGame, 0.9f, 0.9f, 2, 0, 1.0);
         
         loop();
       } else if (mouseX > (width * 2 / 3 - border * 3 / 2) && (mouseX < (width * 2 / 3 + border * 3 / 2))){
         System.exit(0);
//         exit();
       }
     }
   }
 }
 
void pause() {
 System.out.println("PAUSE");
   if (pause) {
     pause = false;
     //music1.play();
     loop();
   } else {
     pause = true;
     noLoop();
     pushStyle();
     fill(255);
     textAlign(CENTER, TOP);
     textSize(border * 2);
     text("Paused", width / 2, height / 10);
     //music1.stop();
     //music2.stop();
     //music3.stop();
     popStyle();
   }
}

void levelUp(){
  targetSpeed *= 1.25;
  motherShip.moveSpeed *= 1.25;
  level += 1;
  motherShip.mhealth = motherShipHealthLevel[level];
  //music1.stop();
  //music2.stop();
  //music3.stop();
  switch (level){
    case 1:  // This case never happens...
      //music1.play();
      break;
    case 2:
      //music2.play();
      soundPool.play(level_up, 0.9f, 0.9f, 2, 0, 1.0);
      inventory += 10;
      health += 2;
      newTargetFrequency = 90 - score / 200;
      break;
    case 3:
      //music3.play();
      soundPool.play(level_up, 0.9f, 0.9f, 2, 0, 1.0);
      inventory += 20;
      health += 3;
      newTargetFrequency = 90 - score / 175;
      break;
    case 4:
      gameOver();
  }
}
