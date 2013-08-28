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

+(User *)loadUser:(int)targetUserId {
    User *user = [User loadData:targetUserId];
    if (!user) {
        user = [User dataWithId:targetUserId];
        user.name = USER_NO_NAME;
        [user setUserId:targetUserId];
    }
    currentUser = user;
    return user;
}

+(User *)getFirstClass{
    return [self loadUser:0];
}

-(NSString *)name{
    return [self dataWithKeyId:USER_KEY_NAME];
}
-(void)setName:(NSString *)name{
    [self saveData:name WithKeyId:USER_KEY_NAME];
}

-(int)userId{
    NSString *userId_str = [self dataWithKeyId:USER_KEY_USERID];
    return userId_str.intValue;
}
-(void)setUserId:(int)userId{
    [self saveData:[NSString stringWithFormat:@"%d", userId] WithKeyId:USER_KEY_USERID];
}
//誕生日
-(void)setBirthday:(NSDate *)birthday{
    [super saveData:birthday WithKeyId:USER_KEY_BIRTHDAY];
}
-(NSDate *)birthday {
    return [super dataWithKeyId:USER_KEY_BIRTHDAY];
}

//はじめての画像
-(void)setImage:(UIImage *)image{
    [super saveData:image WithKeyId:USER_KEY_IMAGE];
}
-(UIImage *)image {
    return [super dataWithKeyId:USER_KEY_IMAGE];
}


//--------------------------------------------------------------------------------

//ユーザーを読み込みカレントユーザーに設定する
+(User *) loadAndSetCurrentUserForUserId:(int)userId {
    User *user = [User loadData:userId];
    currentUser = user;
    return user;
}
+(User *) load:(int)userId {
    return [self loadUser:userId];
}

//--------------------------------------------------------------------------------
// アイテムリストにアイテムを挿入
-(void)insertItem:(Item *)item{
    [self.itemList addObject:item];
    [self.itemList insertObject:item atIndex:[self index]];
}

//挿入位置を返す
-(int)index{
    return self.itemList.count;
}


//--------------------------------------------------------------------------------

// アイテムのソート

// ソートされたアイテムの操作
//--------------------------------------------------------------------------------



@end
