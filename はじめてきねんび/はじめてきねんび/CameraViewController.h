//
//  CameraViewController.h
//  はじめてきねんび
//
//  Created by Ueda Junya on 2013/08/21.
//  Copyright (c) 2013年 Ueda Junya. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CameraViewController : UIViewController<UINavigationControllerDelegate, UIImagePickerControllerDelegate>
{
}
- (IBAction)cameraButtonTapped:(id)sender;
- (IBAction)libraryButtonTapped:(id)sender;

@property (weak, nonatomic) IBOutlet UIImageView *pictureImage;
@property NSString *personName;
@property NSString *createdPersonDirPath;
@property NSString *dateString;
-(void) saveImageFile:(UIImage *)image personName:name;
- (NSString*) getDataStorePath ;
- (void) readImageFile;
//-(NSString*)createNewImageDirectory:(NSString*)name;


@end
