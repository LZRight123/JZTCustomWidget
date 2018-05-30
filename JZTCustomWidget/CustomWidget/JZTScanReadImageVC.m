//
//  JZTScanReadImageVC.m
//  JZT_SUPPLIER
//
//  Created by 梁泽 on 2018/5/29.
//  Copyright © 2018年 com.jk998.jpeg. All rights reserved.
//

#import "JZTScanReadImageVC.h"

@interface JZTScanReadImageVC ()
@property (nonatomic, strong) UIImage *image;
@property (nonatomic, strong) UIImageView *imageView;
@end

@implementation JZTScanReadImageVC
- (instancetype)initWithImage:(UIImage *)image
{
    self = [super init];
    if (self) {
        _image = image;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"完成" style:UIBarButtonItemStylePlain target:self action:@selector(clickDone)];
    self.imageView = [[UIImageView alloc]initWithFrame:self.view.bounds];
    [self.view addSubview:self.imageView];
    self.imageView.image = self.image;
}

- (void)clickDone{
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.label.text = @"正在处理";
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSString *str = [self readQRCodeFromImage:self.image];
        dispatch_async(dispatch_get_main_queue(), ^{
            [hud hideAnimated:YES];
            if (self.readingCompletion) {
                self.readingCompletion(str);
            }
        });
    });
    
    //震动
    //    AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);
}

- (void)dealloc{
    
}

#pragma mark -
#pragma mark - helper
- (NSString *)readQRCodeFromImage:(UIImage *)image{
    NSData *data = UIImagePNGRepresentation(image);
    CIImage *ciimage = [CIImage imageWithData:data];
    if (ciimage) {
        CIDetector *qrDetector = [CIDetector detectorOfType:CIDetectorTypeQRCode context:nil options:@{CIDetectorAccuracy : CIDetectorAccuracyHigh}];
        NSArray *resultArr = [qrDetector featuresInImage:ciimage];
        if (resultArr.count >0) {
            CIFeature *feature = resultArr.firstObject;
            CIQRCodeFeature *qrFeature = (CIQRCodeFeature *)feature;
            NSString *result = qrFeature.messageString;
            
            return result;
        }else{
            return nil;
        }
    }else{
        return nil;
    }
}

@end
