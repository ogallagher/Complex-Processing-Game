void echo() {                                                      //NOTE: the central server will be getting multiple of each header, eventually. It then consolidates them before sending again.
  Client client = server.available();
  if (client != null) {
    String text = client.readString();
    
    String requestText = searchString(text,requestHD,endHD);
    String blockText = searchString(text,blockHD,endHD);
    String playerText = searchString(text,playerHD,endHD);
    
    broadcast(requestHD + requestText + endHD);
    broadcast(blockHD + blockText + endHD);
    broadcast(playerHD + playerText + endHD);
  }
}

String searchString(String text, String head, String foot) {      //Find all received data that falls into this type of head-foot interval and join them together
  String occurences = "";
  int start = -1;
  
  while (text.indexOf(head,start) > -1) {
    int end = text.indexOf(head,start) + 1;
    String occurence;
    
    if (text.indexOf(head,end) < 0) {
      occurence = text.substring(text.indexOf(head,start));
    }
    else {
      occurence = text.substring(text.indexOf(head,start),text.indexOf(head,end));
    }
    
    occurences += extractString(occurence,head,foot);
    
    start = text.indexOf(head,start) + occurence.length();
  }
  
  return occurences;
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