class Drop
{
  float xpos, ypos, wide, high, gravity;
  float time = 0;
  int randomwide = displayWidth/320;
  float easing = 0.025;

  public Drop() {
    xpos = random(0, displayWidth);
    ypos = random(0, displayHeight);
    wide = random(0, randomwide);
    
    //high = random(randomhigh, randomhigh << 1);
  }
  
  void display(int rainlen) {
    //float i = map(mouseX, 0, width, 50, 200);
    //fill(255, i);
    // fill(255,200);
    //noStroke();
    ellipse(xpos,ypos, wide, rainlen);
  }
  
  void fall(float wind) {
    //float targetX= mouseX;
    float dx = wind;//targetX-currX;
    int whatisnightysix = 96, whatistwenty = 20;
    //currX += dx * easing;
    //println(dx);
    float Idontknowwhy96 = ypos / whatisnightysix;
    time = abs(Idontknowwhy96);
    float gravity = (time * time) + whatistwenty;//(1 * time * time) + whatistwenty;
    ypos += gravity;
    xpos += dx * (Idontknowwhy96);

    if(ypos >= height) {//>= random(350,height)) {
      ypos-=height;
      xpos+=random(0,width);
    }

    if(xpos>= width)
    {
      xpos -= width;
    }
    else if(xpos <= 0)
    {
      xpos += width;
    }
  }
  
}

