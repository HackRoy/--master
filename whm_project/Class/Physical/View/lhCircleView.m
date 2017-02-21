//
//  lhCircleView.m
//  LHNormalTest
//
//  Created by bosheng on 16/7/27.
//  Copyright © 2016年 liuhuan. All rights reserved.
//

#import "lhCircleView.h"
#import "NSTimer+LHBlockSupport.h"

static const CGFloat progressStrokeWidth = 3;
static const CGFloat backStrokeWidth = 1;

@interface lhCircleView ()
{
    CAShapeLayer *backGroundLayer; //背景图层
    CAShapeLayer *twoBackGroundLayer;
    CAShapeLayer *threeBackGroundLayer;
    CAShapeLayer *fourBackGroundLayer;
    CAShapeLayer *frontFillLayer;//用来填充的图层
    UIBezierPath *backGroundBezierPath;//背景贝赛尔曲线
    UIBezierPath *twoBackGroundBezierPath;
    UIBezierPath *threeBackGroundBezierPath;
    UIBezierPath *fourBackGroundBezierPath;


    UIBezierPath *frontFillBezierPath;//用来填充的贝赛尔曲线
    
    UIColor *progressColor;//进度条颜色
    UIColor *progressTrackColor;//进度条轨道颜色
    UIColor *twoTrackColor;
    UIColor *threeTrackColor;
    UIColor *fourTrackColor;
    
    NSTimer * timer;//定时器用作动画
    CGPoint center;//中心点
    UILabel * twoLabel;
}

@end

@implementation lhCircleView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self) {
        progressColor = [UIColor colorWithRed:253/255.0 green:90/255.0 blue:86/255.0 alpha:1];
        progressTrackColor = [UIColor whiteColor];
        twoTrackColor = [UIColor colorWithWhite:1.0 alpha:0.7];
        threeTrackColor = [UIColor colorWithWhite:1.0 alpha:0.4];
        fourTrackColor = [UIColor colorWithWhite:1.0 alpha:0.1];


        //创建背景图层
        backGroundLayer = [CAShapeLayer layer];
        backGroundLayer.fillColor = nil;
        backGroundLayer.frame = [self withFrame:self.bounds number:1];

        twoBackGroundLayer = [CAShapeLayer layer];
        twoBackGroundLayer.fillColor = nil;
        twoBackGroundLayer.frame = [self withFrame:self.bounds number:10];

        threeBackGroundLayer = [CAShapeLayer layer];
        threeBackGroundLayer.fillColor = nil;
        threeBackGroundLayer.frame = [self withFrame:self.bounds number:19];

        fourBackGroundLayer = [CAShapeLayer layer];
        fourBackGroundLayer.fillColor = nil;
        fourBackGroundLayer.frame = self.bounds;
        
        //创建填充图层
        frontFillLayer = [CAShapeLayer layer];
        frontFillLayer.fillColor = nil;
        frontFillLayer.frame = self.bounds;
        
        frontFillLayer.strokeColor = progressColor.CGColor;
        backGroundLayer.strokeColor = progressTrackColor.CGColor;
        twoBackGroundLayer.strokeColor = twoTrackColor.CGColor;
        threeBackGroundLayer.strokeColor = threeTrackColor.CGColor;
        fourBackGroundLayer.strokeColor = fourTrackColor.CGColor;
        
        center = CGPointMake(CGRectGetWidth(self.bounds)/2, CGRectGetHeight(self.bounds)/2);
        
        backGroundBezierPath = [UIBezierPath bezierPathWithArcCenter:center radius:(CGRectGetWidth(self.bounds)-27)/2.f startAngle:0 endAngle:M_PI*2 clockwise:YES];
        backGroundLayer.path = backGroundBezierPath.CGPath;

        twoBackGroundBezierPath = [UIBezierPath bezierPathWithArcCenter:center radius:(CGRectGetWidth(self.bounds)-19)/2.f startAngle:0 endAngle:M_PI*2 clockwise:YES];
        twoBackGroundLayer.path = twoBackGroundBezierPath.CGPath;

        threeBackGroundBezierPath = [UIBezierPath bezierPathWithArcCenter:center radius:(CGRectGetWidth(self.bounds)-10)/2.f startAngle:0 endAngle:M_PI*2 clockwise:YES];
        threeBackGroundLayer.path = threeBackGroundBezierPath.CGPath;

        fourBackGroundBezierPath = [UIBezierPath bezierPathWithArcCenter:center radius:(CGRectGetWidth(self.bounds)-1)/2.f startAngle:0 endAngle:M_PI*2 clockwise:YES];
        fourBackGroundLayer.path = fourBackGroundBezierPath.CGPath;

        
        frontFillLayer.lineWidth = progressStrokeWidth;
        backGroundLayer.lineWidth = backStrokeWidth;
        twoBackGroundLayer.lineWidth = backStrokeWidth;
        threeBackGroundLayer.lineWidth = backStrokeWidth;
        fourBackGroundLayer.lineWidth = backStrokeWidth;

        

        
        [self.layer addSublayer:backGroundLayer];
        [self.layer addSublayer:twoBackGroundLayer];
        [self.layer addSublayer:threeBackGroundLayer];
        [self.layer addSublayer:fourBackGroundLayer];
        [self.layer addSublayer:frontFillLayer];

        [self p_setView];

    }
    
    return self;
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
    [self addSubview:_contentLabel];

    UILabel * otherLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.contentLabel.frame), CGRectGetMinY(self.contentLabel.frame), 20, 21)];
    otherLabel.font = [UIFont systemFontOfSize:10];
    otherLabel.text = @"分";
    otherLabel.textColor = [UIColor colorWithRed:253/255.0 green:90/255.0 blue:86/255.0 alpha:1];
    [self addSubview:otherLabel];
    

    twoLabel = [[UILabel alloc]init];
    twoLabel.frame = CGRectMake(0, 0, CGRectGetWidth(self.contentLabel.frame) + 20, CGRectGetHeight(self.contentLabel.frame) / 1.5);
    twoLabel.textAlignment = NSTextAlignmentCenter;
    twoLabel.textColor = [UIColor whiteColor];
    twoLabel.center = CGPointMake(currentCenter.x, currentCenter.y + 20);
    [self addSubview:twoLabel];

}

- (void)setProgressValue:(CGFloat)progressValue
{

    _progressValue = progressValue;
    
    if (timer) {
        [timer invalidate];
        timer = nil;
    }

    __weak typeof(self) wSelf = self;
    __block CGFloat progress = 0.0;
    timer = [NSTimer lh_scheduledTimerWithTimeInterval:0.01 block:^{
        
        if (progress >= _progressValue || progress >= 1.0f) {
            if (timer) {
                [timer invalidate];
                timer = nil;
            }
            return;
        }
        else{
            frontFillBezierPath = [UIBezierPath bezierPathWithArcCenter:center radius:(CGRectGetWidth(wSelf.bounds)-26)/2.f startAngle:-M_PI_2 endAngle:(2*M_PI)*progress-M_PI_2 clockwise:YES];
            frontFillLayer.path = frontFillBezierPath.CGPath;
        }
        progress += 0.01*(_progressValue);
        
        self.contentLabel.text = [NSString stringWithFormat:@"%.2f",progress*100];
        CGFloat myProgress =progress * 100;
        if ( myProgress>= 60 && myProgress <80) {
            twoLabel.text = @"— 合格 —";
        }else if(myProgress >= 80 && myProgress <90)
        {
            twoLabel.text = @"— 良好 —";
        }else if(myProgress >= 90)
        {
            twoLabel.text = @"— 优秀 —";
        }
        else if (myProgress == 0)
        {
            twoLabel.text = @"- 暂无数据 -";
        }
        else
        {
            twoLabel.text = @"— 不合格 —";
        }
        
    } repeats:YES];
    [[NSRunLoop currentRunLoop]addTimer:timer forMode:NSRunLoopCommonModes];
    
}
-(CGRect)withFrame:(CGRect)frame number:(CGFloat)number
{
    CGFloat  width = CGRectGetHeight(frame);
    CGFloat  height = CGRectGetWidth(frame);
    CGRect kFrame = CGRectMake(0, 0, width - number, height - number);
    return kFrame;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
