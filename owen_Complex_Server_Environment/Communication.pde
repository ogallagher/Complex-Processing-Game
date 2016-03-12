void listen() {
  if (client.available() > 0) {
    String text = client.readString();
    //println("Incoming: " + text);
    
    String requestText = extractString(text,requestHD,endHD);
    
    if (requestText.indexOf(nameID + "ENV" + endID) > -1) {
      sendEnvironment();
      println("SENDING ENVIRONMENT");
    }
  }
}

void sendEnvironment() {  
  broadcast(blockHD + environment.substring(0,100) + endHD);
}

void broadcast(String text) {
  if (text.length() > 0) {
    client.write(text);
  }
}

String extractString(String text, String begin, String end) {
  String extracted = "";
  int i = text.indexOf(begin) + 1;

  if (i - 1 > -1) {
    int j = text.indexOf(end, i);                  //indexOf("",i) == first index of "" after index i.

    if (j > -1 && i > -1) {                        //just in case
      extracted = text.substring(i, j);
    }
  }

  return extracted;
}