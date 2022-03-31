int sensorFlag0 = 0;
int sensorFlag1 = 0;


void input() {


  for (int i=0; i < MAX_BALLS; i++) {
    /////////////////////////////////////////加速度センサ用///////////////////////////////////////////////////
    if (ballType[i] == 0) {
      if ((ballX[i] - width/2)*(ballX[i] - width/2) + (ballY[i] - height/2)*(ballY[i] - height/2) < 10000) {
        if (accelerationX*accelerationX*accelerationY*accelerationY>1000000) {
          if (ballInput[i] == false) {

            ballVX[i] = accelerationX*20/255;      //振った方向にボールが飛ぶ(振る速さでボールの速度が変わる)
            ballVY[i] = -(accelerationY+10)*20/255;
            ballInput[i] = true;
            fill(0);
            textSize(50);
            text("GOOD!!!", 610, 1070);
                se1.trigger();
          }
        }
      }
      if ((ballX[i] - width/2)*(ballX[i] - width/2) + (ballY[i] - height/2)*(ballY[i] - height/2) > 90000 && ballInput[i]==false) {
        ballFlag[i] = false;
      }
    }
    /////////////////////////////////////////////手を離す///////////////////////////////////////////////////
    if (ballType[i] == 1) {
      if (ballRadius[i] < 30 && ballInput[i] == false) {
        if ( sensor0<s0m) {              //手をあげると反応する
          fill(0);
          textSize(50);
          text("GOOD1!!!", 610, 1070);
              se2.trigger();
          ballFlag[i] = false;
          ballInput[i] = true;
          
        }
      }
      if (ballRadius[i] < 3&& ballInput[i]==false) {  //手をあげられなかったらブロックが追加される
        ballFlag[i] = false;
        for (int k=0; k<MAX_BLOCKS; k++) {
          if (blockHitFlag[k]==true) {
            blockHitFlag[k] = false;
            return;
          }
        }

      }
     
    }
    ////////////////////////////////////////手を振る///////////////////////////////////////////////////////////////////
    if (ballType[i] == 2) {    //左から右に手を動かす
      if ( sensor0 <= s0m && sensor1 >=s1m || sensorFlag0 == 1)  sensorFlag0 =1 ;
      if ( sensor0 >= s0m && sensor1 >=s1m && sensorFlag0 == 1) {
        ballVX[i] = 5;
        sensorFlag0 = 0;
        fill(0);
        textSize(50);
        text("GOOD2!!!", 610, 1070);
            se3.trigger();
      }
    }
    if (ballType[i] == 3) {        //右から左に手を動かす
      if ( sensor0 >= s0m && sensor1 <=s1m || sensorFlag1 == 1)  sensorFlag1 =1 ;
      if ( sensor0 >= s0m && sensor1 >= s1m && sensorFlag1 == 1) {
        ballVX[i] = -5;
        sensorFlag1 = 0;
        fill(0);
        textSize(50);
        text("GOOD3!!!", 610, 1070);
            se3.trigger();
      }
    }
  }
}


//////////////////////////////////フォトリフレクタの微調整用、値がぶれまくる///////////////////////////////
//float s0min = 255;
//float s0max =0;
//float s1min = 255;
//float s1max =0;
float s0m =65;
float s1m =44;

//void sensorAjust() {
//  if (sensor0 < s0min) s0min = sensor0;
//  if (sensor0 > s0max) s0max = sensor0;
//  if (sensor1 < s1min) s1min = sensor1;
//  if (sensor1 > s1max) s1max = sensor1;
//  s0m=(s0min+s0max)/2;
//  s1m=(s1min+s1max)/2;
//}
