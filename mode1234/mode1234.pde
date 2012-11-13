// Learning Processing
// Daniel Shiffman
// http://www.learningprocessing.com

// Example 16-4: Display QuickTime movie

import processing.video.*;

// Step 1. Declare Movie object
Movie movie; 
WeatherGrabber wg;
int lastSecond, weatherHttpSeconds, numDrops, rainlength, windspeed;
Drop [] drops = new Drop[50];
int randomhigh;

boolean sketchFullScreen() {
  return true;
}

void setup() {
  size(displayWidth, displayHeight);
  //size(320,240);
  randomhigh = displayHeight/16;
  for(int i = 0; i < drops.length; i++)
  {
    drops[i] = new Drop();
  }
  weatherHttpSeconds = 10;
  // Step 2. Initialize Movie object
  // Movie file should be in data folder
  movie = new Movie(this, "cat.mov"); 
  wg = new WeatherGrabber();//zips[counter]);
  // Step 3. Start movie playing
  movie.loop();
}

// Step 4. Read new frames from movie
void movieEvent(Movie movie) {
  movie.read();
  if( second() % weatherHttpSeconds == 0 && lastSecond != second() )
  {
     wg.requestWeather(); 
     lastSecond = second();
     numDrops = (int)map(getAlpha(3), 50, 200, 0, drops.length);
     rainlength = (int)map(getAlpha(3), 50, 200, randomhigh >> 1, randomhigh );
     windspeed = wg.getSpeed() / 6;
  }
  /*
  else if( abs( lastSecond - second() ) == (weatherHttpSeconds >> 1) )
  {
     println(numDrops);
     println(rainlength);
     println(windspeed);
     //println(wg.getCode());
     lastSecond = second();
  }
  */
}

void draw() {
  // Step 5. Display movie.
  image(movie,0,0);
  fill(255, getAlpha(3));
  noStroke();
  for(int i = 0; i <numDrops; i++)
  {
    drops[i].display(rainlength);
    drops[i].fall(windspeed);
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
        i = 0;
      break;
    }  
    return i;
  }
