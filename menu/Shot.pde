

class Shot {

  int i;
  int xPosition;
  int yPosition;
  boolean inverter;
  boolean hitted; 
  Shot(int _xPosition, int _yPosition, boolean _inverter) {
    //xPosition recebe +20 para que o tiro saia no meio da imagem do player/inimigo
    xPosition = _xPosition + 25;
    inverter = _inverter;
    if(inverter) yPosition = _yPosition - 40;
    else yPosition = _yPosition + 40;
    ellipse(xPosition, yPosition, 5, 5);
  }

  void update(int enemyX, int enemyY, int playerX, int playerY) {
    
    //Verifica se o tiro acerto um enemigo ou o player e de onde ele veoi
    if (inverter && !hitted) {
      yPosition --;
      ellipse(xPosition, yPosition, 5, 5);
    } else if (yPosition < height && !hitted) {
      yPosition ++;
      ellipse(xPosition, yPosition, 5, 5);
    } 

    
    //hitmark
    if ((enemyX - 50 < xPosition && enemyX + 50 > xPosition) &&
      (enemyY - 50 < yPosition && enemyY + 50 > yPosition) && inverter && !hitted) {
      //println("enemyX" + enemyX);
      //println("enemyY" + enemyY);
        //for (i=0; i<10; i++) println("Acertou o enimigo");
      hitted = true;
      enemyHit++;
      
      println("enemy hitted:" + enemyHit);
    }
    // value = 0 (xplayer)
    // XPosition = 5
    // yPlayer = 585
    if((playerX < xPosition && playerX + 40 > xPosition) &&
      (playerY - 40 < yPosition && playerY > yPosition) && !inverter && !hitted) {
    //if((xPosition >= playerX && xPosition <= playerX +10) && 
    //   (yPosition >= playerY && yPosition <= playerY-10) && !hitted){
    //if ((playerX - 10 < xPosition && playerX + 10 > xPosition) &&
    //  (playerY <= yPosition && playerY + 10 > yPosition ) && !hitted && !inverter) {
        hitted = true;
        playerHit++;
      println("palyer hitted: " + playerHit);
    }
    
  }
}
