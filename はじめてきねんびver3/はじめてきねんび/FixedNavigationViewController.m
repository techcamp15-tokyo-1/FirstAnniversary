//
//  FixedNavigationViewController.m
//  はじめてきねんび
//
//  Created by Jin Sasaki on 2013/08/28.
//  Copyright (c) 2013年 Ueda Junya. All rights reserved.
//

#import "FixedNavigationViewController.h"

@interface FixedNavigationViewController ()

@end

@implementation FixedNavigationViewController

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
//回転処理が存在するかどうかを返す
- (BOOL)shouldAutorotate
{
    return YES;
}

//回転する方向を指定
- (NSUInteger)supportedInterfaceOrientations
{
    return [self.visibleViewController supportedInterfaceOrientations];
}




@end
