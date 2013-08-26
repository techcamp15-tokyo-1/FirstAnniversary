//
//  MakeViewController.m
//  はじめてきねんび
//
//  Created by Ueda Junya on 2013/08/25.
//  Copyright (c) 2013年 Ueda Junya. All rights reserved.
//

#import "MakeViewController.h"

@interface MakeViewController ()

@end

@implementation MakeViewController
@synthesize assetExport = _assetExport;
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
    // 合成処理実行。動画ファイルのURLを渡す。
    NSURL *outputFileURL = [[NSBundle mainBundle] URLForResource:@"IMG_0256" withExtension:@"MOV"];
    [self compositeMovieFromUrl:outputFileURL];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
// 動画の合成処理。コピーライトと会社のロゴを合成する。
- (void)compositeMovieFromUrl:(NSURL *)outputFileURL {
    
    //***** 1. ベースとなる動画のコンポジションを作成。*****//
    
    // 動画URLからアセットを生成
    AVURLAsset *videoAsset = [[AVURLAsset alloc] initWithURL:outputFileURL options:nil];
    
    // コンポジション作成
    AVMutableComposition* mixComposition = [AVMutableComposition composition];
    AVMutableCompositionTrack *compositionVideoTrack =
    [mixComposition addMutableTrackWithMediaType:AVMediaTypeVideo
                                preferredTrackID:kCMPersistentTrackID_Invalid];
    
    // アセットからトラックを取得
    AVAssetTrack *videoTrack = [[videoAsset tracksWithMediaType:AVMediaTypeVideo] objectAtIndex:0];
    
    // コンポジションの設定
    [compositionVideoTrack insertTimeRange:CMTimeRangeMake(kCMTimeZero, videoAsset.duration) ofTrack:videoTrack atTime:kCMTimeZero error:nil];
    [compositionVideoTrack setPreferredTransform:[[[videoAsset tracksWithMediaType:AVMediaTypeVideo] objectAtIndex:0] preferredTransform]];
    
    //***** 2. 合成したいテキストやイラストをCALayerで作成して、合成用コンポジションを生成。*****//
    
    // ロゴのCALayer作成
    UIImage *logoImage = [UIImage imageNamed:@"TabBar01.png"];
    CALayer *logoLayer = [CALayer layer];
    logoLayer.contents = (id) logoImage.CGImage;
    logoLayer.frame = CGRectMake(5, 25, 57, 57);
    logoLayer.opacity = 0.9;
    
    // 動画のサイズを取得
    CGSize videoSize = videoTrack.naturalSize;
    
    // コピーライトのCALayerを作成
    CATextLayer *copyrightLayer = [CATextLayer layer];
    copyrightLayer.string = @"First";
    [copyrightLayer setFont:@"Helvetica"];
    copyrightLayer.fontSize = videoSize.height / 3;
    copyrightLayer.shadowOpacity = 0.5;
    copyrightLayer.alignmentMode = kCAAlignmentCenter;
    copyrightLayer.bounds = CGRectMake(0, 100, videoSize.width, videoSize.height / 3);
    
    // 親レイヤーを作成
    CALayer *parentLayer = [CALayer layer];
    CALayer *videoLayer = [CALayer layer];
    parentLayer.frame = CGRectMake(0, 0, videoSize.width, videoSize.height);
    videoLayer.frame  = CGRectMake(0, 0, videoSize.width, videoSize.height);
    [parentLayer addSublayer:videoLayer];
    [parentLayer addSublayer:logoLayer];
    [parentLayer addSublayer:copyrightLayer];
    
    // 合成用コンポジション作成
    AVMutableVideoComposition* videoComp = [AVMutableVideoComposition videoComposition];
    videoComp.renderSize = videoSize;
    videoComp.frameDuration = CMTimeMake(1, 30);
    videoComp.animationTool =
    [AVVideoCompositionCoreAnimationTool
     videoCompositionCoreAnimationToolWithPostProcessingAsVideoLayer:videoLayer
     inLayer:parentLayer];
    
    // インストラクション作成
    AVMutableVideoCompositionInstruction *instruction =
    [AVMutableVideoCompositionInstruction videoCompositionInstruction];
    instruction.timeRange = CMTimeRangeMake(kCMTimeZero, [mixComposition duration]); // 時間を設定
    AVMutableVideoCompositionLayerInstruction* layerInstruction =
    [AVMutableVideoCompositionLayerInstruction
     videoCompositionLayerInstructionWithAssetTrack:videoTrack];
    instruction.layerInstructions = [NSArray arrayWithObject:layerInstruction];
    
    // インストラクションを合成用コンポジションに設定
    videoComp.instructions = [NSArray arrayWithObject: instruction];
    
    //***** 3. AVAssetExportSessionを使用して1と2のコンポジションを合成。*****//
    
    // 1のコンポジションをベースにAVAssetExportを生成
    _assetExport = [[AVAssetExportSession alloc] initWithAsset:mixComposition
                                                    presetName:AVAssetExportPresetMediumQuality];
    // 2の合成用コンポジションを設定
    _assetExport.videoComposition = videoComp;
    
    // エクスポートファイルの設定
    NSString* videoName = @"kuman.mov";
    NSString *exportPath = [NSTemporaryDirectory() stringByAppendingPathComponent:videoName];
    NSURL *exportUrl = [NSURL fileURLWithPath:exportPath];
    _assetExport.outputFileType = AVFileTypeQuickTimeMovie;
    _assetExport.outputURL = exportUrl;
    _assetExport.shouldOptimizeForNetworkUse = YES;
    
    // ファイルが存在している場合は削除
    if ([[NSFileManager defaultManager] fileExistsAtPath:exportPath])
    {
        [[NSFileManager defaultManager] removeItemAtPath:exportPath error:nil];
    }
    
    // エクスポード実行
    [_assetExport exportAsynchronouslyWithCompletionHandler:
     ^(void ) {
         // 端末に保存
         ALAssetsLibrary *library = [[ALAssetsLibrary alloc] init];
         if ([library videoAtPathIsCompatibleWithSavedPhotosAlbum:exportUrl])
         {
             [library writeVideoAtPathToSavedPhotosAlbum:exportUrl
                                         completionBlock:^(NSURL *assetURL, NSError *assetError)
              {
                  if (assetError) { }
              }];
         }
     }
     ];
}

@end
