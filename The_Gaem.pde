import processing.net.*;
import java.lang.Math.*;

Player clnPlayer;
Player srvPlayer;

Server srv;
Client cln;

ArrayList<Projectiles> myProjectiles = new ArrayList<Projectiles>();
ArrayList<Projectiles> justProjectiles = new ArrayList<Projectiles>();

ArrayList<Wall> walls = new ArrayList<Wall>();

ArrayList<Float[]> projectilesBuffer = new ArrayList<Float[]>();

ArrayList<Items> items = new ArrayList<Items>();

String srvIP;
boolean modePick,
        isCln,
        preparingIP,
        gameStart,
        send;

//ArrayList<String> Data = new ArrayList<String>();

PImage backgroundImage, blackeyProjectile, whiteyProjectile;

int bulletSx = 20, bulletSy = 20;

void setup(){
  blackeyProjectile = loadImage("Images/Blackey/projectile.png");
  blackeyProjectile.resize(bulletSx, bulletSy);
  whiteyProjectile = loadImage("Images/Whitey/projectile.png");
  whiteyProjectile.resize(bulletSx, bulletSy);
  
  
  
  backgroundImage = loadImage("Images/backgroundImage.png");
  backgroundImage.resize(width, height);
  size(700, 700);
  //fullScreen();

  firstRun();
  noLoop();
}

void draw(){
  background(255);

  ClnOrSrv();

  UI();
}

void ClnOrSrv(){
  if (gameStart) {

    image(backgroundImage, width/2, height/2);
    if(isCln) clnUpdate(); else srvUpdate();

    showWalls();
    showItems();
  
    shootBullets();

    clnPlayer.show();
    srvPlayer.show();  
  };
}
