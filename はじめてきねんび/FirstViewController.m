//
//  FirstViewController.m
//  はじめてきねんび
//
//  Created by Ueda Junya on 2013/08/21.
//  Copyright (c) 2013年 Ueda Junya. All rights reserved.
//

#import "FirstViewController.h"
#import <MobileCoreServices/MobileCoreServices.h>

@interface FirstViewController ()

@end

@implementation FirstViewController

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
