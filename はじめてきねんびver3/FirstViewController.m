//
//  FirstViewController.m
//  はじめてきねんび
//
//  Created by Ueda Junya on 2013/08/21.
//  Copyright (c) 2013年 Ueda Junya. All rights reserved.
//

#import "FirstViewController.h"
#import <MobileCoreServices/MobileCoreServices.h>
#import "SettingViewController.h"
#import "CameraViewController.h"

@implementation FirstViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item {
    if ( item.tag == CAMERA_TAB ){
        
        [self performSegueWithIdentifier:@"camera" sender:item];
    }
    User *user = [User loadUser:item.tag];
//    [self paintBackgroundColor: user.userId];
    self.userName.text = user.name;    
}

- (void)paintBackgroundColor:(int)currentId{
    float r = 0;
    float g = 0;
    float b = 0;
    float a = 1.0;
    switch (currentId) {
        case 0:
            r = 1.0;
            g = 0.5;
            b = 0.0;
            break;
        case 1:
            r = 0.5;
            g = 0.0;
            b = 1.0;
            break;
        case 2:
            r = 0.0;
            g = 1.0;
            b = 0.5;
            break;
    }
    self.view.backgroundColor = [UIColor colorWithRed:r green:g blue:b alpha:a];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    User *user = [User getCurrentUser];
    if (!user) {
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        int currentId = [defaults integerForKey:@"currentId"];
        user = [User loadUser:currentId];
    }
    
	//ナビゲーションバーの色を変える
    self.navigationController.navigationBar.tintColor = [UIColor blackColor];
    
    //ユーザー切り替えをハンドリングする
    int i = 0;
    for (UITabBar *tab in self.userTab.items) {
        tab.tag=i++;
    }
    self.userTab.selectedItem = self.userTab.items[user.userId];
    self.userTab.delegate = self;
    self.view.backgroundColor = [UIColor colorWithRed:0.0 green:0.5 blue:1.0 alpha:1.0];
    
    //ナビゲーション切り替えをハンドリングする
    self.uIBarButtonItem.target = self;
    self.uIBarButtonItem.action = @selector(barButtonTap);
//    [self paintBackgroundColor: user.userId];
    
    
    //ユーザの名前を出す
    if ([user.name length] == 0 )
        self.userName.text = @"未設定";
    else
        self.userName.text = user.name;
//    UITabBarItem *tbi = [self.tabBar.items objectAtIndex:0];
//    tbi.title = @"hoge";
//    
    
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)openCam:(id)sender {
    UIImagePickerController *controller = [[UIImagePickerController alloc]init];
    controller.delegate = self;
    controller.sourceType = UIImagePickerControllerSourceTypeCamera;
    controller.mediaTypes = @[(__bridge NSString *)kUTTypeImage];
    
    //UI表示
    [self presentViewController:controller animated:YES completion:^{}];
    
}

//UIImagePickerControllerでの撮影が終わった後に呼び出される
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    //撮影UIを画面から取り除く
    [picker dismissViewControllerAnimated:YES completion:^{}];
    
}



@end
