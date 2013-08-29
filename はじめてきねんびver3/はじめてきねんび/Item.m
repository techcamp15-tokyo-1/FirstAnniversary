//
//  Item.m
//  はじめてきねんび
//
//  Created by Ueda Junya on 2013/08/16.
//  Copyright (c) 2013年 Ueda Junya. All rights reserved.
//

#import "Item.h"

@implementation Item



//-(Item *)init{
//    
//    return self;
//}
-(void)setDate:(NSDate *)date{
    [self setObject:date forKeyAsInt:ITEM_KEY_DATE];
}
-(NSDate *)date{
    return [self objectForKeyAsInt:ITEM_KEY_DATE];
}
-(void)setDays:(NSString *)days{
    [self setObject:days forKeyAsInt:ITEM_KEY_DAYS];
}
-(NSString *)days{
    return  [self objectForKeyAsInt:ITEM_KEY_DAYS];
}

-(void)setImageName:(NSString *)imageName {
    [self setObject:imageName forKeyAsInt:ITEM_KEY_IMAGE_NAME];
}
-(NSString *)imageName{
    return [self objectForKeyAsInt:ITEM_KEY_IMAGE_NAME];
}

-(void)setTitle:(NSString *)title{
    [self setObject:title forKeyAsInt:ITEM_KEY_TITLE];
}
-(NSString *)title{
    return [self objectForKeyAsInt:ITEM_KEY_TITLE];
}

-(void)setMessage:(NSString *)message{
    [self setObject:message forKeyAsInt:ITEM_KEY_MESSAGE];
}
-(NSString *)message{
    return [self objectForKeyAsInt:ITEM_KEY_MESSAGE];
}

-(void)setObject:(id)anObject forKeyAsInt:(enum ITEM_KEY)keyAsInt{
    NSString *key = [NSString stringWithFormat:@"%d",keyAsInt];
    [super setObject:anObject forKey:key];
}

-(id)objectForKeyAsInt:(enum ITEM_KEY)keyAsInt {
    NSString *key = [NSString stringWithFormat:@"%d",keyAsInt];
    return [super objectForKey:key];
}

//static Item *currentItem;
//
//-(void )saveItem:(NSString *)title
//      andMessage:(NSString *)message
//         andName:(NSString *)imageName
//         andDate:(NSDate *)date {
//    self.title = title;
//    self.message = message;
//    self.imageName = imageName;
//    self.date = date;
//}
//
//+(Item *)getCurrentItem {
//    return currentItem;
//}
//
//+(Item *)itemWithId:(int)targetItemId {
//	Item *item = (Item *)[self dataWithId:targetItemId];
//	item.title = ITEM_NO_TITLE;
//	item.itemId = targetItemId;
//	
//	return item;
//}
//+(Item *)loadItem:(int)targetItemId {
//	Item *item = (Item *)[super loadData:targetItemId];
//	if (!item) item = [self itemWithId:targetItemId];
//	currentItem = item;
//	
//	return item;
//}
//
////アイテムID
//-(void)setItemId:(int)itemId {
//	NSString *itemId_str = [NSString stringWithFormat:@"%d", itemId];
//	[super saveData:itemId_str WithKeyId:ITEM_KEY_ITEMID];
//}
//-(int)itemId {
//	NSString *itemId_str = [super dataWithKeyId:ITEM_KEY_ITEMID];
//	return itemId_str.intValue;
//}
@end

