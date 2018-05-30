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
    UIView *loadingView = [[UIView alloc]init];
    loadingView.backgroundColor = [[UIColor blackColor]colorWithAlphaComponent:0.7];
    loadingView.frame = CGRectMake(0, 0, 100, 100);
    loadingView.layer.cornerRadius = 5;
    loadingView.center = self.imageView.center;
    [self.imageView addSubview:loadingView];
    UIActivityIndicatorView *aiv = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
    aiv.transform = CGAffineTransformMakeScale(2, 2);
    aiv.center = CGPointMake(50, 37);
    [aiv startAnimating];
    [loadingView addSubview:aiv];
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(aiv.frame) + 10, CGRectGetWidth(loadingView.frame), 20)];
    label.text = @"正在处理...";
    label.textColor = [UIColor whiteColor];
    label.font = [UIFont systemFontOfSize:13];
    label.textAlignment = NSTextAlignmentCenter;
    [loadingView addSubview:label];
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSString *str = [self readQRCodeFromImage:self.image];
        dispatch_async(dispatch_get_main_queue(), ^{
            [loadingView removeFromSuperview];
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
