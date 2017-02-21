//
//  insuranceCollectionViewCell.m
//  小胖的demo
//
//  Created by YiTu8 on 2016/10/19.
//  Copyright © 2016年 shuaili. All rights reserved.
//

#import "insuranceCollectionViewCell.h"


#define kScreenW [[UIScreen mainScreen] bounds].size.width

@implementation insuranceCollectionViewCell



-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        
       
        
        self.completeImage = [[UIImageView alloc]initWithFrame:CGRectMake(20, 25, kScreenW/3 - 40, kScreenW/3 - 75)];
        //self.completeImage.backgroundColor = [UIColor redColor];
        [self.contentView addSubview:_completeImage];
        
        
        
        self.completeLab = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMinX(_completeImage.frame), CGRectGetMaxY(_completeImage.frame) + 10, kScreenW/3 - 40, 30)];
        self.completeLab.textAlignment = NSTextAlignmentCenter;
        self.completeLab.textColor = [UIColor colorWithRed:111/255.0 green:111/255.0  blue:111/255.0  alpha:1.0];
        //self.completeLab.layer.borderColor=[[UIColor grayColor]CGColor];  //边框的颜色
        
        //self.completeLab.layer.borderWidth = 0.5; //边框的宽度
        
        //给label的边框设置圆角
        
        self.completeLab.layer.masksToBounds = YES;
        self.completeLab.font = [UIFont systemFontOfSize:14];
        self.completeLab.backgroundColor = [UIColor clearColor];
        self.completeLab.layer.cornerRadius = 2;  //设置圆角大小
        [self.contentView addSubview:_completeLab];
        
    }
    return self;
}








@end
