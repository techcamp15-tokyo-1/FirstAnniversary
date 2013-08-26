//
//  EditViewController.m
//  はじめてきねんび
//
//  Created by Jin Sasaki on 2013/08/26.
//  Copyright (c) 2013年 Ueda Junya. All rights reserved.
//

#import "EditViewController.h"
#import "User.h"

@interface EditViewController ()

@end

@implementation EditViewController

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
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
