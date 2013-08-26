//
//  DataModel.m
//  はじめてきねんび
//
//  Created by KikruaYuichirou on 2013/08/27.
//  Copyright (c) 2013年 Ueda Junya. All rights reserved.
//

#import "DataModel.h"

#ifndef DataModel_m
#define DataModel_m

#define DATAMODEL_KEY_DATAID @"data-key-dataId"
#define DATAMODEL_FORMAT_DATAID @"data-key-%d"

#endif

@implementation DataModel

NSMutableDictionary *dict;

//コンストラクタ
+(id) data {
	return [self dataWithId:(int)[[NSDate date] timeIntervalSince1970]];
}

//コンストラクタ with Id
+(id) dataWithId:(int)dataId {
	DataModel *data = [[self alloc] init];
    [data setDictionary:[[NSMutableDictionary alloc] init]];
    [data setDataId:dataId];
	
	return data;
}

//指定されたIDのデータを読み込む
+(id) loadData:(int) targetDataId {
    DataModel *data  = [self data];
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
	
	//データのIDに(クラス名)-(番号)を採用
	//こうすることで、例えばUserの1番とItemの1番でもデータが重ならないで済む
    NSMutableDictionary *dictLoaded = [defaults objectForKey:[NSString stringWithFormat:@"%@-%d",
															  NSStringFromClass(self),
															  targetDataId]];
    NSLog(@"%@-%d",
		  NSStringFromClass(self),
		  targetDataId);
	
	if (!dictLoaded) return nil;
	
	[data setDictionary:dictLoaded];
	return data;
}

//データモデルと実際にデータが入った辞書をひもづける
-(void) setDictionary:(NSMutableDictionary *)targetdict{
	if (!targetdict) return;
    dict = [NSMutableDictionary dictionaryWithDictionary:targetdict];
}

//データモデルにdataIDを設定する
-(void) setDataId:(int)dataId{
	NSString *dataId_str = [NSString stringWithFormat:@"%@-%d",
							NSStringFromClass(self.class),
							dataId];
    [self saveData:dataId_str WithKeyStr:DATAMODEL_KEY_DATAID];
}

//辞書に値を設定しUserDefaultsへ保存する
-(void) saveData:(id)value WithKeyStr:(NSString *)key {
    [dict setValue:value forKey:key];
	
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *key_dataId = [dict objectForKey:DATAMODEL_KEY_DATAID];
    [defaults setObject:dict forKey:key_dataId];
}
//辞書に値を設定しUserDefaultsへ保存する（keyがintバージョン)
-(void) saveData:(id)value WithKeyId:(int)key {
	NSString *key_str = [NSString stringWithFormat:DATAMODEL_FORMAT_DATAID, key];
	[self saveData:value WithKeyStr:key_str];
}

//値を読み込んで返す
-(id) dataWithKeyStr:(NSString *)key {
	return [dict valueForKey:key];
}

//値を読み込んで返す（keyがintバージョン）
-(id) dataWithKeyId:(int)key {
	return [self dataWithKeyStr: [NSString stringWithFormat:DATAMODEL_FORMAT_DATAID, key]];
}

@end
