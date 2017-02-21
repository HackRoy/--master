//
//  PayTableViewCell.m
//  ShanXinZhiHuiYangLao
//
//  Created by Stephy_xue on 16/5/12.
//  Copyright © 2016年 HeNanGuiBuWangLuoGongSi. All rights reserved.
//

#import "PayTableViewCell.h"

@implementation PayTableViewCell
-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self=[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        self.bounds = CGRectMake(0, 0, wScreenW, 50);
        [self creatMyView];
    }
    return self;
}
-(void)creatMyView
{
    self.myLab=[[UILabel alloc] init];
    self.myLab.font=[UIFont systemFontOfSize:14];
    [self addSubview:_myLab];
    
    self.myrLab=[UILabel new];
    self.myrLab.font=[UIFont systemFontOfSize:12];
    self.myrLab.textColor=wOrangeColor;
    [self addSubview:_myrLab];
    
    self.img=[[UIImageView alloc] initWithFrame:CGRectMake(15, 15,self.bounds.size.height-30, self.bounds.size.height-30)];
    self.img.layer.masksToBounds=YES;
    self.img.layer.cornerRadius=(self.bounds.size.height-30)/2;
    [self addSubview:_img];
    
    self.upLab=[[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.img.frame)+10,0, wScreenW/2, self.bounds.size.height/2)];
    self.upLab.font=[UIFont systemFontOfSize:12];
    [self addSubview:_upLab];
    
    self.downLab=[[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.img.frame)+10, CGRectGetMaxY(self.upLab.frame), wScreenW/2, self.bounds.size.height/2)];
    self.downLab.font=[UIFont systemFontOfSize:10];
    self.downLab.textColor = wGrayColor2;
    [self addSubview:_downLab];
    
    self.myBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.myBtn.frame = CGRectMake(wScreenW - 30 - 20, 10, 30, 30);
    
    [self addSubview:self.myBtn];
    
}

@end
