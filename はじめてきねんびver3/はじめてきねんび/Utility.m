////
////  Utility.m
////  はじめてきねんび
////
////  Created by Jin Sasaki on 2013/08/27.
////  Copyright (c) 2013年 Ueda Junya. All rights reserved.
////
//
//#import "Utility.h"
//#import "Item.h"
//#import "User.h"
//
//@implementation Utility
//static NSMutableArray *utitlityArray;
//static Utility  *currentUtility;
////
//
//+(Utility *)getCurrentUtility{
//    return currentUtility;
//}
//
//-(Utility *)loadUtility{
//    
//}
//
////utilityArray
//-(void)setUtilityArray:(NSMutableArray *)utilityArray {
//    [super saveData:utilityArray WithKeyId:UTILITY_KEY_USERID];
//}
//-(NSMutableArray *)utilityArray {
//	return [super dataWithKeyId:UTILITY_KEY_USERID];
//}
//
//+(void)saveItem:(Item *)item {
//    
//}
//
////ユーザから保存命令
//-(void)createItemFromUser:(int)userId{
//    //ユーティリティの呼び出し？    
//}
//
////アイテムを作成してitemIdをget
//-(int)getItemId{
//    return 1;
//}
//
////ユーザから取得命令
//-(Item *)getItem:(int)userId{
//    //ユーティリティの呼び出し
//}
//
//
//User *user;
//Item *item;
//
//
////ユーザ１人に対してひとつのindexArrayをもつ
////indexArrayの中にはItemの位置(int)を入れる
////indexArrayはitem.dateで並び替える
//
//// 追加
//// Itemを追加したときにindexArrayに追加する
//-(void)setIndexArray{
//    user = [User getCurrentUser];
//    
//    item = [Item getCurrentItem];
//    [self.indexArray addObject:[NSNumber numberWithInt: item.itemId]];
//    
//}
//// indexArrayを並び替える
//
//// 出力
//// セルに表示するときにindexArrayの順で表示する
//-(int)getItemIdWithIndex:(int)index{
//    return [[self.indexArray objectAtIndex:index] intValue];
//}
//// 指定番目のItemを取り出す
//-(Item *)getItemWithIndex:(int)index{
//    return [Item loadItem:[self getItemIdWithIndex:index]];
//}
//
//// セルに渡す
//
//
//
//
//-(void )saveUtilty:(int)title
//        andMessage:(NSString *)message
//           andName:(NSString *)imageName {
//    self.title = title;
//    self.message = message;
//    self.imageName = imageName;
//}
//+(Item *)getCurrentItem {
//    return currentItem;
//}
//+(Item *)itemWithId:(int)targetItemId {
//	Item *item = (Item *)[self dataWithId:targetItemId];
//	item.title = ITEM_NO_TITLE;
//	item.itemId = targetItemId;
//	
//	return item;
//}
//+(Item *)loadItem:(int)targetItemId {
//	Item *item = (Item *)[super loadData:targetItemId];
//	if (!item) item = [self itemWithId:targetItemId];
//	currentItem = item;
//	
//	return item;
//}
//
////アイテムID
//-(void)setItemId:(int)itemId {
//	NSString *itemId_str = [NSString stringWithFormat:@"%d", itemId];
//	[super saveData:itemId_str WithKeyId:ITEM_KEY_ITEMID];
//}
//-(int)ItemId {
//	NSString *itemId_str = [super dataWithKeyId:ITEM_KEY_ITEMID];
//	return itemId_str.intValue;
//}
//
//
//@end
