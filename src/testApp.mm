#include "testApp.h"


#define camW 640
#define camH 480

//--------------------------------------------------------------
void testApp::setup()
{
	vidGrabber.setVerbose(true);
	vidGrabber.listDevices();
	vidGrabber.setDeviceID(1);
	vidGrabber.initGrabber(camW,camH);
	
	colorImg.allocate(camW,camH);
	cameraControl = [[UVCCameraControl alloc] initWithVendorID:0x046D productID:0x0821];
	
	[cameraControl setAutoFocus:YES]; //FOCUS = FUCKED!
	[cameraControl setAutoExposure:YES];
	[cameraControl setAutoWhiteBalance:YES];
	 aFocus = true;
	 aExposure = true;
	 aWhiteBalance = true;
    
    setGUI1();
}

void testApp::exit()
{
	[cameraControl release];	
    delete gui1;
}

//--------------------------------------------------------------
void testApp::update()
{
	ofBackground(red,green,blue);

    vidGrabber.update();
	
	if (vidGrabber.isFrameNew())
    {
		colorImg.setFromPixels(vidGrabber.getPixels(), camW,camH);
	}
 }

//--------------------------------------------------------------
void testApp::draw()
{
	colorImg.draw(270, 20);		
}

//--------------------------------------------------------------
void testApp::guiEvent(ofxUIEventArgs &e)
{
	string name = e.widget->getName();
	

    
    if(name == "FOCUS")
	{
		ofxUISlider *slider = (ofxUISlider *) e.widget; 
        [cameraControl setAbsoluteFocus:(slider->getScaledValue())];
	}
    else if(name == "EXPOSURE")
	{
		ofxUISlider *slider = (ofxUISlider *) e.widget; 
        [cameraControl setExposure:(slider->getScaledValue())];
	}
    else if(name == "WHITE BALANCE")
	{
		ofxUISlider *slider = (ofxUISlider *) e.widget; 
		[cameraControl setWhiteBalance:(slider->getScaledValue())]; 		
	}
    else if(name == "SHARPNESS")
	{
		ofxUISlider *slider = (ofxUISlider *) e.widget; 
		[cameraControl setSharpness:(slider->getScaledValue())];		
	}
    else if(name == "BRIGHTNESS")
	{
		ofxUISlider *slider = (ofxUISlider *) e.widget; 
		[cameraControl setBrightness:(slider->getScaledValue())];		
	}
    else if(name == "CONTRAST")
	{
		ofxUISlider *slider = (ofxUISlider *) e.widget; 
		[cameraControl setContrast:(slider->getScaledValue())];	
	}
    else if(name == "SATURATION")
	{
		ofxUISlider *slider = (ofxUISlider *) e.widget; 
		[cameraControl setSaturation:(slider->getScaledValue())];
	}
    else if(name == "AUTO EXPOSURE")
	{
		ofxUILabelToggle *slider = (ofxUILabelToggle *) e.widget; 
        aExposure = slider->getValue();
        if(aExposure) [cameraControl setAutoExposure:YES];
        else [cameraControl setAutoExposure:NO];
	}
    else if(name == "AUTO WHITE BALANCE")
	{
		ofxUILabelToggle *slider = (ofxUILabelToggle *) e.widget; 
        aExposure = slider->getValue();
        if(aExposure) [cameraControl setAutoWhiteBalance:YES];
        else [cameraControl setAutoWhiteBalance:NO];
	}
    
    else if(name == "AUTO FOCUS")
	{
		ofxUILabelToggle *slider = (ofxUILabelToggle *) e.widget; 
        aFocus = slider->getValue();
        if(aFocus) [cameraControl setAutoFocus:YES];
        else [cameraControl setAutoFocus:NO];
	}
}

//--------------------------------------------------------------
void testApp::keyPressed  (int key){

	switch (key){
		case 's':
			vidGrabber.videoSettings();
			break;
		case '1':
			aFocus = !aFocus;
			if(aFocus) [cameraControl setAutoFocus:YES];
			else [cameraControl setAutoFocus:NO];
			break;
		case '2':
			aExposure = !aExposure;
			if(aExposure) [cameraControl setAutoExposure:YES];
			else [cameraControl setAutoExposure:NO];
			break;
		case '3':
			aWhiteBalance = !aWhiteBalance;
			if(aWhiteBalance) [cameraControl setAutoWhiteBalance:YES];
			else [cameraControl setAutoWhiteBalance:NO];			
			break;
		case 'p':
			printf("getExposure = %f ",[cameraControl getExposure]);
			printf("getAbsoluteFocus = %f ",[cameraControl getAbsoluteFocus]);
			printf("getWhiteBalance = %f ",[cameraControl getWhiteBalance]);
			
			printf("\n");
			break;
	}
}

//--------------------------------------------------------------
void testApp::setGUI1()
{
	red = 176; blue = 58; green = 70; 
	
	float dim = 16; 
	float xInit = OFX_UI_GLOBAL_WIDGET_SPACING; 
    float length = 255-xInit; 
    
    focus = [cameraControl getAbsoluteFocus];
    exposure = [cameraControl getExposure];
    white = [cameraControl getWhiteBalance];
    sharpness = [cameraControl getSharpness];
    brightness = [cameraControl getBrightness];
    contrast = [cameraControl getContrast];
    saturation = [cameraControl getSaturation];
	
  	gui1 = new ofxUICanvas(0, 0, length+xInit, ofGetHeight()); 
	gui1->addWidgetDown(new ofxUILabel("UVC CONTROL", OFX_UI_FONT_LARGE));
    
    gui1->addWidgetDown(new ofxUISlider(length-xInit,dim, 0.0, 1.0, focus, "FOCUS")); 
    gui1->addWidgetDown(new ofxUISlider(length-xInit,dim, 0.0, 1.0, exposure, "EXPOSURE")); 
	gui1->addWidgetDown(new ofxUISlider(length-xInit,dim, 0.0, 1.0, white, "WHITE BALANCE")); 
	gui1->addWidgetDown(new ofxUISlider(length-xInit,dim, 0.0, 1.0, sharpness, "SHARPNESS")); 	
    gui1->addWidgetDown(new ofxUISlider(length-xInit,dim, 0.0, 1.0, brightness, "BRIGHTNESS")); 
	gui1->addWidgetDown(new ofxUISlider(length-xInit,dim, 0.0, 1.0, contrast, "CONTRAST")); 
	gui1->addWidgetDown(new ofxUISlider(length-xInit,dim, 0.0, 1.0, saturation, "SATURATION")); 
	
    gui1->addWidgetDown(new ofxUILabelToggle(length-xInit, true, "AUTO FOCUS", OFX_UI_FONT_MEDIUM)); 
    gui1->addWidgetDown(new ofxUILabelToggle(length-xInit, true, "AUTO EXPOSURE", OFX_UI_FONT_MEDIUM)); 
    gui1->addWidgetDown(new ofxUILabelToggle(length-xInit, true, "AUTO WHITE BALANCE", OFX_UI_FONT_MEDIUM)); 
   	
	ofAddListener(gui1->newGUIEvent,this,&testApp::guiEvent);
}

//--------------------------------------------------------------
void testApp::mouseMoved(int x, int y ){	}
//--------------------------------------------------------------
void testApp::mouseDragged(int x, int y, int button){ }
//--------------------------------------------------------------
void testApp::mousePressed(int x, int y, int button){}
//--------------------------------------------------------------
void testApp::mouseReleased(int x, int y, int button){}
//--------------------------------------------------------------
void testApp::windowResized(int w, int h){}

