//
//  QRCodeViewController.m
//  ITHouse
//
//  Created by zhifu360 on 2019/1/3.
//  Copyright © 2019 ZZJ. All rights reserved.
//

#import "QRCodeViewController.h"
#import <AVFoundation/AVFoundation.h>

#define QRCodeToolInstance [QRCodeTool sharedTool]

@interface QRCodeViewController ()<AVCaptureMetadataOutputObjectsDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>

///设备输入
@property (nonatomic, strong) AVCaptureDeviceInput *deviceInput;
///数据输出
@property (nonatomic, strong) AVCaptureMetadataOutput *dataOutput;
///捕获会话任务
@property (nonatomic, strong) AVCaptureSession *session;
///相机图像层
@property (nonatomic, strong) AVCaptureVideoPreviewLayer *previewLayer;
///imagePicker
@property (nonatomic, strong) UIImagePickerController *imagePicker;

@end

@implementation QRCodeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setNavigationBar];
    [self startScan];
}

#pragma mark - function
- (void)startScan {
    if (![self statusCheck]) {
        return;
    }
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.maskView];
    [self.view.layer insertSublayer:self.previewLayer atIndex:0];
    [self.session startRunning];
}

- (void)setNavigationBar {
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"相册" style:UIBarButtonItemStylePlain target:self action:@selector(openPhotoLibrary)];
}

- (void)openPhotoLibrary {
    if (![QRCodeToolInstance isLibaryAuthStatusCorrect]) {
        [QRCodeToolInstance showPermissionAlert:@"需要相机/相册权限" vc:self];
        return;
    }
    [self presentViewController:self.imagePicker animated:YES completion:nil];
}

- (BOOL)statusCheck {
    if (![QRCodeToolInstance isCameraAvailable]) {
        [QRCodeToolInstance showWarning:@"设备无相机" shouldPop:YES vc:self];
        return NO;
    }
    
    if (![QRCodeToolInstance isRearCameraAvailable] && ![QRCodeToolInstance isFrontCameraAvailable]) {
        [QRCodeToolInstance showWarning:@"设备相机错误" shouldPop:YES vc:self];
        return NO;
    }
    NSLog(@"%@",@([QRCodeToolInstance isCameraAuthStatusCorrect]));
    if (![QRCodeToolInstance isCameraAuthStatusCorrect]) {
        [QRCodeToolInstance showPermissionAlert:@"需要相机/相册权限" vc:self];
        return NO;
    }
    
    return YES;
}

///可扫描范围
- (CGRect)scanRect {
    //通过代理设置扫描范围
    if (self.delegate && [self.delegate respondsToSelector:@selector(interestedRect)]) {
        return [self.delegate interestedRect];
    }
    
    CGSize scanSize = CGSizeMake(QRSCREEN_WIDTH/3*4, QRSCREEN_HEIGHT/3*4);
    CGRect scanRect = CGRectMake((QRSCREEN_WIDTH-scanSize.width)/2, (QRSCREEN_HEIGHT-scanSize.height)/2, scanSize.width, scanSize.height);
    return scanRect;
}

- (CGRect)scanRectOfInterest {
    CGRect scanRect = [self scanRect];
    scanRect = CGRectMake(scanRect.size.height/QRSCREEN_HEIGHT, scanRect.size.width/QRSCREEN_WIDTH, scanRect.size.height/QRSCREEN_HEIGHT, scanRect.size.width/QRSCREEN_WIDTH);
    return scanRect;
}

#pragma mark - UIImagePickerControllerDelegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<UIImagePickerControllerInfoKey,id> *)info {
    [picker dismissViewControllerAnimated:YES completion:nil];
    UIImage *image = info[UIImagePickerControllerOriginalImage];
    NSString *result = [QRCodeToolInstance messageFromQRCodeImage:image];
    //识别信息处理
    NSLog(@"识别结果：%@",result);
    if (self.delegate && [self.delegate respondsToSelector:@selector(scanMessage:)]) {
        [self.delegate scanMessage:result];
    }
}

#pragma mark - AVCaptureMetadataOutputObjectsDelegate
- (void)captureOutput:(AVCaptureOutput *)output didOutputMetadataObjects:(NSArray<__kindof AVMetadataObject *> *)metadataObjects fromConnection:(AVCaptureConnection *)connection {
    if (metadataObjects.count == 0) {
        return;
    }
    
    [self.session stopRunning];
    NSString *result = [metadataObjects.firstObject stringValue];
    NSLog(@"扫描结果：%@",result);
    if (self.delegate && [self.delegate respondsToSelector:@selector(scanMessage:)]) {
        [self.delegate scanMessage:result];
    }
}

#pragma mark - lazy
- (AVCaptureDeviceInput *)deviceInput {
    if (!_deviceInput) {
        NSError *error;
        AVCaptureDevice *device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
        _deviceInput = [AVCaptureDeviceInput deviceInputWithDevice:device error:&error];
        if (error) {
            NSLog(@"%@",error.localizedDescription);
        }
    }
    return _deviceInput;
}

- (AVCaptureMetadataOutput *)dataOutput {
    if (!_dataOutput) {
        _dataOutput = [[AVCaptureMetadataOutput alloc] init];
        [_dataOutput setMetadataObjectsDelegate:self queue:dispatch_get_main_queue()];
        _dataOutput.rectOfInterest = [self scanRectOfInterest];
    }
    return _dataOutput;
}

- (AVCaptureSession *)session {
    if (!_session) {
        _session = [[AVCaptureSession alloc] init];
        [_session setSessionPreset:(QRSCREEN_HEIGHT < 500) ? AVCaptureSessionPreset640x480 : AVCaptureSessionPreset1920x1080];
        if ([_session canAddInput:self.deviceInput]) {
            [_session addInput:self.deviceInput];
        }
        
        if ([_session canAddOutput:self.dataOutput]) {
            [_session addOutput:self.dataOutput];
            self.dataOutput.metadataObjectTypes = @[AVMetadataObjectTypeQRCode];
        }
    }
    return _session;
}

- (AVCaptureVideoPreviewLayer *)previewLayer {
    if (!_previewLayer) {
        _previewLayer = [AVCaptureVideoPreviewLayer layerWithSession:self.session];
        _previewLayer.videoGravity = AVLayerVideoGravityResizeAspectFill;
        _previewLayer.frame = [UIScreen mainScreen].bounds;
    }
    return _previewLayer;
}

- (UIImagePickerController *)imagePicker {
    if (!_imagePicker) {
        _imagePicker = [[UIImagePickerController alloc] init];
        _imagePicker.delegate = self;
        _imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    }
    return _imagePicker;
}

- (UIView *)maskView {
    if (!_maskView) {
        _maskView = [[UIView alloc] initWithFrame:self.view.bounds];
        _maskView.backgroundColor = [UIColor blackColor];
        _maskView.alpha = 0.8;
        UIBezierPath *path = [UIBezierPath bezierPathWithRect:_maskView.bounds];
        [path appendPath:[[UIBezierPath bezierPathWithRect:[self scanRect]] bezierPathByReversingPath]];
        CAShapeLayer *layer = [CAShapeLayer layer];
        layer.path = path.CGPath;
        _maskView.layer.mask = layer;
    }
    return _maskView;
}

@end
