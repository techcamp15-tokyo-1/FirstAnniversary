//
//  MasterViewController.m
//  はじめてきねんび
//
//  Created by Ueda Junya on 2013/08/16.
//  Copyright (c) 2013年 Ueda Junya. All rights reserved.
//

#import "MasterViewController.h"

#import "DetailViewController.h"

#import "Item.h"

@interface MasterViewController () {
    NSMutableArray *_objects;
    NSMutableArray *_itemArray;
    Item *_item1, *_item2, *_item3, *_item4, *_item5;
}
@end

@implementation MasterViewController

- (void)awakeFromNib
{
    [super awakeFromNib];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
//    self.navigationItem.leftBarButtonItem = self.editButtonItem;

    UIBarButtonItem *addButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(insertNewObject:)];
    self.navigationItem.rightBarButtonItem = addButton;
    
    _itemArray = [ NSMutableArray arrayWithCapacity: 1];
    
    _item1 = [Item new];
    _item1.itemName = @"初めての寝返り";
    _item1.itemImage =[UIImage imageNamed:@"寝返り.png"];
   // UIImage *img_ato;  // リサイズ後UIImage
    CGFloat width = 100;  // リサイズ後幅のサイズ
    CGFloat height = 100;  // リサイズ後高さのサイズ
    UIGraphicsBeginImageContext(CGSizeMake(width, height));
    [_item1.itemImage drawInRect:CGRectMake(0, 0, width, height)];
    _item1.itemImage = UIGraphicsGetImageFromCurrentImageContext();
  //  UIGraphicsEndImageContext();
    [_itemArray addObject:_item1];
    
    _item2 = [Item new];
    _item2.itemName = @"離乳食デビュー";
    _item2.itemImage =[UIImage imageNamed:@"離乳食.png"];
    [_item2.itemImage drawInRect:CGRectMake(0, 0, width, height)];
    _item2.itemImage = UIGraphicsGetImageFromCurrentImageContext();
//    UIGraphicsEndImageContext();
    [_itemArray addObject:_item2];
    
    _item3 = [Item new];
    _item3.itemName = @"七五三";
    _item3.itemImage =[UIImage imageNamed:@"753.png"];
     [_item3.itemImage drawInRect:CGRectMake(0, 0, width, height)];
    _item3.itemImage = UIGraphicsGetImageFromCurrentImageContext();
    [_itemArray addObject:_item3];
    
    _item4 = [Item new];
    _item4.itemName = @"初めての水遊び";
     _item4.itemImage =[UIImage imageNamed:@"水遊び.png"];
     [_item4.itemImage drawInRect:CGRectMake(0, 0, width, height)];
    _item4.itemImage = UIGraphicsGetImageFromCurrentImageContext();
    [_itemArray addObject:_item4];
    
    _item5 = [Item new];
    _item5.itemName = @"初めての幼稚園";
     _item5.itemImage =[UIImage imageNamed:@"入園式.png"];
     [_item5.itemImage drawInRect:CGRectMake(0, 0, width, height)];
    _item5.itemImage = UIGraphicsGetImageFromCurrentImageContext();
     UIGraphicsEndImageContext();
     [_itemArray addObject:_item5];
    

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)insertNewObject:(id)sender
{
    if (!_objects) {
        _objects = [[NSMutableArray alloc] init];
    }
    [_objects insertObject:[NSDate date] atIndex:0];
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
    [self.tableView insertRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
}

#pragma mark - Table View

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    //return _objects.count;
    return [_itemArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
//
//    NSDate *object = _objects[indexPath.row];
//    cell.textLabel.text = [object description];
   
        Item  *item = _itemArray[indexPath.row];
        cell.textLabel.text = [item itemName];
    cell.imageView.image = [item itemImage];
    return cell;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [_objects removeObjectAtIndex:indexPath.row];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
    }
}

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"showDetail"]) {
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        NSDate *object = _objects[indexPath.row];
        [[segue destinationViewController] setDetailItem:object];
    }
}

- (IBAction)movieCreate:(id)sender {
}
@end
