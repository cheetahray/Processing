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

