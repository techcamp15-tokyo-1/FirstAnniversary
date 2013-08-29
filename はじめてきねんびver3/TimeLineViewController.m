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
    NSMutableDictionary *objects;
    NSMutableArray *arrayOfDates;
    NSMutableArray *arrayOfDays;
    User *user;
}
@property (nonatomic, strong)NSArray *photos;

@end

@implementation TimeLineViewController
NSMutableArray *items;
User *user;

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
//    [self.navigationController setNavigationBarHidden:YES animated:YES];
    self.collectionView .backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"corkboard.jpg"]];
    //ユーザ情報の取得
    user = [User getCurrentUser];

}

//データ読み込みメソッド
-(NSMutableArray *)loadItems{
    NSMutableArray *array = [NSMutableArray array];
    for (NSMutableDictionary *item in user.itemList){
        [array addObject:item];
    }
    return array;
}

//-(NSMutableArray *)loadArrayOfDate (NSMutableArray *)arrayOfDate addItem:(Item *)item{
//    NSDateFormatter *df = [[NSDateFormatter alloc]init];
//    df.dateFormat = @"yyyy/MM/dd";
//    [arrayOfDates addObject:[df stringFromDate:item.date]];
//}




//経過日数を計算し、文字列で返す

//CollectionViewControllerに関するメソッド
//セクションの数　今回は１つ
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}
//セルの個数を設定　+1　は最後のRightCellの分
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return user.itemList.count + 1;
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

    NSMutableDictionary *item;
    NSDate *date ;
    FileManager *fm = [FileManager getInstance];

    if(indexPath.row == 0){
        NSLog(@"Start!");
        item = [user.itemList objectAtIndex:indexPath.row];
        date = [item objectForKey:ITEM_DATE];
        [cell setDate:date];
        UIImage *image = [UIImage imageWithContentsOfFile:[[fm getCurrentUserDirForPath] stringByAppendingString:[NSString stringWithFormat:@"/%@",[item objectForKey:ITEM_IMAGE_NAME]]]];
        [cell setImage:image];

 //       [cell setDays_str:[item objectForKey:ITEM_DAYS]];
    }else if(indexPath.row == user.itemList.count){
        NSLog(@"Last!");
        date = [NSDate date];
        [cell setDate:date];
 //       [cell setDays:date addBirrhday:user.birthday];
    }else{
        NSLog(@"No.%d",indexPath.row);
        item = [user.itemList objectAtIndex:indexPath.row];
        date = [item objectForKey:ITEM_DATE];
        [cell setDate:date];
        UIImage *image = [UIImage imageWithContentsOfFile:[[fm getCurrentUserDirForPath] stringByAppendingString:[NSString stringWithFormat:@"/%@",[item objectForKey:ITEM_IMAGE_NAME]]]];
        [cell setImage:image];
 //       [cell setDays:date addBirrhday:user.birthday];
    }
//    
//    
//    if (indexPath.row == user.itemList.count){
//        NSLog(@"さいご！");
//        date = [NSDate date];
//        [cell setDays:[item objectForKey:ITEM_DATE] addBirrhday:user.birthday];
//    }
//    
//    else{
//        item = [user.itemList objectAtIndex:indexPath.item];
//        date = [item objectForKey:ITEM_DATE];
//        FileManager *fm = [FileManager getInstance];
//        if ( indexPath.row == 0){
//            [cell setDays_str:[item objectForKey:ITEM_DAYS]];
//        }else{
//            [cell setDays:[item objectForKey:ITEM_DATE] addBirrhday:user.birthday];
//        }
//
//    }
//    [cell setDays:date addBirrhday:user.birthday];
//    NSLog(@"imageName = %@ ,title = %@ ,message = %@ ,days = %@",item.imageName,item.title,item.message,item.days);
}


// identifier の分岐
- (NSString *)identifierWithIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0)
        return @"LeftCell";
    else if (indexPath.row == user.itemList.count)
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
        nextVC.itemIndex = ((UIButton *)sender).tag;
        NSLog(@"@%d",((UIButton *)sender).tag);
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
