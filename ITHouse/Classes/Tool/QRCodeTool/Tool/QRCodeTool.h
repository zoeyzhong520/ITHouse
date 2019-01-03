//
//  QRCodeTool.h
//  ITHouse
//
//  Created by zhifu360 on 2019/1/3.
//  Copyright © 2019 ZZJ. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

#define QRSCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
#define QRSCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height

@interface QRCodeTool : NSObject

+ (instancetype)sharedTool;

///识别图片二维码
- (NSString *)messageFromQRCodeImage:(UIImage *)image;

///相机是否存在
- (BOOL)isCameraAvailable;
///前置摄像头是否正常
- (BOOL)isFrontCameraAvailable;
///后置摄像头是否正常
- (BOOL)isRearCameraAvailable;
///相机权限是否正常
- (BOOL)isCameraAuthStatusCorrect;
///相册权限是否正常
- (BOOL)isLibaryAuthStatusCorrect;

///弹框
- (void)showPermissionAlert:(NSString *)message vc:(UIViewController *)vc;
///警告
- (void)showWarning:(NSString *)message shouldPop:(BOOL)pop vc:(UIViewController *)vc;

@end

NS_ASSUME_NONNULL_END
