PImage weburl;
int num = 300, numH = 300; //number of particles
int mouseState = 0; //int for toggling gravity
int keyState = 0; //int for toggling image reform
int pixWidth, pixHeight, lastSecond;

Pix[][] pix = new Pix[num][numH];

boolean sketchFullScreen() {
  return true;
}

void setup(){
  size(displayWidth, displayHeight, P2D);
  weburl = loadImage("1.jpg");
  if( weburl.width > (width >> 1) || weburl.height > (height >> 1) )
    weburl.resize(width >> 1, height >> 1);
  noStroke();
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

void draw(){
  fill(0);
  rect(width >> 1, height >> 1, width >> 1, height >> 1);
  
      if( second()%15 == 0 && lastSecond!=second() )
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
       
        if( second()% 5 == 0 && lastSecond!=second())
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
/*
void mousePressed(){
  keyState=0;
  mouseState+=1;
  if (mouseState>1){
    mouseState=0;
  }
}

void keyPressed(){
  if (key==32){
    keyState+=1;
    mouseState=0;
    if(keyState>1){
      keyState=0;
    }
  }
}
*/
class Pix{
  float x, y;
  float nx, ny;
  float ox, oy;
  float gravity;
  int w,h;
  int del=16;

  Pix(float _x, float _y, float _nx, float _ny, float _ox, float _oy, float _gravity, int _w, int _h){
    x = _x;
    y = _y;
    nx = _nx;
    ny = _ny;
    ox = _ox;
    oy = _oy;
    gravity = _gravity;
    w = _w;
    h = _h;
  }

  void display(){
    noStroke();
    //rectMode(CENTER);
    rect(x, y, w, h);
  }

  void move(){
    x = x+nx+gravity;
    y = y+ny+gravity;

    if(y>height || y< (height >> 1) ){
      ny = ny * -0.4;
    }
    if(x>width || x< (width >> 1) ){
      nx = nx * -0.4;
    }
  }

  void reform(){
    x+=(ox-x)/del;
    y+=(oy-y)/del;
  }
}


