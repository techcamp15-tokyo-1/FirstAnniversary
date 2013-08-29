//
//  EditViewController.m
//  はじめてきねんび
//
//  Created by Jin Sasaki on 2013/08/26.
//  Copyright (c) 2013年 Ueda Junya. All rights reserved.
//

#import "EditViewController.h"

@interface EditViewController ()

@end

@implementation EditViewController
bool fromCamera = false;
User *user;
Item *item;
NSDate *date;
NSData *imageData;

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

    //背景指定
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"corkboard.jpg"]];

    user = [User getCurrentUser];
    Item *item = [[Item alloc]init];
    
    //deligate
    self.textFieldTitle.delegate = self;
    self.textFieldMessage.delegate = self;
    
    UIImage *image;
    NSDateFormatter *df = [[NSDateFormatter alloc]init];
    df.dateFormat = @"YYYY/MM/dd";
    
    //placeholder
    self.textFieldTitle.placeholder = TEXT_FIELD_TITLE;
    self.textFieldMessage.placeholder = TEXT_FIELD_MESSAGE;
    
    //カメラからならユーザデフォルト
    if( !self.isCamera){
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        NSMutableDictionary *dict = [defaults objectForKey:TMP];
        image = [UIImage imageWithData:[dict objectForKey:TMP_IMAGE]];
        date = [dict objectForKey:TMP_DATE];
        NSLog(@"%d",user.userId);
        
    }else{
        //ディテールからならセグエから引き継ぎ
        item = _editItem;
        self.textFieldTitle.text = [NSString stringWithFormat:@"%@",item.title];
        self.textFieldMessage.text = [NSString stringWithFormat:@"%@",item.message];
        NSString *path = [[FileManager getInstance] createPathByImageName:item.imageName];
        image = [UIImage imageWithContentsOfFile:path];
        date = item.date;
    }
    self.takenDate.text = [df stringFromDate:date];
    self.imageEdit.image = image;
    imageData = UIImageJPEGRepresentation(image, 0.8f);
    
    
    
}

- (IBAction)regist:(id)sender {
    
    //入力判断
    BOOL validationOfTitle = NO;
    BOOL validationOfMessage = NO;
    //itemの保存
    
    //カメラから
//    if (!self.isCamera) {
//        <#statements#>
//    }
//    
    //ディテールから
    Item *item =[[Item alloc]init];
    if([self.textFieldTitle.text isEqualToString: @""]);
    else{
        item.title = self.textFieldTitle.text;
        validationOfTitle = YES;
    }
    if([self.textFieldMessage.text isEqualToString: @""]);
    else{
        item.message = self.textFieldMessage.text;
        validationOfMessage = YES;
    }
    UIAlertView *alert = [[UIAlertView alloc]init];
    if (validationOfTitle) {
        if (validationOfMessage) {
            item.date = date;
            item.imageName = [[FileManager getInstance] convertDateToString:date];
            [user insertItem:item];
            //画像の保存
            FileManager *fm = [FileManager getInstance];
            [fm saveImageData:imageData andDate:date];
            
            alert.title = @"登録が完了しました";
            alert.message = nil;
            [alert addButtonWithTitle:@"OK"];
            [alert show];
            
            if (user.userId == CAMERA_TAB){
                //return to home
                [self.navigationController popToRootViewControllerAnimated:YES];
            }else{
                [self.navigationController popViewControllerAnimated:YES];
                
            }
        }else{
            alert.title = @"メッセージが入力されていません。";
            alert.message = nil;
            [alert addButtonWithTitle:@"OK"];
            [alert show];
            return;
        }
        
    }else{
        alert.title = @"タイトルが入力されていません。";
        alert.message = nil;
        [alert addButtonWithTitle:@"OK"];
        [alert show];
        return;
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(BOOL)textFieldShouldReturn:(UITextField*)textField{
    [self.textFieldTitle resignFirstResponder];
    [self.textFieldMessage resignFirstResponder];
    
    //    switch (textField.tag) {
    //        case 1:
    //            [self.textFieldTitle resignFirstResponder];
    //            break;
    //        case 2:
    //            break;
    //}
    [self.view endEditing:YES];
    
    return YES;
}


@end
