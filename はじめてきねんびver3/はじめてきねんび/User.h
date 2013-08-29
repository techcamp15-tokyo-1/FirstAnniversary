//
//  User.h
//  はじめてきねんび
//
//  Created by Jin Sasaki on 2013/08/24.
//  Copyright (c) 2013年 Ueda Junya. All rights reserved.
//

#import "DataModel.h"
//#import "Item.h"

@interface User : DataModel {
}

@property (strong) NSString* name;
@property (readonly) int userId;
@property (strong) NSDate *birthday;
@property (strong) NSData *image;
@property (strong) NSMutableArray *itemList;
+(User *)getCurrentUser;
+(User *)loadUser:(int)targetUserId;
-(void)addItemToCurrent:(NSDate *)date;
//-(Item *)loadItemFromCurrent:(NSDate *)date;
-(void)insertItem:(NSMutableDictionary *)item;
-(NSMutableDictionary *) itemFactory:(NSString *)title
                          addMessage:(NSString *)message
                             addDate:(NSDate *)date
                        addImageName:(NSString *)imageName
                             addDays:(NSString *)days;

@end

#ifndef User_h
#define User_h

#define USER_NO_NAME @"未設定"

enum USER_KEY {
	USER_KEY_USERID = 0,
	USER_KEY_NAME,
	USER_KEY_BIRTHDAY,
	USER_KEY_IMAGE,
    USER_KEY_ITEMLIST
};

#endif

#define ITEM_TITLE @"title"
#define ITEM_MESSAGE @"message"
#define ITEM_DATE @"date"
#define ITEM_DAYS @"days"
#define ITEM_IMAGE_NAME @"imageName"
