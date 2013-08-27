//
//  fileManager.m
//  はじめてきねんび
//
//  Created by Jin Sasaki on 2013/08/27.
//  Copyright (c) 2013年 Ueda Junya. All rights reserved.
//

#import "FileManager.h"
#import "User.h"

@implementation FileManager

+(FileManager *)getInstance{
    static FileManager *instance;
    if (!instance) instance = [[FileManager alloc] init];
    return instance;
}

-(void )saveImage:(NSDate *)image:(NSDate *)date{
    //////////////////////////////////////////////
    
    User *user = [User getCurrentUser];
	
    //Cacheディレクトリの下に新規でディレクトリを作る
    //日付の取得
    NSDateFormatter *df = [[NSDateFormatter alloc] init];
    df.dateFormat = @"yyyyMMddHHmmss";
    NSDate *now = [NSDate date];
    NSString *dateString = [df stringFromDate:now];
    //NSUserDefaultにnowを

    //Cacheディレクトリのパスを取得する
    NSArray *array = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    NSString *cacheDirPath = [array objectAtIndex:0];
    
    //Cacheディレクトリの下に新規でディレクトリを作る
    //新規で作るディレクトリの絶対パスを作成
    NSString *userNameDirPath = [NSString stringWithFormat:@"%@",[cacheDirPath stringByAppendingPathComponent:user.name]];
    NSLog(@"%@",userNameDirPath);
    
    //FileManagerでディレクトリを作成
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSError *error = nil;
    BOOL created = [fileManager createDirectoryAtPath:userNameDirPath
                          withIntermediateDirectories:YES
                                           attributes:nil
                                                error:&error];
    // 作成に失敗した場合は、原因をログに出す。
    if (!created) {
        NSLog(@"failed to create directory. reason is %@ - %@", error, error.userInfo);
    }
    
//    [self saveImageFile:saveImage personName:personName];
//	   
//	
//    // convert UIImage to NSData
//    // JPEGのデータとしてNSDataを作成します
//    NSData *imageData = [[NSData alloc] initWithData:UIImageJPEGRepresentation(image, 0.8f)];
//    //保存する先のパス
//    NSString *saveFolderPath = userNameDirPath;
//    NSString *savedPath = [NSString strsingWithFormat:@"%@",[saveFolderPath stringByAppendingPathComponent:dateString]];
//    // 保存処理を行う。
//    // write NSData into the file
//    [imageData writeToFile:savedPath atomically:YES];
//    
//    //    });
//    
//    //////////////////////////////////////////////////////////////////
//    
//}
//-(void) saveImageFile:(UIImage *)image personName:name {
//    // convert UIImage to NSData
//    // JPEGのデータとしてNSDataを作成します
//    NSData *imageData = [[NSData alloc] initWithData:UIImageJPEGRepresentation(image, 0.8f)];
//    //保存する先のパス
//    NSString *saveFolderPath = userNameDirPath;
//    NSString *savedPath = [NSString strsingWithFormat:@"%@",[saveFolderPath stringByAppendingPathComponent:dateString]];
//    // 保存処理を行う。
//    // write NSData into the file
//    [imageData writeToFile:savedPath atomically:YES];
}
@end
