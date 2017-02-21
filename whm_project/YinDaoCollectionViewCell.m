//
//  YinDaoCollectionViewCell.m
//  zheShiGeHaoRuanJian
//
//  Created by Stephy_xue on 16/11/4.
//  Copyright © 2016年 henankuibu. All rights reserved.
//

#import "YinDaoCollectionViewCell.h"

@implementation YinDaoCollectionViewCell


-(instancetype)initWithFrame:(CGRect)frame
{
    self=[super initWithFrame:frame];
    
    if (self)
    {
     
        [self creatView];
        
    }
    return self;
}


-(void)creatView
{
    self.img=[[UIImageView alloc] initWithFrame:CGRectMake(0, 0, wScreenW, wScreenH)];
    
    
    [self addSubview:self.img];
}










@end
