//
//  WHlhCircleView.m
//  whm_project
//
//  Created by 王义国 on 16/11/17.
//  Copyright © 2016年 chenJw. All rights reserved.
//

#import "WHlhCircleView.h"
#import <UIImageView+WebCache.h>


@interface WHlhCircleView ()
{
    CGPoint center;//中心点
    UILabel * twoLabel;
}
@end

@implementation WHlhCircleView
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self) {

       // center = CGPointMake(CGRectGetWidth(self.bounds)/2, CGRectGetHeight(self.bounds)/2);
        
        [self p_setView];

    }
    return self;
}
-(void)getTit:(NSString *)title
{
    self.titLebar.text = title;
    
}
-(void)getImage:(NSString *)img
{
    [self.MyImg sd_setImageWithURL:[NSURL URLWithString:img]];
}

-(void)p_setView
{
    self.contentLabel = [[UILabel alloc]init];
    self.contentLabel.frame = CGRectMake(0, 0, CGRectGetWidth(self.frame)/2.3, CGRectGetWidth(self.frame) / 5);
    CGPoint currentCenter = self.center;
    self.contentLabel.center = CGPointMake(currentCenter.x, currentCenter.y - 20);
    self.contentLabel.font = [UIFont systemFontOfSize:25];
    [self.contentLabel setTextColor:[UIColor colorWithRed:253/255.0 green:90/255.0 blue:86/255.0 alpha:1]];
    self.contentLabel.textAlignment = NSTextAlignmentCenter;
    //    self.contentLabel.backgroundColor = [UIColor redColor];
    self.contentLabel.text = @"";
    [self addSubview:_contentLabel];
    //
    self.titLebar = [[UILabel alloc]init];
    self.titLebar.frame = CGRectMake(0,0, CGRectGetWidth([UIScreen mainScreen].bounds)*0.5, 30);
   // self.titLebar.text = @"中国人帮保险公司详情";
    self.telLaber.font = [UIFont systemFontOfSize:15.0];
    self.titLebar.textColor = [UIColor whiteColor];
    [self addSubview:_titLebar];
    //
    self.MyImg = [[UIImageView alloc]init];
    self.MyImg.frame = CGRectMake(CGRectGetWidth(self.frame)*0.30, CGRectGetWidth(self.frame)*0.25, CGRectGetWidth(self.frame) / 2, CGRectGetWidth(self.frame) / 2);
   // self.MyImg.image = [UIImage imageNamed:@"message"];
    
    [self addSubview:_MyImg];
    
    //
    self.telLaber = [[UILabel alloc]init];
    self.telLaber.frame = CGRectMake(CGRectGetWidth(self.frame)*0.25, CGRectGetMaxY(self.MyImg.frame)+5, CGRectGetWidth(self.MyImg.frame)*1.5, 20);
    self.telLaber.font = [UIFont systemFontOfSize:13.0];
    self.telLaber.text = @"客户电话:955588";
    [self addSubview:_telLaber];
    

    
}
@end
