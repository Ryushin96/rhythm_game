/**************************************
    Ballのソースコード
 **************************************/
 final int MAX_BALLS = 30;
float[] ballX = new float[MAX_BALLS];
float[] ballY = new float[MAX_BALLS];
float[] ballVX = new float[MAX_BALLS];
float[] ballVY = new float[MAX_BALLS];
float[] ballRadius = new float[MAX_BALLS];
float[] ballVRadius = new float[MAX_BALLS];
float[] pballX = new float[MAX_BALLS];
float[] pballY = new float[MAX_BALLS];
boolean[] ballFlag = new boolean[MAX_BALLS]; 
boolean[] ballInput = new boolean[MAX_BALLS]; 
int[] ballType = new int[MAX_BALLS];

void arrangeBall(){
  int i = 0;
  while ( i < MAX_BLOCKS ) {
    ballFlag[i] = false;
    ballInput[i] = false;
    ballRadius[i] = 20.0f;
    ballVRadius[i] = 0;
    ballVX[i]=0;
    ballVY[i]=0;
    i++;
  }
}

////////////////////////////////////////////////////ボールの種類を選択////////////////////////////////////
void startBall(int t,int n, int a,float b){
  ballFlag[n] = true;
  ballType[n] = t;
  if(t == 0){
  if(a==0){                //下から
  ballX[n] = width/2;
  ballY[n] = height/2 + 300;
  ballVX[n]= 0;
  ballVY[n]= -b;
  }
  if(a==1){                //右から
  ballX[n] = width/2 + 300;
  ballY[n] = height/2;
  ballVX[n]= -b;
  ballVY[n]= 0;
  }
  if(a==2){                //上から
  ballX[n] = width/2;
  ballY[n] = height/2 - 300;
  ballVX[n]= 0;
  ballVY[n]= b;
  }
  if(a==3){                //左から
  ballX[n] = width/2 - 300;
  ballY[n] = height/2;
  ballVX[n]= b;
  ballVY[n]= 0;
  }
  }
  if(t == 1){              //手を離す
    ballX[n] = width/2;
    ballY[n] = height/2;
    ballRadius[n] = a;
    ballVRadius[n] = b;
  }
    if(t == 2){              //手を右
    ballX[n] = 100;
    ballY[n] = height/2;

  }
    if(t == 3){              //手を左
    ballX[n] = 1900;
    ballY[n] = height/2;
    ballVX[n] = 0;
    ballVY[n] = 0;
  }
}
//////////////////////////////////////////////////////////////////////////////////////////////////

/* ボールの移動 */
void moveBall(){
  for(int i=0; i < MAX_BALLS; i++){
  ballX[i] = ballX[i] + ballVX[i];
  ballY[i] = ballY[i] + ballVY[i];
  ballRadius[i] = ballRadius[i] + ballVRadius[i];
  }
} // moveBall

/* ボールの描画 */
void drawBall(){
    int i = 0;
  while ( i < MAX_BALLS ) {
    if(ballFlag[i] == true){
      fill(55, 130, 100);
      ellipse(ballX[i],ballY[i],ballRadius[i]*2,ballRadius[i]*2);
    }
    i++; 
  }
}
