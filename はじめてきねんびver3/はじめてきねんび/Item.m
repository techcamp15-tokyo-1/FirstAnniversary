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

-(void)saveItem : (NSString *)title :(NSString *)message :(NSString *)imageName{
    self.title = title;
    self.message = message;
    self.imageName = imageName;
}

+(Item *)getCurrentItem{
    return currentItem;
}


+(Item *)loadItem:(int) targetItemId {
    Item *item = [[Item alloc] init];
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSMutableDictionary *dict = [defaults objectForKey:[NSString stringWithFormat:@"%d", targetItemId]];
    
    if (dict) {
        [item setDictionary:dict];
    } else {
        [item initializeWithItemID:targetItemId];
    }
    currentItem = item;
    return item;
}
-(void)initializeWithItemID:(int)ItemId{
    _dict = [[NSMutableDictionary alloc] init];
    [self setItemId:ItemId];
    self.name = NO_TITLE;
}
-(void)setItemId:(int)ItemId {
    [_dict setValue:[NSString stringWithFormat:@"%d", ItemId] forKey:@"itemId"];
    [self saveData];
}
-(int)ItemId {
    NSString *ItemID_str = [_dict valueForKey:@"itemId"];
    return ItemID_str.intValue;
}
-(void)setName:(NSString *)name{
    [_dict setObject:name forKey:@"name"];
    [self saveData];
}
-(NSString *)name {
    return [_dict valueForKey: @"name"];
}
-(void)setBirthday:(NSString *)birthday{
    [_dict setObject:birthday forKey:@"birthday"];
    [self saveData];
}
-(NSString *)birthday {
    return [_dict valueForKey: @"birthday"];
}
-(void)setDictionary:(NSMutableDictionary *)dict{
    _dict = [NSMutableDictionary dictionaryWithDictionary:dict];
}

-(void) saveData {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    //selfをまるごとdefaultに保存
    NSString *key = [NSString stringWithFormat:@"%d", self.itemId];
    NSLog(@"SAVE: ItemID = %d", self.itemId);
    [defaults setObject:_dict forKey:key];
}
@end

