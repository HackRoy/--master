//
//  LYTitleView.m
//  MYPage
//
//  Created by 赵良育 on 2016/11/10.
//  Copyright © 2016年 赵良育. All rights reserved.
//

#import "LYTitleView.h"
#import "lhCircleView.h"

@interface LYTitleView ()
/**
 *  🐶view    👇
 */
@property(nonatomic,weak)lhCircleView * view;

@end

@implementation LYTitleView
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
       
        [self p_setOtherView];
    }
    return self;
}
-(void)p_setOtherView
{
    CGPoint center = self.center;
    center.y -= 5;
    lhCircleView * view = [[lhCircleView alloc]initWithFrame:CGRectMake(0, 0, 180, 180)];
    view.center = center;
    
    self.view = view;
    [self addSubview:view];
}
-(void)p_setProgressValue:(CGFloat)progressValue
{
    self.view.progressValue = progressValue / 100;
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [super touchesBegan:touches withEvent:event];
    
//    self.view.progressValue =600.f/1000;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
//-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
//{
//    [super touchesBegan:touches withEvent:event];
//
//    NSLog(@"点击了头部的view");
//}
@end
