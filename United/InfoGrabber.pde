// Learning Processing
// Daniel Shiffman
// http://www.learningprocessing.com

// Example 18-5: Parsing Yahoo's XML weather feed manually

// A WeatherGrabber class
class infoGrabber {
  
  String weburl;
  String wish = "";
  
  // Get the weather
  String getWish() {
    return wish;
  }
  
  String getImg() {
    return weburl;
  }
  
  // Make the actual XML request
  void requestInfo() {
    // Get all the HTML/XML source code into an array of strings
    // (each line is one element in the array)
    String url = "http://ftp.daf.org.tw/wishing.php"; //"http://xml.weather.yahoo.com/forecastrss?p=" + zip;
    String[] lines = loadStrings(url);
    
    // Turn array into one long String
    String xml = join(lines, "" ); 
    
    String lookfor = "<url>";
    String eend = "</url>";
    weburl = giveMeTextBetween (xml,lookfor, eend);

    // Searching for weather condition
    lookfor = "<text>";
    eend = "</text>";
    wish = giveMeTextBetween(xml,lookfor,eend);
   
  }
  
  // A function that returns a substring between two substrings
  String giveMeTextBetween(String s, String before, String after) {
    String found = "";
    int start = s.indexOf(before);    // Find the index of the beginning tag
    if (start == - 1) return"";       // If we don't find anything, send back a blank String
    start += before.length();         // Move to the end of the beginning tag
    int end = s.indexOf(after,start); // Find the index of the end tag
    if (end == -1) return"";          // If we don't find the end tag, send back a blank String
    return s.substring(start,end);    // Return the text in between
  }
  
  // A function that returns a substring between two substrings
  String giveRayTextBetween(String s, String before, String after, int begin) {
    String found = "";
    int start = s.indexOf(before, begin);    // Find the index of the beginning tag
    if (start == - 1) return"";       // If we don't find anything, send back a blank String
    start += before.length();         // Move to the end of the beginning tag
    int end = s.indexOf(after,start); // Find the index of the end tag
    if (end == -1) return"";          // If we don't find the end tag, send back a blank String
    return s.substring(start,end);    // Return the text in between
  }
  
}
