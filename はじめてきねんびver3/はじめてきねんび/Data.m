//
//  imageData.m
//  はじめてきねんび
//
//  Created by Jin Sasaki on 2013/08/26.
//  Copyright (c) 2013年 Ueda Junya. All rights reserved.
//

#import "Data.h"
#import "User.h"
#import "Item.h"

@implementation Data

+(void)saveImageData:(UIImage *)image :(NSDate *)date {
    User *user = [User getCurrentUser];
    //Cacheディレクトリの下に新規でディレクトリを作る
    //日付の取得
    NSDateFormatter *df = [[NSDateFormatter alloc] init];
    df.dateFormat = @"yyyy/MM/dd HH:mm:ss";
    NSString *dateString = [df stringFromDate:date];

    //NSUserDefaultにnowを
    Item *item = [[Item alloc]init];
    //    static dispatch_once_t token;
    //    dispatch_once(&token, ^{
    //Cacheディレクトリのパスを取得する
    NSArray *array = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    NSString *cacheDirPath = [array objectAtIndex:0];
    //Cacheディレクトリの下に新規でディレクトリを作る
    //新規で作るディレクトリの絶対パスを作成
    NSString *userDirrectoryPath = [NSString stringWithFormat:@"%@",[cacheDirPath stringByAppendingPathComponent:user.name]];
    
    NSLog(@"%@",userDirrectoryPath);
    //    [cacheDirPath stringByAppendingPathComponent:(@"%@,Directory",name);
    //FileManagerでディレクトリを作成
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSError *error = nil;
    BOOL created = [fileManager createDirectoryAtPath:userDirrectoryPath
                          withIntermediateDirectories:YES
                                           attributes:nil
                                                error:&error];
    // 作成に失敗した場合は、原因をログに出す。
    if (!created) {
        NSLog(@"failed to create directory. reason is %@ - %@", error, error.userInfo);
    }
    // convert UIImage to NSData
    // JPEGのデータとしてNSDataを作成します
    NSData *imageData = [[NSData alloc] initWithData:UIImageJPEGRepresentation(image, 0.8f)];
    //保存する先のパス
    NSString *saveFolderPath =userDirrectoryPath;
    NSString *savedPath = [NSString stringWithFormat:@"%@",[saveFolderPath stringByAppendingPathComponent:dateString]];
    // 保存処理を行う。
    // write NSData into the file
    [imageData writeToFile:savedPath atomically:YES];

}
//-(void) saveImageFile:(UIImage *)image personName:name {
//    // convert UIImage to NSData
//    // JPEGのデータとしてNSDataを作成します
//    NSData *imageData = [[NSData alloc] initWithData:UIImageJPEGRepresentation(image, 0.8f)];
//    //保存する先のパス
//    NSString *saveFolderPath = createdPersonDirPath;
//    NSString *savedPath = [NSString stringWithFormat:@"%@",[saveFolderPath stringByAppendingPathComponent:dateString]];
//    // 保存処理を行う。
//    // write NSData into the file
//    [imageData writeToFile:savedPath atomically:YES];
//}



@end

