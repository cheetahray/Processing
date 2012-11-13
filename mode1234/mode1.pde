// Learning Processing
// Daniel Shiffman
// http://www.learningprocessing.com

// Example 16-4: Display QuickTime movie

import processing.video.*;

// Step 1. Declare Movie object
Movie movie; 
WeatherGrabber wg;
int lastSecond, weatherHttpSeconds;

boolean sketchFullScreen() {
  return true;
}

void setup() {
  //size(displayWidth, displayHeight, P3D);
  size(320,240);
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
  }
  /*
  else if( abs( lastSecond - second() ) == (weatherHttpSeconds >> 1) )
  {
     println(wg.getWeather());
     println(wg.getTemp());
     println(wg.getSpeed());
     println(wg.getCode());
     lastSecond = second();
  }
  */
}

void draw() {
  // Step 5. Display movie.
  image(movie,0,0);
  
}
