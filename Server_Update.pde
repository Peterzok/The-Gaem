void srvUpdate(){
    srvWrite();
    srvRecieve();
    srvPlayer.showUpdate();
    showProjectiles();
}

void serverEvent(Server someServer, Client someClient){
    println(someClient.ip() + " Connected.");
    gameStart = true;
    send = true;
}

void srvWrite(){
    if (send){
        //SEND server Player Positions etc
        String sendData;
        sendData = "PlayerPositions," + srvPlayer.x + "," + srvPlayer.y + "||";
        
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

        srv.write(sendData);
        send = false;
    }
}

void srvRecieve(){
    String tempData;

    Client someClient = srv.available();

    if (someClient != null){
        tempData = someClient.readString();

        if (tempData != null){
            //println(tempData);
            //CLN UPDATE
            String[] formatedString;
            String[] updateXY;
            String[] projectiles;

            formatedString = split(tempData, "||");

            for (int a = 0; a < formatedString.length; a++){
                if (match(formatedString[a],"PlayerPositions") != null){
                    updateXY = split(formatedString[a], ",");
                    clnPlayer.updateVars(float (updateXY[1]), float (updateXY[2]));
                }
                if (match(formatedString[a],"Projectiles") != null){
                    projectiles = split(formatedString[a], ",");
                    //comments below
                    //println("justProjectiles Length: " + projectiles.length + " Data: " + projectiles);
                    for (int i = 1; i < projectiles.length; i+=2){
                        justProjectiles.add(new Projectiles(float(projectiles[i]), float(projectiles[i+1]), false));
                    }
                }
            }

            send = true;
        }
    }
}
