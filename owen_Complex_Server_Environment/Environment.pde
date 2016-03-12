void loadEnvironment() {
  for (int z=0; z<(complexWidth*cubicleWidth*blockWidth); z+=(cubicleWidth*blockWidth)) {
    for (int y=0; y<(complexWidth*cubicleWidth*blockWidth); y+=(cubicleWidth*blockWidth)) {
      for (int x=0; x<(complexWidth*cubicleWidth*blockWidth); x+=(cubicleWidth*blockWidth)) {
        cubicles.add(new Cubicle(new PVector(x + (width/2) - (0.5*(complexWidth-1)*cubicleWidth*blockWidth),y + (height/2) - (0.5*(complexWidth-1)*cubicleWidth*blockWidth),z - (0.5*(complexWidth-1)*cubicleWidth*blockWidth))));
      }
    }
  }
}

//Delete single blocks that overlap each other
void compressEnvironment() {
  int removed = 0;
  
  for (int cub=0; cub<cubicles.size(); cub++) {
    for (int fac=0; fac<cubicles.get(cub).faces.size(); fac++) {
      for (int fea=0; fea<cubicles.get(cub).faces.get(fac).features.size(); fea++) {
        for (int blo=0; blo<cubicles.get(cub).faces.get(fac).features.get(fea).blocks.size(); blo++) {
          for (int cub2=0; cub2<cubicles.size(); cub2++) {
            for (int fac2=0; fac2<cubicles.get(cub2).faces.size(); fac2++) {
              for (int fea2=0; fea2<cubicles.get(cub2).faces.get(fac2).features.size(); fea2++) {
                for (int blo2=0; blo2<cubicles.get(cub2).faces.get(fac2).features.get(fea2).blocks.size(); blo2++) {
                  Block block1 = cubicles.get(cub).faces.get(fac).features.get(fea).blocks.get(blo);
                  Block block2 = cubicles.get(cub2).faces.get(fac2).features.get(fea2).blocks.get(blo2);
                  
                  if (!(cub == cub2 && fac == fac2 && fea == fea2 && blo == blo2)) {
                    if (cubicles.get(cub).faces.get(fac).features.get(fea).type == 2 && cubicles.get(cub2).faces.get(fac2).features.get(fea2).type == 2) {
                      if (abs(block1.location.x - block2.location.x) < (block1.dimensions.x*0.5 + block2.dimensions.x*0.5) && abs(block1.location.y - block2.location.y) < (block1.dimensions.y*0.5 + block2.dimensions.y*0.5) && abs(block1.location.z - block2.location.z) < (block1.dimensions.z*0.5 + block2.dimensions.z*0.5)) {
                        if (block2.dimensions.x > blockWidth) {
                          if (block1.location.x < block2.location.x) {
                            block2.dimensions.x -= blockWidth;
                            block2.location.x += blockWidth*0.5;
                            removed += cubicleWidth;
                          }
                          else if (block1.location.x > block2.location.x) {
                            block2.dimensions.x -= blockWidth;
                            block2.location.x -= blockWidth*0.5;
                            removed += cubicleWidth;
                          }
                        }
                        if (block2.dimensions.y > blockWidth) {
                          if (block1.location.y < block2.location.y) {
                            block2.dimensions.y -= blockWidth;
                            block2.location.y += blockWidth*0.5;
                            removed += cubicleWidth;
                          }
                          else if (block1.location.y > block2.location.y) {
                            block2.dimensions.y -= blockWidth;
                            block2.location.y -= blockWidth*0.5;
                            removed += cubicleWidth;
                          }
                        }
                        if (block2.dimensions.z > blockWidth) {
                          if (block1.location.z < block2.location.z) {
                            block2.dimensions.z -= blockWidth;
                            block2.location.z += blockWidth*0.5;
                            removed += cubicleWidth;
                          }
                          else if (block1.location.z > block2.location.z) {
                            block2.dimensions.z -= blockWidth;
                            block2.location.z -= blockWidth*0.5;
                            removed += cubicleWidth;
                          }
                        }
                      }
                    }
                    else if ((cubicles.get(cub).faces.get(fac).features.get(fea).type == 1 && cubicles.get(cub2).faces.get(fac2).features.get(fea2).type == 1) && (block1.location.equals(block2.location))) {
                        cubicles.get(cub2).faces.get(fac2).features.get(fea2).blocks.remove(blo2);
                        blo2--;
                        removed++;
                    }
                    else if ((cubicles.get(cub).faces.get(fac).features.get(fea).type == 2 || cubicles.get(cub).faces.get(fac).features.get(fea).type == 3 || cubicles.get(cub).faces.get(fac).features.get(fea).type == 4 || cubicles.get(cub).faces.get(fac).features.get(fea).type == 5) && cubicles.get(cub2).faces.get(fac2).features.get(fea2).type == 1) {
                      if (abs(block1.location.x - block2.location.x) < (block1.dimensions.x*0.5 + blockWidth*0.5) && abs(block1.location.y - block2.location.y) < (block1.dimensions.y*0.5 + blockWidth*0.5) && abs(block1.location.z - block2.location.z) < (block1.dimensions.z*0.5 + blockWidth*0.5)) {
                        cubicles.get(cub2).faces.get(fac2).features.get(fea2).blocks.remove(blo2);
                        blo2--;
                        removed++;
                      }
                    }
                  }
                }
              }
            }
          }
        }
      }
    }
  }
  
  println("Removed " + removed + " extraneous blocks.");
}

void recordEnvironment() {
  for (int cub=0; cub<cubicles.size(); cub++) {
    for (int fac=0; fac<cubicles.get(cub).faces.size(); fac++) {
      for (int fea=0; fea<cubicles.get(cub).faces.get(fac).features.size(); fea++) {
        for (int blo=0; blo<cubicles.get(cub).faces.get(fac).features.get(fea).blocks.size(); blo++) {
          Block block = cubicles.get(cub).faces.get(fac).features.get(fea).blocks.get(blo);
          
          String location = locationID + str(int(block.location.x / blockWidth)) + ',' + str(int(block.location.y / blockWidth)) + ',' + str(int(block.location.z / blockWidth)) + endID;
          String dimensions = dimensionsID + str(int(block.dimensions.x / blockWidth)) + ',' + str(int(block.dimensions.y / blockWidth)) + ',' + str(int(block.dimensions.z / blockWidth)) + endID;
          
          environment.append(location + dimensions);
        }
      }
    }
  }
}