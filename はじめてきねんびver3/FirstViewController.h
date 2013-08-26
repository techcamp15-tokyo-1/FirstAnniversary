//
//  FirstViewController.h
//  はじめてきねんび
//
//  Created by Ueda Junya on 2013/08/21.
//  Copyright (c) 2013年 Ueda Junya. All rights reserved.
//

#import <UIKit/UIKit.h>
#define CAMERA_TAB 3


@interface FirstViewController : UIViewController<UINavigationControllerDelegate, UIImagePickerControllerDelegate,
    UITabBarDelegate
>
@property (weak, nonatomic) IBOutlet UITabBar *userNumber;
@property (weak, nonatomic) IBOutlet UILabel *userName;
@property (weak, nonatomic) IBOutlet UITabBar *userTab;

@property (weak, nonatomic) IBOutlet UIBarButtonItem *uIBarButtonItem;

@property (weak, nonatomic) IBOutlet UIImageView *pictureImage;


@property NSString *personName;//Taro
@property NSString *createdPersonDirPath;//TaroのPath
@property NSString *dateString;//日付のString選択した瞬間

-(void) saveImageFile:(UIImage *)image personName:name;//コピペ
//- (NSString*) getDataStorePath ;




@end
