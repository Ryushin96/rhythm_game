void checkCollision(){
  for (int i = 0; i < MAX_BLOCKS; i++){
    for(int k = 0; k< MAX_BALLS; k++){
      if(ballFlag[k] == true){
    if  ( blockHitFlag[i] == false ){
      if ( (ballX[k] - blockX[i])*(ballX[k] - blockX[i]) + (ballY[k] - blockY[i])*(ballY[k] - blockY[i]) < blockWidth[i]*blockWidth[i] + blockHeight[i]*blockHeight[i]){ 
          blockHitFlag[i] = true;    // 当たったことにする
          ballFlag[k]=false;
      }
    }
      }
    }
  }
}
