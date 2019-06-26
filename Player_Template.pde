class Player{
    public float x, y,
                speed,
                health,
                buff_MSvalue = 2,
                fireRate = 20;

    public int sx = 35, sy = 45;

    public int r, g, b;
    public boolean right, left, up, down;
        
    private boolean buff_FR,
                    buff_MS,
                    local,
                    isWalking;

    private float buffStartedTimer_FR,
                    buffStartedTimer_MS,
                    buffEndTime_FR,
                    buffEndTime_MS,
                    buffsTimer = 10,
                    buff_fireRate = 2;

    private float frameTime = 5;

    private int idleFrameIndex,
                walkingFrameIndex,
                spriteIdleSize,
                spriteWalkingSize;

    PImage[] spriteIdle,
            spriteWalking;

    Player(boolean loc){
        local = loc;
        x = width/2; y = height/2;
        imageMode(CENTER);

        if (local){
            //BLACKEY
            spriteIdleSize = 11;
            spriteWalkingSize = 7;

            spriteIdle = new PImage[spriteIdleSize];
            for (int a = 0; a < spriteIdleSize; a++){
                String filename = "images/Blackey/Blackey_Idle_Animation/" + a + ".gif";
                spriteIdle[a] = loadImage(filename);
                spriteIdle[a].resize(sx, sy);
            }
            spriteWalking = new PImage[spriteWalkingSize];
            for (int a = 0; a < spriteWalkingSize; a++){
                String filename = "images/Blackey/Blackey_Walk_Animation/" + a + ".gif";
                spriteWalking[a] = loadImage(filename);
                spriteWalking[a].resize(sx, sy);
            }
        }else{
            //WHITEY
            spriteIdleSize = 21;
            spriteWalkingSize = 7;

            spriteIdle = new PImage[spriteIdleSize];
            for (int a = 0; a < spriteIdleSize; a++){
                String filename = "images/Whitey/Whitey_Idle_Animation/" + a + ".gif";
                spriteIdle[a] = loadImage(filename);
                spriteIdle[a].resize(sx, sy);
            }
            spriteWalking = new PImage[spriteWalkingSize];
            for (int a = 0; a < spriteWalkingSize; a++){
                String filename = "images/Whitey/Whitey_Walk_Animation/" + a + ".gif";
                spriteWalking[a] = loadImage(filename);
                spriteWalking[a].resize(sx, sy);
            }
        }
        health = 100.0f;
        speed = 4.0f;
    }

    public void show(){
        if (!isWalking){
            if (frameCount % frameTime == 0) idleFrameIndex++;
            if (idleFrameIndex >= spriteIdleSize) idleFrameIndex = 0;
            image(spriteIdle[idleFrameIndex], x, y);
        }else{
            if (frameCount % frameTime == 0) walkingFrameIndex++;
            if (walkingFrameIndex >= spriteWalkingSize) walkingFrameIndex = 0;
            image(spriteWalking[walkingFrameIndex], x, y);
        }
        fill(0);
        //ellipse(x, y, sx, sy);
    }

    private void buffTimers(){
        if (buff_FR){
            if (buffEndTime_FR == second()){
                println("buffTimer_FR has been reseted");
                buff_FR = false;
            }
        }
        if (buff_MS){
            if (buffEndTime_MS == second()){
                println("buffTimer_MS has been reseted");
                buff_MS = false;
            }
        }
    }

    public void showUpdate(){
        isWalking = false;
        buffTimers();
        float tempSpeed = speed;
        if (buff_MS) tempSpeed *= buff_MSvalue;
        if(left){
            if (!wallCollision(x, y, sx, sy)){
                x -= tempSpeed;
            }
            if (wallCollision(x, y, sx, sy)){
                x += tempSpeed;
            }
            isWalking = true;
        }
        if(right){
            if (!wallCollision(x, y, sx, sy)){
                x += tempSpeed;
            }
            if (wallCollision(x, y, sx, sy)){
                x -= tempSpeed;
            }
            isWalking = true;
        }
        if(up){
            if (!wallCollision(x, y, sx, sy)){
                y -= tempSpeed;
            }
            if (wallCollision(x, y, sx, sy)){
                y += tempSpeed;
            }
            isWalking = true;
        }
        if(down){
            if (!wallCollision(x, y, sx, sy)){
                y += tempSpeed;
            }
            if (wallCollision(x, y, sx, sy)){
                y -= tempSpeed;
            }
            isWalking = true;
        }
    }

    public void updateVars(float xx, float yy){
        if (x == xx && y == yy) isWalking = false;
        else isWalking = true;
        x = xx; y = yy;
    }

    public void healthBarShow(){
        rectMode(CORNER);
        fill(255, 0, 0);
        rect(x - 25, y - 40, 50, 10);
        fill(0,255,0);
        rect(x - 25, y - 40, health/2, 10);
        rectMode(CENTER);
    }
    
    public void takeDamage(float dmg, boolean take){
        if (take) health -= dmg; else health += dmg;
        if (health <= 0) health = 100.0f;
        if (health > 100) health = 100.0f;
    }

    public float takeFireRate(){
        if (buff_FR) return fireRate/buff_fireRate;
        else return fireRate;
    }

    public void activateBuff(String str){
        switch (str){
            case "buff_fireRate":
                buffStartedTimer_FR = second();
                buffEndTime_FR = buffStartedTimer_FR;
                for (int a = 0; a < buffsTimer; a++){
                    if ((buffEndTime_FR + 1) > 59){
                        buffEndTime_FR = 0;
                    }
                    buffEndTime_FR++;
                }
                buff_FR = true;
                break;
            case "buff_MovementSpeed":
                buffStartedTimer_MS = second();
                //println("buffStartedTimer_MS: " + buffStartedTimer_MS);
                buffEndTime_MS = buffStartedTimer_MS;
                for (int a = 0; a < buffsTimer; a++){
                    if ((buffEndTime_MS + 1) > 59){
                        buffEndTime_MS = 0;
                    }
                    buffEndTime_MS++;
                }
                //println("buffEndTime_MS: " + buffEndTime_MS);
                buff_MS = true;
                break;
            default:
                println("Unkown Buff inside Player Template");
                break;
        }
    }
}
