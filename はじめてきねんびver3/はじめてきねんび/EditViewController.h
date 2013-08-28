//
//  EditViewController.h
//  はじめてきねんび
//
//  Created by Jin Sasaki on 2013/08/26.
//  Copyright (c) 2013年 Ueda Junya. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "User.h"
#import "Item.h"
#import "FirstViewController.h"

#define TEXT_FIELD_TITLE @"タイトル"
#define TEXT_FIELD_MESSAGE @"メッセージ"



@interface EditViewController : UIViewController<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UILabel *takenDate;
@property (weak, nonatomic) IBOutlet UIImageView *imageEdit;
@property (weak, nonatomic) IBOutlet UITextField *textFieldTitle;
@property (weak, nonatomic) IBOutlet UITextField *textFieldMessage;

- (IBAction)register:(id)sender;

@end
