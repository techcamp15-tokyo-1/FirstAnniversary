//
//  SettingViewController.m
//  はじめてきねんび
//
//  Created by Ueda Junya on 2013/08/19.
//  Copyright (c) 2013年 Ueda Junya. All rights reserved.
//

#import "SettingViewController.h"
#import "FirstViewController.h"


@interface SettingViewController ()
{
    UILabel *labelBirthday;
    UITextField *userName;
    
}

@end

@implementation SettingViewController
@synthesize userBirthday;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (IBAction)DateChanged:(id)sender{
    
    //ラベルに表示する日付・時刻のフォーマットを指定
    NSDateFormatter *df = [[NSDateFormatter alloc]init];
    df.dateFormat = @"yyyy年MM月dd日 HH時mm分";
    
    [self.defaults setObject:df forKey:@"birthday"];
    
    //ラベルに指定したフォーマットで表示
   // NSLog([df stringFromDate:userBirthday.date]);
    
}

- (IBAction)saveInformation:(id)sender {
    NSString *name= self.textfield.text;
    [self.defaults setObject: name forKey:@"name"] ;
    name=[self.defaults objectForKey:@"name"];
    NSLog(@"%@",name);
    BOOL successful = [self.defaults synchronize];
    if(successful){
        NSLog(@"保存されました");
    }
    UIViewController *con = [[FirstViewController alloc] init];
    UINavigationController *navCon = [[UINavigationController alloc] initWithRootViewController:con];
    [self.navigationController popToRootViewControllerAnimated:YES];
;
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.textfield.delegate = self;
    
	// Do any additional setup after loading the view.
    userBirthday.datePickerMode = UIDatePickerModeDate;
    // 言語は日本語(iOSの設定の書式に該当)
    userBirthday.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"ja_JP"];
    if ([self.defaults objectForKey:@"birthday"]==nil){
        [labelBirthday setText:@"Pleas input the birthday"];
    }else{
        [labelBirthday setText:[self.defaults objectForKey:@"birthday"]];
        
    }
     userName.text=[self.defaults objectForKey:@"name"];
     
    
}
-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [self.view endEditing:YES];
    return YES;

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
