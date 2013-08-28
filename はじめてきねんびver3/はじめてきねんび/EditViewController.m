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
    item = [Item getCurrentItem];

    self.textFieldTitle.delegate = self;
    self.textFieldMessage.delegate = self;
    
    if (!item) {
        self.textFieldTitle.placeholder = TEXT_FIELD_TITLE;
        self.textFieldMessage.placeholder = TEXT_FIELD_MESSAGE;
    }
    self.textFieldTitle = [NSString stringWithFormat:@"%@",item.title];
    self.textFieldMessage = [NSString stringWithFormat:@"%@",item.message];
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    UIImage *tmp = [[UIImage alloc]initWithData:[[defaults dictionaryForKey:TMP] objectForKey:TMP_IMAGE]];
    self.imageEdit.image = tmp;
    date =[[defaults dictionaryForKey:TMP] objectForKey:TMP_DATE];
    NSDateFormatter *df = [[NSDateFormatter alloc]init];
    df.dateFormat = @"YYYY/MM/dd";
    self.takenDate.text = [df stringFromDate:date];
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
    return YES;
}


- (IBAction)register:(id)sender {
    
    [user addItemToCurrent: date];
    UIAlertView *alert = [[UIAlertView alloc]init];
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
}
@end
