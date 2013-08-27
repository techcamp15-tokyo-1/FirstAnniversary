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


-(id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
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
    df.dateFormat = @"yyyy/MM/dd";
    
    
    [defaults setObject:self.userBirthday forKey:@"birthday"];
    
    //ラベルに指定したフォーマットで表示
   // NSLog([df stringFromDate:userBirthday.date]);
    
    
    
    
}

//ユーザ情報を保存
- (IBAction)saveInformation:(id)sender {
    int validation = [self isUserInformationValidate];
    if (validation == SUCCESS) {
        user.name = self.textfield.text;
        user.birthday = self.userBirthday.date;
    } else {
        [self errorMessage:validation];
        
    }
}

- (IBAction)openCamera:(id)sender {
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

//ユーザ情報が有効かを判定するバリデーション
- (int)isUserInformationValidate{
    
    if ([self.textfield.text isEqualToString:@""]) return ERR_NONAME;
    if ([self.userBirthday.date timeIntervalSince1970] > [[NSDate date] timeIntervalSince1970]) return ERR_BIRTHDAY_IS_INVALID;
    
    return SUCCESS;
}
- (void)errorMessage:(int )errorType{
    UIAlertView *alert = [[UIAlertView alloc] init];
    alert.title = @"入力情報を確認してください";
    [alert addButtonWithTitle:@"OK"];
    switch (errorType) {
        case ERR_NONAME:
            alert.message = @"名前が未入力です";
            break;
        case ERR_BIRTHDAY_IS_INVALID:
            alert.message = @"誕生日が正しくありません";
            break;
    }
    [alert show];
    
}

//セグエの設定
- (BOOL)shouldPerformSegueWithIdentifier:(NSString *)identifier sender:(id)sender {
    if  ([self isUserInformationValidate] == SUCCESS){
        return YES;
    } else {
        return NO;
    }
}

//撮影後
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    // オリジナル画像
	UIImage *originalImage = (UIImage *)[info objectForKey:UIImagePickerControllerOriginalImage];
	// 編集画像
	UIImage *editedImage = (UIImage *)[info objectForKey:UIImagePickerControllerEditedImage];
    UIImage *saveImage;
    NSData *imageData ;
	if(editedImage) saveImage = editedImage ;
	else            saveImage = originalImage;
    imageData = [[NSData alloc] initWithData:UIImageJPEGRepresentation(saveImage, 0.8f)];
    user.image = imageData;
    
	[self dismissViewControllerAnimated:YES completion:nil];
//    self.userImage.contentMode = UIViewContentModeScaleAspectFit;
    self.userImage.image  = [[UIImage alloc] initWithData:user.image] ;
//    self.userImage.clipsToBounds = YES;
//    [self.userImage sizeToFit];
    
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
    if ([user.name isEqualToString:USER_NO_NAME]) {
        self.textfield.placeholder = @"名前を入力してください";
    } else {
        self.textfield.text = user.name;
        NSLog(@"elseの方通ってますわ");
    }
    
    if (user.image) {
        self.userImage.image = [[UIImage alloc] initWithData:user.image];
//        self.image.contentMode = UIViewContentModeScaleAspectFit;
//        [self.image sizeToFit];
        
    }else{
        self.userImage.image = [UIImage imageNamed:@"noimage.png"];
    }

    //誕生日を表示
    self.userBirthday.date = user.birthday ? user.birthday : [NSDate date];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}



@end
