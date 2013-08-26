//
//  Item.h
//  はじめてきねんび
//
//  Created by Ueda Junya on 2013/08/16.
//  Copyright (c) 2013年 Ueda Junya. All rights reserved.
//

#import <Foundation/Foundation.h>
#define NO_TITLE @"未設定"
@interface Item : NSObject{
    NSMutableDictionary *_dict;
}

@property NSString *title;
@property NSString *message;
@property NSString *imageName;
@property (readonly) int itemId;


+(Item *)getCurrentItem;
+(Item *)loadItem:(int)targetItemId;
-(void )saveItem;

@end
