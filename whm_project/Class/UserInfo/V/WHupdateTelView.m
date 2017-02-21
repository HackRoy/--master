//
//  WHupdateTelView.m
//  whm_project
//
//  Created by 王义国 on 16/10/24.
//  Copyright © 2016年 chenJw. All rights reserved.
//

#import "WHupdateTelView.h"
#import "UIColor+Hex.h"

@implementation WHupdateTelView
-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setUI];
    }
    
    return self;
}
-(void)setUI
{
    self.myImage = [[UIImageView alloc]init];
    self.myImage.frame = CGRectMake(CGRectGetWidth([UIScreen mainScreen].bounds)*0.25, 40, CGRectGetWidth([UIScreen mainScreen].bounds)*0.5, CGRectGetHeight([UIScreen mainScreen].bounds) * 0.4);
    self.myImage.image = [UIImage imageNamed:@"telephone.png"];
    [self addSubview:_myImage];
    
    //
    
    self.telText = [[UITextField alloc]init];
    self.telText.frame = CGRectMake(10, CGRectGetMaxY(self.myImage.frame)+20, CGRectGetWidth([UIScreen mainScreen].bounds)*0.6, 36);
    self.telText.placeholder = @"新手机号";
    self.telText.borderStyle = UITextBorderStyleNone;
    self.telText.clearButtonMode = UITextFieldViewModeWhileEditing;
    self.telImage = [[UIImageView alloc]init];
    self.telImage.frame = CGRectMake(0, 0, 30, 30);
    self.telImage.image = [UIImage imageNamed:@"Jw_mob"];
    self.telText.leftView = self.telImage;
    self.telText.leftViewMode = UITextFieldViewModeAlways;
    self.telText.keyboardType = UIKeyboardTypeNumberPad;
    
    self.lineView = [[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(self.telText.frame)    , CGRectGetWidth([UIScreen mainScreen].bounds), 1)];
    self.lineView.backgroundColor = [UIColor colorWithRed:0.871 green:0.875 blue:0.878 alpha:1];
    
    [self addSubview:_lineView];
    
    
    [self addSubview:_telText];

    
    //
    self.codeBut = [UIButton buttonWithType:(UIButtonTypeSystem)];
    self.codeBut.frame = CGRectMake(CGRectGetMaxX(self.telText.frame)+5, CGRectGetMinY(self.telText.frame), CGRectGetWidth([UIScreen mainScreen].bounds)*0.3, CGRectGetHeight(self.telText.frame)-3);
    self.codeBut.layer.cornerRadius = 15;
    //  self.codeBut.backgroundColor = [UIColor colorWithRed:0.234 green:0.332 blue:0.996 alpha:1];
    [self.codeBut setTitle:@"获取验证码" forState:(UIControlStateNormal)];
    [self.codeBut  setTintColor:[UIColor blueColor]];
    
    [self addSubview:_codeBut];
    
    //
    self.codeText = [[UITextField alloc]init];
    self.codeText.frame = CGRectMake(10, CGRectGetMaxY(self.telText.frame)+10, CGRectGetWidth(self.telText.frame), CGRectGetHeight(self.telText.frame));
    self.codeText.placeholder = @"验证码";
    self.codeText.borderStyle = UITextBorderStyleNone;
    self.codeText.clearButtonMode = UITextFieldViewModeWhileEditing;
    self.codeImage = [[UIImageView alloc]init];
    self.codeImage.frame = CGRectMake(0, 0, 30, 30);
    self.codeImage.image = [UIImage imageNamed:@"Jw_yanzheng"];
    self.codeText.leftView = self.codeImage;
    self.codeText.leftViewMode = UITextFieldViewModeAlways;
    self.codeText.keyboardType = UIKeyboardTypeNumberPad;
    
    self.lineView2 = [[UIView alloc]init];
    self.lineView2.frame = CGRectMake(0, CGRectGetMaxY(self.codeText.frame), CGRectGetWidth(self.lineView.frame), 1);
    self.lineView2.backgroundColor = [UIColor colorWithRed:0.871 green:0.875 blue:0.878 alpha:1];
    
    [self addSubview:_lineView2];
    
    [self addSubview:_codeText];
    //
    self.timeLaber = [[UILabel alloc]init];
    self.timeLaber.frame = CGRectMake(CGRectGetMaxX(self.codeText.frame)+25, CGRectGetMinY(self.codeText.frame)-3, CGRectGetWidth(self.codeBut.frame), CGRectGetHeight(self.codeBut.frame));
    self.timeLaber.text = @"60s";
    self.timeLaber.textColor = [UIColor grayColor];
    
    self.timeLaber.layer.cornerRadius = 15.0;
    self.timeLaber.layer.masksToBounds = YES;
    // self.timeLaber.backgroundColor = [UIColor colorWithRed:0.871 green:0.875 blue:0.878 alpha:1];
    [self addSubview:_timeLaber];
    
    self.nextBut = [UIButton buttonWithType:(UIButtonTypeSystem)];
    self.nextBut.frame = CGRectMake(30, CGRectGetMaxY(self.lineView2.frame)+30, CGRectGetWidth([UIScreen mainScreen].bounds)-60, CGRectGetHeight(self.telText.frame)*1.2);
    [self.nextBut setTitle:@"提交" forState:(UIControlStateNormal)];
    self.nextBut.backgroundColor = [UIColor colorWithHex:0x4367FF ];
    
    self.nextBut.layer.shadowOffset = CGSizeMake(1, 1);
    self.nextBut.layer.shadowOpacity = 0.8;
    self.nextBut.layer.shadowColor = [UIColor colorWithHex:0x4367FF ].CGColor;
    
    [self.nextBut setTintColor:[UIColor whiteColor]];
    self.nextBut.layer.cornerRadius = 20.0;
    [self addSubview:_nextBut];


    
}


@end
