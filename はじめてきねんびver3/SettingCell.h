//
//  SettingCell.h
//  はじめてきねんび
//
//  Created by Jin Sasaki on 2013/08/25.
//  Copyright (c) 2013年 Ueda Junya. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SettingCell : UICollectionViewCell
@property (strong, nonatomic) IBOutlet UITextField *textField;
@property (strong, nonatomic) IBOutlet UILabel *labelBirthday;
@property (nonatomic ,retain) IBOutlet UIDatePicker *userBirthday;
- (IBAction)DateChanged:(id)sender;
- (IBAction)saveInformation:(id)sender;

@end
