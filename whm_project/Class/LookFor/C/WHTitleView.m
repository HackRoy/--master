//
//  WHTitleView.m
//  whm_project
//
//  Created by 王义国 on 16/11/17.
//  Copyright © 2016年 chenJw. All rights reserved.
//

#import "WHTitleView.h"
#import "WHlhCircleView.h"

@interface WHTitleView()
@property(nonatomic,weak)WHlhCircleView * view;
@end

@implementation WHTitleView

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
    WHlhCircleView* view = [[WHlhCircleView alloc]initWithFrame:CGRectMake(0, 0, 180, 150)];
    view.center = center;
    
    self.view = view;
    [self addSubview:view];
}

-(void)titllaber:(NSString *)tle
{
    [self.view getTit:tle];
}
-(void)getImageImg:(NSString *)image
{
    [self.view getImage:image];
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [super touchesBegan:touches withEvent:event];

}




/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
