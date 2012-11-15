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

ArrayList boids = new ArrayList();
PImage weburl;
/*
boolean mouseDownL= false;
boolean mouseDownR = false;
*/
PGraphics pg;
float minBrightness = 80;
int lastSecond;

int num = 300, numH = 300; //number of particles
int mouseState = 0; //int for toggling gravity
int keyState = 0; //int for toggling image reform
int pixWidth, pixHeight;

Pix[][] pix = new Pix[num][numH];

boolean sketchFullScreen() {
  return true;
}

void setup() {
  
  size(displayWidth, displayHeight);
  textFont( createFont("DFKai-SB Regular", 48) );
  
  
  yubound = 30;
  ylbound = (height >> 1) - 10;
  xrbound = (width >> 2) - 64;
  xpos=random(0, xrbound);
  ypos=random(yubound, ylbound);
  fpos=random(0, xrbound);
  hpos=random(yubound, ylbound);
  
  distance = 0;
  ppmouseX = (width >> 3) * 3;
  ppmouseY = height >> 2;
  div4 = new int[4];
  angleobj = new float[4];
  
  mouseXX = (width >> 1) + (width >> 2);
  swingunit = 5;
  
  mywish = "英國外交官羅伯特．庫伯注意到現代歐洲國家這樣的特質，將之定位為後現代國家。";
  
  weburl = loadImage("girl_with_pearl_earbuds.jpg");
  if( weburl.width > (width >> 1) || weburl.height > (height >> 1) )
    weburl.resize(width >> 1, height >> 1);
  createBoids(weburl);
  
  pixWidth = weburl.width / num;
  pixHeight = weburl.height / numH;
  if(pixWidth == 0)
    pixWidth = 1;
  if(pixHeight == 0)
    pixHeight = 1;
  int imgWidth = pixWidth * num;
  for (int i=0; i<num; i+=pixWidth){
    for (int j=0; j<numH; j+=pixHeight){
      pix[i][j] = new Pix(i + (width >> 1) + ( (width >> 2) - (num >> 2) ), j + (height >> 1), random(-1, 1), random(1, 2), i, j, random(0.1, 0.5), pixWidth, pixHeight);
    }
  }
}

void draw() {
  if(!mywish.equals("none"))
  {
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
    angleObject = (TWO_PI/numObjects);
    div4[0] = numObjects;
    for(int ii=0; ii< 4; ii++)
    {
      angleobj[ii] = (angleObject / 5) * (ii+1);
      div4[ii] = numObjects * (ii+1); 
    }
    
    mywish3 = mywish.length() > 8 ? mywish.substring(0,8): mywish;
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
  
  if(second()%10 == 1 && lastSecond!=second())
  {
    fill(0);
    rect(0, height >> 1, width >> 1, height >> 1);
    minBrightness = 50;
    createBoids(weburl);
    lastSecond = second();
  }
  else
  {
    loadPixels();
    for (int i=0;i<boids.size();i++)
    {
      Boid b=(Boid)boids.get(i);
      /*
      if (mouseDownR)
        b.mDownR();
      if (mouseDownL)
        b.mDown();
      if (mouseDownR==false&&mouseDownL==false)
      */
        b.mUp();
    }
    fastBlur(g, 1);
    updatePixels();
  }
  
      fill(0);
      rect(width >> 1, height >> 1, width >> 1, height >> 1);
  
      if( second()%15 == 2 && lastSecond!=second() )
      {
        for(int i=0; i<num; i+=pixWidth){
          for(int j=0; j<numH; j+=pixHeight){
            pix[i][j] = new Pix(i + (width >> 1) + ( (width >> 2) - (num >> 2) ), j + (height >> 1), random(-1, 1), random(1, 2), i, j, random(0.1, 0.5), pixWidth, pixHeight);
          }
        }
        mouseState=0;
        lastSecond = second();
      }
      else
      {
       
        if( second()% 15 == 4 && lastSecond!=second())
          mouseState=1;
        for(int i=0; i<num; i+=pixWidth){
          for(int j=0; j<numH; j+=pixHeight){
  
            color pixel = weburl.get(i * pixWidth, j * pixHeight);
            fill(pixel, 200);
            pix[i][j].display();
      
            if(keyState==1){
              mouseState=0;
              pix[i][j].reform();
            }
            else if(mouseState==1){
              keyState=0;
              pix[i][j].move();
            }
        
          }
        }
      }
}

float myNoise(float x)
{
  //float val = 4.0*(noise(x)-0.25);
  //float val = noise(x);
  float val = 2.0*(noise(x)-0.5);
  //println(val);
  return val;
}

void fastBlur(PImage img, int radius) {

  if (radius<1) {
    return;
  }
  int w=width;
  int h=height;
  int wm=w-1;
  int hm=h-1;
  int wh=w*h;
  int div=radius+radius+1;
  int r[]=new int[wh];
  int g[]=new int[wh];
  int b[]=new int[wh];
  int rsum, gsum, bsum, fx, fy, i, p, p1, p2, yp, yi, yw;
  int vmin[] = new int[max(w, h)];
  int vmax[] = new int[max(w, h)];
  int[] pix = img.pixels;
  int dv[]=new int[256*div];
  for (i=0;i<256*div;i++) {
    dv[i]=(i/div);
  }

  yw=yi=0;

  for (fy=0;fy<h;fy++) {
    rsum=gsum=bsum=0;
    for (i=-radius;i<=radius;i++) {
      p=pix[yi+min(wm, max(i, 0))];
      rsum+=(p & 0xff0000)>>16;
      gsum+=(p & 0x00ff00)>>8;
      bsum+= p & 0x0000ff;
    }
    for (fx=0;fx<w;fx++) {

      r[yi]=dv[rsum];
      g[yi]=dv[gsum];
      b[yi]=dv[bsum];

      if (fy==0) {
        vmin[fx]=min(fx+radius+1, wm);
        vmax[fx]=max(fx-radius, 0);
      }
      p1=pix[yw+vmin[fx]];
      p2=pix[yw+vmax[fx]];

      rsum+=((p1 & 0xff0000)-(p2 & 0xff0000))>>16;
      gsum+=((p1 & 0x00ff00)-(p2 & 0x00ff00))>>8;
      bsum+= (p1 & 0x0000ff)-(p2 & 0x0000ff);
      yi++;
    }
    yw+=w;
  }

  for (fx=0;fx<w;fx++) {
    rsum=gsum=bsum=0;
    yp=-radius*w;
    for (i=-radius;i<=radius;i++) {
      yi=max(0, yp)+fx;
      rsum+=r[yi];

      gsum+=g[yi];
      bsum+=b[yi];
      yp+=w;
    }
    yi=fx;
    for (fy=0;fy<h;fy++) {
      pix[yi]=0xff000000 | (dv[rsum]<<16) | (dv[gsum]<<8) | dv[bsum];
      if (fx==0) {
        vmin[fy]=min(fy+radius+1, hm)*w;
        vmax[fy]=max(fy-radius, 0)*w;
      }
      p1=fx+vmin[fy];
      p2=fx+vmax[fy];

      rsum+=r[p1]-r[p2];
      gsum+=g[p1]-g[p2];
      bsum+=b[p1]-b[p2];

      yi+=w;
    }
  }
}

void createBoids(PImage img)
{
  boids = new ArrayList(); 
  for (int i=0;i<img.width;i++)
  {
    for (int j=0;j<img.height;j++)
    {
      color c = img.get(i, j);
      if (brightness(c)>minBrightness)
        boids.add(new Boid(new PVector((width>>1)*i*1.0/img.width, (height>>1)*j*1.0/img.height), c));
    }
  }
}
