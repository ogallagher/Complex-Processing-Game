void tick() {
  clock = System.currentTimeMillis();
  println("T: " + clock);
}

String longToString(long input) {
  String time = "";
  
  for (int i=9; i>0; i--) {
    int place = int(pow(10,i));
    time += str(round((input % place) / (place / 10)));
  }
  
  return time;
}