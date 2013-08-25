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

- (IBAction)openCam:(id)sender;
- (IBAction)sendInformationToSetting:(id)sender;

@property (weak, nonatomic) IBOutlet UIBarButtonItem *uIBarButtonItem;

@end
