//
//  SettingViewController.h
//  はじめてきねんび
//
//  Created by Ueda Junya on 2013/08/19.
//  Copyright (c) 2013年 Ueda Junya. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "User.h"

@interface SettingViewController : UIViewController<UITextFieldDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>

@property (strong, nonatomic) IBOutlet UITextField *textfield;

@property (strong, nonatomic) IBOutlet UILabel *labelBirthday;
@property (nonatomic ,retain) IBOutlet UIDatePicker *userBirthday;
- (IBAction)DateChanged:(id)sender;
- (IBAction)saveInformation:(id)sender;

- (IBAction)openCamera:(id)sender;
@property (weak, nonatomic) IBOutlet UIImageView *image;

@end

enum ERRORTYPE {
    SUCCESS,
    ERR_NONAME,
    ERR_BIRTHDAY_IS_INVALID
};