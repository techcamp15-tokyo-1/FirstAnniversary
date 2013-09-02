//
//  DetailViewController.m
//  はじめてきねんび
//
//  Created by Ueda Junya on 2013/08/16.
//  Copyright (c) 2013年 Ueda Junya. All rights reserved.
//

#import "DetailViewController.h"

@interface DetailViewController ()
- (void)configureView;
@end

@implementation DetailViewController
#pragma mark - Managing the detail item

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"corkboard.jpg"]];
	// Do any additional setup after loading the view, typically from a nib.
    [self configureView];
}

- (void)setDetailItem:(id)newDetailItem
{
    if (_detailItem != newDetailItem) {
        _detailItem = newDetailItem;
        
        // Update the view.
//        [self configureView];
    }
}

- (void)configureView
{
    // Update the user interface for the detail item.

    if (self.detailItem) {
        Item *item = (Item *)_detailItem;
        NSString *path = [[FileManager getInstance] createPathByImageName:item.imageName];
        UIImage *image = [UIImage imageWithContentsOfFile:path];
        self.detailImageView.image = image;
        self.navigationItem.title = item.title;
    }
}

//編集表示にセグエ
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    EditViewController *nextVC = [segue destinationViewController];
    nextVC.editItem = self.detailItem;
    nextVC.isCamera = NO;

}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
