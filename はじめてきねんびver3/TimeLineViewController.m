//
//  TimeLineViewController.m
//  はじめてきねんび
//
//  Created by Jin Sasaki on 2013/08/23.
//  Copyright (c) 2013年 Ueda Junya. All rights reserved.
//

#import "TimeLineViewController.h"

@interface TimeLineViewController ()
{
    NSMutableArray *objects;
    NSMutableArray *arrayOfDates;
    NSMutableArray *arrayOfDays;
    User *user;
}
@property (nonatomic, strong)NSArray *photos;

@end

@implementation TimeLineViewController
NSMutableArray *items;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    self.collectionView .backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"corkboard.jpg"]];
    //ユーザ情報の取得
    user = [User getCurrentUser];
    
/////////////////////////////
//    for (int i = 1; i <= 7; i++) {
//        NSString *filename = [NSString stringWithFormat:@"p%d.jpg", i];
//        [array addObject:[UIImage imageNamed:filename]];
//    }
//////////////////////////////
    
    // サンプルデータの読み込み
    items = [self loadItems];
}

//--------------------------------------------------------------------------------
//データ読み込み
//Itemの読み込み
-(NSMutableArray *)loadItems{
    NSMutableArray *array = [NSMutableArray array];
    for (Item * item in user.itemList){
        [array addObject:item];
    }
    return array;
}

//






//- (void)loadlabelDays
//{
//    //経過日数を設定読み込む
//    _arrayOfDays = [NSMutableArray array];
//    NSString *firstGreeting =[NSString stringWithFormat:@"はじめまして\n%@\nさん",user.name];
//    [_arrayOfDays addObject:firstGreeting];
//    for ( int i = 1 ; i<= [_arrayOfDates count]-1 ;i++){
//        [_arrayOfDays addObject:[self calcDaysAsString: _arrayOfDates[i]:user.birthday]];
//    }
////    _arrayOfDays=[[NSMutableArray alloc]initWithObjects:firstGreeting,@"4days",@"5days",@"6days",@"7days",@"8days",@"9days",@"9days",@"9days", nil];
//}

//経過日数を計算し、文字列で返す
- (NSString *)calcDaysAsString :(NSDate *)date :(NSDate *)birthday{
    NSTimeInterval days = [date timeIntervalSinceDate:birthday] / 24 / 60 / 60;
    NSLog(@"%.0f日",days);
    return [NSString stringWithFormat:@"%.0f日",days];
}

//CollectionViewControllerに関するメソッド
//セクションの数　今回は１つ
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}
//セルの個数を設定　+1　は最後のRightCellの分
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return items.count + 1;
}
//imageNameからパス作成

//--------------------------------------------------------------------------------
//セル関連
//セルを生成
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CustomCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:[self identifierWithIndexPath:indexPath] forIndexPath:indexPath];
    [self setInformationWithIndexPath:indexPath :cell];
    [cell button].tag = indexPath.row;
    return cell;
}
//セルのオブジェクトにセット
- (void)setInformationWithIndexPath:(NSIndexPath *)indexPath : (CustomCell *) cell {
    Item *item = [items objectAtIndex:indexPath.row];
    if (indexPath.row == items.count);
    else{
        FileManager *fm =[FileManager getInstance];
        UIImage *image = [UIImage imageWithContentsOfFile: [[fm getCurrentUserDirForPath] stringByAppendingString:item.imageName]];
        [cell setImage:image];
    }
    [cell setDate:item.date];
    [cell setDays:[self calcDaysAsString:item.date :user.birthday]];
}

// identifier の分岐
- (NSString *)identifierWithIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0)
        return @"LeftCell";
    else if (indexPath.row == items.count)
        return @"RightCell";
    else if(indexPath.row % 2 == 0)
        return @"DownCell";
    else if(indexPath.row % 2 == 1)
        return @"UpCell";
    return nil;
}

//詳細表示にセグエ
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"showDetail"]) {
        UIImage *img = items[((UIButton *)sender).tag];
        DetailViewController *nextVC = [segue destinationViewController];
        nextVC.detailItem = img;
        
    }
}


//？？？？？？？
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)imageButton:(id)sender {
}

// フォトライブラリー起動
- (IBAction)libraryButtonTapped:(id)sender {
    if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary])
	{
		UIImagePickerController *imagePickerController = [[UIImagePickerController alloc]init];
		[imagePickerController setSourceType:UIImagePickerControllerSourceTypePhotoLibrary];
		[imagePickerController setAllowsEditing:YES];
		[imagePickerController setDelegate:self];
		
        [self presentViewController:imagePickerController animated:YES completion:nil];
        
	}
	else
	{
		NSLog(@"Photo library invalid.");
	}
    
}

//回転処理が存在するかどうかを返す
- (BOOL)shouldAutorotate
{
    return YES;
}

//回転する方向を指定
- (NSUInteger)supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskAll;
}

@end
