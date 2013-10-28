//
//  MakingMovieViewController.m
//  はじめてきねんび
//
//  Created by Ueda Junya on 2013/08/30.
//  Copyright (c) 2013年 Ueda Junya. All rights reserved.
//

#import "MakingMovieViewController.h"
#import <UIKit/UIKit.h>
#import <MediaPlayer/MediaPlayer.h>
#import "MovieProcessor.h"
#import <MessageUI/MessageUI.h>
#import <MessageUI/MFMailComposeViewController.h>

@interface MakingMovieViewController ()
{
    MovieProcessor *movieProcessor_;
}
@end

@implementation MakingMovieViewController
@synthesize moviePlayer;

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
- (IBAction)createVideo:(id)sender {
    movieProcessor_ = [[MovieProcessor alloc] init];
    [(MovieProcessor *)movieProcessor_ setDelegate:self];
    NSLog(@"Start");
    [movieProcessor_ rec];
    //    self.musicAddButton.enabled = NO;
    //    self.playButton.enabled = NO;
    
    
}

- (IBAction)playMovie:(id)sender {
    //動画を表示する
    moviePlayer = [[MPMoviePlayerController alloc] initWithContentURL:[NSURL fileURLWithPath:movieProcessor_.savedPathAfterAddingMusic]];
    self.moviePlayer.controlStyle = MPMovieControlStyleDefault;
    //moviePlayer.scalingMode = MPMovieScalingModeAspectFit;
    //self.moviePlayer.view.autoresizingMask    = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    moviePlayer.view.frame = self.view.frame;
    moviePlayer.view.bounds = self.view.bounds;
    ///動画読み込み後に呼ばれるNotification設定
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(moviePreloadDidFinish:)
                                                 name:MPMoviePlayerContentPreloadDidFinishNotification object:moviePlayer];
    
    //動画の再生終了後に呼ばれるＮｏｔｉｆｉｃａｔｉｏｎ設定
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(moviePlayerPlaybackDisFinish1:) name:MPMoviePlayerPlaybackDidFinishNotification
                                               object:moviePlayer];
    //ここがミソ　MPMoviePlayerControllerのframeを変更することで
    //表示位置、サイズを設定することが出来ます。
    //[moviePlayer.view setFrame:CGRectMake(0.0f, 75.0f, 640, 640)];
    
    
    [self.view addSubview:moviePlayer.view];
    [moviePlayer play];
    
}
-(void)moviePreloadDidFinish:(id)_nortification {
    //Notificationに入ったら　そのNotificationを削除しましょう～
    [[NSNotificationCenter defaultCenter] removeObserver:self name:MPMoviePlayerContentPreloadDidFinishNotification object:nil];
    // 適当にいかに必要な処理
}
- (void)moviePlayBackDidFinish:(NSNotification*)notification
{
    
    //Notificationに入ったら　そのNotificationを削除しましょう～
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:MPMoviePlayerPlaybackDidFinishNotification
                                                  object:nil];
    
    // 適当にいかに必要な処理
}

- (IBAction)musicAdd:(id)sender {
    
    [movieProcessor_ addAudioToFileAtPath:movieProcessor_.savedPath toPath:movieProcessor_.savedPathAfterAddingMusic];
    
    
}

- (IBAction)mailSend:(id)sender {
    MFMailComposeViewController *mailPicker = [[MFMailComposeViewController alloc] init];
    mailPicker.mailComposeDelegate = self;
    
    // メール本文を設定
    [mailPicker setMessageBody:@"本文" isHTML:NO];
    
    // 題名を設定
    [mailPicker setSubject:@"題名"];
    
    // 宛先を設定
    [mailPicker setToRecipients:[NSArray arrayWithObjects:@"aaa@bbb", @"ccc@ddd", nil]];
    
    // 添付ファイル名を設定
    //    NSString *imagePath = [NSString stringWithFormat:@"%@/test.gif" , [NSHomeDirectory() stringByAppendingPathComponent:@"Documents"]];
    NSData* fileData = [NSData dataWithContentsOfFile:movieProcessor_.savedPathAfterAddingMusic];
    
    [mailPicker addAttachmentData:fileData mimeType:@"movie/mov" fileName:movieProcessor_.savedPathAfterAddingMusic];
    
    // メール送信用のモーダルビューを表示
    [self presentViewController:mailPicker animated:TRUE completion:nil];  // iOS6以降
    
    //[mailPicker release];
    
    
}
// メール送信処理完了時のイベント
- (void)mailComposeController:(MFMailComposeViewController*)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError*)error {
    switch (result){
        case MFMailComposeResultCancelled:  // キャンセル
            break;
        case MFMailComposeResultSaved:      // 保存
            break;
        case MFMailComposeResultSent:       // 送信成功
        {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil
                                                            message:@"送信に成功しました"
                                                           delegate:nil
                                                  cancelButtonTitle:nil
                                                  otherButtonTitles:@"OK", nil];
            [alert show];
            //   [alert release];
            break;
        }
        case MFMailComposeResultFailed:     // 送信に失敗した場合
        {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil
                                                            message:@"送信に失敗しました"
                                                           delegate:nil
                                                  cancelButtonTitle:nil
                                                  otherButtonTitles:@"OK", nil];
            [alert show];
            //[alert release];
            break;
        }
        default:
            break;
    }
    //[self dismissModalViewControllerAnimated:YES];
    [self dismissViewControllerAnimated:YES completion:nil];  // iOS6以降
}

@end
