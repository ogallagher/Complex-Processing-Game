void tick() {
  clock = System.currentTimeMillis();
}

long toLong(String input) {
  if (input.length() > 0) {
    return Long.parseLong(input);
  }
  else {
    return 0;
  }
}

String longToString(long input) {
  String time = "";
  
  for (int i=9; i>0; i--) {
    int place = int(pow(10,i));
    time += str(round((input % place) / (place / 10)));
  }
  
  return time;
}