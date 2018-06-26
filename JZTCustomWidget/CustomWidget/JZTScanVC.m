//
//  JZTSacnVC.m
//  JZT_SUPPLIER
//
//  Created by 梁泽 on 2018/5/29.
//  Copyright © 2018年 com.jk998.jpeg. All rights reserved.
//

#import "JZTScanVC.h"
#import "JZTScanReadImageVC.h"
@interface JZTScanVC ()<AVCaptureMetadataOutputObjectsDelegate, UIImagePickerControllerDelegate>
@property (strong,nonatomic)AVCaptureDevice *device;
@property (strong,nonatomic)AVCaptureDeviceInput *input;
@property (strong,nonatomic)AVCaptureMetadataOutput *output;
@property (strong,nonatomic)AVCaptureSession *session;
@property (strong,nonatomic)AVCaptureVideoPreviewLayer *previewLayer;
@end

@implementation JZTScanVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    if (CGRectEqualToRect(self.scanRect, CGRectZero)) {
        self.scanRect = CGRectMake(40, 140, [UIScreen mainScreen].bounds.size.width - 2 * 40, [UIScreen mainScreen].bounds.size.width - 2 * 40);
    }
    if (self.metadataObjectTypes.count == 0) {
        self.metadataObjectTypes = @[AVMetadataObjectTypeQRCode,AVMetadataObjectTypeEAN13Code, AVMetadataObjectTypeEAN8Code, AVMetadataObjectTypeCode128Code];
    }    
    
    
    UIView *loadingView = [[UIView alloc] initWithFrame:self.view.bounds];
    loadingView.backgroundColor = [UIColor grayColor];
    UIActivityIndicatorView *aiv = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    aiv.center = loadingView.center;
    [aiv startAnimating];
    [loadingView addSubview:aiv];
    [self.view addSubview:loadingView];
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        AVAuthorizationStatus authStatus =  [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
        if (![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera] || authStatus == AVAuthorizationStatusRestricted || authStatus ==AVAuthorizationStatusDenied){
            dispatch_async(dispatch_get_main_queue(), ^{
                UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"未获得授权使用摄像头" message:@"请在iOS\"设置\"-\"隐私\"-\"相机\"中打开" preferredStyle:UIAlertControllerStyleAlert];
                [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil]];
                [self presentViewController:alert animated:YES completion:nil];
            });
            return;
        }
        [self setCamera];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [aiv stopAnimating];
            [UIView animateWithDuration:0.1 animations:^{
                loadingView.alpha = 0;
            } completion:^(BOOL finished) {
                [loadingView removeFromSuperview];
            }];
            [self startReading];
        });
    });
}

-(void)startReading{
    [self.session startRunning];
}

-(void)stopReading{
    [self.session stopRunning];
}

- (void)setCamera{
    _device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    _input = [AVCaptureDeviceInput deviceInputWithDevice:self.device error:NULL];
    
    _output = [[AVCaptureMetadataOutput alloc]init];
    [_output setMetadataObjectsDelegate:self queue:dispatch_get_main_queue()];
    
    _session = [[AVCaptureSession alloc]init];
    if ([_session canAddInput:self.input]) {
        [_session addInput:self.input];
    }
    
    if ([_session canAddOutput:self.output]) {
        [_session addOutput:self.output];
    }
    
    NSMutableArray *tempArr = @[].mutableCopy;
    for (AVMetadataObjectType obj in self.metadataObjectTypes) {
        if ([self.output.availableMetadataObjectTypes containsObject:obj]) {
            [tempArr addObject:obj];
        }
    }
    self.output.metadataObjectTypes = tempArr.copy;
    
    _previewLayer =[AVCaptureVideoPreviewLayer layerWithSession:self.session];
    _previewLayer.videoGravity = AVLayerVideoGravityResizeAspectFill;
    
    dispatch_async(dispatch_get_main_queue(), ^{
        self.previewLayer.frame = self.view.layer.bounds;
        [self.view.layer insertSublayer:self.previewLayer atIndex:0];
        __weak typeof(self) weakSelf = self;
        [[NSNotificationCenter defaultCenter] addObserverForName:AVCaptureInputPortFormatDescriptionDidChangeNotification object:nil queue:[NSOperationQueue mainQueue] usingBlock:^(NSNotification * _Nonnull note) {
            weakSelf.output.rectOfInterest = [weakSelf.previewLayer metadataOutputRectOfInterestForRect:weakSelf.scanRect];
        }];
    });
}
#pragma mark -
#pragma mark - extend
//手电筒🔦的开和关
- (void)flashlightOnOrOff:(BOOL)onOrOff{
    [self.device lockForConfiguration:nil];
    AVCaptureTorchMode mode = onOrOff ? AVCaptureTorchModeOn : AVCaptureTorchModeOff;
    [self.device setTorchMode:mode];
    [self.device unlockForConfiguration];
}

- (void)openPhotoLibrary{
    UIImagePickerController *pickCtr = [[UIImagePickerController alloc] init];
    pickCtr.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    pickCtr.delegate= self;
    pickCtr.allowsEditing = NO;
//    pickCtr.navigationBar.titleTextAttributes = @{ NSForegroundColorAttributeName : [UIColor whiteColor]};
    [self presentViewController:pickCtr animated:YES completion:nil];
}

- (void)readingCompletionWithResult:(NSString *)result metadataObjectType:(AVMetadataObjectType)type{
    if ([self.delegate respondsToSelector:@selector(jztSacn:didSearchResult:)]) {
        [self.delegate jztSacn:self didSearchResult:result];
    }
}

- (void)readingFailedType:(JZTScanSourceType)source{
    //子类实现
}

#pragma mark -
#pragma mark - AVCaptureMetadataOutputObjectsDelegate
- (void)captureOutput:(AVCaptureOutput *)output didOutputMetadataObjects:(NSArray<__kindof AVMetadataObject *> *)metadataObjects fromConnection:(AVCaptureConnection *)connection{
    NSString *stringValue;
    if (metadataObjects.count > 0) {
        AVMetadataMachineReadableCodeObject * metadataObject = [metadataObjects objectAtIndex:0];
        stringValue = metadataObject.stringValue;
        [self stopReading];
        
        if (stringValue.length == 0) {
            [self readingFailedType:JZTScanSourceTypeCamera];
            return;
        }
        [self readingCompletionWithResult:stringValue metadataObjectType:metadataObject.type];
    }
}

#pragma mark -
#pragma mark - UIImagePickerControllerDelegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{
    UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
    JZTScanReadImageVC *readVC = [[JZTScanReadImageVC alloc]initWithImage:image];
    __weak typeof(self) weakSelf = self;
    [readVC setReadingCompletion:^(NSString *result) {
        [picker dismissViewControllerAnimated:YES completion:nil];
        if (result.length == 0) {
            [weakSelf readingFailedType:JZTScanSourceTypeImage];
        }else{
            [self readingCompletionWithResult:result metadataObjectType:AVMetadataObjectTypeQRCode];
        }
    }];
    [picker pushViewController:readVC animated:YES];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    [picker dismissViewControllerAnimated:YES completion:nil];
}


@end
