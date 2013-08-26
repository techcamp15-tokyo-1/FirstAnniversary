//
//  UIImage+OpenCV.mm
//  OpenCVClient
//
//  Created by Robin Summerhill on 02/09/2011.
//  Copyright 2011 Aptogo Limited. All rights reserved.
//
//  Permission is given to use this source code file without charge in any
//  project, commercial or otherwise, entirely at your risk, with the condition
//  that any redistribution (in part or whole) of source code must retain
//  this copyright and permission notice. Attribution in compiled projects is
//  appreciated but not required.
//

#import "UIImage+OpenCV.h"

@implementation UIImage (OpenCV)

-(cv::Mat)CVMat
{
    // self(UIImage)の色空間を取得
    CGColorSpaceRef colorSpace = CGImageGetColorSpace(self.CGImage);
    CGFloat cols = self.size.width;
    CGFloat rows = self.size.height;

    // cv::Matオブジェクトとして領域を確保
    cv::Mat cvMat(rows, cols, CV_8UC4); // 8 bits per component, 4 channels

    // cvMat.dataをベースにビットマップコンテキストを作成
    CGContextRef contextRef = \
        CGBitmapContextCreate(cvMat.data,         // Pointer to backing data
                              cols,               // Width of bitmap
                              rows,               // Height of bitmap
                              8,                  // Bits per component
                              cvMat.step[0],      // Bytes per row
                              colorSpace,         // Colorspace
                              kCGImageAlphaNoneSkipLast |
                              kCGBitmapByteOrderDefault); // Bitmap info flags

    // UIImageの画像データをコンテキスト上に描画
    CGContextDrawImage(contextRef,
                       CGRectMake(0, 0, cols, rows),
                       self.CGImage);

    // 不要になったコンテキストを解放(cvMatのdataは残る)
    CGContextRelease(contextRef);
    return cvMat;
}

- (id)initWithCVMat:(const cv::Mat&)cvMat
              scale:(CGFloat)scale
        orientation:(UIImageOrientation)orientation
{
    size_t bitsPerPixel, bytesPerRow;
    CGBitmapInfo bitmapInfo = 0;

    // データをNSData型にラップ
    NSData *data = [NSData dataWithBytes:cvMat.data
                                  length:cvMat.elemSize() * cvMat.total()];

    // NSDataを元にDataProviderを作成し、それを元にCGImageRefを作成
    bitsPerPixel = 8 * cvMat.elemSize();
    bytesPerRow = cvMat.step[0];
    bitmapInfo = kCGImageAlphaNone | kCGBitmapByteOrderDefault;
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGDataProviderRef provider = \
        CGDataProviderCreateWithCFData((__bridge CFDataRef)data);
    CGImageRef imageRef = \
        CGImageCreate(cvMat.cols,                 // Width
                      cvMat.rows,                 // Height
                      8,                          // Bits per component
                      bitsPerPixel,               // Bits per pixel
                      bytesPerRow,                // Bytes per row
                      colorSpace,                 // Colorspace
                      bitmapInfo,                 // Bitmap info flags
                      provider,                   // CGDataProviderRef
                      NULL,                       // Decode
                      false,                      // Should interpolate
                      kCGRenderingIntentDefault); // Intent

    // CGImageRefを使ってUIImageとして初期化
    // imageRefだけでは倍率と方向が不明なため別途指定する
    self = [self initWithCGImage:imageRef
                           scale:scale
                     orientation:orientation];

    // 不要になった情報を削除
    CGImageRelease(imageRef);
    CGDataProviderRelease(provider);
    CGColorSpaceRelease(colorSpace);

    return self;
}


@end
