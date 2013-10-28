//
//  MakingMovieViewController.h
//  はじめてきねんび
//
//  Created by Ueda Junya on 2013/08/30.
//  Copyright (c) 2013年 Ueda Junya. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MediaPlayer/MediaPlayer.h>
#import "MovieProcessor.h"
#import <MessageUI/MessageUI.h>
#import <MessageUI/MFMailComposeViewController.h>

@interface MakingMovieViewController : UIViewController <MovieProcessorDelegate, UIActionSheetDelegate, MFMailComposeViewControllerDelegate>

@property (weak, nonatomic) IBOutlet UIButton *musicAddButton;
@property MPMoviePlayerController *moviePlayer;
@property (weak, nonatomic) IBOutlet UIButton *playButton;
- (IBAction)createVideo:(id)sender;

- (IBAction)playMovie:(id)sender;

- (IBAction)musicAdd:(id)sender;
- (IBAction)mailSend:(id)sender;

@end







