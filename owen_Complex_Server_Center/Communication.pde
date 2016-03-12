void listen() {                                                      //NOTE: the central server will be getting multiple of each header, eventually. It then consolidates them before sending again.
  Client client = server.available();
  if (client != null) {
    String text = client.readString();
    String address = extractString(text,addressID,endID);
    
    String requestText = extractString(text,requestHD,endHD);
    println("REQUEST: " + requestText);
    String blockText = extractString(text,blockHD,endHD);
    println("BLOCKS: " + blockText.length());
    
    broadcast(requestHD + requestText + endHD);
    broadcast(blockHD + blockText + endHD);
  }
}

void broadcast(String text) {
  if (text.length() > 0) {
    server.write(text);
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