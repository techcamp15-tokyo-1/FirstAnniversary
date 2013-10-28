//
//  CustomCell.m
//  はじめてきねんび
//
//  Created by Jin Sasaki on 2013/08/22.
//  Copyright (c) 2013年 Ueda Junya. All rights reserved.
//

#import "CustomCell.h"

@implementation CustomCell
{
    NSDateFormatter *df;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (UIButton *) button {
    return imageButton;
}

- (void)setImage:(UIImage *)image
{
    [imageButton setBackgroundImage:image forState:UIControlStateNormal];
}

- (void)setDate:(NSDate *)date
{
    df =  [[NSDateFormatter alloc]init];
    df.dateFormat = @"yyyy/MM/dd";
    [labelDate setText: [df stringFromDate:date]];
}
//- (void)setDays:(NSDate *)date addBirthday:(NSDate *)birthday
//{
//    NSString *days = [self calcDaysAsString:date :birthday];
//    [labelDays setText: days];
//}
-(void)setDays_str:(NSString *)str{
    [labelDays setText:str];
}

//-(void)setLabels:(NSDate *)date addBirhday:(NSDate *)birhday{
//    [self setDays:date:birhday];
//    [self setDate:date];
//}

- (NSString *)calcDaysAsString :(NSDate *)date :(NSDate *)birthday{
    NSTimeInterval days = [date timeIntervalSinceDate:birthday] / 24 / 60 / 60;
    NSLog(@"%.0f日",days);
    return [NSString stringWithFormat:@"%.0f日",days];
}


/*
- (void)setImage:(UIImage *)image
{
    [imageView setImage:image];
}
*/

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
