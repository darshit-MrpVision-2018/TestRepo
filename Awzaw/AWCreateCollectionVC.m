//
//  ViewController.m
//  Awzaw
//
//  Created by Darshit Vora on 11/10/17.
//  Copyright © 2017 MrpVision. All rights reserved.
//

#import "AWCreateCollectionVC.h"
#import "AWPhoneVerificationVC.h"
#import "JMBackgroundCameraView.h"
#import "AWLibraryCVCell.h"
#import "AWPreviewCVCell.h"
#import <Photos/Photos.h>
#import "Album.h"
#import "UIImageView+WebCache.h"

#define COLLECTIONVIEW_TAG 10

@interface AWCreateCollectionVC ()<UICollectionViewDelegate,UICollectionViewDataSource>
@property (nonatomic,strong) IBOutlet JMBackgroundCameraView *cameraView;
@property (nonatomic,strong) IBOutlet UIView *utilsView,*libraryView;

@property (nonatomic,strong) IBOutlet UICollectionView *albumCollectionViewObj,*previewCollectionViewObj;

@property (nonatomic,strong) NSMutableArray *arrAlbums,*arrSelectedAlbumsIndexPath;

@property (nonatomic,strong) IBOutlet UIButton *capturePhotoBtn,*stopVideoBtn;
@property (nonatomic,strong) IBOutlet UIButton *fronRearBtn;
@property (nonatomic,strong) IBOutlet UIButton *flashBtn,*backBtn;
@property (nonatomic,strong) IBOutlet UIButton *photoTabBtn, *videoTabBtn, *libraryTabBtn;

@property (nonatomic) int cameraPosition;

@property (nonatomic) BOOL isPhotoTab;  // To check whether PhotoTab is selected or not
@property (nonatomic) BOOL isRecording;  // To check whether recording is ON or not
@end

@implementation AWCreateCollectionVC

- (void)viewDidLoad {
    [super viewDidLoad];

}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:YES];
    [self setUpViewComponants];
    [self showPhotoView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Custom Methods -

- (void)setUpUtils {
    [self formatUtilsButton:self.capturePhotoBtn];
    [self formatUtilsButton:self.fronRearBtn];
    [self formatUtilsButton:self.flashBtn];
    self.utilsView.layer.borderWidth = 1;
    self.utilsView.layer.borderColor = [UIColor blackColor].CGColor;
    [self.stopVideoBtn setHidden:YES];
}

- (void)setUpViewComponants {
    self.cameraPosition = DevicePositonBack;
    self.isPhotoTab = TRUE;
    self.isRecording = FALSE;
    
    self.arrAlbums = [[NSMutableArray alloc] init];
    self.arrSelectedAlbumsIndexPath = [[NSMutableArray alloc] init];
    self.albumCollectionViewObj.delegate = self;
    self.albumCollectionViewObj.dataSource = self;
    self.albumCollectionViewObj.allowsSelection = YES;
    self.albumCollectionViewObj.allowsMultipleSelection = YES;
    self.previewCollectionViewObj.delegate = self;
    self.previewCollectionViewObj.dataSource = self;
}

- (void)formatUtilsButton:(UIButton *)btn {
    btn.layer.masksToBounds = YES;
    btn.layer.cornerRadius = btn.frame.size.width/2;
}

- (void)showLibraryView {
    [self.libraryView setHidden:NO];
    [self.view bringSubviewToFront:self.libraryView];
    [self.view bringSubviewToFront:self.backBtn];
    [self checkPhotoLibraryAuthorization];
    [self performSelector:@selector(reloadAlbumData) withObject:nil afterDelay:1.0];
}

- (void)showPhotoView {
    [self.view bringSubviewToFront:self.cameraView];
    [self.view bringSubviewToFront:self.utilsView];
    [self.view bringSubviewToFront:self.backBtn];
    [self.libraryView setHidden:YES];
    self.isPhotoTab = TRUE;
    [self setUpUtils];
}

- (void)showVideoview {
    [self showPhotoView];
    self.isPhotoTab = FALSE;
}

- (void)reloadAlbumData {
    [self.albumCollectionViewObj reloadData];
}

- (void)reloadPreviewSection {
    [self.previewCollectionViewObj reloadData];
}

- (void)checkPhotoLibraryAuthorization {
    [PHPhotoLibrary requestAuthorization:^(PHAuthorizationStatus status) {
        if (status == PHAuthorizationStatusAuthorized) {
            [self getAllPhotosFromDevice];
        }else{
            
        }
    }];
}

- (void)getAllPhotosFromDevice {
    
    PHFetchOptions *options = [[PHFetchOptions alloc] init];
    options.predicate = [NSPredicate predicateWithFormat:@"favorite == YES"];
    options.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:@"" ascending:YES]];
    //key:@"creationDate", ascending:NO
    PHFetchResult *results = [PHAsset fetchAssetsWithMediaType:PHAssetMediaTypeImage
                                                       options:nil];
    
    NSMutableArray<PHAsset *> *assets = [[NSMutableArray alloc] init];
    [results enumerateObjectsUsingBlock:^(id  _Nonnull object, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([object isKindOfClass:[PHAsset class]]) {
            [assets addObject:object];
            NSLog(@"asset : %@",[object filename]);
            NSLog(@"index : %lu",(unsigned long)idx);
            NSLog(@"count : %lu",(unsigned long)assets.count);
            
            if (object) {
                // get photo info from this asset
                PHImageRequestOptions * imageRequestOptions = [[PHImageRequestOptions alloc] init];
                imageRequestOptions.synchronous = YES;
                [[PHImageManager defaultManager]requestImageForAsset:object targetSize:CGSizeMake(200,200) contentMode:PHImageContentModeAspectFill options:imageRequestOptions resultHandler:^(UIImage * _Nullable result, NSDictionary * _Nullable info) {
                    NSLog(@"get image from result");
                    NSLog(@"image : %@",result);
                    NSLog(@"info : %@",info);
                    [self.arrAlbums addObject:result];
                }];
            }
        }
    }];
    [self performSelector:@selector(reloadAlbumData) withObject:nil afterDelay:2.0];
}

#pragma mark - Custom Actions -
- (IBAction)btnBackClick:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)flashBtnClick:(id)sender {
    AVCaptureDevice *flashLight = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    if ([flashLight isTorchAvailable] && [flashLight isTorchModeSupported:AVCaptureTorchModeOn])
    {
        BOOL success = [flashLight lockForConfiguration:nil];
        if (success)
        {
            if ([flashLight isTorchActive]) {
                [flashLight setTorchMode:AVCaptureTorchModeOff];
            }
            else {
                [flashLight setTorchMode:AVCaptureTorchModeOn];
            }
            [flashLight unlockForConfiguration];
        }
    }
    else{
        [UIAlertController showAlertIn:self WithTitle:Title_Warning message:Msg_Flash_Not_Supported cancelButtonTitle:Button_OK otherButtonTitles:nil style:UIAlertControllerStyleAlert tapBlock:^(UIAlertController *alertViewController, NSInteger buttonIndex) {
            
        }];
    }
}

- (IBAction)btnFrontRearBtnCick:(id)sender {
    if (self.cameraPosition == DevicePositonFront) {
        // Front View
        self.cameraPosition = DevicePositonBack;
        [self.cameraView initCameraInPosition:DevicePositonBack];
    }
    else{
        // Rear View
        self.cameraPosition = DevicePositonFront;
        [self.cameraView initCameraInPosition:DevicePositonFront];
    }
}

- (IBAction)btnCameraCaptureClick:(id)sender {
    
    if (self.isPhotoTab) {
        // Capture Photo
        [self.cameraView capturePhotoNowWithcompletionBlock:^(UIImage *image) {

            UIImage * img = [[UIImage alloc] init];
            img = image;
            NSLog(@"image captured!");
        }];
        
    } else{
        // Capture Video
        [self.cameraView startRecording];
        self.isRecording = TRUE;
        [self.capturePhotoBtn setHidden:YES];
        [self.stopVideoBtn setHidden:NO];
//        [NSTimer timerWithTimeInterval:10.0 target:self selector:@selector(btnStopRecordingClick:) userInfo:nil repeats:NO];
    }
}

- (IBAction)btnStopRecordingClick:(id)sender {
    [self.cameraView stopRecording];
    [self.capturePhotoBtn setHidden:NO];
    [self.stopVideoBtn setHidden:YES];
    [UIAlertController showAlertIn:self WithTitle:Title_Success message:Msg_Video_Captured_Successfully cancelButtonTitle:Button_OK otherButtonTitles:nil style:UIAlertControllerStyleAlert tapBlock:^(UIAlertController *alertViewController, NSInteger buttonIndex) {
        
    }];
}

- (IBAction)btnCaptureVideoClick:(id)sender {
    [self.photoTabBtn setTitle:@"PHOTO" forState:UIControlStateSelected];
    [self.libraryTabBtn setSelected:NO];
    [self.videoTabBtn setSelected:NO];
    [self.photoTabBtn.titleLabel setFont:[UIFont bold:17.0]];
    [self.cameraView startRecording];
}

- (IBAction)btnPhotoTabClick:(id)sender {
    [self showPhotoView];
}
// 7053500897
- (IBAction)btnLibraryTabClick:(id)sender {
    [self showLibraryView];
}

- (IBAction)btnVideoTabClick:(id)sender {
    [self showVideoview];
}

- (void)adjustCollectionViewWithAnimation {
    if (self.arrSelectedAlbumsIndexPath.count < 1) {
        for(int i=0;i<self.albumCollectionViewObj.constraints.count;i++){
            NSLayoutConstraint *constraints=[self.albumCollectionViewObj.superview.constraints objectAtIndex:i];
            if(constraints.firstItem==self.albumCollectionViewObj && constraints.firstAttribute==NSLayoutAttributeTop){
                constraints.constant=self.albumCollectionViewObj.superview.frame.size.height - self.previewCollectionViewObj.frame.size.height - self.albumCollectionViewObj.frame.size.height;
                break;
            }
        }
    }
    
    if (self.arrSelectedAlbumsIndexPath.count > 0 && self.arrSelectedAlbumsIndexPath.count <= 1) {
        for(int i=0;i<self.albumCollectionViewObj.constraints.count;i++){
            NSLayoutConstraint *constraints=[self.albumCollectionViewObj.superview.constraints objectAtIndex:i];
            if(constraints.firstItem==self.albumCollectionViewObj && constraints.firstAttribute==NSLayoutAttributeTop){
                constraints.constant=self.albumCollectionViewObj.superview.frame.size.height - self.previewCollectionViewObj.frame.size.height - 64;
                break;
            }
        }
    }
    
    [UIView animateWithDuration:0.5 animations:^{
        NSLog(@"animation started");
        [self.view layoutIfNeeded];
    } completion:^(BOOL finished) {
        NSLog(@"animation ended");
    }];
}


#pragma mark - UICollectionView Delegate Methods -

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    NSLog(@"should be seeing %lu collection view cells", (unsigned long)self.arrAlbums.count);
    
    if (collectionView == self.previewCollectionViewObj) {
        return self.arrSelectedAlbumsIndexPath.count;
    } else{
        if (self.arrAlbums.count>0)
            return self.arrAlbums.count;
        
        return 0;
    }
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    NSLog(@"QUERYING NUMBER OF SECTIONS IN COLLECTION VIEW");
    return 1;
}

- (UICollectionViewCell  *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    if (collectionView == self.previewCollectionViewObj) {
        static NSString *cellIdentifier = @"AWPreviewCVCell";
        AWPreviewCVCell *cell = (AWPreviewCVCell *)[self.previewCollectionViewObj dequeueReusableCellWithReuseIdentifier:cellIdentifier forIndexPath:indexPath];
        cell.imgView.image = [self.arrAlbums objectAtIndex:[[self.arrSelectedAlbumsIndexPath objectAtIndex:indexPath.row] row]];
        cell.pageControlObj.numberOfPages = self.arrSelectedAlbumsIndexPath.count;
        cell.pageControlObj.currentPage = indexPath.row;
        return cell;
        
    } else{
        static NSString *cellIdentifier = @"AWLibraryCVCell";
        AWLibraryCVCell *cell = (AWLibraryCVCell *)[self.albumCollectionViewObj dequeueReusableCellWithReuseIdentifier:cellIdentifier forIndexPath:indexPath];
        
        cell.lbl.text = @"";
        
        // Logic for implementing the counting of selected cells while scrolling collectionview
        if (self.arrAlbums.count > 0) {
            [cell.imgView setImage:[self.arrAlbums objectAtIndex:indexPath.row]];
            cell.imgView.tag = indexPath.row;
            if (self.arrSelectedAlbumsIndexPath.count > 0 ) {
                for (int i=0; i<self.arrSelectedAlbumsIndexPath.count; i++) {
                    AWLibraryCVCell *cell1 = (AWLibraryCVCell *) [self.albumCollectionViewObj cellForItemAtIndexPath:[self.arrSelectedAlbumsIndexPath objectAtIndex:i]];
                    cell1.selectedNumber = i+1;
                    cell1.lbl.text = [NSString stringWithFormat:@"%d",cell1.selectedNumber];
                }
            }
        }
        return cell;
    }
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"calling didselctitem at path");
    if (collectionView == self.previewCollectionViewObj) {
        [self reloadPreviewSection];
    }else {
        
    }
}

- (void)collectionView:(UICollectionView *)collectionView didDeselectItemAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"diddeselectitem");
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    if (collectionView == self.previewCollectionViewObj) {
        return CGSizeMake(self.previewCollectionViewObj.frame.size.width, self.previewCollectionViewObj.frame.size.height);
    } else{
        return CGSizeMake(self.albumCollectionViewObj.frame.size.width/3, self.albumCollectionViewObj.frame.size.width/3);
    }
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return 0.0;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return 0.0;
}

- (BOOL) collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (collectionView == self.previewCollectionViewObj) {
        
    } else{
        NSLog(@"shouldSelectItemAtIndexPath : %ld",(long)indexPath.row);
        AWLibraryCVCell *cell = (AWLibraryCVCell *) [self.albumCollectionViewObj cellForItemAtIndexPath:indexPath];
        
        //Unselected//
        if ([self.albumCollectionViewObj.indexPathsForSelectedItems containsObject: indexPath])
        {
            [self.albumCollectionViewObj deselectItemAtIndexPath: indexPath animated: YES];
            for (int i=0; i<self.arrSelectedAlbumsIndexPath.count; i++) {
                if ([self.arrSelectedAlbumsIndexPath objectAtIndex:i] == indexPath) {
                    [self.arrSelectedAlbumsIndexPath removeObjectAtIndex:i];
                }
            }
            for (int i=0; i<self.arrSelectedAlbumsIndexPath.count; i++) {
                AWLibraryCVCell *cell1 = (AWLibraryCVCell *) [self.albumCollectionViewObj cellForItemAtIndexPath:[self.arrSelectedAlbumsIndexPath objectAtIndex:i]];
                cell1.selectedNumber = i+1;
                cell1.lbl.text = [NSString stringWithFormat:@"%d",cell1.selectedNumber];
            }
            
            cell.lbl.text = @"";
            [self reloadPreviewSection];
            [self adjustCollectionViewWithAnimation];
            
            return NO;
        }
        
        //Selected//
        [self.arrSelectedAlbumsIndexPath addObject:indexPath];
        cell.selectedNumber = (int)self.arrSelectedAlbumsIndexPath.count;
        cell.lbl.text = [NSString stringWithFormat:@"%d",cell.selectedNumber];
        [self reloadPreviewSection];
        [self adjustCollectionViewWithAnimation];
    }
    
    return YES;
}

- (BOOL)collectionView:(UICollectionView *)collectionView shouldDeselectItemAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

/// Fetch out the last image from Device Library///

/*
 PHFetchOptions *fetchOptions = [[PHFetchOptions alloc] init];
 fetchOptions.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:@"creationDate" ascending:YES]];
 PHFetchResult *fetchResult = [PHAsset fetchAssetsWithMediaType:PHAssetMediaTypeImage options:fetchOptions];
 PHAsset *lastAsset = [fetchResult lastObject];
 [[PHImageManager defaultManager] requestImageForAsset:lastAsset
 targetSize:self.photoLibraryButton.bounds.size
 contentMode:PHImageContentModeAspectFill
 options:PHImageRequestOptionsVersionCurrent
 resultHandler:^(UIImage *result, NSDictionary *info) {
 
 dispatch_async(dispatch_get_main_queue(), ^{
 
 [[self photoLibraryButton] setImage:result forState:UIControlStateNormal];
 
 });
 }];
 */



@end
