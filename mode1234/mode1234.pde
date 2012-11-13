// Learning Processing
// Daniel Shiffman
// http://www.learningprocessing.com

// Example 16-4: Display QuickTime movie

import processing.video.*;

// Step 1. Declare Movie object
Movie movie; 
WeatherGrabber wg;
infoGrabber ifg;
int lastSecond, weatherHttpSeconds, numDrops, rainlength, windspeed;
Drop [] drops = new Drop[75];
int randomhigh;
String mywish, myurl;
PImage weburl;
int starttime;
int curtime;

boolean sketchFullScreen() {
  return true;
}

void setup() {
  size(displayWidth, displayHeight);
  //size(320,240);
  randomhigh = displayHeight/12;
  myurl = "none";
  lastSecond = -1;
  starttime = -6000;
  textFont( createFont("DFKai-SB Regular", 80) );
  textSize(16);
  for(int i = 0; i < drops.length; i++)
  {
    drops[i] = new Drop();
  }
  weatherHttpSeconds = 10;
  // Step 2. Initialize Movie object
  // Movie file should be in data folder
  movie = new Movie(this, "cat.mov"); 
  wg = new WeatherGrabber();//zips[counter]);
  ifg = new infoGrabber();
  // Step 3. Start movie playing
  movie.loop();
}

// Step 4. Read new frames from movie
void movieEvent(Movie movie) {
  if(lastSecond != second())
  {
    float myAlpha = getAlpha(wg.getCode());
    if( second() % weatherHttpSeconds == 0 )
    {
       wg.requestWeather(); 
       numDrops = (int)map(myAlpha, 50, 200, 0, drops.length);
       rainlength = (int)map(myAlpha, 50, 200, randomhigh >> 1, randomhigh );
       windspeed = wg.getSpeed() / 6;
       starttime = millis();
       lastSecond = second();
    }
    else if( (millis() - starttime) / 1000 == ( weatherHttpSeconds >> 1 ) )
    {
       ifg.requestInfo();
       myurl = ifg.getImg();
       if(!myurl.equals("none"))
       {
          mywish = ifg.getWish();
          weburl = loadImage(myurl);
          weburl.resize(width,height);
       }
       //println(mywish);
       //println(windspeed);
       //println(map(wg.getSpeed(),0,50,1,2));
       //println(wg.getCode());
       if(myAlpha > 0 && abs(lastSecond - second()) > 1)
       {
         windspeed = -windspeed;
       }
       else
       {
         //movie.speed(map(wg.getSpeed(),0,50,1,2));
       }
       lastSecond = second();
    }
  }
  movie.read();
}

void draw() {
  // Step 5. Display movie.
  if(myurl.equals("none"))
  {
    image(movie,0,0);
    fill(255, getAlpha(wg.getCode()));
    noStroke();
    for(int i = 0; i <numDrops; i++)
    {
      drops[i].display(rainlength);
      drops[i].fall(windspeed);
    }
  }
  else
  {
    if(movie.time() > 0)
    {
      //println(movie.time());
      movie.stop();
      starttime = millis();
    }
    else if( (millis() - starttime) / 1000 <= 30 )
    {
      image(weburl,0, 0);
      fill(0);
      text(mywish, 0, 200);
    }
    else
    {
      myurl = "none";
      movie.loop(); 
    }
  }
}

  float getAlpha(int code)
  {
    float i = 0;
    switch(code)
    {
      case 3:
      case 37:
      case 38:
      case 39:
        i = random(190,200);
      break; 
      case 4:
        i = random(175,190);
      break;
      case 8:
      case 9:
        i = random(50,75);
      break;
      case 10:
      case 23:
        i = random(75,125);
      break;
      case 11:
      case 12:
        i = random(125,150);
      break;
      case 40:
      case 45:
      case 47:
        i = random(150,175);
      break;
      default:
        i = random(125,150);
      break;
    }  
    return i;
  }
