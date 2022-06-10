
  /*--------------------------------------------- COSMIC ASCENTION -----------------------------------------------------------------------/
  /                                                                                                                                       /
  /                                                                                                                                       /
  / Esse projeto surgiu de um trabalho da matéria de processamento de imagens e computação gráfica lecionada por José Guilherme Picolo.   /
  / Esse jogo foi inspirado nos clássicos space shooter que tinham nos fliperamas nos anos 90.                                            /
  / Aproveite e caso tenha algum feedback, sinta-se à vontade para notificar Gabriel Keglevich através do email :                         /
  / gabrielkmoraes@gmail.com ou      gitHub: github.com/gabrielkmoraes                                                                    /
  /                                                                                                                                       /
  /                                                                                                                                       /
  /                                                BOM JOGO  !!!                                                                          /
  /                                                                                                                                       /
  /                                         Créditos: Gabriel Keglevich Moraes                                                            /
  /                                              Erick da Cunha Cézar                                                                     /
  /                                                                                                                                       /
  / ______________________________________________________________________________________________________________________________________*/                                                                                                                                       
  
  
import java.util.*;
import java.awt.Point;
import ddf.minim.*;  


//Gerenciador de áudio
Minim gerenciador;   
AudioPlayer menuSong, startPlayerSound, fightSong, enemyShootSound, playerShootSound, gameOverSong, endSong;


//Recursos de background, skins e fonte do texto
PShape player, enemy, life;
PImage menuBG, somIMG, semSomIMG, fightBG, vidaCheiaIMG, vidaVaziaIMG, gameOverBG, creditosBG, winBG; //Variáveis utilizadas para armazenar os sprites.
PImage inimigoIMG, jogadorIMG;
PFont font;



/*
/
/ Permite alternar entre as telas sendo elas:
/ 1 = menu
/ 2 = iniciar jogo
/ 3 = gameOver
/ 4 = créditos
/ 5 = tela caso o player ganhe
/ 6 = seletor de dificuldades
/
*/

int estado =1;


// Variaveis de posição e arraylist dos tiros
ArrayList<Shot> shots = new ArrayList<Shot>();
int enemyY, enemyX = 30, playerX, playerY = 540;
int xspeed;
int posX, posY;
int randomNumber;


//Variáveis de pontuação
int playerHit, enemyHit;

//Variáveis de controle de tempo
long startTime =0, finishTime, timeElapsed;
long endScreenStart =0, endScreenNow;

//Variáveis para controle de transição entre as telas
boolean start =false, endScreen;
int op = 0;

//Dificuldade
int shootTime, difficulty =1, shootVelocity, velocidadePlayer;


//Controle do áudio
boolean muted =false;




void setup() {
  //Tamanho da imagem
  size(500, 600);
  //Recursos (skins, background, etc...)
  menuBG = loadImage("data/Imagens/menuBackground.jpg");
  vidaCheiaIMG = loadImage("data/Imagens/vidaCheia.png");
  vidaVaziaIMG = loadImage("data/Imagens/vidaVazia.png");
  somIMG = loadImage("data/Imagens/som.png");  // sprite botao de som ativo musica menu
  semSomIMG = loadImage("data/Imagens/semSom.png");  // sprite boao de som desativado musica menu
  jogadorIMG = loadImage("data/Imagens/playerSkin.png");
  inimigoIMG = loadImage("data/Imagens/enemySkin.png");
  gameOverBG = loadImage("data/Imagens/gameOverBackground.png");
  winBG = loadImage("data/Imagens/winBG.jpg");
  creditosBG = loadImage("data/Imagens/creditos2.png");
  fightBG = loadImage("data/Imagens/fightBG.png");

  ///Redimensionamento das imagens que serão usados como background
  menuBG.resize(500,600);
  fightBG.resize(500,600);
  creditosBG.resize(500,600);

  //Gerenciador de áudio
  gerenciador = new Minim(this);
  menuSong = gerenciador.loadFile("musicMenu.mp3");
  startPlayerSound = gerenciador.loadFile("start-level.wav");
  fightSong = gerenciador.loadFile("fight.mp3");
  enemyShootSound = gerenciador.loadFile("enemyShoot.mp3");
  playerShootSound = gerenciador.loadFile("playerShoot.mp3");
  gameOverSong = gerenciador.loadFile("GameOver.mp3");
  endSong = gerenciador.loadFile("ending-Song.mp3");
  
  //Repete o som
  fightSong.rewind();
  menuSong.rewind();
  menuSong.play();
  
  //Configura a dificuldade padrão para 1 (EASY)
  selecionarDificuldade();

  PFont font;
  

}

void draw() {
  //estado realiza o controle de qual tela deverá ser exibida e então chama a função correspondente   
  if(estado ==1) iniciarMenu();
  else if (estado ==2) iniciarJogo();
  else if (estado ==3) gameOver();
  else if (estado ==4) iniciarCreditos();
  else if (estado ==5) winScreen();
  else if (estado ==6) selecionarDificuldade();

 }

  
//Quando for pressionado alguma tecla

void keyPressed() {
  
  // Seleção das opções no menu inicial ou na tela de dificuldade
  
  if(estado == 1 || estado ==6){
  
    if ((keyCode == 39 || keyCode == 40) && op == 3 ) op = 0;
         
    if ((keyCode == 39 || keyCode == 40))  op++;
    
    //Inicia o jogo
    if(keyCode == 32 && op ==1 && estado ==1){
      menuSong.pause();
      startPlayerSound.play();
      op = 5;
      delay(5000);
      estado =2;
    }
    
    
    //Abre a tela de menu
    if(keyCode == 32 && op ==2 && estado == 1){
      op =0;
      estado = 6;
    }
      
    //Abre os créditos
    if(keyCode == 32 && op ==3 && estado ==1) estado = 4;
    
  }
  
  //Sair dos créditos/selação da dificuldade e volta para o menu inical  
  if(estado == 6 && keyCode == 10) estado =1 ;
  if(estado == 4 && keyCode == 10){
      estado =1;
      op =0;  
    }
  
  
  //Quando iniciar o jogo (Mover para dentro de iniciarJogo();
   if(start){
      if (keyCode == 39) playerX += velocidadePlayer;
      else if (keyCode == 37) playerX -= velocidadePlayer;
      if (playerX + 40 > width - velocidadePlayer) playerX = width-40;
      else if (playerX < velocidadePlayer) playerX = 0;


    
    //Limita a quantidade de tiros do player
     if(timeElapsed > shootTime){
        if (keyCode == 32) {
          shots.add(new Shot(playerX, 580, true, 1));
          playerShootSound.play(0);
          startTime = System.currentTimeMillis();
        }
      }
        finishTime = System.currentTimeMillis();
        timeElapsed = finishTime - startTime;
    }
}



void mouseClicked() {
  //Mutar a música
  if((mouseX > 430 && mouseX < 470) &&
     (mouseY >530 && mouseY <570)){
      muted = !muted;
  } 
} 



/*
/ Função que é chamado dentro de void draw para desenhar
/ a tela de jogo, o inimigo, os tiros e o player
*/
public void iniciarJogo(){
  start = true;
  fightSong.play();
  background(fightBG);





  //Desenha o inimigo e adiciona uma imagem sobre a forma dele
  enemy = createShape(RECT, 0 , 0, 40,40);
  enemy.setStroke(false);
  enemy.setTexture(inimigoIMG);
  shape(enemy, enemyX, 110);  
  enemyX += xspeed;


  
  //Inverte o sentido da movimentação do inimigo quando ele bater nos limites da tela
  //e chama o método randomNumber para gerar um novo valor aleatório para o inimigo atirar
  
  if(enemyX > height - 120 || enemyX < 10){
    randomNumber = randomNumber();
      xspeed = xspeed * (-1);
    }
    

  //Inimigo realiza o tiro
  atirou(enemyX, shootVelocity, randomNumber);

  //Desenha o player
  player = createShape(RECT, 0, 0,50,50);
  player.setStroke(false);
  player.setTexture(jogadorIMG);
  shape(player, playerX, playerY); 
  
  //Atualiza as posições de tiro de cada objeto Shot
  for (int x =0; x<shots.size(); x++) {
    shots.get(x).update(enemyX, 110, playerX, height-5);
  }
  
  //Desenha e exibe a vida do player
  life = createShape(RECT, 0, 0, 20, 20);
  life.setStroke(false);
  life.setTexture(vidaCheiaIMG);
  
  //Altera de acordo com a quantidade de tiro que o atingiu
  switch(playerHit){
    case 0:
    shape(life, 0, 0);
    shape(life, 50, 0);
    shape(life, 100, 0);
  
    case 1:
      shape(life,0,0);
      shape(life,50,0);
      life.setTexture(vidaVaziaIMG);
      shape(life, 100, 0);
      break;
    case 2:
      shape(life,0,0);
      life.setTexture(vidaVaziaIMG);
      shape(life,50,0);
      shape(life, 100, 0);
      break;
    case 3:
      life.setTexture(vidaVaziaIMG);
      shape(life,0,0);
      shape(life,50,0);
      shape(life, 100, 0);
      //chama o gameOver();
      estado =3;
      start = false;
      break;
  }
  
  //Quando o inimigo for derrotado:
  if(enemyHit == 10) {
    background(0);
    estado =5;
  }
  
}
  

/*
/ Função que fará o inimigo atirar
*/

public void atirou(int enemyX, int shootVelocity, int randomNumber) {
  //O inimigo fica fixo na seguinte posição
  int yPos = 110;

  //Só atira quando o inimigo chegar na posição de realizar o tiro
  if (enemyX == randomNumber) {
    posX = enemyX;
    shots.add(new Shot(posX, yPos, false, shootVelocity));
    enemyShootSound.play(0);
  }
}


/*
/ Gera um valor aleatório para o tiro.
/ Caso queira aumentar a dificuldade, basta alterar a função para aumentar
/ a cadência de tiros do inimigo.
*/

public int randomNumber() {
  int tiro =1;
  Random rand = new Random();
  while (tiro%5!=0) {
    tiro = rand.nextInt(0, width-30);
  }
  return tiro;
}


/*
/ Função que iniciar e desenha o menu
*/

public void iniciarMenu(){
  
  background(menuBG);
  imageMode(CENTER);
  image(somIMG, 450, 550, 30, 30); 
  
  //Se estiver mutado
  if(muted){
    image(semSomIMG, 450, 550, 30, 30); //sprites de audio
     menuSong.pause();
  }else{  
    image(somIMG, 450, 550, 30, 30); //sprites de audio
    menuSong.play();
  }

  //Cria um novo estilo de fonte para ser aplicado por todo o código
  font = createFont("Pixeled.otf", 25);
  textFont(font);
  

  //Desenha os botões do menu
  stroke(0, 408, 612);
  strokeWeight(3);
  fill (0, 0, 0);
  rect(50, 410, 150, 40);  //INICIAR JOGO 
  rect(180, 500, 150, 40); //CREDITOS 
  rect(310, 410, 150, 40); // DIFICULDADE 
  

  //TITULO DO JOGO (COSMIC ASCENSION)
  fill(0, 408, 612);
  textSize(25);
  text(" COSMIC ASCENSION", 70, 140);
  
  //Sinaliza a opção selecionada
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


/*
/Inicia os Créditos
*/

public void iniciarCreditos(){
  background(creditosBG); 
  
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

/*
/ Método para desenhar quando o usuário perder o jogo
*/


//ARRUMAR
public void gameOver(){
  //Voltar a trabalhar nessa parte
  estado = 3;
  fightSong.pause();
  gameOverSong.play();
  background(0);
  background(gameOverBG);
  textSize(54);
  text("  GAME OVER ", 180, 300);
  println("Na tela do gameOver");
  delay(13500);  
  println("Voltei para o menu");

  //volta para o menu
  estado = 1;
  gameOverSong.play(0);
  gameOverSong.pause();
  reset();

}



//ARRUMAR
public void winScreen(){
  estado =5;
  fightSong.pause();
  textSize(8);
  text("Pressione ENTER para voltar ao menu", 140 ,560);
  
  if(keyCode == 13 && estado ==5){
    estado = 1;
    endSong.pause();
  }
  
  endSong.play();
  winBG.resize(500,600);
  background (winBG);


}

/*
/ Método para redefinir todos os valores das variáveis do jogo
*/
public void reset (){
  
  op=0;
  enemyHit = 0;
  playerHit = 0;
  enemyX = 0;
  playerX = 0;
  
  //remove todos os tiros da tela
  for (int x =0; x<shots.size(); x++) {
    shots.remove(x);
  }
  
  
}


/*
/ Método que faz a seleção das dificuldades e configura elas
*/
public void selecionarDificuldade(){

  background(menuBG);
  imageMode(CENTER);
  
  font = createFont("Pixeled.otf", 25);
  textFont(font);
  background (0);
  textSize(20);
  
  fill(0, 408, 612);
  text(" SELECIONE A DIFICULDADE ",40, 140);
  noFill();
  stroke(0, 408, 612);
  strokeWeight(3);
  
  //Desenha as opções
  rect(60, 240, 360, 40);
  rect(60, 300, 360, 40);
  rect(60, 360, 360, 40);
  
  fill(255);
  textSize(8);
  text("Pressione ENTER para selecionar", 140 ,560);
  
  
  
  //Sinaliza as opções de dificuldade/desenha elas
  textSize(16);
  
  switch(op){  
   case 0:
      fill(255);
      text("EASY", 210, 270);
      text("MEDIUM", 190,330);
      text("HARD", 210,390);
      break;
    case 1:
      fill(255);
      text("EASY", 210, 270);
      fill(0);
      text("MEDIUM", 190,330);
      text("HARD", 210,390);
      break;
    case 2:
      fill(255);
      text("MEDIUM", 190,330);
      fill(0);
      text("EASY", 210, 270);
      text("HARD", 210,390);
      break;
    case 3:
      fill(255);
      text("HARD", 210,390);
      fill(0);
      text("MEDIUM", 190,330);
      text("EASY", 210, 270);
      break;
}

  //Seleciona a dificulade
  if (keyCode == 32 && op == 1 ) {
      difficulty = 1;
      op =0;
      estado = 1;
    }
    
    
    if(keyCode == 32 && op == 2) {
      difficulty =  2;
      estado = 6;
      op =0;
      estado =1 ;
  
    }
    
    if (keyCode == 32 && op ==3){
      difficulty = 3;
      estado = 6;
      op =0;
      estado = 1;
    }
  
    //Configura a dificuldade alterando os valores das variáveis
    switch(difficulty){
      case 1:
        xspeed = 5;
        velocidadePlayer = 10;
        shootVelocity = 2;
        shootTime = 500;
        break;
      case 2:
        xspeed = 10;
        velocidadePlayer = 7;
        shootVelocity = 5;
        shootTime = 800;
        break;
      case 3:
        xspeed = 15;
        velocidadePlayer = 3;
        shootVelocity = 8;
        shootTime = 1250;
        break;
    }
}
