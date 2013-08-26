//
//  MovieViewController.h
//  はじめてきねんび
//
//  Created by Ueda Junya on 2013/08/25.
//  Copyright (c) 2013年 Ueda Junya. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>

@interface MovieViewController : UIViewController <AVCaptureVideoDataOutputSampleBufferDelegate>
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (nonatomic, strong) AVCaptureSession* session;
@end
