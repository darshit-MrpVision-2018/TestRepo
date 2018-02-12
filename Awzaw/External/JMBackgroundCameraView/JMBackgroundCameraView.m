//
//  JMBackgroundCameraView.m
//  JMBackgroundCameraView
//
//  Created by Joan Molinas on 23/10/14.
//  Copyright (c) 2014 joan molinas ramon. All rights reserved.
//

#import "JMBackgroundCameraView.h"
#import <AssetsLibrary/AssetsLibrary.h>
#import "UIImage+MultiFormat.h"

#define MovieName_TimeStamp [NSString stringWithFormat:@"%@%f",@"MOV",[[NSDate date] timeIntervalSince1970] * 1000]

@implementation JMBackgroundCameraView {
    UIVisualEffectView *blurEffectView;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    [self initCameraInPosition:1];
}

-(instancetype)init{
    if (self = [super init]) {
        self.frame = self.superview.frame;
        [self initCameraInPosition:1];
    }
    return self;
}

-(instancetype)initWithFrame:(CGRect)frame positionDevice:(DevicePositon)position blur:(UIBlurEffectStyle)blur {
    if (self = [super initWithFrame:frame]) {
        [self initCameraInPosition:position];
        [self addBlurEffect:blur];
    }
    return self;
}

-(instancetype)initWithFrame:(CGRect)frame positionDevice:(DevicePositon)position {
    if (self = [super initWithFrame:frame]) {
        [self initCameraInPosition:position];
    }
    return self;
}

-(void)initCameraInPosition:(DevicePositon)position {
    self.session = [AVCaptureSession new];
    [self.session setSessionPreset:AVCaptureSessionPresetHigh];
    
    NSArray *devices = [NSArray new];
    devices = [AVCaptureDevice devicesWithMediaType:AVMediaTypeVideo];
    for (AVCaptureDevice *device in devices) {
        if (position == DevicePositonBack) {
            if ([device position] == AVCaptureDevicePositionBack) {
                _device = device;
                break;
            }
        }else {
            if ([device position] == AVCaptureDevicePositionFront) {
                _device = device;
                break;
            }
        }
    }
    
    NSError *error;
    
    self.input = [[AVCaptureDeviceInput alloc] initWithDevice:self.device error:&error];
    if ([self.session canAddInput:self.input]) {
        [self.session addInput:self.input];
    }
    
    self.imageOutput = [AVCaptureStillImageOutput new];
    NSDictionary *outputSettings = @{AVVideoCodecKey:AVVideoCodecJPEG};
    [self.imageOutput setOutputSettings:outputSettings];
    [self.session addOutput:self.imageOutput];
    
    self.movieFileOutput = [AVCaptureMovieFileOutput new];
    
    Float64 TotalSeconds = 15;			//Total seconds
    int32_t preferredTimeScale = 30;	//Frames per second
    CMTime maxDuration = CMTimeMakeWithSeconds(TotalSeconds, preferredTimeScale);
    //SET MAX DURATION
    
    self.movieFileOutput.maxRecordedDuration = maxDuration;
    self.movieFileOutput.minFreeDiskSpaceLimit = 1024 * 1024;
    if ([self.session canAddOutput:self.movieFileOutput])
        [self.session addOutput:self.movieFileOutput];
    
    //SET THE CONNECTION PROPERTIES (output properties)
    [self CameraSetOutputProperties];			//(We call a method as it also has to be done after changing camera)
    
    self.preview = [[AVCaptureVideoPreviewLayer alloc] initWithSession:self.session];
    [self.preview setVideoGravity:AVLayerVideoGravityResizeAspectFill];
    [self.preview setFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
    [self.layer addSublayer:self.preview];
    
    [self.session startRunning];
}

- (void)CameraSetOutputProperties
{
    //SET THE CONNECTION PROPERTIES (output properties)
    AVCaptureConnection *CaptureConnection = [self.movieFileOutput connectionWithMediaType:AVMediaTypeVideo];
    
    //Set landscape (if required)
    if ([CaptureConnection isVideoOrientationSupported])
    {
        AVCaptureVideoOrientation orientation = AVCaptureVideoOrientationLandscapeRight;
        //SET VIDEO ORIENTATION IF LANDSCAPE
        [CaptureConnection setVideoOrientation:orientation];
    }
}

//********** GET CAMERA IN SPECIFIED POSITION IF IT EXISTS **********
- (AVCaptureDevice *) CameraWithPosition:(AVCaptureDevicePosition) Position
{
    NSArray *Devices = [AVCaptureDevice devicesWithMediaType:AVMediaTypeVideo];
    for (AVCaptureDevice *Device in Devices)
    {
        if ([Device position] == Position)
        {
            return Device;
        }
    }
    return nil;
}

-(void)removeBlurEffect {
    [blurEffectView removeFromSuperview];
}

-(void)addBlurEffect:(UIBlurEffectStyle)style {
    UIBlurEffect *blur = [UIBlurEffect effectWithStyle:style];
    
    blurEffectView = [[UIVisualEffectView alloc] initWithEffect:blur];
    blurEffectView.frame = self.bounds;
    
    [self insertSubview:blurEffectView atIndex:1];
}

-(void)capturePhotoNowWithcompletionBlock:(void (^)(UIImage *))completionBlock{
    
    if (self.imageOutput != nil) {
        AVCaptureConnection *videoConnection = nil;
        
        for (AVCaptureConnection *connection in self.imageOutput.connections) {
            for (AVCaptureInputPort * port in connection.inputPorts) {
                if ([[port mediaType] isEqual:AVMediaTypeVideo]) {
                    videoConnection = connection;
                    [videoConnection setVideoOrientation:AVCaptureVideoOrientationPortrait];
                    break;
                }
            }
            if (videoConnection) { break; }
        }
        
        [videoConnection setVideoOrientation:AVCaptureVideoOrientationPortrait];
        
        [self.imageOutput captureStillImageAsynchronouslyFromConnection:videoConnection
                                                      completionHandler:^(CMSampleBufferRef imageDataSampleBuffer, NSError *error) {
                                                        
                                                          NSData *imageData = [AVCaptureStillImageOutput jpegStillImageNSDataRepresentation:imageDataSampleBuffer];
                                                          UIImage *capturedImage = [self rotateImageAppropriately:[UIImage imageWithData:imageData]];
           
                                                          completionBlock(capturedImage);
                                                          
                                                      }];
    }
}

- (UIImage*) rotateImageAppropriately:(UIImage*)imageToRotate
{
    UIImage* properlyRotatedImage;
    
    CGImageRef imageRef = [imageToRotate CGImage];
    
    if (imageToRotate.imageOrientation == 0)
    {
        properlyRotatedImage = imageToRotate;
    }
    else if (imageToRotate.imageOrientation == 3)
    {
        
        CGSize imgsize = imageToRotate.size;
        UIGraphicsBeginImageContext(imgsize);
        [imageToRotate drawInRect:CGRectMake(0.0, 0.0, imgsize.width, imgsize.height)];
        properlyRotatedImage = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
    }
    else if (imageToRotate.imageOrientation == 1)
    {
        properlyRotatedImage = [UIImage imageWithCGImage:imageRef scale:1.0 orientation:1];
    }
    
    return properlyRotatedImage;
}
-(void)startRecording{
    [[[self movieFileOutput] connectionWithMediaType:AVMediaTypeVideo] setVideoOrientation:[[(AVCaptureVideoPreviewLayer *) self.preview connection] videoOrientation]];
    
    // Start recording to a temporary file.
    self.outputFilePath = [NSTemporaryDirectory() stringByAppendingPathComponent:[MovieName_TimeStamp stringByAppendingPathExtension:@"mov"]];
    [[self movieFileOutput] startRecordingToOutputFileURL:[NSURL fileURLWithPath:self.outputFilePath] recordingDelegate:self];
}

-(void)stopRecording{
    [[self movieFileOutput] stopRecording];
}

- (void)captureOutput:(AVCaptureFileOutput *)captureOutput didFinishRecordingToOutputFileAtURL:(NSURL *)outputFileURL fromConnections:(NSArray *)connections error:(NSError *)error
{
    if (error)
        NSLog(@"%@", error.description);
    
//    [self setLockInterfaceRotation:NO];
    
    // Note the backgroundRecordingID for use in the ALAssetsLibrary completion handler to end the background task associated with this recording. This allows a new recording to be started, associated with a new UIBackgroundTaskIdentifier, once the movie file output's -isRecording is back to NO — which happens sometime after this method returns.
//    UIBackgroundTaskIdentifier backgroundRecordingID = [self backgroundRecordingID];
//    [self setBackgroundRecordingID:UIBackgroundTaskInvalid];
    
    if (UIVideoAtPathIsCompatibleWithSavedPhotosAlbum([outputFileURL path])) {
        UISaveVideoAtPathToSavedPhotosAlbum([outputFileURL path] ,nil,nil,nil);
    }
    
//    [[[ALAssetsLibrary alloc] init] writeVideoAtPathToSavedPhotosAlbum:outputFileURL completionBlock:^(NSURL *assetURL, NSError *error) {
//        if (error)
//            NSLog(@"%@", error);
//        
//        self.outputFilePathURL = outputFileURL;
//        [[NSUserDefaults standardUserDefaults] setObject:[NSString stringWithFormat:@"%@",outputFileURL] forKey:@"outputFileURL"];
//        [[NSUserDefaults standardUserDefaults] setInteger:2 forKey:@"SHOWTHUMBNAIL"];
//        [[NSUserDefaults standardUserDefaults] setInteger:1 forKey:@"ISCAPTURED"];
////        [[NSFileManager defaultManager] removeItemAtURL:outputFileURL error:nil];
//        
//        //Temp commmented
////        [[Singleton sharedSingleton] setVideoData:[NSData dataWithContentsOfURL:outputFileURL]];
//        
//        if (backgroundRecordingID != UIBackgroundTaskInvalid)
//            [[UIApplication sharedApplication] endBackgroundTask:backgroundRecordingID];
//    }];
}

@end
