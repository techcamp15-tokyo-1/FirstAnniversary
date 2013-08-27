//
//  AllSlideViewController.h
//  はじめてきねんび
//
//  Created by Ueda Junya on 2013/08/27.
//  Copyright (c) 2013年 Ueda Junya. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AllSlideViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIBarButtonItem *nextButton;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *playButton;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *pauseButton;

- (IBAction)nextSlide:(id)sender;
- (IBAction)startShow:(id)sender;
- (IBAction)pauseShow:(id)sender;


@end
