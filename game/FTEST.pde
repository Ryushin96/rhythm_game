/*プラグインについて、オーディオ、シリアル通信についてのプラグインを入れています。*/



/////////////////////////////////シリアル通信////////////////////////////////////
import processing.serial.*;
Serial serial;
float accelerationX, accelerationY, accelerationZ, sensor0, sensor1;    // 受け取る変数を宣言
////////////////////////////////////////////////////////////////////////////////
import ddf.minim.*;
Minim minim;
AudioPlayer bgm,bgmt;
AudioSample se1,se2,se3;
PImage back, back1;
int menu = 0;
int time =0;
int s;


void setup() {
  serial = new Serial(this, "COM3", 115200);//シリアル通信
  size(2000, 2000);
  PFont font = createFont("Meiryo", 50);
textFont(font);
  arrangeBlocks();    // Blockの配置
  arrangeBall();      //Ballの配置
  minim = new Minim(this);
  bgm = minim.loadFile("./data/sound/bgm1.mp3");//サウンド関連
  bgmt = minim.loadFile("./data/sound/bgm.mp3");
  se1 = minim.loadSample("./data/sound/se1.mp3");
  se2 = minim.loadSample("./data/sound/se2.mp3");
  se3 = minim.loadSample("./data/sound/se3.mp3");
  back1 = loadImage ("./data/picture/back1.jpg");//背景画像
  back1.resize(2000, 2000);
  back = loadImage ("./data/picture/back.jpg");
  back.resize(2000, 2000);
  


  //rectMode(CENTER);
}

void draw() {
  //sensorAjust();
  blocks=0;            //ブロックの数を数える
  for (int i=0; i < MAX_BLOCKS; i++) {
    if (blockHitFlag[i] == true) blocks++;
  }
  if (menu == 0) {      //ゲームメニュー画面
        bgmt.play();
    image(back1, 0, 0);
    fill(0, 255, 255);
    rect(600, 1000, 200, 100);
    fill(255, 0, 0);
    rect(1200, 1000, 200, 100);
    fill(200,200,200);
    rect(250, 150, 1700, 170);
    fill(250,40,40);
    textSize(150);
    text("音ゲーでブロック崩し！", 300, 300);
    fill(0);
    textSize(50);
    text("START", 610, 1070);
    text("EXIT", 1250, 1070);
    s=millis();
    if (mousePressed) {
        bgmt.pause();
      if (mouseX > 600 && mouseX < 800 && mouseY > 1000 && mouseY <1100) menu = 1;
      if (mouseX > 1200 && mouseX < 1400 && mouseY > 1000 && mouseY <1100) exit();
    }
  }

  if (menu == 2) {    //ゲーム終了画面

    image(back1, 0, 0);
        fill(200,200,200);
    rect(250, 250, 1700, 120);
    textSize(100);
    fill(255,0,0);
    text("YOUR SOCORE  "+blocks, 510, 370);
    fill(0, 255, 255);
    rect(600, 1000, 250, 100);
    fill(255, 0, 0);
    rect(1200, 1000, 200, 100);
    fill(0);
    textSize(50);
    text("RESTART", 610, 1070);
    text("EXIT", 1250, 1070);
    s=millis();
    if (mousePressed) {
      if (mouseX > 600 && mouseX < 850 && mouseY > 1000 && mouseY <1100) {
        menu = 1;
        arrangeBlocks();    // Blockの配置
        arrangeBall();
        minim = new Minim(this);
        bgm = minim.loadFile("./data/sound/bgm1.mp3");
      }
      if (mouseX > 1200 && mouseX < 1400 && mouseY > 1000 && mouseY <1100) exit();
    }
  }
  if (menu == 1) {    //ゲーム画面
    time = millis()-s;//ゲーム画面の時間にそろえる
    bgm.play();
    image(back, 0, 0);
    ellipse(width/2, height/2, 100, 100);
    textSize(100);
    text("blocks  "+blocks, 100, 100);

    input();        //アルディーノの動作を反映
    musical_score();//譜面。ノーツの種類や数を指定
    moveBall();    //ボールの動き
    moveBlocks();  //ブロックの動き
    checkCollision();//当たり判定
    drawBall();      //描画
    drawBlocks();
  }
  println("sensor: " + sensor1 + " "+ sensor0);
  println(accelerationX + " " + accelerationY + " " + accelerationZ);
}


/*********************************************
 受信部分の処理
 *********************************************/
char[] lineBuffer = new char[512];
int currentIndex;
final int DATA_SIZE = 5;  // 最大データサイズ
void serialEvent(Serial serial) {
  while (serial.available() > 0) {  
    /* 区切りの改行文字が来るまで1文字ずつ読み取る */
    char c = serial.readChar();
    if ( c != '\n' ) {
      lineBuffer[currentIndex] = c;
      currentIndex++;
      continue;
    }


    /* 改行文字が来たら受信した文字列をスペース区切りで分割 */
    currentIndex = 0;    
    String s = new String(lineBuffer);
    String[] data = s.split(" ");    
    if (data == null || data.length != DATA_SIZE) {
      continue;
    }
    /* 文字列を変数に変換する */
    try {
      accelerationX = Float.parseFloat(data[0]);  // x軸
      accelerationY = Float.parseFloat(data[1]);  // y軸ニュートラル補正
      accelerationZ = Float.parseFloat(data[2]);  // z軸使わない
      sensor0 = Float.parseFloat(data[3]);  // フォトリフレクタ右
      sensor1 = Float.parseFloat(data[4]);  // フォトリフレクタ左
    } 
    catch (NumberFormatException e) {
      continue;
    }
  }
}
