//
//  SettingViewController.m
//  はじめてきねんび
//
//  Created by Ueda Junya on 2013/08/19.
//  Copyright (c) 2013年 Ueda Junya. All rights reserved.
//

#import "SettingViewController.h"
#import "FirstViewController.h"


@implementation SettingViewController

NSUserDefaults *defaults;
User *user;
int userId;

-
(id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

//- (IBAction)DateChanged:(id)sender{
//    [NSUserDefaults ]
//    //ラベルに表示する日付・時刻のフォーマットを指定
//    NSDateFormatter *df = [[NSDateFormatter alloc]init];
//    df.dateFormat = @"yyyy年MM月dd日 HH時mm分";
//    
//    [self.defaults setObject:df forKey:@"birthday"];
//    
//    //ラベルに指定したフォーマットで表示
//   // NSLog([df stringFromDate:userBirthday.date]);
//    
//}

//ユーザ情報を保存
- (IBAction)saveInformation:(id)sender {
    user.name = self.textfield.text;
}


//閉じたときキーボードをしまう
-(BOOL)textFieldShouldReturn:(UITextField*)textField{
    [self.textfield resignFirstResponder];
    return YES;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.textfield.delegate = self;

    // 言語は日本語(iOSの設定の書式に該当)
    self.userBirthday.datePickerMode = UIDatePickerModeDate;
    self.userBirthday.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"ja_JP"];
    
//    //誕生日を表示
//    if ([[self.defaults stringForKey:@"birthday"] length] == 0 ){
//        [labelBirthday setText:@"Pleas input the birthday"];
//    }else{
//        [labelBirthday setText:[self.defaults stringForKey:@"birthday"]];
//    }
    
    defaults = [NSUserDefaults standardUserDefaults];
    
    user = [User getCurrentUser];
    if ([user.name isEqualToString:NO_NAME]) {
        self.textfield.placeholder = @"名前を入力してください";
    } else {
        self.textfield.text = user.name;
        NSLog(@"elseの方通ってますわ");
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
