/* OpenProcessing Tweak of *@*http://www.openprocessing.org/sketch/6909*@* */
/* !do not delete the line above, required for linking your tweak if you re-upload */
import java.util.Arrays;

String mywish = "啥米碗糕啥米碗糕";

float[] xpositions;
float[] c_offsets;
float[] theta_offsets;

float FONTSIZE;

int num_letters = 125;
float max_c = 3.0;
float max_theta = 5*PI/num_letters;
float c_time;
float theta_time;
float lastMillis;
float c_speed = 0.2;
float theta_speed = 0.1;

boolean sketchFullScreen() {
  return true;
}

float myNoise(float x)
{
  //float val = 4.0*(noise(x)-0.25);
  //float val = noise(x);
  float val = 2.0*(noise(x)-0.5);
  //println(val);
  return val;
}

void setup()
{
  size(displayWidth, displayHeight);
  //noiseDetail(3,0.5);
  //hint(ENABLE_NATIVE_FONTS);
  FONTSIZE = (displayWidth >> 3)/mywish.length();
  textFont( createFont("DFKai-SB Regular", FONTSIZE) );
  textSize(FONTSIZE);
  xpositions = new float[mywish.length()];
  c_offsets = new float[mywish.length()];
  theta_offsets = new float[mywish.length()];
  float mywishlength = textWidth(mywish);
  float letterpos = ( (width >> 2) - mywishlength ) / 2.0 + (width >> 1);
  for(int i = 0; i < mywish.length(); ++i) {
    c_offsets[i] = random(1000.);
    theta_offsets[i] = random(1000.);
    xpositions[i] = letterpos;
    float letterwidth = textWidth(mywish.charAt(i));
    letterpos += letterwidth;
  }
  c_time = millis()/1000.0;
  theta_time = millis()/1000.0;
  lastMillis = millis()/1000.0;
}

void draw()
{
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
  for(int i = 0; i < mywish.length(); ++i) {
    float c = max_c*myNoise(c_offsets[i] + c_time);
    float theta = max_theta*myNoise(theta_offsets[i] + theta_time);
    fill(255);
    text(mywish.charAt(i), xpositions[i], y_0);
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
      text(mywish.charAt(i),0,0);
      popMatrix();
    }
  }
}
  
