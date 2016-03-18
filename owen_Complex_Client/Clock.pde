void tick() {
  clock = System.currentTimeMillis();
}

long toLong(String input) {
  if (input.indexOf('E') < 0) {
    return Long.parseLong(input);
  }
  else {
    return 0;
  }
}