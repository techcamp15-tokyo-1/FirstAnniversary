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
        
//        CameraViewController *mycontroller = [self.storyboard instantiateViewControllerWithIdentifier:@"camera"];
//        [self presentViewController:mycontroller animated:YES completion:nil];
    
    }
    User *user = [User loadUser:item.tag];
    self.userName.text = user.name;    
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
    for (UITabBar *tab in self.userTab.items) tab.tag=i++;
    self.userTab.selectedItem = self.userTab.items[user.userId];
    self.userTab.delegate = self;
    
    //ナビゲーション切り替えをハンドリングする
    self.uIBarButtonItem.target = self;
    self.uIBarButtonItem.action = @selector(barButtonTap);
    
    //ユーザの名前を出す
    if ([user.name length] == 0 )
        self.userName.text = @"未設定";
    else
        self.userName.text = user.name;
    
    NSLog(@" %@",user.name);
    
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
