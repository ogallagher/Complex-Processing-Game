void listen() {
  if (client.available() > 0) {
    String text = client.readString();    
    
    String requestText = "";
    if (text.indexOf(requestHD) > -1) {
      if (text.indexOf(endHD, text.indexOf(requestHD)) > -1) {
        requestText = extractString(text, requestHD, endHD);
      }
      else {
        requestText = text.substring(text.indexOf(requestHD) + 1);
      }
    }
    if (requestText.length() > 0) {
      analyzeRequests(requestText);
    }    
  }
}

void analyzeRequests(String text) {
  int start = -1;
  
  while (text.indexOf(nameID,start) > -1) {
    int end = text.indexOf(nameID,start) + 1;
    String request;
    
    if (text.indexOf(nameID,end) < 0) {
      request = text.substring(text.indexOf(nameID,start));
    }
    else {
      request = text.substring(text.indexOf(nameID,start),text.indexOf(nameID,end));
    }
    
    if (request.indexOf("ENV") > -1) {
      int blockNumber = int(extractString(request,locationID,endID));
      requests.append(blockNumber);
      println("BLOCK.#: " + blockNumber);
    }
    
    start = text.indexOf(nameID,start) + request.length();
  }
}

void sendEnvironment() {
  int requested = requests.get(0);
  requests.remove(0);
  
  for (int i=requests.size()-1; i>-1; i--) {
    if (requests.get(i) == requested) {
      requests.remove(i);
    }
  }
  
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