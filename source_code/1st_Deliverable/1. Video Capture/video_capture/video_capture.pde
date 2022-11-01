import processing.video.*;

// Example 16-1: Display video

// Step 1. Import the video library
import processing.video.*;

// Step 2. Declare a Capture object
Capture video;

void setup() {
  size(500, 500);
  println(Capture.list());

  // Step 3. Initialize Capture object via Constructor
  // Use the default camera at 320x240 resolution
  video = new Capture(this, "pipeline:autovideosrc");
  video.start();
}

// An event for when a new frame is available
void captureEvent(Capture video) {
  // Step 4. Read the image from the camera.
  video.read();
}

void draw() {
  // Step 5. Display the video image.
  image(video, 0, 0);
}
