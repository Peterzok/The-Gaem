void firstRun(){
  modePick = true;
  rectMode(CENTER);
  gameStart = false;
  preparingIP = false;
  srvIP = "";
}

void startSrv(){
  modePick = false;
  srv = new Server(this,5204);
  isCln = false;
  //gameStart = true;
  generateSession();
  loop();
}

void prepareCln(){
  isCln = true;
  modePick = false;
  preparingIP = true;
  loop();
}

void startCln(){
  preparingIP = false;
  gameStart = true;
  cln = new Client(this,srvIP,5204);
  generateSession();
}

void clnPrepareIP(){
    if (isCln && preparingIP){
        if (key == BACKSPACE){
        srvIP = "";
        }
        if (key == '.' || (key >= 48 && key <= 57)){
        srvIP += key;
        }
        if (key == ENTER){
        startCln();
        }
    }
}

void generateSession(){
  clnPlayer = new Player(true);
  srvPlayer = new Player(false);
  generateMap();
}

void generateMap(){
  generateWalls();
  generateItems();
}

void generateItems(){
  /* ITEM NAMES
    healthPack
    buff_fireRate
    buff_MovementSpeed
  */
  items.add(new Items((width/10), (height/10), 50, 50, "buff_MovementSpeed"));
  items.add(new Items(width - (width/10), height - (height/10), 50, 50, "healthPack"));
  items.add(new Items(width - (width/10), (height/10), 50, 50, "buff_fireRate"));
}

void generateWalls(){
  outerWalls();
  insideWalls();
}

void insideWalls(){
  float rx = width/10, ry = height/10,
        wtX = width/30, wtY = height/30;

  //TOP TO BOTTOM
  createWall(rx * 3.5, ry/2, wtX, wtY*2);
  createWall(rx * 7, ry/2, wtX, wtY*2);
  createWall(rx * 3.5, ry*4.5, wtX, wtY*14);
  createWall(rx * 7, ry*2.6, wtX, wtY*2);
  createWall(rx * 6.5, ry*3, wtX*5, wtY);
  createWall(rx * 9.5, ry*3, wtX*4, wtY);
  createWall(rx * 5.75, ry*4.315, wtX, wtY*9);
  createWall(rx * 6.41, ry*5.75, wtX*5, wtY);
  createWall(rx * 9, ry*5.75, wtX*5, wtY);
  createWall(rx * 1, ry*5, wtX*5, wtY);
  createWall(rx * 5.75, ry*8.39, wtX, wtY*9);
  createWall(rx * 3.5, ry*8.9, wtX, wtY*6);
}

void outerWalls(){
  float rx = width/7, ry = height/7,
        wtX = width/20, wtY = height/20;

  //OUTER WALLS
  //TOP WALL
  createWall(width/2, 0, width, wtY);
  //RIGHT WALL
  createWall(width, height/2, wtX, height);
  //BOTTOM WALL
  createWall(width/2, height, width, wtY);
  //LEFT WALL
  createWall(0, height/2, wtX, height);
}

void createWall(float x, float y, float sx, float sy){
  walls.add(new Wall(x, y, sx, sy));
}
