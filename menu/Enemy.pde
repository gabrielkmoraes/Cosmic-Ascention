
//class Enemy {

//  int i=1;
//  int xPosition;
//  int yPosition;
//  int tam;
//  int velocity;
//  int hit;
    
//    //Construtor para receber textura do inimigo, tamanho, velocidade, etc...
//    Enemy(int x1, int y1,int _tam, int _velocity){
//      //xPosition = x1;
//      //yPosition = y1;
//      velocity = _velocity;
//      tam = _tam;
//      ellipse(x1, y1, tam, tam);
//      DDA(x1, y1);
//    }
  
  
  
//  //update move (por enquanto)
//  public void update(){
    
//    if(i == moveX.length ) {
//      DDA(moveX[i], moveY[i]);
//      i=1;  
//    }
           
//    //desenha o inimigo na posição:
//    ellipse(moveX[i], moveY[i], tam,tam);
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
//    int [] moveX = new int[len];
//    int [] moveY = new int[len];
    
//    for (int aux=0; aux<moveX.length; aux++) {
//      moveX[aux] = moveY[aux] = 0;  
//    }
      
//    while (i <= len) {
  
//      x += dx;
//      y += dy;
//      moveX[i] = int(x);
//      moveY[i] = int(y);
//      i++;
//    }
//   }

//}
//class Move{

//  int [] moveX;
//  int [] moveY;



//  void clean(int [] moveX, int moveY[]){

//    int [] moveX;
//    int [] moveY;



//    }


//  }
