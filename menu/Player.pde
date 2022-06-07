

class Player{
  int posX, posY;
  int acertos; 
  int vida;
  int velocidade;
  
  Player(int _velocidade){
    velocidade = _velocidade;
  }
  
  void keyPressed() {
  //movimentação do personagem
  if (keyCode == 39) posX += 5;
  else if (keyCode == 37) posX -= 5;
  if (posX > width - 10) posX = width-10;
  else if (posX < 0) posX = 0;

  //if(keyCode == 32 && timeElapsed < 5000){

  if (keyCode == 32) {
    Timer timer = new Timer();
    shots.add(new Shot(posX, 580, true));
  }
}
  
  
  
  //update para movimentos, tiros e acertos
  public void update(){
      
    
  
  
  }



}
