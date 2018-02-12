//
//  JMBackgroundCameraView.h
//  JMBackgroundCameraView
//
//  Created by Joan Molinas on 23/10/14.
//  Copyright (c) 2014 joan molinas ramon. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>


typedef NS_ENUM(NSInteger, DevicePositon) {
    DevicePositonFront,
    DevicePositonBack
};

@interface JMBackgroundCameraView : UIView <AVCaptureFileOutputRecordingDelegate>{
    
}
@property (nonatomic, retain) AVCaptureSession *session;
@property (nonatomic, retain) AVCaptureDeviceInput *input;
@property (nonatomic, retain) AVCaptureDevice *device;
@property (nonatomic, retain) AVCaptureStillImageOutput *imageOutput;
@property (nonatomic, retain) AVCaptureVideoPreviewLayer *preview;
@property (nonatomic, retain) AVCaptureMovieFileOutput *movieFileOutput;
@property (nonatomic) UIBackgroundTaskIdentifier backgroundRecordingID;
@property (nonatomic, retain) NSString *outputFilePath;
@property (nonatomic, retain) NSURL *outputFilePathURL;

-(instancetype)initWithFrame:(CGRect)frame positionDevice:(DevicePositon)position blur:(UIBlurEffectStyle)blur;
-(instancetype)initWithFrame:(CGRect)frame positionDevice:(DevicePositon)position;
-(void)initCameraInPosition:(DevicePositon)position;
-(void)removeBlurEffect;
-(void)addBlurEffect:(UIBlurEffectStyle)style;
-(void)capturePhotoNowWithcompletionBlock:(void(^)(UIImage *image))completionBlock;
- (void)CameraSetOutputProperties;
- (IBAction)StartStopButtonPressed:(id)sender;
- (IBAction)CameraToggleButtonPressed:(id)sender;
-(void)startRecording;
-(void)stopRecording;

@end
