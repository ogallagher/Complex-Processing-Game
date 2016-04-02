void initializeSound() {
  sounds[0] = new SoundFile(this, "testMono.wav");
  sounds[1] = new SoundFile(this, "impact1.wav");
  sounds[2] = new SoundFile(this, "impact2.wav");
}

void playSound(int id, PVector aspects) {
  constrain(aspects.x,0,1);
  
  sounds[id].play();
  sounds[id].amp(aspects.x);
  sounds[id].pan(aspects.y);
}