import java.util.Arrays;
int photosCount;
Photo[] allPhotos;
int rowNum;
int colNum;
int photoWidth;
int photoHeight;
int photosWidth = 650;

import generativedesign.*;
PImage img;
color[] colors;
int tileCount;
float rectSize;
String sortMode = null;

boolean checkStart = false;
boolean switchShape = false;
int switchShapeInt = 0;

int switchPhotos = 0;

void setup() {
  size(900, 900);
  background(255);
  noStroke();
  colorMode(HSB, 360, 100, 100, 100);

  rowNum = 7; //hang
  colNum = 3; //lie
  photoWidth = photosWidth/colNum;
  photoHeight = height/rowNum;

  loadPhotos();
  sortPhotos();
  drawPhotos();
  saveFrame("photos.png");

  img = loadImage("../photos.png");
  
  fill(0);
  textSize(15);
  text("tap to start", width/2+250,690);
  text("try key 1,2,3,4,5", width/2+250,720);
  text("try key r to change shapes", width/2+250,750);
}

void draw() {
  
  if (switchShapeInt%2 == 0){
    switchShape = false;
  }else{
    switchShape =true;
  }
  
  
  //background(255);
  tileCount = (int)map(mouseX, 0, width, 1, width/10);
  rectSize = width/ (float)tileCount;
  loadColor();
  sortColor();
  //drawColor();
  if (checkStart == true) {
    drawColor();
  } else {
    checkStart = false;
  }
  

}

void loadPhotos() {
  Table metaTable;
  if (switchPhotos == 0) {
    metaTable = loadTable("metadata.csv", "header");
    photosCount = metaTable.getRowCount();
    allPhotos = new Photo[photosCount];
    int index = 0;
    for ( TableRow row : metaTable.rows() ) {
      String fileName = row.getString("SourceFile");
      String fileDate = row.getString("CreateDate");
      int fileWidth = row.getInt("ImageWidth");
      int fileHeight = row.getInt("ImageHeight");

      Photo one = new Photo(fileName, fileDate, fileWidth, fileHeight);
      println(one.name, one.created.getTime());  //name? created? --> in the class
      allPhotos[index] = one;
      index ++;
    }
  } else if (switchPhotos == 6) { //it doesnt work
    println("switchphotos6");
    metaTable = loadTable("../data/top_data/top_data.csv", "header");
    photosCount = metaTable.getRowCount();
    allPhotos = new Photo[photosCount];
    int index = 0;
    for ( TableRow row : metaTable.rows() ) {
      String fileName = row.getString("SourceFile");
      String fileDate = row.getString("CreateDate");
      int fileWidth = row.getInt("ImageWidth");
      int fileHeight = row.getInt("ImageHeight");

      Photo one = new Photo(fileName, fileDate, fileWidth, fileHeight);
      println(one.name, one.created.getTime());  //name? created? --> in the class
      allPhotos[index] = one;
      index ++;
    }
  }
  //Table metaTable = loadTable("metadata.csv", "header");
  //photosCount = metaTable.getRowCount();
  //allPhotos = new Photo[photosCount];
  //int index = 0;
  //for ( TableRow row : metaTable.rows() ) {
  //  String fileName = row.getString("SourceFile");
  //  String fileDate = row.getString("CreateDate");
  //  int fileWidth = row.getInt("ImageWidth");
  //  int fileHeight = row.getInt("ImageHeight");

  //  Photo one = new Photo(fileName, fileDate, fileWidth, fileHeight);
  //  println(one.name, one.created.getTime());  //name? created? --> in the class
  //  allPhotos[index] = one;
  //  index ++;
  //}
}

void sortPhotos() {
  //Arrays.sort(allPhotos);
}

void drawPhotos() {
  for ( int i=0; i<rowNum; i++ ) {
    for ( int j=0; j<colNum; j++) {
      int index = i * colNum + j;
      int posX = photoWidth * j;
      int posY = photoHeight * i;
      Photo one = allPhotos[index];
      //      if){}
      image(one.img, posX, posY, photoWidth, photoHeight);
    }
  }
}

void loadColor() {
  int index = 0;
  colors = new color[tileCount * tileCount];
  for ( int gridY=0; gridY < tileCount; gridY++ ) {
    for (int gridX=0; gridX < tileCount; gridX++ ) {
      int px = (int)( gridX * rectSize );
      int py = (int)( gridY * rectSize );
      colors[index] = img.get(px, py);
      index ++;
    }
  }
}

void sortColor() {
  // sort colors
  if (sortMode != null) colors = GenerativeDesign.sortColors(this, colors, sortMode);
}

void drawColor() {
  int index = 0;
  for ( int gridY=0; gridY < tileCount; gridY++ ) {
    for (int gridX=0; gridX < tileCount; gridX++ ) {
      fill(colors[index]);
      if (switchShape == false) {
        rect(gridX * rectSize, gridY * rectSize, rectSize, rectSize);
      } else {
        ellipseMode(CENTER); 
        ellipse(gridX * rectSize, gridY * rectSize, rectSize, rectSize);
      }
      //rect(gridX * rectSize, gridY * rectSize, rectSize, rectSize);

      index ++;
    }
  }
}
void mouseClicked() {
  checkStart = true;
}
void keyReleased() {
  // change sorting mode
  if (key == '1') {
    sortMode = null;
  }
  if (key == '2') {
    sortMode = GenerativeDesign.HUE;
  }
  if (key == '3') {
    sortMode = GenerativeDesign.SATURATION;
  }
  if (key == '4') {
    sortMode = GenerativeDesign.BRIGHTNESS;
  }
  if (key == '5') {
    sortMode = GenerativeDesign.GRAYSCALE;
  }

  if (key == '0') {
    switchPhotos = 0;
  }
  if (key == '6') {
    switchPhotos = 6;
  }
  if (key == 'r' || key == 'R') {
    //switchShape = true;
    switchShapeInt = switchShapeInt+1;
  }
}