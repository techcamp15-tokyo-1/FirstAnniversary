//
//  Utility.h
//  はじめてきねんび
//
//  Created by Jin Sasaki on 2013/08/27.
//  Copyright (c) 2013年 Ueda Junya. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DataModel.h"

@interface Utility : DataModel{
    
}
@property NSMutableArray *indexArray;

+(Utility *)getCurrentUtility;
-(Utility *)loadUtility;


@end


#ifndef Item_h
#define Item_h

#define UTILITY_NO_TITLE @"未設定"

enum UTILITY_KEY {
	UTILITY_KEY_USERID = 0,
	UTILITY_KEY_1
};

#endif