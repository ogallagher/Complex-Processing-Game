void initializeSound() {
  sounds[0] = new SoundFile(this, "testMono.wav");
  
  sounds[0].loop();
}

void playSounds() {
  sounds[0].pan(map(mouseX, 0, width, -1.0, 1.0));
}