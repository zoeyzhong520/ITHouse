//
//  QRCodeTool.m
//  ITHouse
//
//  Created by zhifu360 on 2019/1/3.
//  Copyright © 2019 ZZJ. All rights reserved.
//

#import "QRCodeTool.h"
#import <GLKit/GLKit.h>
#import <AVFoundation/AVFoundation.h>
#import <Photos/Photos.h>

@implementation QRCodeTool

+ (instancetype)sharedTool {
    static QRCodeTool *instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[self alloc] init];
    });
    return instance;
}

#pragma mark - function
- (NSString *)messageFromQRCodeImage:(UIImage *)image {
    if (!image) {
        return @"未能识别";
    }
    
    //创建上下文
    CIContext *context = [CIContext contextWithOptions:nil];
    //识别类型设置为二维码，精度设为高
    CIDetector *detector = [CIDetector detectorOfType:CIDetectorTypeQRCode context:context options:@{CIDetectorAccuracy: CIDetectorAccuracyHigh}];
    //转换image
    CIImage *ciImage = [CIImage imageWithCGImage:image.CGImage];
    //识别结果
    NSArray *features = [detector featuresInImage:ciImage];
    
    if (features.count == 0) {
        return @"未能识别";
    }
    CIQRCodeFeature *fearure = features.firstObject;
    return fearure.messageString;
}

#pragma mark - 检查设备、权限
- (BOOL)isCameraAvailable {
    return [UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera];
}

- (BOOL)isFrontCameraAvailable {
    return [UIImagePickerController isCameraDeviceAvailable:UIImagePickerControllerCameraDeviceFront];
}

- (BOOL)isRearCameraAvailable {
    return [UIImagePickerController isCameraDeviceAvailable:UIImagePickerControllerCameraDeviceRear];
}

- (BOOL)isCameraAuthStatusCorrect {
    AVAuthorizationStatus status = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
    if (status == AVAuthorizationStatusDenied || status == AVAuthorizationStatusRestricted) {
        return NO;
    }
    return YES;
}

- (BOOL)isLibaryAuthStatusCorrect {
    PHAuthorizationStatus status = [PHPhotoLibrary authorizationStatus];
    if (status == PHAuthorizationStatusDenied || status == PHAuthorizationStatusRestricted) {
        return NO;
    }
    return YES;
}

#pragma mark - 弹框、警告
- (void)showPermissionAlert:(NSString *)message vc:(UIViewController *)vc {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:message preferredStyle:UIAlertControllerStyleAlert];
    [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        [vc.navigationController popViewControllerAnimated:YES];
    }]];
    [alert addAction:[UIAlertAction actionWithTitle:@"同意" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        NSURL *url = [NSURL URLWithString:UIApplicationOpenSettingsURLString];
        if ([[UIApplication sharedApplication] canOpenURL:url]) {
            [[UIApplication sharedApplication] openURL:url];
        }
    }]];
    [vc presentViewController:alert animated:YES completion:nil];
}

- (void)showWarning:(NSString *)message shouldPop:(BOOL)pop vc:(UIViewController *)vc {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:message preferredStyle:UIAlertControllerStyleAlert];
    [alert addAction:[UIAlertAction actionWithTitle:@"好的" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        if (pop) {
            [vc.navigationController popViewControllerAnimated:YES];
        }
    }]];
    [vc presentViewController:alert animated:YES completion:nil];
}

@end
