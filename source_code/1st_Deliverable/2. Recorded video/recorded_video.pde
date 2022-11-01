import processing.video.*;

// Example 16-4: Display QuickTime movie

import processing.video.*;

// Step 1. Declare Movie object
Movie movie; 

void setup() {
  size(1280, 720);

  // Step 2. Initialize Movie object
  // Movie file should be in data folder
  movie = new Movie(this, "Fuego_de_Refineria.mp4"); 

  // Step 3. Start movie playing
  movie.loop();
}

// Step 4. Read new frames from movie
void movieEvent(Movie movie) {
  movie.read();
}

void draw() {
  // Step 5. Display movie.
  image(movie, 0, 0);
}
