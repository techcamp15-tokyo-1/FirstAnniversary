//
//  CameraViewController.m
//  はじめてきねんび
//
//  Created by Ueda Junya on 2013/08/21.
//  Copyright (c) 2013年 Ueda Junya. All rights reserved.
//

#import "CameraViewController.h"
#import <MobileCoreServices/MobileCoreServices.h>

@interface CameraViewController ()

@end

@implementation CameraViewController
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
    personName = @"Taro";
    //[self readImageFile];
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

    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



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
    dateString = [df stringFromDate:[NSDate date]];
    
    //    static dispatch_once_t token;
    //    dispatch_once(&token, ^{
    //Cacheディレクトリのパスを取得する
    NSArray *array = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    NSString *cacheDirPath = [array objectAtIndex:0];
    //Cacheディレクトリの下に新規でディレクトリを作る
    //新規で作るディレクトリの絶対パスを作成
    createdPersonDirPath = [NSString stringWithFormat:@"%@",[cacheDirPath stringByAppendingPathComponent:@"Taro"]];
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

    
    
	if(picker.sourceType == UIImagePickerControllerSourceTypeCamera)
	{
		[self saveImageFile:saveImage personName:personName];
		[self dismissViewControllerAnimated:YES completion:nil];
	}
	else
	{
        [self dismissViewControllerAnimated:YES completion:nil];
	}
}

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
