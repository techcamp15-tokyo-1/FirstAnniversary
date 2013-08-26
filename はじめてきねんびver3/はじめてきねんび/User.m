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

+(User *)loadUser:(int) targetUserId {
    User *user = [[User alloc] init];
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSMutableDictionary *dict = [defaults objectForKey:[NSString stringWithFormat:@"%d", targetUserId]];
    
    if (dict) {
        [user setDictionary:dict];
    } else {
        [user initializeWithUserID:targetUserId];
    }
    currentUser = user;
    return user;
}
-(void)initializeWithUserID:(int)userId{
    _dict = [[NSMutableDictionary alloc] init];
    [self setUserId:userId];
    self.name = NO_NAME;
}
-(void)setUserId:(int)userId {
    [_dict setValue:[NSString stringWithFormat:@"%d", userId] forKey:@"userId"];
    [self saveData];
}
-(int)userId {
    NSString *userID_str = [_dict valueForKey:@"userId"];
    return userID_str.intValue;
}
-(void)setName:(NSString *)name{
    [_dict setObject:name forKey:@"name"];
    [self saveData];
}
-(NSString *)name {
    return [_dict valueForKey: @"name"];
}

-(void)setImage:(NSString *)name{
    [_dict setObject:name forKey:@"image"];
    [self saveData];
}
-(NSString *)image {
    return [_dict valueForKey: @"image"];
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
    NSString *key = [NSString stringWithFormat:@"%d", self.userId];
    NSLog(@"SAVE: userID = %d", self.userId);
    [defaults setObject:_dict forKey:key];
}
@end
