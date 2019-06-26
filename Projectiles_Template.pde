class Projectiles{
    public float x, y,
                r, g, b,
                stepX, stepY,
                bulletDamage,
                speed;
    public int sx, sy;

    private boolean local, clnOrSrv;

    Projectiles(float xx, float yy, boolean loc){
        local = loc;
        bulletDamage = 10.0f;
        speed = 10;
        showRGB();
        calcTrajectories(xx, yy);
        sx = bulletSx; sy = bulletSy;
    }

    private void calcTrajectories(float xx, float yy){
        Player tempPlayer;

        float difX, difY;

        tempPlayer = selectTempPlayer();
        if (tempPlayer == clnPlayer) clnOrSrv = true; else clnOrSrv = false;
  
        x = tempPlayer.x;
        y = tempPlayer.y;

        difX = tempPlayer.x - xx;
        difY = tempPlayer.y - yy;

        calcHypotAndAssign(difX, difY);
    }

    private void calcHypotAndAssign(float x, float y){
        float distance;
        distance = (float)Math.hypot(x, y);
        stepX = x/distance;
        stepY = y/distance;
    }

    private Player selectTempPlayer(){
        if (local){
            if (isCln){
                return selectPlayer(true);
            }else{
                return selectPlayer(false);
            }
        }else{
            if (isCln){
                return selectPlayer(false);
            }else{
                return selectPlayer(true);
            }
        }
    }

    private Player selectPlayer(boolean select){return select ? clnPlayer : srvPlayer;}

    private void showRGB(){
        if(local){
            r=0;
            g=255;
            b=0;
        }else{
            r=255;
            g=0;
            b=0;
        }
    }

    public void show(){
        if (clnOrSrv) image(blackeyProjectile, x, y); else image(whiteyProjectile, x, y); 
        mover();
    }

    private void mover(){
        x -= stepX*speed;
        y -= stepY*speed;
    }
    
    public boolean checkCollision(){
        Player tempPlayer = selectTempPlayer();
        if(tempPlayer != clnPlayer){
            if(clnPlayer.x + (clnPlayer.sx/2) > x-(sx/2)
                && clnPlayer.x - (clnPlayer.sx/2) < x + (sx/2)
                && clnPlayer.y + (clnPlayer.sy/2) > y-(sy/2)
                && clnPlayer.y - (clnPlayer.sy/2) < y + (sy/2) ){
                    clnPlayer.takeDamage(bulletDamage, true);
                    return true;
            }
        }else{
            if(srvPlayer.x + (srvPlayer.sx/2) > x - (sx/2)
                && srvPlayer.x - (srvPlayer.sx/2) < x + (sx/2)
                && srvPlayer.y + (srvPlayer.sy/2) > y-(sy/2)
                && srvPlayer.y - (srvPlayer.sy/2) < y + (sy/2) ){
                    srvPlayer.takeDamage(bulletDamage, true);
                    return true;
            }
        }
        return false;
    }
}


void showProjectiles(){
    int tempNum = myProjectiles.size();
    if (tempNum != 0){
        for (int a = 0; a < tempNum; a++){
            if (myProjectiles.get(a).checkCollision() ||
                 wallCollision(myProjectiles.get(a).x,
                                myProjectiles.get(a).y,
                                myProjectiles.get(a).sx,
                                myProjectiles.get(a).sy
                                )
                ){
                myProjectiles.remove(a);
                //println(myProjectiles.size());
                tempNum--;
                continue;
            }else{
                myProjectiles.get(a).show();
            }
        }
    }

    tempNum = justProjectiles.size();
    if (tempNum != 0){
        //println("before FOR LOOP justProjectiles size: " + justProjectiles.size());
        for (int a = 0; a < tempNum; a++){
            //println("LOOP COUNTER: " + a);
            if (justProjectiles.get(a).checkCollision() || 
                wallCollision(justProjectiles.get(a).x,
                                justProjectiles.get(a).y,
                                justProjectiles.get(a).sx,
                                justProjectiles.get(a).sy
                                )
                ){
                justProjectiles.remove(a);
                //println(justProjectiles.size());
                tempNum--;
                continue;
            }else{
                justProjectiles.get(a).show();
            }
        }
    }
}
