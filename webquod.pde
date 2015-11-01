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

