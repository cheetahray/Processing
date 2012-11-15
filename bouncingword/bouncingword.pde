/* OpenProcessing Tweak of *@*http://www.openprocessing.org/sketch/32916*@* */
/* !do not delete the line above, required for linking your tweak if you re-upload */
float xx=4;
float yy=1;
float ff=2;
float hh=3;
float xpos;
float ypos;
float fpos;
float hpos;
float yubound, ylbound, xrbound;
String mywish[];

boolean sketchFullScreen() {
  return true;
}

void setup() {
  
  size(displayWidth, displayHeight);
  textFont( createFont("DFKai-SB Regular", 50) );
  textSize(32);
  yubound = 30;
  ylbound = (height >> 1) - 10;
  xrbound = (width >> 2) - 70;
  xpos=random(0, xrbound);
  ypos=random(yubound, ylbound);
  fpos=random(0, xrbound);
  hpos=random(yubound, ylbound);
  mywish = new String[3];
  mywish[0]="啥米碗糕";
  mywish[1]=mywish[0].substring(0,mywish[0].length()/2);
  mywish[2]=mywish[0].substring(mywish[0].length()/2);
  
}

void draw() {
  fill(0,0,0);
  rect(0,0,width >> 2, height >> 1);
  fill(random(0,255),random(0,255),random(0,255));
  text(mywish[1],xpos,ypos);
  fill(random(0,255),random(0,255),random(0,255));
  text(mywish[2], fpos,hpos);
  if (ypos<=yubound || ypos>=ylbound) {
    yy=yy*-1;
  }
  if (xpos<=0 || xpos>=xrbound) {
    xx=xx*-1;
  }
  if (hpos<=yubound || hpos>=ylbound) {
    hh=hh*-1;
  }
  if (fpos<=0 || fpos>=xrbound) {
    ff=ff*-1;
  }

  ypos=ypos+yy;
  xpos=xpos+xx;
  fpos=fpos+ff;
  hpos=hpos+hh;
 
}


