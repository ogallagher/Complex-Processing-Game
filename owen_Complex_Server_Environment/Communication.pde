void listen() {
  if (client.available() > 0) {
    String text = client.readString();
    //println("Incoming: " + text);
    
    String requestText = extractString(text,requestHD,endHD);                //Eventually, this will have to take multiple requested blockNumbers
    
    if (requestText.indexOf(nameID + "ENV" + endID) > -1) {
      int blockNumber = int(extractString(requestText,locationID,endID));
      sendEnvironment(blockNumber);
      println("REQUESTED: " + blockNumber);
    }
  }
}

void sendEnvironment(int requested) {
  if (requested == -1) {
    broadcast(blockHD + descriptionID + str(blockWidth) + ',' + str(cubicleWidth) + ',' + str(complexWidth) + ',' + str(environment.size()) + endID + endHD);
  }
  else {
    String broadcast = blockHD;
    
    for (int i=requested; i<requested+200 && i<environment.size(); i++) {
      broadcast += nameID + str(i) + endID + environment.get(i);
    }
    
    broadcast += endHD;
    
    broadcast(broadcast);
  }
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