//
//  User.h
//  はじめてきねんび
//
//  Created by Jin Sasaki on 2013/08/24.
//  Copyright (c) 2013年 Ueda Junya. All rights reserved.
//

#import "DataModel.h"

@interface User : DataModel {
}

@property (strong) NSString* name;
@property (readonly) int userId;
@property (strong) NSDate *birthday;

+(User *)getCurrentUser;
+(User *)loadUser:(int)targetUserId;

@end

#ifndef User_h
#define User_h

#define USER_NO_NAME @"未設定"

enum USER_KEY {
	USER_KEY_USERID = 0,
	USER_KEY_NAME,
	USER_KEY_BIRTHDAY
};

#endif
