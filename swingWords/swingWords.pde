/* OpenProcessing Tweak of *@*http://www.openprocessing.org/sketch/64503*@* */
/* !do not delete the line above, required for linking your tweak if you re-upload */
String mywish = "啥米碗糕";
int mouseXX, swingunit;

boolean sketchFullScreen() {
  return true;
}

void setup(){
  size(displayWidth, displayHeight);//size(500,500);
  mouseXX = (width >> 1) + (width >> 2);
  swingunit = 5;
  /*
  PFont font = loadFont ("AkzidenzGroteskBE-XBdCnIt-48.vlw");
  textFont(font);
  */
  textFont( createFont("DFKai-SB Regular",36) );
  smooth();
  textAlign(LEFT);
}

void draw(){
  fill(255);
  noStroke();
  rect( (width >> 1) + (width >> 2),0 ,width >> 2, height >> 1);
  
  for(int i= ( (width >> 1) + (width >> 2) + ( abs(swingunit) << 1 ) ); i<=width; i+= (width >> 4) )
  { //repeating the whole width
  
    pushMatrix(); // so it doesn't accumulate on itself from the forloop; isolates each rectangle
    float angle = atan2( (height >> 1), mouseXX-i ); //y,x <--tricking atan2
    translate(i,0);
    rotate(angle);
    fill(0);
    text(mywish,0,0); //origin,  width & height
    popMatrix();
  }

  if ( mouseXX < ( (width >> 1) + (width >> 2)  ) || mouseXX > ( width  + ( abs(swingunit) << 4 ) ) ) {
    swingunit *= -1;
  }
  mouseXX += swingunit;
  
}

