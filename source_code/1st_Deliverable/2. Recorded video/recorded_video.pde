import processing.video.*;
Movie myMovie;

void setup() {
  size(1280, 720);
  myMovie = new Movie(this, "Fuego_de_Refineria.mp4");
  myMovie.loop();
}

void draw() {
  image(myMovie, 0, 0);
}

void movieEvent(Movie m) {
  m.read();
}
