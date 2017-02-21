
//
//  CustomProgress.m
//  WisdomPioneer
//
//  Created by 主用户 on 16/4/11.
//  Copyright © 2016年 江萧. All rights reserved.
//

#import "CustomProgress.h"

@implementation CustomProgress
//@synthesize bgimg,leftimg,presentlab,mylaber,Img1,bgimg1,leftimg1,presentlab1,mylaber1,Img2;
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        _bgimg = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
        _bgimg.layer.borderColor = [UIColor clearColor].CGColor;
        _bgimg.layer.borderWidth =  1;
        //bgimg.layer.cornerRadius = 5;
        [_bgimg.layer setMasksToBounds:YES];

        [self addSubview:_bgimg];
        _leftimg = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 0, self.frame.size.height)];
        _leftimg.layer.borderColor = [UIColor clearColor].CGColor;
        _leftimg.layer.borderWidth =  1;
       // leftimg.layer.cornerRadius = 5;
        [_leftimg.layer setMasksToBounds:YES];
        [self addSubview:_leftimg];
        
        _presentlab = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth([UIScreen mainScreen].bounds)*0.3, self.frame.size.height)];
        _presentlab.textAlignment = NSTextAlignmentCenter;
        
        _presentlab.textColor = [UIColor whiteColor];
        _presentlab.font = [UIFont systemFontOfSize:12];
        [self addSubview:_presentlab];

        _mylaber = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetWidth([UIScreen mainScreen].bounds)*0.31, 0,CGRectGetWidth([UIScreen mainScreen].bounds)*0.1 , self.frame.size.height)];
        _mylaber.font = [UIFont systemFontOfSize:13.0];
        [self addSubview:_mylaber];
        
        _Img1 = [[UIImageView alloc]init];
        _Img1.frame = CGRectMake(0, self.frame.size.height, self.frame.size.width, 5);
        _Img1.image = [UIImage imageNamed:@"img1"];
        [self addSubview:_Img1];
           
    }
    return self;
}
-(void)setPresent:(int)present title:(NSString *)title labelText:(NSString *)labelText;
{
    //presentlab.text = [NSString stringWithFormat:@"%d/20",present];
    _presentlab.text = title;
    _mylaber.text = labelText;
    _leftimg.frame = CGRectMake(0, 0, self.frame.size.width/self.maxValue*present, self.frame.size.height);
    //
   
  
}

@end
