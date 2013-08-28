//
//  FirstViewController.m
//  はじめてきねんび
//
//  Created by Ueda Junya on 2013/08/21.
//  Copyright (c) 2013年 Ueda Junya. All rights reserved.
//

#import "FirstViewController.h"

@implementation FirstViewController
@synthesize pictureImage;
@synthesize personName;
@synthesize createdPersonDirPath;
@synthesize dateString;


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
    
    //ナビゲーション切り替えをハンドリングする
    self.uIBarButtonItem.target = self;
    self.uIBarButtonItem.action = @selector(barButtonTap);
    //    [self paintBackgroundColor: user.userId];
    
    
    //ユーザの名前を出す
    if ([user.name length] == 0 )
        self.userName.text = @"未設定";
    else
        self.userName.text = user.name;
    self.userImage.image = [[UIImage alloc]initWithData:user.image];
    UITabBarItem *tbi;
    int tmp = user.userId;
    for (int i = 0 ; i < 3 ; i++){
        tbi = [self.userTab.items objectAtIndex:i];
        tbi.title = [User loadUser:i].name;
    }
    user = [User loadUser:tmp];
    
}
// 写真を撮影した後
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
	// オリジナル画像
	UIImage *originalImage = (UIImage *)[info objectForKey:UIImagePickerControllerOriginalImage];
	// 編集画像
	UIImage *editedImage = (UIImage *)[info objectForKey:UIImagePickerControllerEditedImage];
	editedImage = editedImage ? editedImage : originalImage;
    
    FileManager *fm = [FileManager getInstance];
    NSLog([fm createDirNamedOfUserId] ? @"SUCCESS" : @"ERR");
    NSData *imageData = [[NSData alloc] initWithData:UIImageJPEGRepresentation(editedImage, 0.8f)];
    [fm saveImageData:imageData andDate:[NSDate date]];
    
	if(picker.sourceType == UIImagePickerControllerSourceTypeCamera)
        
    [self dismissViewControllerAnimated:YES completion:nil];
    //画面遷移
    [self performSegueWithIdentifier:@"toEditView" sender:nil];
    
    
}

- (void)tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item {
    if ( item.tag == CAMERA_TAB ){
        self.userTab.selectedItem = self.userTab.items[[User getCurrentUser].userId];
 //       [self openCam:item];
        if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
        {
            UIImagePickerController *imagePickerController = [[UIImagePickerController alloc]init];
            // カメラかライブラリからの読込指定。カメラを指定。
            [imagePickerController setSourceType:UIImagePickerControllerSourceTypeCamera];
            // トリミングなどを行うか否か
            [imagePickerController setAllowsEditing:YES];
            // Delegate
            [imagePickerController setDelegate:self];
            
            // アニメーションをしてカメラUIを起動
            [self presentViewController:imagePickerController animated:YES completion:nil];
        }
        else
        {
            NSLog(@"Camera invalid.");
        }
    
    }else{
        User *user = [User loadUser:item.tag];
        self.userName.text = user.name;
        self.userImage.image = [[UIImage alloc]initWithData:user.image];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//回転処理が存在するかどうかを返す
- (BOOL)shouldAutorotate
{
    return YES;
}

//回転する方向を指定
- (NSUInteger)supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskPortrait;
}

@end
