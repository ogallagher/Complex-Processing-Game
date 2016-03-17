void tick() {
  clock = System.currentTimeMillis();
  println("T: " + clock);
}

long toLong(String input) {
  return Long.parseLong(input);
}