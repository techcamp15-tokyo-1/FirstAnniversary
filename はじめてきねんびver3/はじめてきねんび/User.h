//
//  User.h
//  はじめてきねんび
//
//  Created by Jin Sasaki on 2013/08/24.
//  Copyright (c) 2013年 Ueda Junya. All rights reserved.
//

#define NO_NAME @"未設定"

@interface User : NSObject {
    NSMutableDictionary *_dict;
}

@property (strong) NSString* name;
@property (readonly) int userId;

+(User *)getCurrentUser;
+(User *)loadUser:(int)targetUserId;
@end

