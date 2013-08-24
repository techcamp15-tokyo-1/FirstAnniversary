//
//  SettingViewController.h
//  はじめてきねんび
//
//  Created by Ueda Junya on 2013/08/19.
//  Copyright (c) 2013年 Ueda Junya. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SettingViewController : UIViewController<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *textfield;

@property (weak, nonatomic) IBOutlet UILabel *labelBirthday;
@property (weak, nonatomic) IBOutlet UIDatePicker *userBirthday;
- (IBAction)DateChanged:(id)sender;
- (IBAction)saveInformation:(id)sender;


@property NSUserDefaults *defaults;

@end
