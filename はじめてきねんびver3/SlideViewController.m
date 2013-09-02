//
//  SlideViewController.m
//  はじめてきねんび
//
//  Created by Jin Sasaki on 2013/08/27.
//  Copyright (c) 2013年 Ueda Junya. All rights reserved.
//

#import "SlideViewController.h"
#import <AudioToolbox/AudioToolbox.h>
#import <QuartzCore/QuartzCore.h>

@interface SlideViewController ()
{
    AVAudioPlayer *player;
}
@property (nonatomic, retain) AVAudioPlayer *player;
@end

@implementation SlideViewController
{

    NSMutableArray *_images;
    int _slideNumber;
    NSTimer *_timer;
}
@synthesize player;



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
	// スライドのイメージを_images配列に格納する
    _images = [[NSMutableArray alloc]initWithCapacity:6];
    for (int i = 0 ; i < 6; i++) {
        NSString *str = [NSString stringWithFormat:@"photo-%d.png", i];
        UIImage *img = [UIImage imageNamed:str];
        NSString *message = @"初めてのお風呂";
        [self makeImageCompsitionWithImage:img andText:message];
        [_images addObject:img];
    }
    
    // 最初のイメージを表示
    self.imageView.image = _images[0];
    self.messageView.text = @"初めて記念日";
    //音楽再生準備//////////////////////////////////////
    NSString *soundFilePath =
    [[NSBundle mainBundle] pathForResource: @"miraihe"
                                    ofType: @"mp3"];
    
    NSURL *fileURL =
    [NSURL fileURLWithPath:soundFilePath];
    
    AVAudioPlayer *newPlayer =
    [[AVAudioPlayer alloc] initWithContentsOfURL: fileURL
                                           error: nil];
    self.player = newPlayer;
    
    [player prepareToPlay];
    ////////////////////////////////////////////////////
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)nextSlide:(id)sender {
    // スライド番号を更新
    _slideNumber++;
    if (_slideNumber >= [_images count]){
        _slideNumber = 0;
    }
    
    // 次のイメージを生成
    UIImage *image = _images[_slideNumber];
    UIImageView *nextView = [[UIImageView alloc] initWithImage:image];
//    NSString *message = @"初めてのプール";
//    UIImageView *nextView = [self makeImageCompsitionWithImage:image andText:message];
    
    // トランジションアニメーションを実行
    [UIView transitionFromView:self.imageView
                        toView:nextView
                      duration:1
                       options:UIViewAnimationOptionTransitionFlipFromLeft
                    completion:NULL];
    
    // imageViewを更新
    self.imageView = nextView;
    self.messageView.text = @"初めて記念日";
}

- (IBAction)startShow:(id)sender {
    if (![_timer isValid]){
        _timer = [NSTimer scheduledTimerWithTimeInterval:3.0
                                                  target:self
                                                selector:@selector(nextSlide:)
                                                userInfo:nil
                                                 repeats:YES];
    }
    [player play];
    self.playButton.enabled = NO;
    self.pauseButton.enabled = YES;
    self.nextButton.enabled = NO;
    
}

- (IBAction)pauseShow:(id)sender {
    if ([_timer isValid]){
        [_timer invalidate];
    }
    _timer = nil;
    [player pause];
    self.playButton.enabled = YES;
    self.pauseButton.enabled = NO;
    self.nextButton.enabled = YES;
}
-(void)viewWillDisappear:(BOOL)animated
{
    [player stop];
    [super viewWillDisappear:animated];
    
}
///////画像とテキストを引数で受け取って合成してUIImageを返す。//////
-(UIImage *)makeImageCompsitionWithImage:(UIImage*)image andText:(NSString *)message
{
    //テキストレイヤー
    CATextLayer *messageLayer = [CATextLayer layer];
    messageLayer.string = message;
    [messageLayer setFont:@"Helvetica"];
    messageLayer.fontSize = image.size.height / 20;
    messageLayer.shadowOpacity = 0.5;
    messageLayer.alignmentMode = kCAAlignmentCenter;
    messageLayer.bounds = CGRectMake(0, 0, image.size.width, image.size.height/6);
    //    //画像レイヤー
    //    //UIImage *Image = image;
    //    CALayer *imageLayer = [CALayer layer];
    //    imageLayer.contents = (id) image.CGImage;
    //    imageLayer.frame = CGRectMake(5, 25, 57, 57);
    //    imageLayer.opacity = 0.9;
    //    [imageLayer addSublayer:messageLayer];
    
    // 親レイヤーを作成
    CALayer *parentLayer = [CALayer layer];
    parentLayer.frame = CGRectMake(0, 0, image.size.width, image.size.height);
    //[parentLayer addSublayer:imageLayer];
    [parentLayer addSublayer:messageLayer];
    
    [self.view.layer addSublayer:parentLayer];
    
    // UIView を変換して UIView（resultImage）を取得
    UIGraphicsBeginImageContext(self.view.frame.size);
    [self.view.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *resultImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return resultImage;
    
    
}


@end
