/* OpenProcessing Tweak of *@*http://www.openprocessing.org/sketch/40071*@* */
/* !do not delete the line above, required for linking your tweak if you re-upload */
String mywish;
int numObjects;
int distance;
float angleObject;
int ppmouseX, ppmouseY;
int div4[];
float rotaterate;
float angleobj[];

boolean sketchFullScreen() {
  return true;
}

void setup()
{
  //  "If I had a world of my own, everything would be nonsense. Nothing would be what it is because everything would be what it isn't. And contrary-wise; what it is it wouldn't be, and what it wouldn't be, it would. You see?"
  size(displayWidth, displayHeight);
  textFont( createFont("DFKai-SB Regular", 50) );
  textSize(25);
  mywish = "英國外交官羅伯特．庫伯注意到現代歐洲國家這樣的特質，將之定位為後現代國家。";
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
}

void draw()
{
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
  
}

