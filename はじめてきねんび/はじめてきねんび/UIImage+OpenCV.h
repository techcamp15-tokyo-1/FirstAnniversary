//
//  UIImage+OpenCV.h
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


#import <UIKit/UIKit.h>
#include <opencv2/opencv.hpp>

@interface UIImage (OpenCV)

// UIImageオブジェクトからcv::Matオブジェクトを作成し、返す
-(cv::Mat)CVMat;

// cv::MatオブジェクトからUIImageオブジェクトを作成し、返す
-(id)initWithCVMat:(const cv::Mat&)cvMat
             scale:(CGFloat)scale
       orientation:(UIImageOrientation)orientation;

@end
