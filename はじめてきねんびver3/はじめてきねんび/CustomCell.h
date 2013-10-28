//
//  CustomCell.h
//  はじめてきねんび
//
//  Created by Jin Sasaki on 2013/08/22.
//  Copyright (c) 2013年 Ueda Junya. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustomCell : UICollectionViewCell
{
    __weak IBOutlet UILabel *labelDate;
    __weak IBOutlet UILabel *labelDays;
    __weak IBOutlet UIButton *imageButton;
}
- (void)setImage:(UIImage *)image;
- (void)setDate:(NSDate *)date;
//- (void)setDays:(NSDate *)date addBirrhday:(NSDate *)birhday;
- (UIButton *) button;
- (void)setDays_str:(NSString *)str;
<<<<<<< HEAD
=======
-(void)setDate_str:(NSString *)str;
>>>>>>> c790d9e6035e54d720f2190c24558fc269bf64db

@end
