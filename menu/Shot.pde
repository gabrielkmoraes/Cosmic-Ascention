
/*
/ Classe que realiza o tiro do jogador e do inimigo
*/
class Shot {

  int i;
  int xPosition;
  int yPosition;
  int velocity;
  boolean inverter;
  boolean atingido; 
    
  Shot(int _xPosition, int _yPosition, boolean _inverter, int _velocity) {
    //xPosition recebe +20 para que o tiro seja desenhado no meio da imagem do player/inimigo
    velocity = _velocity;
    xPosition = _xPosition + 25;
    inverter = _inverter;
    if(inverter) yPosition = _yPosition - 40;
    else yPosition = _yPosition + 40;
    ellipse(xPosition, yPosition, 5, 5);
  }

  //Função que desenha as novas posições do tiro 
  void update(int enemyX, int enemyY, int playerX, int playerY) {
    
    //Verifica se o tiro acertou um inimigo ou o player e qual foi sua origem (inverter)
    
    if (inverter && !atingido) {
      //Caso seja o player que atirou
      yPosition --;
      stroke(0, 408, 612);
      ellipse(xPosition, yPosition, 5, 5);
    }else if (yPosition < height && !atingido) {
      //Ou se o inimigo atirou
       yPosition = velocity + yPosition;
      stroke(178,13,13);
      ellipse(xPosition, yPosition, 5, 5);
    } 

    //Inimigo Atingido    
    if ((enemyX - 50 < xPosition && enemyX + 50 > xPosition) &&
      (enemyY - 50 < yPosition && enemyY + 50 > yPosition) && inverter && !atingido) {
      atingido = true;
      enemyHit++;
    }
    //Player atingido
    if((playerX < xPosition && playerX + 40 > xPosition) &&
      (playerY - 40 < yPosition && playerY > yPosition) && !inverter && !atingido) {
        atingido = true;
        playerHit++;
    }
  }
}
