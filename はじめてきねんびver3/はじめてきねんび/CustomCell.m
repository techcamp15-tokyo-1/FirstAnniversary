//
//  CustomCell.m
//  はじめてきねんび
//
//  Created by Jin Sasaki on 2013/08/22.
//  Copyright (c) 2013年 Ueda Junya. All rights reserved.
//

#import "CustomCell.h"

@implementation CustomCell

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
- (void)setDate:(UILabel *)label
{
    [labelDate setText:label.text ];
}
- (void)setDays:(UILabel *)label
{
    [labelDays setText:label.text ];
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
