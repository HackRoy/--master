//
//  PicUpdateCollectionViewCell.m
//  动态添加图片
//
//  Created by WHM on 2016/11/1.
//  Copyright © 2016年 WHM. All rights reserved.
//

#import "PicUpdateCollectionViewCell.h"
#define kScreenW [[UIScreen mainScreen] bounds].size.width
@implementation PicUpdateCollectionViewCell


-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        
        self.picImage = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, (kScreenW - 45) / 2, (kScreenW - 45) / 2)];
        self.picImage.backgroundColor = [UIColor blueColor];
        self.picImage.layer.cornerRadius = 5;
        [self addSubview:_picImage];
       
        
        
    }
    return self;
}


@end
