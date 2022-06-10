/*
/ Classe contendo as variáveis necessárias para o player
/  ------------ NÃO FOI IMPLEMENTADA AINDA ------------
*/

class Player{
  int posX, posY;
  int acertos; 
  int vida;
  int velocidade =5;

  Player(int _velocidade){
    velocidade = _velocidade;
  }
  
  void keyPressed() {
  //movimentação do personagem
  if (keyCode == 39) posX += velocidade;
  else if (keyCode == 37) posX -= velocidade;
  if (posX > width - 10) posX = width-10;
  else if (posX < 0) posX = 0;

  //if(keyCode == 32 && timeElapsed < 5000){

  if (keyCode == 32) {
    Timer timer = new Timer();
    shots.add(new Shot(posX, 580, true, 1));
  }
}
  
  
  
  //update para movimentos, tiros e acertos
  public void update(){
      
    
  
  
  }



}
