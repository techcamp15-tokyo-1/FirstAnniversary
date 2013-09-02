//
//  Item.m
//  はじめてきねんび
//
//  Created by Ueda Junya on 2013/08/16.
//  Copyright (c) 2013年 Ueda Junya. All rights reserved.
//

#import "Item.h"

@implementation Item



//---------NSCoding-----------------------------------------------------------------------

static NSString *filePath;

- (id)initWithCoder:(NSCoder *)decoder
{
    self = [super init];
    if (self) {
        _title = [decoder decodeObjectForKey:@"title"];
        _message = [decoder decodeObjectForKey:@"message"];
        _date = [decoder decodeObjectForKey:@"date"];
        _imageName = [decoder decodeObjectForKey:@"imageName"];
    }
    return self;
}
- (void)encodeWithCoder:(NSCoder *)encoder
{
    [encoder encodeObject:_title forKey:@"title"];
    [encoder encodeObject:_message forKey:@"message"];
    [encoder encodeObject:_date forKey:@"date"];
    [encoder encodeObject:_imageName forKey:@"imageName"];
}
- (void)dealloc
{
    self.title = nil;
    self.message = nil;
    self.date = nil;
    self.imageName = nil;
    
}
//
//-(void)setItem:(Item *)item{
//    NSString *directory = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents"];
//    filePath = [directory stringByAppendingPathComponent:@"data.dat"];
//
//    NSArray *array = @[item.title,item.message,item.date,item.imageName];
//    BOOL success = [NSKeyedArchiver archiveRootObject:array toFile:filePath];
//    if(success){
//        NSLog(@"succeed");
//    }
//}
//-(Item *)item{
//    NSArray *array = [NSKeyedUnarchiver unarchiveObjectWithFile:filePath];
//    if (array) {
//        for (Item *item in array) {
//            NSLog(@"%@", item.title);
//            NSLog(@"%@", item.message);
//            NSLog(@"%@", item.date);
//            NSLog(@"%@", item.imageName);
//        }
//    } else {
//        NSLog(@"%@", @"データが存在しません。");
//    }
//}
//
//
////--------------------------------------------------------------------------------







static Item *currentItem;

-(void )saveItem:(NSString *)title
      andMessage:(NSString *)message
         andName:(NSString *)imageName
         andDate:(NSDate *)date {
    self.title = title;
    self.message = message;
    self.imageName = imageName;
    self.date = date;
}

+(Item *)getCurrentItem {
    return currentItem;
}

+(Item *)itemWithId:(int)targetItemId {
	Item *item = (Item *)[self dataWithId:targetItemId];
	item.title = ITEM_NO_TITLE;
	item.itemId = targetItemId;
	
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
-(int)itemId {
	NSString *itemId_str = [super dataWithKeyId:ITEM_KEY_ITEMID];
	return itemId_str.intValue;
}
@end

