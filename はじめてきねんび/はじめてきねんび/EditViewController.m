//
//  EditViewController.m
//  はじめてきねんび
//
//  Created by Jin Sasaki on 2013/08/26.
//  Copyright (c) 2013年 Ueda Junya. All rights reserved.
//

#import "EditViewController.h"
#import "User.h"
#import "Item.h"

@interface EditViewController ()

@end

@implementation EditViewController
bool fromCamera = false;

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
    Item *item = [Item getCurrentItem];

    self.textFieldTitle.delegate = self;
    self.textFieldMessage.delegate = self;
    if (!item) {
        self.textFieldTitle.placeholder = @"タイトル";
        self.textFieldMessage.placeholder = @"メッセージ";
    }
    self.textFieldTitle = [NSString stringWithFormat:@"%@",item.title];
    self.textFieldMessage = [NSString stringWithFormat:@"%@",item.message];

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




- (IBAction)register:(id)sender {
    
    Item *item =[Item getCurrentItem];
    [item saveItem:self.textFieldTitle.text:self.textFieldMessage.text:nil];
    //　保存する
    
    
    if (fromCamera){
        //return to home
    }else{
        UIAlertView *alert = [[UIAlertView alloc]init];
        alert.title = @"登録が完了しました";
        alert.message = nil;
        [alert addButtonWithTitle:@"OK"];
        [alert show];
    }
}
@end
