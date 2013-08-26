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

- (void)tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item {
    if ( item.tag == CAMERA_TAB ){
        self.userTab.selectedItem = self.userTab.items[[User getCurrentUser].userId];
 //       [self openCam:item];

        
        
        // カメラ起動
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
        
//        [self performSegueWithIdentifier:@"camera" sender:item];
        
    }else{
        User *user = [User loadUser:item.tag];
        //    [self paintBackgroundColor: user.userId];
        self.userName.text = user.name;
    }
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
    
///////////////////////////////////////////////////////////////////////////////////////////
    personName = @"Taro";
    //[self readImageFile];
    
    
    
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


//- (IBAction)openCam:(id)sender {
//    UIImagePickerController *controller = [[UIImagePickerController alloc]init];
//    controller.delegate = self;
//    controller.sourceType = UIImagePickerControllerSourceTypeCamera;
//    controller.mediaTypes = @[(__bridge NSString *)kUTTypeImage];
//    
//    //UI表示
//    [self presentViewController:controller animated:YES completion:^{}];
//    
//}
//

////////////////////////////////////////////

//@interface CameraViewController ()
//
//@end


// 写真を撮影した後
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
	// オリジナル画像
	UIImage *originalImage = (UIImage *)[info objectForKey:UIImagePickerControllerOriginalImage];
	// 編集画像
	UIImage *editedImage = (UIImage *)[info objectForKey:UIImagePickerControllerEditedImage];
	UIImage *saveImage;
	
	if(editedImage)
	{
		saveImage = editedImage;
	}
	else
	{
		saveImage = originalImage;
	}
	
	// UIImageViewに画像を設定
	self.pictureImage.image = saveImage;
    //Cacheディレクトリの下に新規でディレクトリを作る
    //日付の取得
    NSDateFormatter *df = [[NSDateFormatter alloc] init];
    df.dateFormat = @"yyyy/MM/dd HH:mm:ss";
    NSDate *now = [NSDate date];
    dateString = [df stringFromDate:now];
    //NSUserDefaultにnowを
    
    //    static dispatch_once_t token;
    //    dispatch_once(&token, ^{
    //Cacheディレクトリのパスを取得する
    NSArray *array = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    NSString *cacheDirPath = [array objectAtIndex:0];
    //Cacheディレクトリの下に新規でディレクトリを作る
    //新規で作るディレクトリの絶対パスを作成
    createdPersonDirPath = [NSString stringWithFormat:@"%@",[cacheDirPath stringByAppendingPathComponent:personName]];
    NSLog(@"%@",createdPersonDirPath);
    //    [cacheDirPath stringByAppendingPathComponent:(@"%@,Directory",name);
    //FileManagerでディレクトリを作成
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSError *error = nil;
    BOOL created = [fileManager createDirectoryAtPath:createdPersonDirPath
                          withIntermediateDirectories:YES
                                           attributes:nil
                                                error:&error];
    // 作成に失敗した場合は、原因をログに出す。
    if (!created) {
        NSLog(@"failed to create directory. reason is %@ - %@", error, error.userInfo);
    }
    
    //    });

    [self saveImageFile:saveImage personName:personName];
	
    
//    //動画を入れないのでいらない/////////////////////////////////////////////////
//	if(picker.sourceType == UIImagePickerControllerSourceTypeCamera)
//	{
//		[self saveImageFile:saveImage personName:personName];
//	}
//	else
//	{
//        
//	}

    
    [self dismissViewControllerAnimated:YES completion:nil];
    
    //画面遷移
    [self performSegueWithIdentifier:@"toEditView" sender:nil];
    
    
}
//
//- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
//    NSLog(@"cansel");
//    [self performSegueWithIdentifier:@"toHome" sender:picker];
//    NSLog(@"return");
//    
//}


-(void) saveImageFile:(UIImage *)image personName:name {
    // convert UIImage to NSData
    // JPEGのデータとしてNSDataを作成します
    NSData *imageData = [[NSData alloc] initWithData:UIImageJPEGRepresentation(image, 0.8f)];
    //保存する先のパス
    NSString *saveFolderPath = createdPersonDirPath;
    NSString *savedPath = [NSString stringWithFormat:@"%@",[saveFolderPath stringByAppendingPathComponent:dateString]];
    // 保存処理を行う。
    // write NSData into the file
    [imageData writeToFile:savedPath atomically:YES];
}


//- (void)dealloc {
//	[_pictureImage release];
//	[super dealloc];
//}


@end
