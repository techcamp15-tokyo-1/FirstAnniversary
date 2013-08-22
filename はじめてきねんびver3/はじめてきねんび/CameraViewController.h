//
//  CameraViewController.h
//  はじめてきねんび
//
//  Created by Ueda Junya on 2013/08/21.
//  Copyright (c) 2013年 Ueda Junya. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <opencv2/highgui/highgui_c.h>
#import <opencv2/highgui/highgui.hpp>
//#import <opencv2/core/core_c.h>

//using namespace cv;


@interface CameraViewController : UIViewController<UINavigationControllerDelegate, UIImagePickerControllerDelegate>//, CvVideoCameraDelegate>
{
// CVideoCamera* videocamera;
}
- (IBAction)cameraButtonTapped:(id)sender;
- (IBAction)libraryButtonTapped:(id)sender;
@property (weak, nonatomic) IBOutlet UIImageView *pictureImage;
//@property (nonatomic,retain)CvVideoCamera

@end
