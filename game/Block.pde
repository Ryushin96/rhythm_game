final int MAX_BLOCKS = 20;
float[] blockX = new float[MAX_BLOCKS];
float[] blockY = new float[MAX_BLOCKS];
float[] blockAngle = new float[MAX_BLOCKS];
float[] blockWidth = new float[MAX_BLOCKS];
float[] blockHeight = new float[MAX_BLOCKS];
boolean[] blockHitFlag = new boolean[MAX_BLOCKS];

final int BLOCK_ROWS = 12;
final int BLOCK_GAP = 6;

int blocks;



float x = 0;    //横位置
float y = 0;    //縦位置



void moveBlocks() {    //半径500で、角度がフレームごとに変化する。三角関数を使ってブロックが円状に動く
  for (int i = 0; i < MAX_BLOCKS; i++) {
    blockAngle[i] -= 0.01;

    x = cos(blockAngle[i]);
    y = sin(blockAngle[i]);
    blockX[i] = width/2 - blockWidth[i]/2 + x * 500;
    blockY[i] = height/2 - blockHeight[i]/2 + y * 500;

  }
} 


void drawBlocks() {

  for (int i = 0; i < MAX_BLOCKS; i++) {
    if (blockHitFlag[i] == false) {
      fill(255, 0, 40);
      rect(blockX[i] , blockY[i] , blockWidth[i], blockHeight[i]);
    }


  }
} 


void arrangeBlocks() {
  for (int i = 0; i < MAX_BLOCKS; i++) {

    blockAngle[i] = i*TWO_PI/MAX_BLOCKS;
    x = cos(blockAngle[i]);
    y = sin(blockAngle[i]);
    blockWidth[i] = 100.0f;
    blockHeight[i] = 100.0f;
    blockHitFlag[i] = false;
    blockX[i] = width/2 - blockWidth[i]/2 + x * 500;
    blockY[i] = height/2 - blockHeight[i]/2 + y * 500;

  }
} 
