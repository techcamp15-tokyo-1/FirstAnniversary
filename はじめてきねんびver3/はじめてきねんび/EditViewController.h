//
//  EditViewController.h
//  はじめてきねんび
//
//  Created by Jin Sasaki on 2013/08/26.
//  Copyright (c) 2013年 Ueda Junya. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EditViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIImageView *imageEdit;
@property (weak, nonatomic) IBOutlet UITextField *textFieldTitle;
@property (weak, nonatomic) IBOutlet UITextField *textFieldMessage;

@end
