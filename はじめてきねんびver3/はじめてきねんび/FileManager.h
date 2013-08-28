//
//  fileManager.h
//  はじめてきねんび
//
//  Created by Jin Sasaki on 2013/08/27.
//  Copyright (c) 2013年 Ueda Junya. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FirstViewController.h"
#import "User.h"


@interface FileManager : NSObject
+(FileManager *)getInstance;
-(BOOL)createDirNamedOfUserId;
-(void )saveImageData:(NSData *)imageData
          andDate:(NSDate *)date;


@end
