//
//  SettingViewController.h
//  はじめてきねんび
//
//  Created by Ueda Junya on 2013/08/19.
//  Copyright (c) 2013年 Ueda Junya. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "User.h"
#import "FirstViewController.h"
#import "FileManager.h"


@interface SettingViewController : UIViewController<UITextFieldDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>

@property (strong, nonatomic) IBOutlet UITextField *textfield;

@property (nonatomic ,retain) IBOutlet UIDatePicker *userBirthday;
- (IBAction)DateChanged:(id)sender;
- (IBAction)saveInformation:(id)sender;

- (IBAction)openCamera:(id)sender;
@property (weak, nonatomic) IBOutlet UIImageView *userImage;

@end

enum ERRORTYPE {
    SUCCESS,
    ERR_NONAME,
    ERR_BIRTHDAY_IS_INVALID
};