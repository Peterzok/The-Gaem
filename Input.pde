void keyPressed(){

  //println(int(key));

  modePicker();
  clnPrepareIP();

  playerMovement(true);
}

void keyReleased(){
  playerMovement(false);
}

void playerMovement(boolean move){
  if (gameStart){
    Player tempPlayer;
    if (isCln){
      tempPlayer = clnPlayer;
    }else{
      tempPlayer = srvPlayer;
    }

    switch (key) {
      case 'w':
        tempPlayer.up = move;
        break;
      case 'a':
        tempPlayer.left = move;
        break;
      case 's':
        tempPlayer.down = move;
        break;
      case 'd':
        tempPlayer.right = move;
        break;
    }
  }
}

void shootBullets(){
  Player tempPlayer;
  if (isCln) tempPlayer = clnPlayer; else tempPlayer = srvPlayer;
  if (gameStart && frameCount % tempPlayer.takeFireRate() == 0){
    if (mousePressed){
      Float tempArr[] = {float(mouseX), float(mouseY)};
      projectilesBuffer.add(tempArr);
      myProjectiles.add(new Projectiles(mouseX, mouseY, true));
    }
  }
}

/*
void mousePressed(){
  if(gameStart && frameCount % 100){
    Float tempArr[] = {float(mouseX), float(mouseY)};
    projectilesBuffer.add(tempArr);
    myProjectiles.add(new Projectiles(mouseX, mouseY, true));
  }
}
*/