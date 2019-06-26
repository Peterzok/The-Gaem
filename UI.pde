void UI(){
  if (preparingIP){
    fill(0);
    textAlign(CENTER);
    text(srvIP,width/2,height/2); 
  }
  if (modePick){
    fill(0);
    textAlign(CENTER);
    text("First run: Press C or S",width/2,height/2);
  }
  if (gameStart){
    clnPlayer.healthBarShow();
    srvPlayer.healthBarShow();
  }
}
