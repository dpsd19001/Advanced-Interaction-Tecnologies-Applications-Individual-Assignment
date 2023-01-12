 import TUIO.*; //<>//

TuioProcessing tuioClient;



float scale_factor = 1;
PFont font;
PImage img;
PImage img1;
int imagewidth, imageheight;
float zoom = 100;
boolean loadImage= false ;
float red=255;

boolean verbose = true; 
boolean callback = true; 

void setup()
{
  size(700, 500);
  img = loadImage("sea.jpg"); //2o
  img1 = loadImage("voreio-selas.jpg");

  
  if (!callback) {
    frameRate(60);
    loop();
  } else noLoop(); 

  font = createFont("Arial", 18);
  tuioClient  = new TuioProcessing(this);
  imagewidth = img.width;
  imageheight = img.height;
}


void draw()
{
  background(255);
  textFont(font, 18*scale_factor);

  ArrayList<TuioObject> tuioObjectList = tuioClient.getTuioObjectList();
  for (int i=0; i<tuioObjectList.size(); i++) {
    TuioObject tobj = tuioObjectList.get(i);


    if (tobj.getSymbolID()==0) // emfanish 1hs eikonas
    {
      translate(tobj.getScreenX(width), tobj.getScreenY(height));
      rotate(tobj.getAngle());
      image(img, 0, 0, imagewidth, imageheight);
    }


     if (tobj.getSymbolID()==1) //emfanish 2hs eikonas
     {
     translate(tobj.getScreenX(width),tobj.getScreenY(height));
     rotate(tobj.getAngle());
     image(img1, 0, 0);
     }

    if (loadImage)
    {
      if (tobj.getSymbolID()==2) //allazw to megethos ths 1hs eikonas
      {
        zoom =constrain(zoom +tobj.getRotationSpeed()*3, 10, 300 );
        imagewidth = int(img.width* zoom/100); // allazw to mege8ow tis eikonas me basi to zoom
        imageheight = int(img.height*zoom/100);
      }
      
      if (tobj.getSymbolID()==3) //allagh xrwmatos
      {
        red =map(tobj.getAngle(), 0, 6.2 ,  255, 0 );
        tint(red, 100 , 80);
      }
      
      if (tobj.getSymbolID()==4) //megalwnw to megethos ths 2hs eikonas
      {
        zoom =constrain(zoom +tobj.getRotationSpeed()*3, 10, 300 );
        imagewidth = int(img1.width* zoom/50);
        imageheight = int(img1.height*zoom/50);
      }
       if(tobj.getSymbolID() == 5){ //emfanizw thn 1h eikona deuterh fora
     filter(INVERT);
     pushMatrix();
     translate(tobj.getScreenX(width),tobj.getScreenY(height));
     rotate(tobj.getAngle());
     image(img,  width/4, height/3);
     popMatrix();
   }
   
    }
  }
}

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
      red = 255;  
      tint(red, 100 , 80);
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
