//
//  TimeLineViewController.m
//  はじめてきねんび
//
//  Created by Jin Sasaki on 2013/08/23.
//  Copyright (c) 2013年 Ueda Junya. All rights reserved.
//

#import "TimeLineViewController.h"
#import "CustomCell.h"
#import "DetailViewController.h"
#import "User.h"

@interface TimeLineViewController ()
{
    NSMutableArray *_objects;
    NSMutableArray *_arrayOfDates;
    NSMutableArray *_arrayOfDays;
    User *user;
}
@property (nonatomic, strong)NSArray *photos;

@end

@implementation TimeLineViewController

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
    
    //ユーザ情報の取得
    user = [User getCurrentUser];
    //画像データを配列に
    NSMutableArray *array = [NSMutableArray array];
    array = [NSMutableArray array];
    for (int i = 1; i <= 8; i++) {
        NSString *filename = [NSString stringWithFormat:@"p%d.jpg", i];
        [array addObject:[UIImage imageNamed:filename]];
    }
    // サンプルデータの読み込み
    [self loadImageData:array];
    [self loadlabelDate];
    [self loadlabelDays];
}


//データ読み込みメソッド
- (void)loadImageData: (NSMutableArray *)array
{
    //画像名を読み込む
    _objects = array;
}

- (void)loadlabelDate
{
    //日付を読み込む
    NSDateFormatter *df = [[NSDateFormatter alloc]init];
    df.dateFormat = @"yyyy/MM/dd";
    _arrayOfDates = [NSMutableArray array];
    [_arrayOfDates addObject:[df stringFromDate:user.birthday]];
    
    for (int i = 1 ; i <= 7 ; i++){
        NSString *str = [NSString stringWithFormat:@"%d",i];
        [_arrayOfDates addObject: str];
    }
    [_arrayOfDates addObject:[df stringFromDate:[NSDate date]]];
}

- (void)loadlabelDays
{
    //経過日数を設定読み込む
    _arrayOfDays = [NSMutableArray array];
    NSString *firstGreeting =[NSString stringWithFormat:@"はじめまして%@さん",user.name];
    [_arrayOfDays addObject:firstGreeting];
    int index = 1;
    for ( id content in _arrayOfDates ){
        _arrayOfDays = [self calcDaysAsString:_arrayOfDates[index]];
        
    }
//    _arrayOfDays=[[NSMutableArray alloc]initWithObjects:firstGreeting,@"4days",@"5days",@"6days",@"7days",@"8days",@"9days",@"9days",@"9days", nil];
}

//経過日数を計算し、文字列で返す
- (NSString *)calcDaysAsString :(NSDate *)date{
    NSDate *now = [NSDate date];
    NSTimeInterval days = [now timeIntervalSinceDate:date];
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
    return _objects.count + 1;
}

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
    if (indexPath.row == _objects.count);
    else{
        [cell setImage:[_objects objectAtIndex:indexPath.item]];
    }
    [cell setDate:[_arrayOfDates objectAtIndex:indexPath.item]];
    [cell setDays:[_arrayOfDays objectAtIndex:indexPath.item]];
}

// identifier の分岐
- (NSString *)identifierWithIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0)
        return @"LeftCell";
    else if (indexPath.row == _objects.count)
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
        UIImage *img = _objects[((UIButton *)sender).tag];
        [[segue destinationViewController] setDetailItem:img];
    }
}

//回転制御　が、しかしうまくいってなさそう
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // 横方向のみ回転を許可する
    if ((interfaceOrientation == UIInterfaceOrientationLandscapeRight) ||
        (interfaceOrientation == UIInterfaceOrientationLandscapeLeft)) {
        return YES;
    } else {
        return NO;
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




@end
