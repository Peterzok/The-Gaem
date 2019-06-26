void clnUpdate(){
    clnWrite();
    clnReceive();
    clnPlayer.showUpdate();
    showProjectiles();
}

void clnWrite(){
    if (send){
        //SEND client Player Positions etc
        String sendData;
        sendData = "PlayerPositions," + clnPlayer.x + "," + clnPlayer.y + "||";
        
        int tempNum = projectilesBuffer.size();
        if (tempNum != 0){
            sendData += "Projectiles,";
            for (int a = 0; a < tempNum; a++){
                sendData += projectilesBuffer.get(a)[0] + "," + projectilesBuffer.get(a)[1];
                if (a != tempNum - 1){
                    sendData += ",";
                }
            }
            projectilesBuffer.clear();
        }

        cln.write(sendData);
        send = false;
    }
}

void clnReceive(){
    String tempData = cln.readString();

    if (tempData != null){
        //println(tempData);
        //SRV UPDATE
        String[] formatedString;
        String[] updateXY;
        String[] projectiles;

       formatedString = split(tempData, "||");

        for (int a = 0; a < formatedString.length; a++){
            if (match(formatedString[a],"PlayerPositions") != null){
                updateXY = split(formatedString[a], ",");
                srvPlayer.updateVars(float (updateXY[1]), float (updateXY[2]));
            }
            if (match(formatedString[a],"Projectiles") != null){
                projectiles = split(formatedString[a], ",");
                for (int i = 1; i < projectiles.length; i+=2){
                    justProjectiles.add(new Projectiles(float(projectiles[i]), float(projectiles[i+1]), false));
                }
            }
        }

        send = true;
    }
}
/*
void clientEvent(Client someClient){
    
}
*/