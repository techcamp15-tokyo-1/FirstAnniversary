//
//  Item.h
//  はじめてきねんび
//
//  Created by Ueda Junya on 2013/08/16.
//  Copyright (c) 2013年 Ueda Junya. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DataModel.h"

@interface Item : DataModel　{
}

@property NSString *title;
@property NSString *message;
@property NSString *imageName;
@property NSDate *date;


@property (readonly) int itemId;

+(Item *)getCurrentItem;
+(Item *)loadItem:(int)targetItemId;
-(void )saveItem:(NSString *)title andMessage:(NSString *)message andName:(NSString *)imageName;
+(Item *)itemWithId:(int)targetItemId;


@end

#ifndef Item_h
#define Item_h

#define ITEM_NO_TITLE @"未設定"

enum ITEM_KEY {
	ITEM_KEY_TITLE = 0,
	ITEM_KEY_MESSAGE,
	ITEM_KEY_IMAGE_NAME,
	ITEM_KEY_ITEMID,
    ITEM_KEY_DATE
    
};

#endif
