//
//  SlideViewController.m
//  はじめてきねんび
//
//  Created by Jin Sasaki on 2013/08/27.
//  Copyright (c) 2013年 Ueda Junya. All rights reserved.
//

#import "SlideViewController.h"

@interface SlideViewController ()

@end

@implementation SlideViewController
{

    NSMutableArray *_images;
    int _slideNumber;
    NSTimer *_timer;
}



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
        [_images addObject:img];
    }
    
    // 最初のイメージを表示
    self.imageView.image = _images[0];
    
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
    
    // トランジションアニメーションを実行
    [UIView transitionFromView:self.imageView
                        toView:nextView
                      duration:1
                       options:UIViewAnimationOptionTransitionFlipFromLeft
                    completion:NULL];
    
    // imageViewを更新
    self.imageView = nextView;
    
}

- (IBAction)startShow:(id)sender {
    if (![_timer isValid]){
        _timer = [NSTimer scheduledTimerWithTimeInterval:3.0
                                                  target:self
                                                selector:@selector(nextSlide:)
                                                userInfo:nil
                                                 repeats:YES];
    }
    
    self.playButton.enabled = NO;
    self.pauseButton.enabled = YES;
    self.nextButton.enabled = NO;
    
}

- (IBAction)pauseShow:(id)sender {
    if ([_timer isValid]){
        [_timer invalidate];
    }
    _timer = nil;
    self.playButton.enabled = YES;
    self.pauseButton.enabled = NO;
    self.nextButton.enabled = YES;
}


@end
