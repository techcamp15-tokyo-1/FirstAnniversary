//
//  FirstViewController.h
//  はじめてきねんび
//
//  Created by Ueda Junya on 2013/08/21.
//  Copyright (c) 2013年 Ueda Junya. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MobileCoreServices/MobileCoreServices.h>
#import "SettingViewController.h"
#import "FileManager.h"
#import "EditViewController.h"
<<<<<<< HEAD
=======
#import <QuartzCore/QuartzCore.h>
>>>>>>> c790d9e6035e54d720f2190c24558fc269bf64db

#ifndef CAMERA_TAB
#define CAMERA_TAB 3
#endif

#ifndef TMP_PHOTO
#define TMP @"tmp"
#define TMP_IMAGE @"tmpImage"
#define TMP_DATE @"tmpDate"
#endif


@interface FirstViewController : UIViewController<UINavigationControllerDelegate, UIImagePickerControllerDelegate,
    UITabBarDelegate
>
@property (weak, nonatomic) IBOutlet UITabBar *userNumber;
@property (weak, nonatomic) IBOutlet UILabel *userName;
@property (weak, nonatomic) IBOutlet UITabBar *userTab;
@property (weak, nonatomic) IBOutlet UIImageView *userImage;

- (IBAction)historyPushd:(id)sender;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *uIBarButtonItem;

@property (weak, nonatomic) IBOutlet UIImageView *pictureImage;

@property (weak, nonatomic) IBOutlet UIButton *timeline;
@property (weak, nonatomic) IBOutlet UIButton *films;

@property NSString *personName;//Taro
@property NSString *createdPersonDirPath;//TaroのPath
@property NSString *dateString;//日付のString選択した瞬間

-(void) saveImageFile:(UIImage *)image personName:name;//コピペ
//- (NSString*) getDataStorePath ;




@end
