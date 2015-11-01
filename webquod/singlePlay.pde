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