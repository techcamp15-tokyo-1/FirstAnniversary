//
//  SettingViewController.m
//  はじめてきねんび
//
//  Created by Ueda Junya on 2013/08/19.
//  Copyright (c) 2013年 Ueda Junya. All rights reserved.
//

#import "SettingViewController.h"

@interface SettingViewController ()

@end

@implementation SettingViewController
@synthesize birthdaySet;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    birthdaySet.datePickerMode = UIDatePickerModeDate;
    // 言語は日本語(iOSの設定の書式に該当)
    birthdaySet.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"ja_JP"];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
