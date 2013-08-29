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

NSDate *date;
NSData *imageData;

NSString *title;
NSString *message;
NSString *imageName;
NSDate *date;
NSString *days;


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
    user = [User getCurrentUser];

    self.textFieldTitle.delegate = self;
    self.textFieldMessage.delegate = self;
    
    if (user.userId == CAMERA_TAB) {
        self.textFieldTitle.placeholder = TEXT_FIELD_TITLE;
        self.textFieldMessage.placeholder = TEXT_FIELD_MESSAGE;
    }else{
        NSMutableDictionary *dict = [user.itemList objectAtIndex:self.itemIndex];
        self.textFieldTitle = [NSString stringWithFormat:@"%@",[dict objectForKey:ITEM_TITLE]];
        self.textFieldMessage = [NSString stringWithFormat:@"%@",[dict objectForKey:ITEM_MESSAGE]];
        
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        imageData =[[defaults dictionaryForKey:TMP] objectForKey:TMP_IMAGE];
        UIImage *tmp = [[UIImage alloc]initWithData:imageData];
        self.imageEdit.image = tmp;
        date =[[defaults dictionaryForKey:TMP] objectForKey:TMP_DATE];
        NSDateFormatter *df = [[NSDateFormatter alloc]init];
        df.dateFormat = @"YYYY/MM/dd";
        self.takenDate.text = [df stringFromDate:date];
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
    
    return YES;
}


- (IBAction)regist:(id)sender {
    //アイテムの保存
    title = self.textFieldTitle.text;
    message = self.textFieldMessage.text;
    date = date;
    imageName = [[FileManager getInstance] convertDateToString:date];
    days = [self calcDaysAsString:user.birthday :date];
    NSMutableDictionary *item = [user itemFactory:title addMessage:message addDate:date addImageName:imageName addDays:days];
    [user insertItem:item];
    
    
    //画像をキャッシュに保存
    FileManager *fm = [FileManager getInstance];
    [fm saveImageData:imageData andDate:date];
    
    //アラートの表示
    UIAlertView *alert = [[UIAlertView alloc]init];
    alert.title = @"登録が完了しました";
    alert.message = nil;
    [alert addButtonWithTitle:@"OK"];
    [alert show];
    
    //画面遷移先指定
    if (user.userId == CAMERA_TAB){
        //return to home
        [self.navigationController popToRootViewControllerAnimated:YES];
    }else{
        [self.navigationController popViewControllerAnimated:YES];
        
    }
    
}
- (NSString *)calcDaysAsString :(NSDate *)date :(NSDate *)birthday{
    NSTimeInterval days = [date timeIntervalSinceDate:birthday] / 24 / 60 / 60;
    NSLog(@"%.0f日",days);
    return [NSString stringWithFormat:@"%.0f日",days];
}

@end
