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

