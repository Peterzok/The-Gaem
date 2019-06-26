void modePicker(){
    if (modePick){
        if (key == 's' || key == 'S'){
        startSrv();
        }
        if (key == 'c' || key == 'C'){
        prepareCln();
        }
    }
}