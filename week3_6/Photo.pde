import java.util.Date;
import java.util.Comparator;
import java.text.SimpleDateFormat;

class Photo {
  PImage img;
  String name;
  Date created;
  int imageWidth;
  int imageHeight;
  
  Photo( String f_name, String c_date, int img_w, int img_h){
    name = f_name;
    img = loadImage(name);
    
    SimpleDateFormat format = new SimpleDateFormat("yyyy:MM:dd HH:mm:ss");
    try {
      created = format.parse(c_date);
    } catch(Exception e){
    }
    
    imageWidth = img_w;
    imageHeight = img_h;
  }
}