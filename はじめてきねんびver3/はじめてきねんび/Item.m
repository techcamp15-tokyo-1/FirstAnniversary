//
//  Item.m
//  はじめてきねんび
//
//  Created by Ueda Junya on 2013/08/16.
//  Copyright (c) 2013年 Ueda Junya. All rights reserved.
//

#import "Item.h"

@implementation Item
static Item *currentItem;

-(void )saveItem:(NSString *)title andMessage:(NSString *)message andName:(NSString *)imageName {
    self.title = title;
    self.message = message;
    self.imageName = imageName;
}
+(Item *)getCurrentItem {
    return currentItem;
}
+(Item *)itemWithId:(int)targetItemId {
	Item *item = (Item *)[self dataWithId:targetItemId];
	item.title = ITEM_NO_TITLE;
	
	return item;
}
+(Item *)loadItem:(int)targetItemId {
	Item *item = (Item *)[super loadData:targetItemId];
	if (!item) item = [self itemWithId:targetItemId];
	currentItem = item;
	
	return item;
}

//アイテムID
-(void)setItemId:(int)itemId {
	NSString *itemId_str = [NSString stringWithFormat:@"%d", itemId];
	[super saveData:itemId_str WithKeyId:ITEM_KEY_ITEMID];
}
-(int)ItemId {
	NSString *itemId_str = [super dataWithKeyId:ITEM_KEY_ITEMID];
	return itemId_str.intValue;
}
@end

