
//class Enemy {

//  int i=1;
//  int xPosition;
//  int yPosition;
//  int tam;
//  int velocity;
//  int hit;
//  int enemyX, enemyY;
//  PImage skin;
//  //ArrayList<integer> moveX = new ArrayList<int>();
//  //ArrayList<integer> moveY = new ArrayList<int>();

//    //Construtor para receber textura do inimigo, tamanho, velocidade, etc...
//    Enemy(int x1, int y1,int _tam, int _velocity, PImage _skin){
//      //xPosition = x1;
//      //yPosition = y1;
//      skin = _skin;
//      velocity = _velocity;
//      tam = _tam;
//      ellipse(x1, y1, tam, tam);
//      DDA(x1, y1);
//    }
  
  
  
//  //update move (por enquanto)
//  public void update(){
//    enemyX = moveX.get(pos);
//    enemyY = moveY.get(pos);
    
//    //Se chegou no ultimo elemento, chama novamente o método DDA
//    if(moveX.get(moveX.size() -1 ) == enemyX){
//      DDA(enemyX, enemyY);
//    }
    
//    //desenha o inimigo na posição:
      
//    enemy = createShape(RECT, 0 , 0, tam,tam);
//    enemy.setStroke(false);
//    enemy.setTexture(skin);
//    shape(enemy, enemyX, enemyY);  
//    //enemyX = enemyX + xspeed;

//    //ellipse(moveX[i], moveY[i], tam,tam);
//    i++;

//  }
  
  
//  public void DDA(int x1, int y1) {

//    //gera os valores aleatórios desde que eles sejam divisiveis por 10
//    Random rand = new Random();
//    int x2 = rand.nextInt(0, width-30);
//    int y2 = rand.nextInt(60, 160);
    
    
//    while (x2%10!=0 && y2%10!=0 ) {
//      x2 = rand.nextInt(0, width-30);
//      y2 = rand.nextInt(60, 160);
//    }
  
  
//    int i, len;
//    float dx, dy, x, y;
//    if (abs(x2-x1) >= abs(y2-y1)) {
//      len = abs(x2-x1);
//    } else {
//      len = abs(y2-y1);
//    }
//    dx = (float) (x2-x1) / len;
//    dy = (float) (y2-y1) / len;
//    x = x1 + 0.5;
//    y = y1 + 0.5;
//    i=1;
    
//    //Zerando os valores dentro da array list 

//    for (int aux=0; aux<moveX.size(); aux++) {
//      moveX.remove(aux);
//      moxeY.remove(aux);
//    }
      
//    while (i <= len) {
  
//      x += dx;
//      y += dy;
//      moveX.add(int(x));
//      moveY.add(int(y));
//      i++;
//    }
//   }

//}
