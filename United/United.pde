/* OpenProcessing Tweak of *@*http://www.openprocessing.org/sketch/32916*@* */
/* !do not delete the line above, required for linking your tweak if you re-upload */
import java.util.Arrays;

float xx=4;
float yy=1;
float ff=2;
float hh=3;
float xpos;
float ypos;
float fpos;
float hpos;
float yubound, ylbound, xrbound;
String mywisharray[];

String mywish;
int numObjects;
int distance;
float angleObject;
int ppmouseX, ppmouseY;
int div4[];
float rotaterate;
float angleobj[];

float[] xpositions;
float[] c_offsets;
float[] theta_offsets;

float FONTSIZE;

int num_letters = 50;
float max_c = 3.0;
float max_theta = 5*PI/num_letters;
float c_time;
float theta_time;
float lastMillis;
float c_speed = 0.2;
float theta_speed = 0.1;

String mywish3, mywish4;

int mouseXX, swingunit;

boolean sketchFullScreen() {
  return true;
}

void setup() {
  
  size(displayWidth, displayHeight);
  textFont( createFont("DFKai-SB Regular", 48) );
  
  mywish = "英國外交官羅伯特．庫伯注意到現代歐洲國家這樣的特質，將之定位為後現代國家。";
  
  yubound = 30;
  ylbound = (height >> 1) - 10;
  xrbound = (width >> 2) - 64;
  xpos=random(0, xrbound);
  ypos=random(yubound, ylbound);
  fpos=random(0, xrbound);
  hpos=random(yubound, ylbound);
  mywisharray = new String[2];
  mywisharray[0]=mywish.substring(0,mywish.length()/2);
  mywisharray[1]=mywish.substring(mywish.length()/2);
  
  if(mywish.length()<5)
  {
    int nlen = mywish.length();
    for(int ii=0 ; ii< (5-nlen) ; ii ++)
      mywish += "~"; 
  }
  numObjects = mywish.length()/5;
  distance = 0;
  angleObject = (TWO_PI/numObjects);
  ppmouseX = (width >> 3) * 3;
  ppmouseY = height >> 2;
  div4 = new int[4];
  angleobj = new float[4];
  div4[0] = numObjects;
  for(int ii=0; ii< 4; ii++)
  {
    angleobj[ii] = (angleObject / 5) * (ii+1);
    div4[ii] = numObjects * (ii+1); 
  }
  
  mywish3 = mywish.length() > 6 ? mywish.substring(0,6): mywish;
  FONTSIZE = (width >> 3)/mywish3.length();
  xpositions = new float[mywish3.length()];
  c_offsets = new float[mywish3.length()];
  theta_offsets = new float[mywish3.length()];
  float mywish3length = textWidth(mywish3);
  float letterpos = ( (width >> 2) - mywish3length ) / 2.0 + (width >> 1);
  for(int i = 0; i < mywish3.length(); ++i) {
    c_offsets[i] = random(1000.);
    theta_offsets[i] = random(1000.);
    xpositions[i] = letterpos;
    float letterwidth = textWidth(mywish3.charAt(i));
    letterpos += letterwidth;
  }
  c_time = millis()/1000.0;
  theta_time = millis()/1000.0;
  lastMillis = millis()/1000.0;
  
  mywish4 = mywish.length() > 12 ? mywish.substring(0,12): mywish;
  mouseXX = (width >> 1) + (width >> 2);
  swingunit = 5;
}

void draw() {
  fill(0,0,0);
  noStroke();
  rect(0,0,width >> 2, height >> 1);
  
  textSize(32);
  
  fill(random(0,255),random(0,255),random(0,255));
  
  int xposlen = (int)abs( xpos - (width >> 2) ) / 32;
  int fposlen = (int)abs( fpos - (width >> 2) ) / 32;
  text(mywisharray[0].substring(0, xposlen > mywisharray[0].length() ? mywisharray[0].length(): xposlen ),xpos,ypos);
  fill(random(0,255),random(0,255),random(0,255));
  text(mywisharray[1].substring(0, fposlen > mywisharray[1].length() ? mywisharray[1].length(): fposlen ), fpos,hpos);
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
 
    fill(83,159,162, 125);
    rect(width >> 2 , 0, width >> 2, height >> 1);
    rotaterate = frameCount * 0.01;
    for (int i =0; i<numObjects; i++)
    { 
      
      float posE=(distance+125)*sin(angleObject*i+rotaterate-angleobj[3]);
      float posG=(distance+125)*cos(angleObject*i+rotaterate-angleobj[3]);

      pushMatrix();
      translate(posE, posG);
      textSize(25);
      fill(114,177,164);
      char letter1 = mywish.charAt(div4[3]+i);
      text(letter1,ppmouseX,ppmouseY);
      popMatrix();
      
      float posW=(distance+100)*sin(angleObject*i+rotaterate-angleobj[2]);
      float posK=(distance+100)*cos(angleObject*i+rotaterate-angleobj[2]);

      pushMatrix();
      translate(posW, posK);
      textSize(20);
      fill(114,177,164);
      char letter = mywish.charAt(div4[2]+i);
      text(letter, ppmouseX, ppmouseY);
      popMatrix();


      float posX=(distance+75)*sin(angleObject*i+rotaterate-angleobj[1]);
      float posY=(distance+75)*cos(angleObject*i+rotaterate-angleobj[1]);


      pushMatrix();
      fill(0);
      translate (posX, posY);
      fill(171,204,177);
      textSize(15);
      char letter2 = mywish.charAt(div4[1]+i);
      text(letter2, ppmouseX, ppmouseY);
      popMatrix(); 



      float posB=(distance+50)*sin(angleObject*i+rotaterate-angleobj[0]);
      float posA=(distance+50)*cos(angleObject*i+rotaterate-angleobj[0]);

      pushMatrix();
      fill(192,219,180);
      translate(posB, posA);
      textSize(10);
      char letter3 = mywish.charAt(div4[0]+i);
      text(letter3, ppmouseX, ppmouseY);
      popMatrix();

      float posC=(distance+25)*sin(angleObject*i+rotaterate);
      float posD=(distance+25)*cos(angleObject*i+rotaterate);


      pushMatrix();
      translate(posC, posD);
      char letter4 = mywish.charAt(i);
      textSize(5);
      fill(212,226,182);
      text(letter4, ppmouseX, ppmouseY);
      popMatrix();
    }
    
  textSize(FONTSIZE);
  
  c_speed = random(0,0.5);//map(mouseX,0,width>>2,0.0,0.5);
  theta_speed = random(0,0.25);//map(mouseY,0,height>>1,0.0,0.25);
  float y_0 = 20.0 + FONTSIZE;
  fill(0,0,0);
  rect(width >> 1,0,width >> 2, height >> 1);
  float curMillis = millis()/1000.0;
  c_time += c_speed*(curMillis - lastMillis);
  theta_time += theta_speed*(curMillis - lastMillis);
  lastMillis = curMillis;
  float h = (height >> 4);///8.0;
  for(int i = 0; i < mywish3.length(); ++i) {
    float c = max_c*myNoise(c_offsets[i] + c_time);
    float theta = max_theta*myNoise(theta_offsets[i] + theta_time);
    fill(255);
    text(mywish3.charAt(i), xpositions[i], y_0);
    fill(255,255,255,8);
    float[] x = new float[4];
    float[] y = new float[4];
    x[0] = xpositions[i]; x[1] = x[0];
    x[2] = (width>>1) + (width>>3) + c*(xpositions[i] - (width>>1) - (width >> 3) );//;/2.0);
    x[3] = x[2];
    y[0] = y_0; y[1] = y[0] + (height >> 4);///8.0;
    y[3] = (height>>1) - 1.5*FONTSIZE;
    y[2] = y[3] - (height >> 4);///8.0;
    for(int j = 1; j <= num_letters; ++j) {
      pushMatrix();
      float t = (float)j/num_letters;
      translate( bezierPoint(x[0],x[1],x[2],x[3],t), bezierPoint(y[0],y[1],y[2],y[3],t) );
      rotate( theta*j );
      text(mywish3.charAt(i),0,0);
      popMatrix();
    }
  }
  
  fill(255);
  rect( (width >> 1) + (width >> 2),0 ,width >> 2, height >> 1);
  
  for(int i= ( (width >> 1) + (width >> 2) + ( abs(swingunit) << 1 ) ); i<=width; i+= (width >> 4) )
  { //repeating the whole width
  
    pushMatrix(); // so it doesn't accumulate on itself from the forloop; isolates each rectangle
    float angle = atan2( (height >> 1), mouseXX-i ); //y,x <--tricking atan2
    translate(i,0);
    rotate(angle);
    fill(0);
    text(mywish4,0,0); //origin,  width & height
    popMatrix();
  }

  if ( mouseXX < ( (width >> 1) + (width >> 2)  ) || mouseXX > ( width  + ( abs(swingunit) << 4 ) ) ) {
    swingunit *= -1;
  }
  mouseXX += swingunit;
  
}

float myNoise(float x)
{
  //float val = 4.0*(noise(x)-0.25);
  //float val = noise(x);
  float val = 2.0*(noise(x)-0.5);
  //println(val);
  return val;
}


