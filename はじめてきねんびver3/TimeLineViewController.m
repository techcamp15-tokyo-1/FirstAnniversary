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

- (void)loadImageData
{
    NSMutableArray *samplePhotos = [NSMutableArray array];
    for (int i = 1; i <= 8; i++) {
        NSString *filename = [NSString stringWithFormat:@"p%d.jpg", i];
        [samplePhotos addObject:[UIImage imageNamed:filename]];
    }
   // self.photos = @[samplePhotos];
    _objects = samplePhotos;
    
}
- (void)loadlabelDate
{
    //日付を読み込む
    NSDateFormatter *df = [[NSDateFormatter alloc]init];
    df.dateFormat = @"yyyy/MM/dd";
    _arrayOfDates = [NSMutableArray array];
    [_arrayOfDates addObject:[df stringFromDate:user.birthday]];
    NSLog(@"%@",[df stringFromDate:user.birthday]);
    NSLog(@"%@",user.name);
    for (int i = 1 ; i <= 7 ; i++){
        NSString *str = [NSString stringWithFormat:@"%d",i];
        [_arrayOfDates addObject: str];
        NSLog(@"%d",i);
        
    }
    
    [_arrayOfDates addObject:[df stringFromDate:[NSDate date]]];
    NSLog(@"%@",[df stringFromDate:[NSDate date]]);
    
}
- (void)loadlabelDays
{
    //日数を設定読み込むor計算する
    NSString *firstGreeting =[NSString stringWithFormat:@"はじめまして%@さん",user.name];
    _arrayOfDays=[[NSMutableArray alloc]initWithObjects:firstGreeting,@"4days",@"5days",@"6days",@"7days",@"8days",@"9days",@"9days",@"9days", nil];
}

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
    user = [User getCurrentUser];
    
    // サンプルデータの読み込み
    [self loadImageData];
    [self loadlabelDate];
    [self loadlabelDays];
}
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return _objects.count + 1;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CustomCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:[self identifierWithIndexPath:indexPath] forIndexPath:indexPath];
    [self setInformationWithIndexPath:indexPath :cell];
    [cell button].tag = indexPath.row;
   // [cell setDate:?:[_objects objectAtIndex:indexPath.item]];
   // [cell setImage:[_objects objectAtIndex:indexPath.item]];
    return cell;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // 横方向のみ回転を許可する
    if ((interfaceOrientation == UIInterfaceOrientationLandscapeRight) ||
        (interfaceOrientation == UIInterfaceOrientationLandscapeLeft)) {
        return YES;
    } else {
        return NO;
    }
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"showDetail"]) {
        UIImage *img = _objects[((UIButton *)sender).tag];
        [[segue destinationViewController] setDetailItem:img];
        
    }
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

- (void)setInformationWithIndexPath:(NSIndexPath *)indexPath : (CustomCell *) cell {
    if (indexPath.row == _objects.count);
    else{
        [cell setImage:[_objects objectAtIndex:indexPath.item]];
    }
    [cell setDate:[_arrayOfDates objectAtIndex:indexPath.item]];
    [cell setDays:[_arrayOfDays objectAtIndex:indexPath.item]];
    
}

- (IBAction)imageButton:(id)sender {
    
}
@end
