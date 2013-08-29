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

//はじめての画像
-(void)setImage:(NSData *)image{
    [super saveData:image WithKeyId:USER_KEY_IMAGE];
}
-(NSData *)image {
    return [super dataWithKeyId:USER_KEY_IMAGE];
}

// dateでItemに保存
-(void)addItemToCurrent:(NSDate *)date{
    [currentUser addItem:date];
}
-(void)addItem:(NSDate *)date{
    [Item itemWithId:[date timeIntervalSince1970]];
}
// dateでItemから呼び出し
-(Item *)loadItemFromCurrent:(NSDate *)date{
    return [currentUser loadItem:date];
}

-(Item *)loadItem:(NSDate *)date{
    return [Item loadItem:[date timeIntervalSince1970]];
}
// dateだけ別のarrayに保存
//-(void)saveDateToItemArray:


// アイテムのソート
// ソートされたアイテムの操作


@end
