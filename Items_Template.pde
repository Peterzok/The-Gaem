class Items{
    float x, y,
        healthPack = 50.0f;
    int sx, sy;
    String type;
    boolean active;
    int timer, respawn = 1000;
    Player whoHit;

    PImage item;

    Items(float xx, float yy, int sxx, int syy, String tt){
        x = xx; y = yy; sx = sxx; sy = syy; type = tt; timer = 0;
        active = true;
        switch(type){
            case "healthPack":
                item = loadImage("images/Items/item_HealthPack.png");
                break;
            case "buff_fireRate":
                item = loadImage("images/Items/item_FireRate.png");
                break;
            case "buff_MovementSpeed":
                item = loadImage("images/Items/item_SpeedBuff.png");
                break;
            default:
                println("Unkown Item");
        }
    }

    public void show (){
        fill(0);
        showItem();
        stroke(0);
        switch(type){
            case "healthPack":
                if (checkIfPlayersCollided() && active){
                    whoHit.takeDamage(healthPack, false);
                    active = false;
                };
                break;
            case "buff_fireRate":
                if (checkIfPlayersCollided() && active){
                    whoHit.activateBuff("buff_fireRate");
                    active = false;
                }
                break;
            case "buff_MovementSpeed":
                if (checkIfPlayersCollided() && active){
                    whoHit.activateBuff("buff_MovementSpeed");
                    active = false;
                }
                break;
            default: 
                println("Unkown Type");
                break;
        }
        whoHit = null;
        if (!active) timer++; if (timer > respawn){ timer = 0; active = true; }
        noStroke();
    }

    private void showItem(){
        if (active){
            item.resize(sx, sy);
            image(item, x, y);
        }
    }

    private boolean checkIfPlayersCollided(){
        Player tempPlayer;
        for (int a = 0; a < 2; a++){
            if (a == 0) tempPlayer = clnPlayer;
            else tempPlayer = srvPlayer;

            if (
                y + sy/2 > tempPlayer.y - tempPlayer.sy/2 &&
                y - sy/2 < tempPlayer.y + tempPlayer.sy/2 &&
                x + sx/2 > tempPlayer.x - tempPlayer.sx/2 &&
                x - sx/2 < tempPlayer.x + tempPlayer.sx/2
            ){whoHit = tempPlayer; return true;}
        }
        return false;
    }
}

void showItems(){
    for (int a = 0; a < items.size(); a++){
        items.get(a).show();
    }
}
