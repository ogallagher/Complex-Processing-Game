void updateKeys() {
  if (keyPressed) {
    if (key == 'w') {
      keys[0] = true;
    }
    if (key == 'a') {
      keys[1] = true;
    }
    if (key == 's') {
      keys[2] = true;
    }
    if (key == 'd') {
      keys[3] = true;
    }
    if (key == 'e') {
      keys[4] = true;
    }
    if (key == ' ') {
      keys[5] = true;
    }
  }
  
  /*for (int i=0; i<keys.length; i++) {
    println('[' + i + "] " + keys[i]);
  }*/
}

void keyReleased() {
  if (key == 'w') {
    keys[0] = false;
  }
  if (key == 'a') {
    keys[1] = false;
  }
  if (key == 's') {
    keys[2] = false;
  }
  if (key == 'd') {
    keys[3] = false;
  }
  if (key == 'e') {
    keys[4] = false;
  }
  if (key == ' ') {
    keys[5] = false;
  }
}