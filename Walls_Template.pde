class Wall{
    public float x, y, sx, sy;

    Wall(float xx, float yy, float sxx, float syy){
        x = xx; y = yy; sx = sxx; sy = syy;
    }

    public void show(){
        fill(0);
        noStroke();
        rect(x, y, sx, sy);
        stroke(0);
    }

    public boolean checkCollision(float xx, float yy, float sxx, float syy){
        //println("xx : " + xx + " yy: " + yy + " sxx: " + sxx + " syy: " + syy);
        if (
            y + sy/2 > yy - syy/2 &&
            y - sy/2 < yy + syy/2 &&
            x + sx/2 > xx - sxx/2 &&
            x - sx/2 < xx + sxx/2
        ) return true;
        else return false;
    }
}


void showWalls(){
    int tempNum = walls.size();

    if (tempNum != 0){
        for (int a = 0; a < tempNum; a++){
            walls.get(a).show();
        }
    }
}

boolean wallCollision(float x, float y, float sx, float sy){
    int tempNum = walls.size();
    if (tempNum != 0){
        for (int a = 0; a < tempNum; a++){
            if (walls.get(a).checkCollision(x, y, sx, sy)){
                return true;
            }
        }
    }
    return false;
}
