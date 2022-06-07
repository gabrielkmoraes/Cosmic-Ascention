  
import java.util.*;
import java.awt.Point;
import ddf.minim.*;  



Minim gerenciador;   // Declaração de um objeto da classe Minim. Será utilizada para controlar os áudios do programa.
AudioPlayer music, play_effect, fight, enemyShoot, playerShoot, gameOver;  // Para cada áudio utilizado no software é necessário uma variável do tipo AudioPlayer.size(400, 400);
// Indica qual imagem do sprite será desenhado.
// Quando true a img1 do sprite é desenhado.
// Quando false a img2 do sprite é desenhado.


int estado =1;
//1 = menu
//2 = iniciar jogo
//3 = gameOver
//4 = créditos
//5 = Pausar



boolean muted =false;
float x = 150;   // Variáveis utilizadas para definir a coordenada onde o sprite será desenhado.
float y = 150;   // Variáveis utilizadas para definir a coordenada onde o sprite será desenhado.
int tempo;   // Variável utilizada para armazenar o tempo de execução em milissegundos
PImage img, img1, img2, img3, img4, heart1, heart2, gameOverBG, creditoBG; //Variáveis utilizadas para armazenar os sprites.
PImage img_enemy, img_player;
PFont font;


int op = 0;

boolean start =false;


ArrayList<Shot> shots = new ArrayList<Shot>();
int xspeed = 5;
int velocity = 5;
int posX, posY;
int randomNumber;
long startTime =0, finishTime, timeElapsed;
int iterator  = 0;
int [] moveX = new int[50000];
int [] moveY = new int [50000];
int playerHit, enemyHit;
int enemyY, enemyX = 30, playerX, playerY = 540;



//Enemy enemy = new Enemy(0, 0, 30, velocity);
//Player player1 = new Player(10);
PShape player, enemy, life;

//objeto de classe Menu.
Menu credit;
//boolean credit = false;


void setup() {

  size(500, 600);
  img = loadImage("menu.jpg");
  
  //img.resize(500, 600);  // faz a imagem se ajustar ao background
  //background(img);

  heart1 = loadImage("heart1.png");
  heart2 = loadImage("heart2.png");
  img = loadImage("menu.jpg");  // imagem fundo background menuv
  img1 = loadImage("icone1.png");  // sprite botao de som ativo musica menu
  img2 = loadImage("icone2.png");  // sprite boao de som desativado musica menu
  img_player = loadImage("player.png");
  img_enemy = loadImage("enemy.png");
  gameOverBG = loadImage("gameOverBackground.png");
  creditoBG = loadImage("creditos2.png");
  img3 = loadImage("space_bg.png");
  img3.resize(500,600);
  img4 = loadImage("creditos2.png");
  img4.resize(500,600);
  
  
  gerenciador = new Minim(this);
  music = gerenciador.loadFile("musicamenu.mp3");
  play_effect = gerenciador.loadFile("start-level.wav");
  fight = gerenciador.loadFile("fight.mp3");
  enemyShoot = gerenciador.loadFile("enemyShoot.mp3");
  playerShoot = gerenciador.loadFile("playerShoot.mp3");
  gameOver = gerenciador.loadFile("GameOver.mp3");
  fight.rewind();
  music.rewind();
  music.play();



}

void draw() {

  if(estado ==1) iniciarMenu();
  else if (estado ==2) iniciarJogo();
  else if (estado ==3) gameOver();
  else if (estado ==4) iniciarCreditos();
  

 }

  
//--------------------------------------------------- Código do menu---------------------------------------------------//


//Quando for pressionado alguma tecla

void keyPressed() {
  //movimentação do personagem
  if(estado == 1){
    if (keyCode == 39 && op == 3) op = 0;
  
    if (keyCode == 39)  op++;
    
    if(keyCode == 32 && op ==1){
      music.pause();
      play_effect.play();
      op = 5;
      delay(5000);
      //chama para iniciar o jogo
      estado =2;
    }
    if(keyCode == 32 && op ==3) estado =4;
  }
   if(start){
    if (keyCode == 39) playerX += 5;
    else if (keyCode == 37) playerX -= 5;
    if (playerX +40 > width - 5) playerX = width-40;
    else if (playerX < 0) playerX = 0;
  //Para alterar a dificuldade, basta aumentar esse valor
   if(timeElapsed > 1250){
    if (keyCode == 32) {
      shots.add(new Shot(playerX, 580, true));
      playerShoot.play(0);
      startTime = System.currentTimeMillis();
      }
    }
    finishTime = System.currentTimeMillis();
    timeElapsed = finishTime - startTime;
    
  }
  //sair dos créditos e voltar para o menu
  if(estado ==4 && keyCode == 10){
    estado =1;
    op =0;  
  }
}



void mouseClicked() {
  if((mouseX > 430 && mouseX < 470) &&
     (mouseY >530 && mouseY <570)){
      muted = !muted;
  } 
} 


public void iniciarJogo(){
  start = true;
  fight.play();
  img3.resize(500, 600);  // faz a imagem se ajustar ao background
  background(img3);

  //desenha o numero de hits do player e do inimigo


  enemy = createShape(RECT, 0 , 0, 40,40);
  enemy.setStroke(false);
  enemy.setTexture(img_enemy);
  shape(enemy, enemyX, 110);  
  enemyX = enemyX + xspeed;



  //Inverte o sentido da movimentação do inimigo quando ele bater nos limites da tela
  if(enemyX > height -120 || enemyX < 10){
    randomNumber = randomNumber();
    xspeed = xspeed * (-1);
    }

  //Inimigo realiza o tiro
  atirou(enemyX, velocity, randomNumber);

  //Desenha o player
  player = createShape(RECT, 0, 0,50,50);
  player.setStroke(false);
  player.setTexture(img_player);
  shape(player, playerX, playerY); 
  

 
  //Incrementa o valor de i para cada objeto de shot dentro da arraylist shots
  for (int x =0; x<shots.size(); x++) {
    shots.get(x).update(enemyX, 110, playerX, height-5);
  }
  
  life = createShape(RECT, 0, 0, 20, 20);
  life.setStroke(false);
  life.setTexture(heart1);
  
   
  switch(playerHit){
    case 0:
    shape(life, 0, 0);
    shape(life, 50, 0);
    shape(life, 100, 0);
  
    case 1:
      shape(life,0,0);
      shape(life,50,0);
      life.setTexture(heart2);
      shape(life, 100, 0);


      break;
    case 2:
      shape(life,0,0);
      life.setTexture(heart2);
      shape(life,50,0);
      shape(life, 100, 0);
      break;
    case 3:
      life.setTexture(heart2);
      shape(life,0,0);
      shape(life,50,0);
      shape(life, 100, 0);
      //chama o gameOver();
      estado =3;
      start = false;
      break;
  }
  
  
}
  
 
//39 --> Direita
// 37 --> Esq
//32 --> espaço

//keycode W,A,S,D = 87,65,83, 63




//recebe o valor de enemyX, o valor de random e a velocidade do tiro
public void atirou(int enemyX, int velocity, int randomNumber) {
  int yPos = 110;
  if (enemyX == randomNumber) {
    posX = enemyX;
    //Chama um objeto passando a posição do tiro de x, de y
    //(estáico no momento para 110) e a velocidade do tiro
    shots.add(new Shot(posX, yPos, false));
    enemyShoot.play(0);
    
  }
}


/*
 /--------------------------------------------------------------- FUNÇÕES  ---------------------------------------------------------------/
 */

int randomNumber() {
  int tiro =1;
  Random rand = new Random();
  while (tiro%10!=0) {
    tiro = rand.nextInt(0, width-30);
  }

  return tiro;
}



public void iniciarMenu(){
  

  img.resize(500,600);
  background(img);
  imageMode(CENTER);
  image(img1, 450, 550, 30, 30); //sprites de audio
    //if(gameOver){}
  
  PFont font;
  font = createFont("Pixeled.otf", 25);
  textFont(font);
  

  if(muted){
    imageMode(CENTER);
    image(img2, 450, 550, 30, 30); //sprites de audio
     music.pause();
  }else{  
    imageMode(CENTER);
    image(img1, 450, 550, 30, 30); //sprites de audio
    music.play();
  }



  //println("Keycode Pressionado:" + keyCode);

  //BOTÕES DO MENU
  stroke(0, 408, 612);
  strokeWeight(3);
  
  
  //BOTÕES DO MENU
  fill (0, 0, 0);
  rect(50, 410, 150, 40);  //iniciar jogo (coord.X,coord.Y,comprimentoX,alturaY)
  rect(180, 500, 150, 40); //CREDITOS (coord.X,coord.Y,comprimentoX,alturaY)
  rect(310, 410, 150, 40); // DIFICULDADE (coord.X,coord.Y,comprimentoX,alturaY)
  

  //TITULO DO JOGO (NOME DO JOGO)
  fill(0, 408, 612);
  textSize(25);
  text(" COSMIC ASCENSION", 70, 140);

  
  switch(op){
    case 0 :
      fill(255);
      textSize(14);
      text(" INICIAR JOGO", 53, 440);
      text(" DIFICULDADE", 315, 440);
      text("CREDITOS", 205, 530);
      break;
      
    case 1:
      fill(255);
      textSize(14);
      text(" INICIAR JOGO", 53, 440);
      fill(0);
      text(" DIFICULDADE", 315, 440);
      text("CREDITOS", 205, 530);
      break;
      
   case 2:
     fill (255);
     textSize(14);
     text(" DIFICULDADE", 315, 440);
     fill(0);
     text(" INICIAR JOGO", 53, 440);
     text("CREDITOS", 205, 530);

     break;
     
    case 3: 
     fill (255);
     textSize(14);
     text("CREDITOS", 205, 530);
     fill(0);
     text(" DIFICULDADE", 315, 440);
     text(" INICIAR JOGO", 53, 440);
     break;
    }    
  

}



public void iniciarCreditos(){
  creditoBG.resize(500,600);
  background(creditoBG); 
  
  //-----------------creditos-------------------
  fill(0, 408, 612);
  textSize(40);
  text(" CRÉDITOS ", 85, 100);
  //-------------TEXTO DO CREDITO---------------
  fill(255, 255, 255);
  textSize(16);
  text("  O PROJETO É UM JOGO ENTRE ", 45, 150);
  text("  PESSOA E COMPUTADOR. ", 45, 175);
  textSize(25);
  text("            HISTÓRIA ", 45, 240);
  textSize(16);
  text(" O TEMPO É MARCADO PELA GUERRA.", 45, 300);
  text(" TEMPO ESSE QUE A TECNOLOGIA , . ", 45, 330);
  text(" AVANÇA. A GUERRA É NO ESPAÇO.  ", 45, 360);
  text(" QUE VENÇA O MELHOR. ", 45, 390);
  
  fill(255, 255, 255);
  textSize(13);
  text(" O OBJETIVO DO JOGO É DESVIAR ", 45, 430);
  text(" DE TODOS OS PREJETEIS QUE O  ", 45, 450);
  text(" INIMIGO DISPARAR, E DESTRUIR O INIMIGO. ", 45, 470);
  text("", 45, 500);
  
  
  
  //-----------criadores do jogo---------------
  textSize(10);
  fill(0, 408, 612);
  text("CRIADORES DO JOGO ", 174, 520);
  fill(255, 250, 255);
  text("ERICK DA CUNHA CEZAR" ,164, 560);
  text("GABRIEL KEGLEVICH MORAES ", 141, 580);
  textSize(5);
  text("PRESSIONE ENTER PARA VOLTAR AO MENU", 165, 590 );
}

//tela de game over
public void gameOver(){
  //Voltar a trabalhar nessa parte
  estado = 3;
  background(0);
  fight.pause();
  gameOver.play();
  gameOverBG.resize(500,600);
  background(gameOverBG);
  textSize(54);
  text("  GAME OVER ", 180, 300);
  println("Na tela do gameOver");
  delay(13500);  
  println("Voltei para o menu");
  
  //volta para o menu
  estado = 1;
  gameOver.play(0);
  gameOver.pause();
  reset();

}



public void reset (){
  
  op=0;
  enemyHit = 0;
  playerHit = 0;
  for (int x =0; x<shots.size(); x++) {
    shots.remove(x);
  }
  enemyX = 0;
  playerX = 0;

}

/*
 /--------------------------------------------------------------- CLASSES  ---------------------------------------------------------------
 */



//---------------------------------INICIAR CREDITOS--------------------------------------------
  
 //public void iniciarCreditos(){
   
 //  credit.creditos(); 
 //  fight.play();
 //  img4.resize(500, 600);  // faz a imagem se ajustar ao background
 //  background(img4);
  
 // /*size (500, 600);
 // img = loadImage("creditos2.png");
 // img.resize(500, 600);  // faz a imagem se ajustar ao background
 // background(img);
 // */
  
 // }
  
  

/* Problemas do código
 - adicionar um timer para os tiros
 - arrumar a posição do tiro
 - Arrumar o hit mark
 - fazer a tela de game over
 
 */
 
 
  
