//
//  TimeLineViewController.h
//  はじめてきねんび
//
//  Created by Jin Sasaki on 2013/08/23.
//  Copyright (c) 2013年 Ueda Junya. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CustomCell.h"
#import "DetailViewController.h"
#import "User.h"
#import "FileManager.h"
#import "Item.h"



@interface TimeLineViewController : UICollectionViewController <UINavigationControllerDelegate, UIImagePickerControllerDelegate>
- (IBAction)imageButton:(id)sender;
- (IBAction)libraryButtonTapped:(id)sender;
@end
