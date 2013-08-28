//
//  User.h
//  はじめてきねんび
//
//  Created by Jin Sasaki on 2013/08/24.
//  Copyright (c) 2013年 Ueda Junya. All rights reserved.
//

#import "DataModel.h"
#import "Item.h"

@interface User : DataModel {
}

@property (strong) NSString* name;
@property (readonly) int userId;
@property (strong) NSDate *birthday;
@property (strong) NSData *image;
@property (strong) NSMutableArray *itemList;


+(User *)getCurrentUser;
-(void)save;
+(User *)load:(int)userId;
+(User *)loadUser:(int)userId;
-(void)insertItem:(Item *)item;

@end

#ifndef User_h
#define User_h

#define USER_NO_NAME @"未設定"

#endif

enum USER_KEY {
    USER_KEY_NAME = 0,
    USER_KEY_USERID,
    USER_KEY_BIRTHDAY,
    USER_KEY_ITEMLIST,
    USER_KEY_IMAGE
};


