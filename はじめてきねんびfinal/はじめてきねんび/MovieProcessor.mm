//
//  MovieProcessor.m
//  はじめてきねんび
//
//  Created by Ueda Junya on 2013/08/30.
//  Copyright (c) 2013年 Ueda Junya. All rights reserved.
//

#import "MovieProcessor.h"
#import "User.h"
#import "FileManager.h"
#define kVideoWidth 320
#define kVideoHeight 320

//#define kRate 1
#define kMaxCount 150
#define kRecordingFPS 1

@interface MovieProcessor ()
{
    AVAssetWriter                        * videoWriter_;
    AVAssetWriterInput                   * writerInput_;
    AVAssetWriterInputPixelBufferAdaptor * adaptor_;
    UIImage        * imageBuffer_;
    NSMutableArray *imglist;
    NSURL          * url_;
    CGSize size_;
}
@end
@implementation MovieProcessor
@synthesize imageArray;
@synthesize personName;
@synthesize createdPersonDirPath;
@synthesize savedPath;
@synthesize savedPathAfterAddingMusic;
@synthesize dateString;
@synthesize movieFileName;
@synthesize audioFilePath;
@synthesize afterMovieFileName;
@synthesize done;
@synthesize musicAddDone;
//@synthesize videoAsset;
-(void)rec
{
    done=NO;
    musicAddDone=NO;
    NSLog(@"rec Start");
    _arrayForimageArray = [ NSMutableArray arrayWithCapacity: 1];
    imglist = [ NSMutableArray arrayWithCapacity: 1];
    
    
    UIImage *uiImage1=[UIImage imageNamed:@"19930106092355.jpg"];
    [_arrayForimageArray addObject:uiImage1];
    
    UIImage *uiImage2=[UIImage imageNamed:@"20130830092513.jpg"];
    [_arrayForimageArray addObject:uiImage2];
    
    UIImage *uiImage3=[UIImage imageNamed:@"20130830092629.jpg"];
    [_arrayForimageArray addObject:uiImage3];
    
    UIImage *uiImage4=[UIImage imageNamed:@"20130830092731.jpg"];
    [_arrayForimageArray addObject:uiImage4];
    
    UIImage *uiImage5=[UIImage imageNamed:@"20130830092800.jpg"];
    [_arrayForimageArray addObject:uiImage5];
    NSLog(@"%f_%f",uiImage1.size.width, uiImage1.size.height);
    
    // size_ = CGSizeMake(uiImage1.size.width, uiImage1.size.height);
    size_ = CGSizeMake( kVideoWidth, kVideoHeight);
    
    
    for (int i=0; i<5; i++) {
        /* UIImagePickerなどから画像を取得 */
        UIImage *aImage = [_arrayForimageArray objectAtIndex:i];
        
        // 取得した画像の縦サイズ、横サイズを取得する
        int imageW = aImage.size.width;
        int imageH = aImage.size.height;
        
        // リサイズする倍率を作成する。
        float scale = (imageW > imageH ? 320.0f/imageH : 320.0f/imageW);
        // float scale = (imageW > imageH ? uiImage1.size.height/imageH : uiImage1.size.height/imageW);
        
        
        
        // 比率に合わせてリサイズする。
        // ポイントはUIGraphicsXXとdrawInRectを用いて、リサイズ後のサイズで、
        // aImageを書き出し、書き出した画像を取得することで、
        // リサイズ後の画像を取得します。
        CGSize resizedSize = CGSizeMake(imageW * scale, imageH * scale);
        UIGraphicsBeginImageContext(resizedSize);
        [aImage drawInRect:CGRectMake(0, 0, resizedSize.width, resizedSize.height)];
        UIImage* resizedImage = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        [imglist addObject:resizedImage];
    }
    
    imageArray = [ NSMutableArray arrayWithCapacity: 1];
    for (int j=0; j<5; j++) {
        for(int i=0; i<10; i++){
            [imageArray  addObject:[imglist objectAtIndex:j]];
        }
    }
    NSLog(@"画像配列セット完了");
    
    
    
    //url_ = [NSURL fileURLWithPath:[NSString stringWithFormat:@"%@%@_%@%@", NSTemporaryDirectory(), @"output", [NSDate date], @".mov"]];
    //Cacheディレクトリのパスを取得する
    NSArray *array = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    NSString *cacheDirPath = [array objectAtIndex:0];
    //Cacheディレクトリの下に新規でディレクトリを作る
    //新規で作るディレクトリの絶対パスを作成
    createdPersonDirPath = [NSString stringWithFormat:@"%@",[cacheDirPath stringByAppendingPathComponent:@"Taro"]];
    NSLog(@"%@",createdPersonDirPath);
    //FileManagerでディレクトリを作成
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSError *error = nil;
    BOOL created = [fileManager createDirectoryAtPath:createdPersonDirPath
                          withIntermediateDirectories:YES
                                           attributes:nil
                                                error:&error];
    // 作成に失敗した場合は、原因をログに出す。
    if (!created) {
        NSLog(@"failed to create directory. reason is %@ - %@", error, error.userInfo);
    }
    //保存する先のパス
    //    NSDateFormatter *df = [[NSDateFormatter alloc] init];
    //    df.dateFormat = @"yyyyMMddHHmmss";
    //    dateString = [df stringFromDate:[NSDate date]];
    //movieFileName = [NSString stringWithFormat:@"%@",[dateString stringByAppendingPathComponent:@".MOV"]];
    movieFileName=@"made142.MOV";
    NSString *saveFolderPath = createdPersonDirPath;
    savedPath = [NSString stringWithFormat:@"%@",[saveFolderPath stringByAppendingPathComponent:movieFileName]];
    NSLog(@"%@",savedPath);
    afterMovieFileName=@"addMusic25.MOV";
    savedPathAfterAddingMusic =[NSString stringWithFormat:@"%@",[saveFolderPath stringByAppendingPathComponent:afterMovieFileName]];
    
    [self writeImagesToMovieAtPath:savedPath withSize:size_];
    
}



-(void)writeImagesToMovieAtPath:(NSString *)path withSize:(CGSize)size
{
    NSError *error = nil;
    videoWriter_ = [[AVAssetWriter alloc] initWithURL:[NSURL fileURLWithPath:path]
                                             fileType:AVFileTypeQuickTimeMovie
                                                error:&error];
    if(error) NSLog(@"error : %@", [error localizedDescription]);
    
    NSDictionary * videoSettings = @{AVVideoCodecKey: AVVideoCodecH264,
                                     AVVideoWidthKey: [NSNumber numberWithInt:size_.width],
                                     AVVideoHeightKey: [NSNumber numberWithInt:size_.height]};
    
    writerInput_ = [AVAssetWriterInput assetWriterInputWithMediaType:AVMediaTypeVideo outputSettings:videoSettings];
    [writerInput_ setExpectsMediaDataInRealTime:YES];
    
    NSDictionary * sourcePixelBufferAttributesDictionary = @{(id)kCVPixelBufferPixelFormatTypeKey: @(kCVPixelFormatType_32ARGB)};
    adaptor_ = [AVAssetWriterInputPixelBufferAdaptor assetWriterInputPixelBufferAdaptorWithAssetWriterInput:writerInput_
                                                                                sourcePixelBufferAttributes:sourcePixelBufferAttributesDictionary];
    [videoWriter_ addInput:writerInput_];
    [videoWriter_ startWriting];
    [videoWriter_ startSessionAtSourceTime:kCMTimeZero];
    
    dispatch_queue_t dispatchQueue = dispatch_queue_create("mediaInputQueue", NULL);
    int __block i = 0;
    //[self stopRunning];
    
    // write AVAssetWriterInputPixelBufferAdaptor
    [writerInput_ requestMediaDataWhenReadyOnQueue:dispatchQueue usingBlock:^{
        while ([writerInput_ isReadyForMoreMediaData])
        {
            NSLog(@"whileの最初");
            if(++i >= [imageArray count])
            {
                [writerInput_ markAsFinished];
                //[videoWriter_ finishWriting];
                [videoWriter_ finishWritingWithCompletionHandler:^{
                    dispatch_async(dispatch_get_main_queue(), ^{
                        //[self save];
                        NSLog(@"SAVE!!");
                    });
                }];
                NSLog(@"%@",savedPath);
                done=YES;
                NSLog(@"write end");
                return;
            }
            CVPixelBufferRef buffer = (CVPixelBufferRef)[self pixelBufferFromCGImage:[[imageArray objectAtIndex:i] CGImage] andSize:size_];
            NSLog(@"bufferを書き込んだ");
            BOOL append_ok = NO;
            if (buffer){
                CMTime frameTime = CMTimeMake(i,(int32_t) kRecordingFPS);
                append_ok = [adaptor_ appendPixelBuffer:buffer withPresentationTime:frameTime];
                if(append_ok) NSLog(@"Success : %d", i);
                else NSLog(@"Fail");//[self alert:@"Fail" message:nil btnName:@"OK"];
                CFRelease(buffer);
                buffer = nil;
            }else{
                NSLog(@"bufferなし");
            }
            
        }
    }];
    
}

- (CVPixelBufferRef) pixelBufferFromCGImage: (CGImageRef) image andSize:(CGSize) size
{
    NSDictionary *options = [NSDictionary dictionaryWithObjectsAndKeys:
                             [NSNumber numberWithBool:YES], kCVPixelBufferCGImageCompatibilityKey,
                             [NSNumber numberWithBool:YES], kCVPixelBufferCGBitmapContextCompatibilityKey,
                             nil];
    CVPixelBufferRef pxbuffer = NULL;
    
    CVReturn status = CVPixelBufferCreate(kCFAllocatorDefault, size.width,
                                          size.height, kCVPixelFormatType_32ARGB, (__bridge CFDictionaryRef) options,
                                          &pxbuffer);
    
    NSParameterAssert(status == kCVReturnSuccess && pxbuffer != NULL);
    
    CVPixelBufferLockBaseAddress(pxbuffer, 0);
    void *pxdata = CVPixelBufferGetBaseAddress(pxbuffer);
    NSParameterAssert(pxdata != NULL);
    
    CGColorSpaceRef rgbColorSpace = CGColorSpaceCreateDeviceRGB();
    CGContextRef context = CGBitmapContextCreate(pxdata, size.width,
                                                 size.height, 8, 4*size.width, rgbColorSpace,
                                                 kCGImageAlphaNoneSkipFirst);
    NSParameterAssert(context);
    CGContextConcatCTM(context, CGAffineTransformMakeRotation(0));
    CGContextDrawImage(context, CGRectMake(0, 0, CGImageGetWidth(image),
                                           CGImageGetHeight(image)), image);
    CGColorSpaceRelease(rgbColorSpace);
    CGContextRelease(context);
    
    CVPixelBufferUnlockBaseAddress(pxbuffer, 0);
    
    return pxbuffer;
}
//- (void)alert:(NSString *)title message:(NSString *)message btnName:(NSString *)btnName
//{
//    [[[UIAlertView alloc] initWithTitle:title message:message delegate:nil cancelButtonTitle:btnName otherButtonTitles:nil] show];
//}
- (void)save
{
	ALAssetsLibrary * library = [[ALAssetsLibrary alloc] init];
	[library writeVideoAtPathToSavedPhotosAlbum:url_
                                completionBlock:^(NSURL *assetURL, NSError *error){
                                    // [self alert:@"Save!" message:nil btnName:@"OK"];
                                }];
}

//動画のファイルパスと出力ファイルのパスから動画と音楽の合成を行なう
-(void) addAudioToFileAtPath:(NSString *) filePath toPath:(NSString *)outFilePath
{
    NSError * error = nil;
    
    // 動画URLからアセットを生成
    AVURLAsset * videoAsset = [AVURLAsset URLAssetWithURL:[NSURL fileURLWithPath:filePath] options:nil];
    NSLog(@"%@",filePath);
    if (videoAsset == nil) {
        NSLog(@"asset確認");
    }
    // コンポジション作成
    AVMutableComposition * composition = [AVMutableComposition composition];
    AVMutableCompositionTrack *compositionVideoTrack = [composition addMutableTrackWithMediaType:AVMediaTypeVideo
                                                                                preferredTrackID: kCMPersistentTrackID_Invalid];
    // アセットからトラックを取得
    AVAssetTrack * videoAssetTrack = [[videoAsset tracksWithMediaType:AVMediaTypeVideo] objectAtIndex:0];
    
    // コンポジションの設定
    [compositionVideoTrack insertTimeRange:CMTimeRangeMake(kCMTimeZero,videoAsset.duration) ofTrack:videoAssetTrack atTime:kCMTimeZero error:&error];
    
    /////////オーディオ//////////////
    CMTime audioStartTime = kCMTimeZero;
    
    // 音楽URLからアセットを生成
    NSString *soundFilePath =
    [[NSBundle mainBundle] pathForResource: @"miraihe"
                                    ofType: @"mp3"];
    //NSString * pathString = soundFilePath;
    AVURLAsset * urlAsset = [AVURLAsset URLAssetWithURL:[NSURL fileURLWithPath:soundFilePath] options:nil];
    // コンポジション作成
    AVMutableCompositionTrack *compositionAudioTrack = [composition addMutableTrackWithMediaType:AVMediaTypeAudio
                                                                                preferredTrackID: kCMPersistentTrackID_Invalid];
    // アセットからトラックを取得
    AVAssetTrack * audioAssetTrack = [[urlAsset tracksWithMediaType:AVMediaTypeAudio] objectAtIndex:0];
    
    // コンポジションの設定
    [compositionAudioTrack insertTimeRange:CMTimeRangeMake(kCMTimeZero,urlAsset.duration) ofTrack:audioAssetTrack atTime:kCMTimeZero error:&error];
    
    // 合成用コンポジション作成
    AVMutableVideoComposition *videoComposition = [AVMutableVideoComposition videoComposition];
    videoComposition.frameDuration = CMTimeMake(1,30);
    videoComposition.renderScale = 1.0;
    videoComposition.renderSize = CGSizeMake(320, 240);//renderSize;
    //
    
    
    // インストラクション作成
    AVMutableVideoCompositionInstruction *instruction =
    [AVMutableVideoCompositionInstruction videoCompositionInstruction];
    instruction.timeRange = CMTimeRangeMake(kCMTimeZero, [composition duration]); // 時間を設定
    AVMutableVideoCompositionLayerInstruction* layerInstruction =
    [AVMutableVideoCompositionLayerInstruction
     videoCompositionLayerInstructionWithAssetTrack:videoAssetTrack];
    instruction.layerInstructions = [NSArray arrayWithObject:layerInstruction];
    
    
    // インストラクションを合成用コンポジションに設定
    videoComposition.instructions = [NSArray arrayWithObject: instruction];
    
    
    //***** 3. AVAssetExportSessionを使用して1と2のコンポジションを合成。*****//
    // 1のコンポジションをベースにAVAssetExportを生成
    AVAssetExportSession* assetExport = [[AVAssetExportSession alloc] initWithAsset:composition presetName:AVAssetExportPresetMediumQuality];
    
    // 2の合成用コンポジションを設定
    assetExport.videoComposition = videoComposition;
    // エクスポートファイルの設定
    // NSString* videoName = @"kuman.mov";
    //NSString *exportPath = [NSTemporaryDirectory() stringByAppendingPathComponent:videoName];
    // NSURL *exportUrl = [NSURL fileURLWithPath:exportPath];
    assetExport.outputFileType =AVFileTypeQuickTimeMovie;// @"com.apple.quicktime-movie";
    assetExport.outputURL = [NSURL fileURLWithPath:outFilePath];
    // ファイルが存在している場合は削除
    if ([[NSFileManager defaultManager] fileExistsAtPath:outFilePath])
    {
        [[NSFileManager defaultManager] removeItemAtPath:outFilePath error:nil];
    }
    // エクスポード実行
    [assetExport exportAsynchronouslyWithCompletionHandler:
     ^(void ) {
         switch (assetExport.status)
         {
             case AVAssetExportSessionStatusCompleted:
                 //                export complete
                 NSLog(@"Export Complete");
                 musicAddDone=YES;
                 break;
             case AVAssetExportSessionStatusFailed:
                 NSLog(@"Export Failed");
                 NSLog(@"ExportSessionError: %@", [assetExport.error localizedDescription]);
                 //                export error (see exportSession.error)
                 break;
             case AVAssetExportSessionStatusCancelled:
                 NSLog(@"Export Failed");
                 NSLog(@"ExportSessionError: %@", [assetExport.error localizedDescription]);
                 //                export cancelled
                 break;
         }
     }];
    
    
}

@end
