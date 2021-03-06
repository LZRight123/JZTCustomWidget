//
//  JZTSacnVC.h
//  JZT_SUPPLIER
//
//  Created by 梁泽 on 2018/5/29.
//  Copyright © 2018年 com.jk998.jpeg. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
typedef NS_ENUM(NSUInteger, JZTScanSourceType) {
    JZTScanSourceTypeImage,
    JZTScanSourceTypeCamera,
};
@class JZTScanVC;
@protocol JZTScanDelegate<NSObject>
- (void)jztSacn:(JZTScanVC *)scanVC didSearchResult:(NSString *)result;
@end

@interface JZTScanVC : UIViewController <UINavigationControllerDelegate>
@property (nonatomic, weak  ) id<JZTScanDelegate> delegate;
///defalut = CGRectMake(40, 140, [UIScreen mainScreen].bounds.size.width - 2 * 40, [UIScreen mainScreen].bounds.size.height - 2 * 140)
@property (nonatomic, assign) CGRect scanRect;
///default =  @[AVMetadataObjectTypeQRCode,AVMetadataObjectTypeEAN13Code, AVMetadataObjectTypeEAN8Code, AVMetadataObjectTypeCode128Code]
@property (nonatomic, strong) NSArray<AVMetadataObjectType> *metadataObjectTypes;
@property (nonatomic, assign, readonly) BOOL cameraAuthorization;//yes is open

-(void)startReading;
-(void)stopReading;
//手电筒🔦的开和关
- (void)flashlightOnOrOff:(BOOL)onOrOff;
//从相册读取二维码
- (void)openPhotoLibrary;
//没有授权情况下点警告确定，默认navigationController pop
- (void)dontAuthorizationClickAlertSure;
///重载可调用super 
- (void)readingCompletionWithResult:(NSString *)result metadataObjectType:(AVMetadataObjectType)type;
- (void)readingFailedType:(JZTScanSourceType)source;
@end
