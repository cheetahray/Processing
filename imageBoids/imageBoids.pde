/* OpenProcessing Tweak of *@*http://www.openprocessing.org/sketch/65958*@* */
/* !do not delete the line above, required for linking your tweak if you re-upload */
/* OpenProcessing Tweak of *@*http://www.openprocessing.org/sketch/6658*@* */
/* !do not delete the line above, required for linking your tweak if you re-upload */
ArrayList boids = new ArrayList();
PImage weburl;
/*
boolean mouseDownL= false;
boolean mouseDownR = false;
*/
PGraphics pg;
float minBrightness = 80;
int lastSecond;

boolean sketchFullScreen() {
  return true;
}

void setup()
{
  size(displayWidth, displayHeight);
  background(0);
  weburl = loadImage("girl_with_pearl_earbuds.jpg");
  if( weburl.width > (width >> 1) || weburl.height > (height >> 1) )
    weburl.resize(width >> 1, height >> 1);
  createBoids(weburl);
}

void draw()
{
  if(second()%15 == 0 && lastSecond!=second())
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
}
/*
void mousePressed()
{
  if (mouseButton==LEFT)
    mouseDownL = true;
  if (mouseButton==RIGHT)
    mouseDownR = true;
}

void mouseReleased()
{
  if (mouseButton==LEFT)
    mouseDownL = false;
  if (mouseButton==RIGHT)
    mouseDownR = false;
}
*/
// Super Fast Blur v1.1 by Mario Klingemann
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
/*
void keyPressed()
{
  if (key==' ')
  {
    for (int i=0; i<boids.size(); i++)
    {
      Boid b=(Boid)boids.get(i);
      b.vel = new PVector(random(-100, 100), random(-100, 100));
    }
  }
  else if (key-48 > 0 && key-48 < 4)
  {
    switch (key)
    {
    case '1':
      minBrightness = 50;
      createBoids(weburl);
      break;
    case '2':
      minBrightness = 0;
      createBoids(pic2);
      break;
    default:
      minBrightness = 200;
      createBoids(pic3);
    }
  }
}
*/
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

