//
//  fileManager.m
//  はじめてきねんび
//
//  Created by Jin Sasaki on 2013/08/27.
//  Copyright (c) 2013年 Ueda Junya. All rights reserved.
//

#import "FileManager.h"

@implementation FileManager

+(FileManager *)getInstance{
    static FileManager *instance;
    if (!instance) instance = [[FileManager alloc] init];
    return instance;
}

-(void )saveImageData:(NSData *)imageData
          andDate:(NSDate *)date{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:@{TMP_DATE: date, TMP_IMAGE: imageData} forKey:TMP];
    NSString *dateString =  [self convertDateToString:date];
    
    [self createDirNamedOfUserId];
    
    NSString *savedPath = [NSString stringWithFormat:@"%@",[[self getCurrentUserDirForPath] stringByAppendingPathComponent:dateString]];
    [imageData writeToFile:savedPath atomically:YES];
}

-(NSString *)getCurrentUserDirForPath{
    
    User *user = [User getCurrentUser];
    NSArray *cacheDirArray = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    NSString *userIdAsString = [NSString stringWithFormat:@"%d",user.userId];
    NSString *currentUserPath = [NSString stringWithFormat:@"%@",
                                 [[cacheDirArray objectAtIndex:0] stringByAppendingPathComponent:userIdAsString]];
    NSLog(@"%@",currentUserPath);
    return  currentUserPath;
}

-(BOOL)createDirNamedOfUserId{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    return [fileManager createDirectoryAtPath:[self getCurrentUserDirForPath]
                  withIntermediateDirectories:YES
                                   attributes:nil
                                        error:nil];
}
- (NSString *)convertDateToString:(NSDate *)date{
    NSDateFormatter *df = [[NSDateFormatter alloc] init];
    df.dateFormat = @"yyyyMMddHHmmss";
    return [df stringFromDate:date];
    
}

- (NSString *)createPathByImageName :(NSString *)imageName  {
    return [NSString stringWithFormat:@"%@/%@",[self getCurrentUserDirForPath],imageName];
    
}


@end




