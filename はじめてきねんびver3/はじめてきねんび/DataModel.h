//
//  DataModel.h
//  はじめてきねんび
//
//  Created by KikruaYuichirou on 2013/08/27.
//  Copyright (c) 2013年 Ueda Junya. All rights reserved.
//

@interface DataModel : NSObject {
}

@property (strong) NSMutableArray *dict;


//コンストラクタ
+(id) data;
+(id) dataWithId:(int)dataId;

//指定されたIDのデータを読み込む
+(id) loadData:(int) targetDataId;

//辞書に値を設定しUserDefaultsへ保存する
-(void) saveData:(id)value WithKeyStr:(NSString *)key;
-(void) saveData:(id)value WithKeyId:(int)key;

//値を読み込んで返す
-(id) dataWithKeyId:(int)key;

@end