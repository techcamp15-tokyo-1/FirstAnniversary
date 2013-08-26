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

@property (weak, nonatomic) IBOutlet UIImageView *pictureImage;
@property NSString *personName;//Taro
@property NSString *createdPersonDirPath;//TaroのPath
@property NSString *dateString;//日付のString選択した瞬間

-(void) saveImageFile:(UIImage *)image personName:name;//コピペ
//- (NSString*) getDataStorePath ;


@end
