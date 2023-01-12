 import TUIO.*; //<>//

TuioProcessing tuioClient;

float cursor_size = 15;
float object_size = 60;
float table_size = 760;
float scale_factor = 1;
PFont font;

PImage img;
PImage img1;
PImage img2;
PImage back;
PImage gray;
int imagewidth, imageheight;
float zoom = 100;

boolean loadImage= false ;
//float red=255;
boolean verbose = true; 
boolean callback = true; 

void setup()
{
   noCursor();
  noStroke();
  fill(0);
  
  size(700, 500);
  img = loadImage("sea.jpg");
  img1 = loadImage("voreio-selas.jpg");
  img2 = loadImage("gray.png");

  
  if (!callback) {
    frameRate(60);
    loop();
  } else noLoop(); 

  font = createFont("Arial", 18);
  // scale_factor = height/table_size;
  tuioClient  = new TuioProcessing(this);
  imagewidth = img.width;
  imageheight = img.height;
}


void draw()
{
  background(255);
  textFont(font, 18*scale_factor);
  
    float obj_size = object_size*scale_factor; 
    float cur_size = cursor_size*scale_factor;
  

  ArrayList<TuioObject> tuioObjectList = tuioClient.getTuioObjectList();
  for (int i=0; i<tuioObjectList.size(); i++) {
    TuioObject tobj = tuioObjectList.get(i);


    if (tobj.getSymbolID()==0) // emfanisi 1hs eikonas
    {
     stroke(0);
     fill(0,0,0);
     pushMatrix();
     popMatrix();
     fill(255);
     image(img, tobj.getX()*width, tobj.getY()*height, width/3, height/3);
    }


     if (tobj.getSymbolID()==1) //emfanisi 2hs eikonas
     {
       stroke(0);
     fill(0,0,0);
     pushMatrix();
     popMatrix();
     fill(255);
     image(img1, tobj.getX()*width, tobj.getY()*height, width/3, height/3);  
     }

   // if (loadImage)
    //{
      if (tobj.getSymbolID()==2) //emfanisi 3hs eikonas gray
      {
     stroke(0);
     fill(0,0,0);
     pushMatrix();
     popMatrix();
     fill(255);
     image(img2, tobj.getX()*width, tobj.getY()*height, width/3, height/3);
       
      }
       if(tobj.getSymbolID() == 3){
     filter(GRAY);
     pushMatrix();
     translate(tobj.getScreenX(width),tobj.getScreenY(height));
     rotate(tobj.getAngle());
     image(img, -obj_size/2,-obj_size/2, width/4, height/3);
     popMatrix();
   }
      
     if(tobj.getSymbolID() == 4){
    tint(252, 154, 248);  
     pushMatrix();
     translate(tobj.getScreenX(width),tobj.getScreenY(height));
     rotate(tobj.getAngle());
     image(img1, -obj_size/2,-obj_size/2, width/4, height/3);
     popMatrix();
     
   }

    }
  }
//}

void addTuioObject(TuioObject tobj) {
  if (verbose) println("add obj "+tobj.getSymbolID()+" ("+tobj.getSessionID()+") "+tobj.getX()+" "+tobj.getY()+" "+tobj.getAngle());
  if (tobj.getSymbolID()==0)
  {
    loadImage= true;
  }
}

void updateTuioObject (TuioObject tobj) {
  if (verbose) println("set obj "+tobj.getSymbolID()+" ("+tobj.getSessionID()+") "+tobj.getX()+" "+tobj.getY()+" "+tobj.getAngle()
    +" "+tobj.getMotionSpeed()+" "+tobj.getRotationSpeed()+" "+tobj.getMotionAccel()+" "+tobj.getRotationAccel());
}


void removeTuioObject(TuioObject tobj) {
  if (verbose) println("del obj "+tobj.getSymbolID()+" ("+tobj.getSessionID()+")");
  if (tobj.getSymbolID()==0)
  {
    loadImage= false;
  }
  if (tobj.getSymbolID()==2)
  {
     imagewidth = img.width/2;
     imageheight = img.height/2;
  }
   if (tobj.getSymbolID()==3)
  {
    // red = 255;  
     //tint(red, 100 , 80);
  }
 
}


void addTuioCursor(TuioCursor tcur) {
  if (verbose) println("add cur "+tcur.getCursorID()+" ("+tcur.getSessionID()+ ") " +tcur.getX()+" "+tcur.getY());
}


void updateTuioCursor (TuioCursor tcur) {
  if (verbose) println("set cur "+tcur.getCursorID()+" ("+tcur.getSessionID()+ ") " +tcur.getX()+" "+tcur.getY()
    +" "+tcur.getMotionSpeed()+" "+tcur.getMotionAccel());
}


void removeTuioCursor(TuioCursor tcur) {
  if (verbose) println("del cur "+tcur.getCursorID()+" ("+tcur.getSessionID()+")");
}


void addTuioBlob(TuioBlob tblb) {
  if (verbose) println("add blb "+tblb.getBlobID()+" ("+tblb.getSessionID()+") "+tblb.getX()+" "+tblb.getY()+" "+tblb.getAngle()+" "+tblb.getWidth()+" "+tblb.getHeight()+" "+tblb.getArea());
}




void updateTuioBlob (TuioBlob tblb) {
  if (verbose) println("set blb "+tblb.getBlobID()+" ("+tblb.getSessionID()+") "+tblb.getX()+" "+tblb.getY()+" "+tblb.getAngle()+" "+tblb.getWidth()+" "+tblb.getHeight()+" "+tblb.getArea()
    +" "+tblb.getMotionSpeed()+" "+tblb.getRotationSpeed()+" "+tblb.getMotionAccel()+" "+tblb.getRotationAccel());
}


void removeTuioBlob(TuioBlob tblb) {
  if (verbose) println("del blb "+tblb.getBlobID()+" ("+tblb.getSessionID()+")");
}

void refresh(TuioTime frameTime) {
  if (verbose) println("frame #"+frameTime.getFrameID()+" ("+frameTime.getTotalMilliseconds()+")");
  if (callback) redraw();
}
