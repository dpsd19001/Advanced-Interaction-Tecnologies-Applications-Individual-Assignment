import gab.opencv.*;
import processing.video.*;

//καμερα
Capture video;
OpenCV opencv;


void setup() {
  size(400, 300);
  
  video = new Capture(this, 400, 300, "pipeline: autovideosrc");
  video.start(); 
  opencv = new OpenCV(this, 400, 300);

  opencv.startBackgroundSubtraction(5, 3, 0.5);
}

void draw() {
  image(video, 0, 0);

  if (video.width == 0 || video.height == 0)
    return;

  opencv.loadImage(video);
  opencv.updateBackground();

  opencv.dilate();
  opencv.erode();

  noFill();
  stroke(255, 16, 240);
  strokeWeight(3);
  for (Contour contour : opencv.findContours()) {
    contour.draw();
  }
}

void captureEvent(Capture video) {
  video.read();
}
