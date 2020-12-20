final int sizeX=120;
final int sizeY=120;
final int[] liveNumber={2,3};
final int[] bornNumber={3};
final int cellSize=5;
int frameR=30;
int drawX,drawY;
boolean isDraw=false;
boolean drawMode;
Cell[][] cells=new Cell[sizeX][sizeY];

void setup(){
  size(600,600);
  frameRate(frameR);
  for(int x=0;x<sizeX;x++){
  for(int y=0;y<sizeY;y++){
    cells[x][y]=new Cell(x,y,cellSize,cells);
    }
  }
}

void draw(){
  background(0);
  for(int x=0;x<sizeX;x++){
      for(int y=0;y<sizeY;y++){  
        cells[x][y].check();
      }
    }
  if(isDraw){
  for(int x=0;x<sizeX;x++){
      for(int y=0;y<sizeY;y++){  
        cells[x][y].renew();
      }
    }
  }
  for(int x=0;x<sizeX;x++){
    for(int y=0;y<sizeY;y++){
      cells[x][y].reborn();
    }
  }
}
class Cell{
  boolean live;
  int dirX,dirY;
  int size;
  int[] nX=new int[3];
  int[] nY=new int[3];
  int result;
  int t;
  Cell[][] _cell;
  Cell(int dx,int dy,int s,Cell[][] c){
    live=false;
    dirX=dx;
    dirY=dy;
    size=s;
    _cell=c;
    if((t=dirX-1)>=0)nX[0]=dirX-1;else nX[0]=t+sizeX;
    nX[1]=dirX;
    if((t=dirX+1)<sizeX)nX[2]=dirX+1;else nX[2]=t-sizeX;
    if((t=dirY-1)>=0)nY[0]=dirY-1;else nY[0]=t+sizeY;
    nY[1]=dirY;
    if((t=dirY+1)<sizeY)nY[2]=dirY+1;else nY[2]=t-sizeY;
  }
  void check(){
    result=0;
    for(int x=0;x<3;x++){
      for(int y=0;y<3;y++){
        result+=checkNeighbor(nX[x],nY[y]);
      }
    }
    if(this.live)result--;
    
  }
  int checkNeighbor(int xx,int yy){
    if(_cell[xx][yy].live)return 1;
    else return 0;
  }
  void renew(){
    int n=result;
    if(this.live==true){
      this.live=false;
      for(int i=0;i<liveNumber.length;i++){
        if(n==liveNumber[i]){
          this.live=true;
          break;
        }
      }
    }
    else{
      for(int i=0;i<bornNumber.length;i++){
        if(n==bornNumber[i]){
          this.live=true;
          break;
        }
      }
      
    }
  }
  void reborn(){
    
    
    strokeWeight(1);
    stroke(128);
    if(this.live)fill(32,255,32);else noFill();
    rect(dirX*size,dirY*size,size,size);
  }
}

void reset(float rate){
  for(int x=0;x<sizeX;x++){
    for(int y=0;y<sizeY;y++){
      cells[x][y].live=(random(0,1)<rate);
    }
  }
}
void mousePressed(){
  if(mouseButton==LEFT){
    if(!isDraw){
      drawMode=!cells[drawX=int(mouseX/cellSize)][drawY=int(mouseY/cellSize)].live;
    }
  }
  else{
    isDraw=!isDraw;
  }
}

void mouseDragged(){
  if(mouseButton==LEFT){
    if(!isDraw){
      if(mouseX>0&&mouseX<width&&mouseY>0&&mouseY<height)cells[drawX=int(mouseX/cellSize)][drawY=int(mouseY/cellSize)].live=drawMode;
    }
  }
}
void keyPressed(){
  if(key=='r'){
    reset(0);
    isDraw=false;
  }
  if(key=='0')reset(1);
  for(int i=1;i<10;i++){
    if(key==char('0'+i))reset(i/10f);
  }
  if(key=='+'){
    frameR+=5;
    frameRate(frameR);
  }
  if(key=='-'){
    frameR-=5;
    frameRate(frameR);
  }
}