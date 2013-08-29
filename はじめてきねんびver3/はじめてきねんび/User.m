//
//  User.m
//  はじめてきねんび
//
//  Created by Jin Sasaki on 2013/08/24.
//  Copyright (c) 2013年 Ueda Junya. All rights reserved.
//

#import "User.h"

@implementation User


static User *currentUser;

+(User *)getCurrentUser {
    return currentUser;
}
+(User *)userWithId:(int)targetUserId {
	User *user = (User *)[self dataWithId:targetUserId];
	user.name = USER_NO_NAME;
	user.userId = targetUserId;
//    user.itemList = [NSMutableArray array];
	
	return user;
}
+(User *)loadUser:(int)targetUserId {
	User *user = (User *)[super loadData:targetUserId];
	if (!user) user = [User userWithId:targetUserId];
	currentUser = user;
	
	return user;
}

//ユーザーID
-(void)setUserId:(int)userId {
	NSString *userId_str = [NSString stringWithFormat:@"%d", userId];
    [super saveData:userId_str WithKeyId:USER_KEY_USERID];
}
-(int)userId {
	NSString *userId_str = [super dataWithKeyId:USER_KEY_USERID];
    return userId_str.intValue;
}

//名前
-(void)setName:(NSString *)name{
    [super saveData:name WithKeyId:USER_KEY_NAME];
}
-(NSString *)name {
    return [super dataWithKeyId:USER_KEY_NAME];
}

//誕生日
-(void)setBirthday:(NSString *)birthday{
    [super saveData:birthday WithKeyId:USER_KEY_BIRTHDAY];
}
-(NSString *)birthday {
    return [super dataWithKeyId:USER_KEY_BIRTHDAY];
}
-(void)initItemList{
    
}

//はじめての画像
-(void)setImage:(NSData *)image{
    [super saveData:image WithKeyId:USER_KEY_IMAGE];
}
-(NSData *)image {
    return [super dataWithKeyId:USER_KEY_IMAGE];
}
//itemList
-(void)setItemList:(NSMutableArray *)itemList{
    if(!itemList){
        itemList = [NSMutableArray array];
    }
    [super saveData:itemList WithKeyId:USER_KEY_ITEMLIST];

//    self.itemList = itemList;
}
-(NSMutableArray *)itemList {
    return (NSMutableArray *)[super dataWithKeyId:USER_KEY_ITEMLIST];
}

//// dateでItemに保存
//-(void)addItemToCurrent:(NSDate *)date{
//    [currentUser addItem:date];
//}
//-(void)addItem:(NSDate *)date{
//    [Item itemWithId:[date timeIntervalSince1970]];
//}
//// dateでItemから呼び出し
//-(Item *)loadItemFromCurrent:(NSDate *)date{
//    return [currentUser loadItem:date];
//}
//
//-(Item *)loadItem:(NSDate *)date{
//    return [Item loadItem:[date timeIntervalSince1970]];
//}
//--------------------------------------------------------------------------------

// アイテムリストにアイテムを挿入
-(void)insertItem:(NSMutableDictionary *)item{
    NSMutableArray *items;
    items = self.itemList;
    [items addObject:item];
    //[items insertObject:item atIndex:[self index]];
    [self setItemList:items];
}

//辞書に保存してアイテムリストに辞書を挿入
-(NSMutableDictionary *) itemFactory:(NSString *)title
                          addMessage:(NSString *)message
                             addDate:(NSDate *)date
                        addImageName:(NSString *)imageName
                             addDays:(NSString *)days{
    
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    
    if (title) {
        [dict setObject:title forKey:ITEM_TITLE];
    } else {
        NSLog(@"Title未指定");
    }
    if (message) {
        [dict setObject:message forKey:ITEM_MESSAGE];
    } else {
        NSLog(@"message未指定");
    }

    [dict setObject:date forKey:ITEM_DATE];
    [dict setObject:imageName forKey:ITEM_IMAGE_NAME];
    
    if (!days) days = [NSString stringWithFormat:@"%d日",
        (int)([[NSDate date] timeIntervalSinceDate:currentUser.birthday]) / 60 / 60 / 24];
    
    [dict setObject:days forKey:ITEM_DAYS];
    [self insertItem:dict];
    return dict;
}

//挿入位置を返す
-(int)index{
    return self.itemList.count+1;
}



// アイテムのソート
// ソートされたアイテムの操作


@end
