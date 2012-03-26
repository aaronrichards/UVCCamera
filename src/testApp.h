#ifndef _TEST_APP
#define _TEST_APP

#include "ofMain.h"

#include "ofxOpenCv.h"
#include "UVCCameraControl.h"
#include "ofxQTKitVideoGrabber.h"
#include "ofxUI.h"


class testApp : public ofBaseApp
{

	public:

		void setup();
		void update();
		void draw();
		void exit();
	
		void keyPressed  (int key);
		void mouseMoved(int x, int y );
		void mouseDragged(int x, int y, int button);
		void mousePressed(int x, int y, int button);
		void mouseReleased(int x, int y, int button);
		void windowResized(int w, int h);
        void guiEvent(ofxUIEventArgs &e);
        void setGUI1();

        ofxQTKitVideoGrabber    vidGrabber;
        ofxCvColorImage         colorImg;
		UVCCameraControl *      cameraControl;

        bool                    aFocus, aExposure, aWhiteBalance;
        float                   exposure, white, sharpness, brightness, contrast, saturation, focus;
        int                     red, green, blue;
        ofxUICanvas *           gui1;
        
};

#endif
