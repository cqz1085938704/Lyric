//
//  CustomCell.m
//  Lyric
//
//  Created by caiyao's Mac on 15/9/8.
//  Copyright (c) 2015年 core's Mac. All rights reserved.
//

#import "CustomCell.h"

@implementation CustomCell

//-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
//{
//    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])
//    {
//        self.separatorInset = UIEdgeInsetsMake(0, 0, 0, 0);
//    }
//    return self;
//}

-(void)layoutSubviews
{
    [super layoutSubviews];
    
    self.imageView.frame = CGRectMake(10, 10, [UIScreen mainScreen].bounds.size.width - 20, self.frame.size.height - 20);
}

@end
