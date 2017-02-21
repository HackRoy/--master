//
//  AddPicCollectionViewCell.m
//  动态添加图片
//
//  Created by 李帅 on 2016/11/1.
//  Copyright © 2016年 shuaili. All rights reserved.
//

#import "AddPicCollectionViewCell.h"

#define kScreenW [[UIScreen mainScreen] bounds].size.width
@implementation AddPicCollectionViewCell


-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        
        self.addBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        self.addBtn.frame = CGRectMake(0, 0, (kScreenW - 45) / 2, (kScreenW - 45) / 2);
        //self.addBtn.backgroundColor = [UIColor blackColor];
        [self addSubview:_addBtn];
        
    }
    return self;
}




@end
