int adjustX, adjustY;

boolean sketchFullScreen() 
{
  return true;
}

void setup()
{
  size(displayWidth, displayHeight);
  textFont(createFont("FFScala", 196));
  adjustX = 50;
  adjustY = 50;
}

void draw()
{
  text("1", (width >> 3) - adjustX, (height >> 2) + adjustY );
  text("2", (width >> 3) - adjustX, (height >> 2) + (height >> 1) + adjustY );
  text("3",  (width >> 3) + (width >> 2) - adjustX, (height >> 2)  + adjustY );
  text("4", (width >> 3) + (width >> 2) - adjustX, (height >> 2) + (height >> 1)  + adjustY );
  text("5", (width >> 3) + (width >> 1) - adjustX, (height >> 2)  + adjustY );
  text("6", (width >> 3) + (width >> 1) - adjustX, (height >> 2) + (height >> 1)  + adjustY );
  text("7", (width >> 3) + (width >> 2) + (width >> 1) - adjustX, (height >> 2)  + adjustY );
  text("8", (width >> 3) + (width >> 2) + (width >> 1) - adjustX, (height >> 2) + (height >> 1)  + adjustY );
}
