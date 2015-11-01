//aWin, bWin : show, A, B win
//showBlock : show gameboard
//menu
//md5
//help
void showBlock() {
  int i, j, round=0;
  fill(255);
  noStroke();
  rect(248, 0, 640, 640); //game display
  for (i=1; i<12; i++) { //show block!
    for (j=1; j<12; j++) {
      fill(255);
      if (blk[i][j]==1) fill(103, 212, 136); 
      else if (blk[i][j]==2) fill(255, 0, 0);
      else if (blk[i][j]==3) fill(0, 0, 255);
      rect(204+i*57, -44+j*57, 44, 44);
    }
  }
  fill(255);
  rect(204+lastBlockX*57, -44+lastBlockY*57, 44, 44);
  if (blk[lastBlockX][lastBlockY]==2) fill(255, 0, 0);
  else fill(0, 0, 255);
  rect(204+lastBlockX*57, -44+lastBlockY*57, 44, 44, 11);
}

void aWin() {

  fill(255);
  noStroke();
  rect(0, 0, 248, 640);
  fill(255, 0, 0);

  text("A win!!", 124, 300);

  fill(193, 243, 214);     
  rect(0, 540, 248, 100); 
  textSize(60);
  fill(0);     
  text("Replay?", 124, 590);

  fill(193, 243, 214);     
  rect(0, 640, 248, 100); 
  textSize(60);
  fill(0);     
  text("Main Menu", 124, 690);

  if (click==1&&mouseX<248&&mouseY>540) {
    gmod=-200;
    reset();
  }
}

void bWin() {

  fill(255);
  noStroke();
  rect(888, 0, 248, 640);
  fill(0, 0, 255);
  text("B win!!", 1012, 300);

  fill(193, 243, 214);     
  rect(888, 540, 248, 100);
  textSize(60);
  fill(0);     
  text("Replay?", 1012, 590);

  if (click==1&&mouseX>888&&mouseY>540) {
    gmod=-200;
    reset();
  }
}

void reset() {
  statemod=1;
  //block setting
  int i, j;
  for (i=1; i<12; i++)
    for (j=1; j<12; j++)
      blk[i][j]=1;
  // 4 corner of quod is blank
  blk[1][1]=0;
  blk[1][11]=0;
  blk[11][1]=0;
  blk[11][11]=0;


  //time left pannel x,y-coordinate
  timeAx=124;
  timeAy=130;
  timeBx=1012;
  timeBy=130;

  timeCache=0;//time cache, for click delay

  quazA=6;
  quazB=6;
  click=0;
  gmod=-200;
  turn=-1;
}

void help() {

  background(184, 241, 241);
  textSize(120);
  noStroke();
  fill(23, 93, 126);
  textAlign(CENTER, CENTER);
  text("help", width/2, 200);
  textSize(70);
  text("visit 'mileu.ml'", width/2, 350);
  fill(255, 206, 160);
  rect(width/2-140, 460, 280, 70);
  fill(0);
  textSize(48);
  textAlign(CENTER, CENTER);
  text("Back", width/2, 495);
  if (mouseX>(width/2-140)&&mouseX<(width/2+140)) {
    fill(241, 232, 212);
    if (mouseY>460&&mouseY<530) {
      rect(width/2-140, 460, 280, 70);
      if (click==1) {
        gmod=-200;
        click=0;
      }
    }
  }
}