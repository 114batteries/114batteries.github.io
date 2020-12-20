import googlemapper.*;
ArrayList<POINT>point=new ArrayList<POINT>();
POINT workClass;
PImage map;
GoogleMapper gMapper;
float mapCenterLat = 33.435007;
float mapCenterLon = 129.998800;
int zoomLevel = 16;
String mapType = GoogleMapper.MAPTYPE_ROADMAP;
int mapWidth=3200;
int mapHeight=2400;
float x=0,y=0;
float X,Y;
class POINT{
  double lat,lon;
  POINT(){
    lat=gMapper.y2lat(Y+mouseY);
    lon=gMapper.x2lon(X+mouseX);
    println(lat+","+lon);
  }
}
public void setup() {
 
    size(640,480);
   
    
   
    gMapper = new GoogleMapper(mapCenterLat, mapCenterLon, zoomLevel, mapType, mapWidth,mapHeight);
   
    map = gMapper.getMap();
}
 
public void draw() {
    background(0);
    X=map.width/2+x;
    Y=map.height/2+y;
    PImage outimg=map.get((int)X-width/2,(int)Y-height/2,width,height);
    image(outimg,0,0);
    for (POINT Point : point) {
      int x=(int)gMapper.lon2x(Point.lon);
      int y=(int)gMapper.lat2y(Point.lat);
      if(X<x&&x<X+width&&Y<y&&y<Y+height){
        strokeWeight(10);
        stroke(255,0,0);
        point(x-X,y-Y);
      }
    }
    //println(frameRate);

}

void mapPoint(float _lat,float _lon,int mapX,int mapY,GoogleMapper _gmap){
  int x=(int)_gmap.lon2x(_lon);
  int y=(int)_gmap.lat2y(_lat);
}

void mouseClicked(){
  point.add(new POINT());
  if (mouseButton==RIGHT){
    for(int i=0;i<point.size();i++){
        workClass=point.get(i);
        println(workClass.lat,workClass.lon);
      
    }
  }
}

void mouseDragged(){
  PVector move=new PVector(pmouseX-mouseX,pmouseY-mouseY);
  x+=move.x;
  y+=move.y;
}