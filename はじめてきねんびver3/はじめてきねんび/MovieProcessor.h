//
//  MovieProcessor.h
//  はじめてきねんび
//
//  Created by Ueda Junya on 2013/08/30.
//  Copyright (c) 2013年 Ueda Junya. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>
#import <CoreFoundation/CFDictionary.h>
#import <AssetsLibrary/AssetsLibrary.h>
#import <QuartzCore/QuartzCore.h>
#import <CoreVideo/CoreVideo.h>
#import <CoreMedia/CoreMedia.h>
#import <AVFoundation/AVMediaFormat.h>

@protocol MovieProcessorDelegate;

@interface MovieProcessor : NSObject

@property (weak, nonatomic) id<MovieProcessorDelegate> delegate;
@property NSMutableArray *imageArray;
@property NSMutableArray *arrayForimageArray;
@property NSString *personName;
@property NSString *createdPersonDirPath;
@property NSString *savedPath;
@property NSString *savedPathAfterAddingMusic;
@property NSString *dateString;
@property NSString *movieFileName;
@property NSString *afterMovieFileName;
@property NSString *audioFilePath;
@property BOOL done;
@property BOOL musicAddDone;

-(void) writeImagesToMovieAtPath:(NSString *) path withSize:(CGSize) size;
//- (CVPixelBufferRef )pixelBufferFromCGImage:(CGImageRef)localImage size:(CGSize)localSize;
- (CVPixelBufferRef) pixelBufferFromCGImage: (CGImageRef) image andSize:(CGSize) size;
-(void) addAudioToFileAtPath:(NSString *) filePath toPath:(NSString *)outFilePath;

-(void)rec;
@end

@protocol MovieProcessorDelegate <NSObject>
//- (void)drawCapture:(UIImage *)image;
@end
