//v0.6.0b1
//beware for singleAI in ai check time.
void draw() {

  switch(gmod) {

  case -100:
    loadS1(); // loading screne, "click to start"
  case 100:
    loadS2();
    break;

  case -200:
    statM1(); // start menu
  case 200:
    statM2();
    break;

  case -300:
    snglP1(); // singlePlay
  case 300:
    snglP2();
    break;

  case -400:
    snglPai1(); // single Play ai
  case 400:
    snglPai2();
    break;

  case -500:
    snglPvs1(); // single Play 1 vs 1 
  case 500:
    snglPvs2();
    break;


  case -1000:
  case 1000:
    aWin(); // a win
    break;

  case -2000:
  case 2000:
    bWin(); // b win
    break;

  case -3000:
  case 3000:
    help(); // help
    break;
  }

  click=0;
}

//ai.. sorry this doesn't have any algorithm..

void ai() {
  int i, j, k, l, m, n, x, y, z, w;
  int colorblock = 1; // check if computer have left blocks
  int aiX[] = new int[100];
  int aiY[] = new int[100];
  m = 0; // number that maybe attacked next time

  aiScore=0;
  for (i=1; i<12; i++) {
    for (j=1; j<12; j++) {
      aiBlk[i][j]=blk[i][j];
    }
  }


  //check quod in player A next time
  for (i=1; i<12; i++) {
    for (j=1; j<12; j++) {
      if (blk[i][j]==2) {
        for (k=1; k<12; k++) {
          for (l=1; l<12; l++) {// blk is avaible for 50 so it is ok for larger then 12, so only care if it is plus
            if (i+j-k>0&&i-j+l>0&&l+k-j>0&&l-k+i>0&&!(k==i&&l==j)) {
              if (blk[k][l]==2&&(blk[i-j+l][i+j-k]==2||blk[l+k-j][l-k+i]==2)) {
                if (blk[i-j+l][i+j-k]==2&&blk[l+k-j][l-k+i]==1) {
                  m+=1;
                  aiX[m]=l+k-j;
                  aiY[m]=l-k+i;
                }
              }
            }
          }
        }
      }
    }
  }

  //check quod in player B
  for (i=1; i<12; i++) {
    for (j=1; j<12; j++) {
      if (blk[i][j]==3) {
        for (k=1; k<12; k++) {
          for (l=1; l<12; l++) {// blk is avaible for 50 so it is ok for larger then 12, so only care if it is plus
            if (i+j-k>0&&i-j+l>0&&l+k-j>0&&l-k+i>0&&!(k==i&&l==j)) {
              if (colorblock==1&&blk[k][l]==3&&(blk[i-j+l][i+j-k]==3||blk[l+k-j][l-k+i]==3)) {
                if (blk[i-j+l][i+j-k]==3&&blk[l+k-j][l-k+i]==1) {
                  aiansX=l+k-j;
                  aiansY=l-k+i;
                  colorblock-=1;
                  m=-1;
                }
              }
            }
          }
        }
      }
    }
  }

  if (m>0) {

    while (m>0) {

      if (quazB>=1&&blk[aiX[m+1]][aiY[m+1]]==1) {

        blk[aiX[m+1]][aiY[m+1]]=0;
        quazB=quazB-1;
      }
      m-=1;
    }
    if (colorblock==1) {
      aiansX=aiX[1];
      aiansY=aiY[1];
    }
    m=-1;
  } else if (m==0) {
    i=int(random(3, 10));
    j=int(random(3, 10));
    while (blk[i][j]!=1) {
      i=int(random(3, 10));
      j=int(random(3, 10));
    }
    if (colorblock==1) {
      aiansX=i;
      aiansY=j;
    }
  }
  aiFinish=1;
}
//chkQd : check if there is quod, if yes : 0, no : 1;

void chkQd(int aorb) {
  int i, j, k, l, m, n, x, y, z, w;
  int round=0;
  noStroke();
  for (i=1; i<12; i++) { //show block!
    for (j=1; j<12; j++) {
      if (blk[i][j]==1) {
        fill(103, 212, 136); 
        rect(204+i*57, -44+j*57, 44, 44);
      } else if (blk[i][j]==2) {
        fill(255, 0, 0);
        round=0;
        if (i==lastBlockX&&j==lastBlockY) round=44/4;
        rect(204+i*57, -44+j*57, 44, 44, round);
      } else if (blk[i][j]==3) {
        fill(0, 0, 255);
        round=0;
        if (i==lastBlockX&&j==lastBlockY) round=44/4;
        rect(204+i*57, -44+j*57, 44, 44, round);
      }
    }
  }

  if (aorb==0) {
    stroke(255, 0, 0);
  }
  if (aorb==1) {
    stroke(0, 0, 255);
  }

  strokeWeight(5);

  //check quod in player A
  for (i=1; i<12; i++) {
    for (j=1; j<12; j++) {
      if (blk[i][j]==2) {
        for (k=1; k<12; k++) {
          for (l=1; l<12; l++) {// blk is avaible for 50 so it is ok for larger then 12, so only care if it is plus
            if (i+j-k>0&&i-j+l>0&&l+k-j>0&&l-k+i>0&&!(k==i&&l==j)) {
              if (blk[k][l]==2&&blk[i-j+l][i+j-k]==2&&blk[l+k-j][l-k+i]==2) {
                line(226+i*57, -22+j*57, 226+k*57, -22+l*57);
                line(226+k*57, -22+l*57, 226+(l+k-j)*57, -22+(l-k+i)*57);
                line(226+(l+k-j)*57, -22+(l-k+i)*57, 226+(i-j+l)*57, -22+(i+j-k)*57);
                line(226+(i-j+l)*57, -22+(i+j-k)*57, 226+i*57, -22+j*57);
                if (aorb == 0) gmod = 1000;
                else gmod = 2000;
              }
            }
          }
        }
      }
    }
  }

  //check quod in player B
  for (i=1; i<12; i++) {
    for (j=1; j<12; j++) {
      if (blk[i][j]==3) {
        for (k=1; k<12; k++) {
          for (l=1; l<12; l++) {// blk is avaible for 50 so it is ok for larger then 12, so only care if it is plus
            if (i+j-k>0&&i-j+l>0&&l+k-j>0&&l-k+i>0&&!(k==i&&l==j)) {
              if (blk[k][l]==3&&blk[i-j+l][i+j-k]==3&&blk[l+k-j][l-k+i]==3) {
                line(226+i*57, -22+j*57, 226+k*57, -22+l*57);
                line(226+k*57, -22+l*57, 226+(l+k-j)*57, -22+(l-k+i)*57);
                line(226+(l+k-j)*57, -22+(l-k+i)*57, 226+(i-j+l)*57, -22+(i+j-k)*57);
                line(226+(i-j+l)*57, -22+(i+j-k)*57, 226+i*57, -22+j*57);
                if (aorb == 0) gmod = 1000;
                else gmod = 2000;
              }
            }
          }
        }
      }
    }
  }
}

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
void mouseReleased() {
  click = 1;
}
//set, basic settings 

int dataIn;

int gmod, turn;// game mode, 0:startmenu, 1:single, 2:UDP, 3:udp server, 4:udp client, 5:A win, 6:B win, turn is play turn 0:A(ai), 1:B(ai), 2: A after do his color block(ai), 3 : B after do his color block(ai) 4:A(1vs1), 5:B(1vs1), 6: A after do his color block(1vs1), 7 : B after do his color block(1vs1)
int menuKind = 0;
int statemod = 1;//server state, etc..
int aiTurn = -1;//check if ai will work or not
int[][] blk = new int[50][50];//x,y coordinate if tile exist 0:no, 1: default 2:red 3: blue
int[][] aiBlk = new int[50][50];//for tile, for ai compute
double aiScore=-5000;
int aiansX, aiansY, aicacheX, aicacheY;
int aiFinish=0;

float timeA, timeB;//time left of player A, B
int timeAx, timeAy, timeBx, timeBy;//time left pannel for player A,B
int timeCache;//time cache for click delay
int quazA, quazB;//quazer left of player A, B
int lastBlockX, lastBlockY;// say what was last block

int click;
PFont font;

void setup() {
  size(1136, 640);
  background(184, 241, 241);


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
  gmod=-100;
  turn=-1;
}

//singleAI : single play with ai
void snglPai1() {

  background(184, 241, 241);
  showBlock();

  //red, playerA
  fill(255, 0, 0);
  textSize(48);
  textAlign(CENTER, CENTER);
  text("A", 124, 40);
  //show number of quaz left
  if (quazA>0) {
    fill(255, 227, 212);
    rect(0, 220, 248, 40);
  }
  if (quazA>1) {
    fill(255, 212, 194);
    rect(0, 270, 248, 40);
  }
  if (quazA>2) {
    fill(255, 197, 188);
    rect(0, 320, 248, 40);
  }
  if (quazA>3) {
    fill(255, 163, 162);
    rect(0, 370, 248, 40);
  }
  if (quazA>4) {
    fill(231, 94, 90);
    rect(0, 420, 248, 40);
  }
  if (quazA>5) {
    fill(187, 62, 69);
    rect(0, 470, 248, 40);
  }

  //blue, playerB
  fill(0, 0, 255);
  textSize(48);
  text("B", 1012, 40);


  if (quazB>0) {
    fill(212, 163, 110);
    rect(888, 220, 248, 40);
  }
  if (quazB>1) {
    fill(196, 132, 85);
    rect(888, 270, 248, 40);
  }
  if (quazB>2) {
    fill(156, 97, 71);
    rect(888, 320, 248, 40);
  }
  if (quazB>3) {
    fill(131, 88, 74);
    rect(888, 370, 248, 40);
  }
  if (quazB>4) {
    fill(110, 76, 68);
    rect(888, 420, 248, 40);
  }
  if (quazB>5) {
    fill(79, 69, 64);
    rect(888, 470, 248, 40);
  }

  if (turn == 0) {

    textSize(60);          
    noStroke();          
    fill(255, 238, 96);          
    rect(0, 540, 248, 100);          
    fill(0);          
    text("quod", 124, 590);   
    fill(193, 243, 214);     
    rect(888, 540, 248, 100);     
    fill(0);     
    text("wait", 1012, 590);
  } else if (turn == 2) {
    textSize(60);          
    noStroke();          
    fill(255, 238, 96);          
    rect(0, 540, 248, 100);          
    fill(0);          
    text("quod", 124, 590);  
    fill(193, 243, 214);     
    rect(888, 540, 248, 100);     
    fill(0);     
    text("wait", 1012, 590);
  } else if (turn == 1 || turn == 3) {
    textSize(60);     
    noStroke();     
    fill(193, 243, 214);     
    rect(0, 540, 248, 100);     
    fill(0);     
    text("wait", 124, 590);      
    fill(255, 238, 96);          
    rect(888, 540, 248, 100);          
    fill(0);          
    text("finish", 1012, 590);
  }

  gmod = -gmod;
}


void snglPai2() {

  //red, playerA
  //timepannel
  fill(240, 248, 255);
  noStroke();
  ellipse(timeAx, timeAy, 100, 100);

  //turn of A
  if (turn == 0) {
    aiTurn=1;//set Ai for compute
    //hand of timepannel
    timeA-=60/frameRate;
    float scdA = map(timeA, 0, 2400, 0, TWO_PI)- HALF_PI;//100 is max
    stroke(255, 0, 0);
    strokeWeight(3);
    line(timeAx, timeAy, timeAx + cos(scdA)*40, timeAy+sin(scdA)*40);

    //mouse click check
    if (click==1&&0<int((mouseX-204)/57)&&int((mouseX-204)/57)<12&&((mouseX-204)%57)<45&&0<int((mouseY+44)/57)&&int((mouseY+44)/57)<12&&((mouseY+44)%57)<45) {
      if (blk[int((mouseX-204)/57)][int((mouseY+44)/57)]==1) {
        if (mouseButton == LEFT) {
          blk[int((mouseX-204)/57)][int((mouseY+44)/57)]=2;
          lastBlockX=int((mouseX-204)/57);
          lastBlockY=int((mouseY+44)/57);
          gmod = -gmod;
          turn=2;
          timeA=0;
        } else if (mouseButton == RIGHT&&quazA>0) {
          blk[int((mouseX-204)/57)][int((mouseY+44)/57)]=0;
          gmod = -gmod;
          quazA-=1;
        }
      }
    }

    //say there is quod
    if (click==1&&mouseX<248&&mouseY>540) {
      gmod = -gmod;
      chkQd(0);
      quazA-=1;
      turn=1;
      timeA=0;
    }

    if (timeA<-2400) {
      gmod = -gmod;
      turn = 1; // turn A end for time limit
      timeA = 0;
      timeB = 0;
    }
  }

  if (turn==2) {
    timeA-=60/frameRate;
    float scdA = map(timeA, 0, 250, 0, TWO_PI) - HALF_PI; // 100 is max
    stroke(255, 0, 0);
    strokeWeight(3);
    line(timeAx, timeAy, timeAx + cos(scdA)*40, timeAy+sin(scdA)*40);

    if (click==1&&mouseX<248&&mouseY>540)
    {
      gmod = -gmod;
      chkQd(0);
      turn=1;
      quazA-=1;
      timeA=0;
    }      

    if (timeA<-250) {
      gmod = -gmod;
      turn=1; // turn A end for tiem limit
      timeA=0;
    }
  }

  //blue, playerB
  fill(240, 248, 255);
  noStroke();
  ellipse(timeBx, timeBy, 100, 100);

  if (turn==1||turn==3) {
    //part of ai, and need for time delay 2 seconds
    //this could make some code mess..
    if (aiTurn==1 && timeB<-30) { // after they compute it goes to chkQd one more time..
      chkQd(1);//say if there is quod!
      ai();
      chkQd(1);
      blk[aiansX][aiansY]=3;
      lastBlockX=aiansX;
      lastBlockY=aiansY;
      chkQd(1);
      gmod = -gmod;
      aiTurn=0;
      aiFinish=0;
    }

    timeB-=60/frameRate;
    float scdB = map(timeB, 0, 150, 0, TWO_PI) - HALF_PI; // 100 is max
    stroke(0, 0, 255);
    strokeWeight(3);
    line(timeBx, timeBy, timeBx + cos(scdB)*40, timeBy+sin(scdB)*40);

    if (timeB<-150) {
      gmod = -gmod;
      turn=0; // turn A end for tiem limit
      timeB=0;
    }
  }
}

//set the mod of single play, with ai or 1 vs 1

void snglP1() {
  statemod=1;

  background(184, 241, 241);
  textSize(120);
  noStroke();
  fill(23, 93, 126);
  textAlign(CENTER, CENTER);
  text("Quod", width/2, 120);
  fill(255, 135, 38);
  textSize(36);
  text("Local Play", width/2, 170);
  fill(255, 206, 160);
  rect(width/2-140, 300, 280, 70);
  rect(width/2-140, 380, 280, 70);
  rect(width/2-140, 460, 280, 70);

  fill(0);
  textSize(48);
  textAlign(CENTER, CENTER);
  text("AI", width/2, 335);
  text("1 VS 1", width/2, 415);
  text("Back", width/2, 495);
  gmod = -gmod;
}

void snglP2() {

  statemod=1;
  noStroke();
  fill(255, 206, 160);
  rect(width/2-140, 300, 280, 70);
  rect(width/2-140, 380, 280, 70);
  rect(width/2-140, 460, 280, 70);

  fill(0);
  textSize(48);
  textAlign(CENTER, CENTER);
  text("AI", width/2, 335);
  text("1 VS 1", width/2, 415);
  text("Back", width/2, 495);

  if (mouseX>(width/2-140)&&mouseX<(width/2+140)) {
    fill(241, 232, 212);
    if (mouseY>300&&mouseY<370) {
      rect(width/2-140, 300, 280, 70);
      if (click==1) {
        turn=0;
        gmod = -400;
        click=0;
        statemod=0;
      }
    } else if (mouseY>380&&mouseY<450) {
      rect(width/2-140, 380, 280, 70);
      if (click==1) {
        turn=4;
        gmod = -500;
        click=0;
        statemod=0;
      }
    } else if (mouseY>460&&mouseY<530) {
      rect(width/2-140, 460, 280, 70);
      if (click==1) {
        gmod=-200;
        click=0;
      }
    }
  }
}
//snglPvs() single play 1 vs 1 in one computer

void snglPvs1() {

  background(184, 241, 241);
  showBlock();

  //red, playerA
  fill(255, 0, 0);
  textAlign(CENTER, CENTER);
  textSize(48);
  text("A", 124, 40);

  //show number of quaz left
  if (quazA>0) {
    fill(255, 227, 212);
    rect(0, 220, 248, 40);
  }
  if (quazA>1) {
    fill(255, 212, 194);
    rect(0, 270, 248, 40);
  }
  if (quazA>2) {
    fill(255, 197, 188);
    rect(0, 320, 248, 40);
  }
  if (quazA>3) {
    fill(255, 163, 162);
    rect(0, 370, 248, 40);
  }
  if (quazA>4) {
    fill(231, 94, 90);
    rect(0, 420, 248, 40);
  }
  if (quazA>5) {
    fill(187, 62, 69);
    rect(0, 470, 248, 40);
  }

  //blue, playerB
  fill(0, 0, 255);
  textSize(48);
  text("B", 1012, 40);

  if (quazB>0) {
    fill(212, 163, 110);
    rect(888, 220, 248, 40);
  }
  if (quazB>1) {
    fill(196, 132, 85);
    rect(888, 270, 248, 40);
  }
  if (quazB>2) {
    fill(156, 97, 71);
    rect(888, 320, 248, 40);
  }
  if (quazB>3) {
    fill(131, 88, 74);
    rect(888, 370, 248, 40);
  }
  if (quazB>4) {
    fill(110, 76, 68);
    rect(888, 420, 248, 40);
  }
  if (quazB>5) {
    fill(79, 69, 64);
    rect(888, 470, 248, 40);
  }

  //downside ui
  if (turn == 4) {
    textSize(60);          
    noStroke();          
    fill(255, 238, 96);          
    rect(0, 540, 248, 100);          
    fill(0);          
    text("quod", 124, 590);    
    fill(193, 243, 214);     
    rect(888, 540, 248, 100);     
    fill(0);     
    text("wait", 1012, 590);
  } else if (turn == 6) {
    textSize(60);          
    noStroke();          
    fill(255, 238, 96);          
    rect(0, 540, 248, 100);          
    fill(0);          
    text("quod", 124, 590);    
    fill(193, 243, 214);     
    rect(888, 540, 248, 100);     
    fill(0);     
    text("wait", 1012, 590);
  } else if (turn == 5) {
    textSize(60);     
    noStroke();     
    fill(193, 243, 214);     
    rect(0, 540, 248, 100);     
    fill(0);     
    text("wait", 124, 590);         
    fill(255, 238, 96);          
    rect(888, 540, 248, 100);          
    fill(0);          
    text("quod", 1012, 590);
  } else if (turn == 7) {
    textSize(60);     
    noStroke();     
    fill(193, 243, 214);     
    rect(0, 540, 248, 100);     
    fill(0);     
    text("wait", 124, 590);         
    fill(255, 238, 96);          
    rect(888, 540, 248, 100);          
    fill(0);          
    text("quod", 1012, 590);
  }

  gmod = -gmod;
}

void snglPvs2() {

  //red, playerA
  //timepanel
  fill(240, 248, 255);
  noStroke();
  ellipse(timeAx, timeAy, 100, 100);

  if (turn==4) {
    //hand of timepannel
    timeA-=60/frameRate;
    float scdA = map(timeA, 0, 2400, 0, TWO_PI) - HALF_PI; // 100 is max
    stroke(255, 0, 0);
    strokeWeight(3);
    line(timeAx, timeAy, timeAx + cos(scdA)*40, timeAy+sin(scdA)*40);

    //mouse click check
    if (click==1&&0<int((mouseX-204)/57)&&int((mouseX-204)/57)<12&&((mouseX-204)%57)<45&&0<int((mouseY+44)/57)&&int((mouseY+44)/57)<12&&((mouseY+44)%57)<45) {
      if (blk[int((mouseX-204)/57)][int((mouseY+44)/57)]==1) {
        if (mouseButton == LEFT) {
          blk[int((mouseX-204)/57)][int((mouseY+44)/57)]=2;
          lastBlockX=int((mouseX-204)/57);
          lastBlockY=int((mouseY+44)/57);
          turn=6;
          gmod = -gmod;
          timeA=0;
        } else if (mouseButton == RIGHT&&quazA>0) {
          blk[int((mouseX-204)/57)][int((mouseY+44)/57)]=0;
          quazA-=1;
          gmod = -gmod;
        }
      }
    }
    //say there is quod
    if (click==1&&mouseX<248&&mouseY>540) {
      chkQd(0);
      quazA-=1;
      turn=5;
      gmod = -gmod;
      timeA=0;
    }   

    if (timeA<-2400) {
      turn=5; // turn A end for tiem limit
      gmod = -gmod;
      timeA=0;
    }
  }

  if (turn==6) {
    timeA-=60/frameRate;
    float scdA = map(timeA, 0, 250, 0, TWO_PI) - HALF_PI; // 100 is max
    stroke(255, 0, 0);
    strokeWeight(3);
    line(timeAx, timeAy, timeAx + cos(scdA)*40, timeAy+sin(scdA)*40);

    if (click==1&&mouseX<248&&mouseY>540) {
      chkQd(0);
      turn=5;
      gmod = -gmod;
      quazA-=1;
      timeA=0;
    }      

    if (timeA<-250) {
      turn=5; // turn A end for tiem limit
      gmod = -gmod;
      timeA=0;
    }
  }


  ////////////////////////////////////////////////

  //blue, player B

  fill(240, 248, 255);
  noStroke();
  ellipse(timeBx, timeBy, 100, 100);

  if (turn==5) {
    //hand of timepannel
    timeB-=60/frameRate;
    float scdB = map(timeB, 0, 3000, 0, TWO_PI) - HALF_PI; // 100 is max
    stroke(0, 0, 255);
    strokeWeight(3);
    line(timeBx, timeBy, timeBx + cos(scdB)*40, timeBy+sin(scdB)*40);

    //mouse click check
    if (click==1&&0<int((mouseX-204)/57)&&int((mouseX-204)/57)<12&&((mouseX-204)%57)<45&&0<int((mouseY+44)/57)&&int((mouseY+44)/57)<12&&((mouseY+44)%57)<45) {
      if (blk[int((mouseX-204)/57)][int((mouseY+44)/57)]==1) {
        if (mouseButton == LEFT) {
          lastBlockX=int((mouseX-204)/57);
          lastBlockY=int((mouseY+44)/57);
          blk[int((mouseX-204)/57)][int((mouseY+44)/57)]=3;        
          turn=7;
          gmod = -gmod;
          timeB=0;
        } else if (mouseButton == RIGHT&&quazB>0) {
          blk[int((mouseX-204)/57)][int((mouseY+44)/57)]=0;
          quazB-=1;
          gmod = -gmod;
        }
      }
    }
    //say there is quod
    if (click==1&&mouseX>888&&mouseY>540) {
      chkQd(1);
      quazB-=1;
      turn=4;
      gmod = -gmod;
      timeB=0;
    }   

    if (timeB<-3000) {
      turn=4; // turn A end for tiem limit
      gmod = -gmod;
      timeB=0;
    }
  }

  if (turn==7) {
    timeB-=60/frameRate;
    float scdB = map(timeB, 0, 250, 0, TWO_PI) - HALF_PI; // 100 is max
    stroke(0, 0, 255);
    strokeWeight(3);
    line(timeBx, timeBy, timeBx + cos(scdB)*40, timeBy+sin(scdB)*40);

    if (click==1&&mouseX>888&&mouseY>540) {
      chkQd(1);
      turn=4;
      gmod = -gmod;
      quazB-=1;
      timeB=0;
    }      

    if (timeB<-250) {
      turn=4; // turn A end for tiem limit
      gmod = -gmod;
      timeB=0;
    }
  }
}
//statM : start menu
//loadS : load screne

void loadS1() {
  statemod=1;

  background(184, 241, 241);
  fill(23, 93, 126);
  textSize(120);
  textAlign(CENTER, CENTER);
  text("Quod", width/2, 120);
  textSize(36);
  fill(255, 135, 38);
  text("v0.6.0b1", width/2, 170);
  textSize(48);
  fill(0);
  textAlign(CENTER, BOTTOM);
  text("click to start", width/2, height-10);

  //set loadS2
  gmod = -gmod;
}
void loadS2() {
  statemod=1;
  if (click == 1) {
    gmod = -200;
    click = 0;
  }
}

void statM1() {
  statemod=1;
  background(184, 241, 241);
  textSize(120);
  noStroke();
  fill(23, 93, 126);
  textAlign(CENTER, CENTER);
  text("Quod", width/2, 120);
  fill(255, 206, 160);
  rect(width/2-140, 300, 280, 70);
  rect(width/2-140, 380, 280, 70);
  rect(width/2-140, 460, 280, 70);
  fill(0);
  textSize(48);
  text("Local Play", width/2, 335);
  text("Online Play", width/2, 415);
  text("Help", width/2, 495);

  gmod = - gmod;
}

void statM2() {
  statemod=1;
  noStroke();
  textAlign(CENTER, CENTER);
  fill(255, 206, 160);
  rect(width/2-140, 300, 280, 70);
  rect(width/2-140, 380, 280, 70);
  rect(width/2-140, 460, 280, 70);
  fill(0);
  textSize(48);
  text("Local Play", width/2, 335);
  text("Online Play", width/2, 415);
  text("Help", width/2, 495);
  if (mouseX>(width/2-140)&&mouseX<(width/2+140)) {
    fill(241, 232, 212);
    if (mouseY>300&&mouseY<370) { // Local Play
      rect(width/2-140, 300, 280, 70);
      if (click==1) {
        gmod=-300;
        click=0;
      }
    } else if (mouseY>380&&mouseY<450) { // Online Play
      rect(width/2-140, 380, 280, 70);
      fill(255, 0, 0);
      textAlign(CENTER, CENTER);
      textSize(24);
      text("server not supported", width/2, 415);
    } else if (mouseY>460&&mouseY<530) { // Help
      rect(width/2-140, 460, 280, 70);
      if (click==1) {
        gmod=3000;
        click=0;
      }
    }
  }
}


