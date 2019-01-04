//
//  QRCodeViewController.h
//  ITHouse
//
//  Created by zhifu360 on 2019/1/3.
//  Copyright © 2019 ZZJ. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QRCodeTool.h"

NS_ASSUME_NONNULL_BEGIN

@class QRCodeViewController;

@protocol QRCodeViewControllerDelegate <NSObject>

@optional
- (void)scanMessage:(NSString *)message andQRCodeVC:(QRCodeViewController *)QRCodeVC;
@optional
- (CGRect)interestedRect;

@end

///二维码扫描
@interface QRCodeViewController : UIViewController

///蒙层，可添加文字等
@property (nonatomic, strong) UIView *maskView;

@property (nonatomic, weak) id<QRCodeViewControllerDelegate>delegate;

@end

NS_ASSUME_NONNULL_END
