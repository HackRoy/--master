//
//  ForgetPwdView.m
//  kuaibaoAPP
//
//  Created by 王义国 on 16/10/8.
//  Copyright © 2016年 王义国. All rights reserved.
//

#import "ForgetPwdView.h"

#import "UIColor+Hex.h"
@implementation ForgetPwdView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setUI];
    }
    return self;
}
-(void)setUI
{

    self.telText = [[UITextField alloc]init];
    self.telText.frame = CGRectMake(10, CGRectGetHeight([UIScreen mainScreen].bounds)*0.045, CGRectGetWidth([UIScreen mainScreen].bounds)*0.9, 36);
    self.telText.placeholder = @"   请输入手机号";
    self.telText.borderStyle = UITextBorderStyleNone;
    self.telText.clearButtonMode = UITextFieldViewModeWhileEditing;
    self.telImage = [[UIImageView alloc]init];
    self.telImage.frame = CGRectMake(0, 0, 20, 20);
    self.telImage.image = [UIImage imageNamed:@"Jw_mob"];
    self.telText.leftView = self.telImage;
    self.telText.leftViewMode = UITextFieldViewModeAlways;
    self.telText.keyboardType = UIKeyboardTypeNumberPad;
    
    self.lineView = [[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(self.telText.frame)    , CGRectGetWidth([UIScreen mainScreen].bounds), 1)];
    self.lineView.backgroundColor = [UIColor colorWithRed:0.871 green:0.875 blue:0.878 alpha:1];
    self.telText.font = [UIFont systemFontOfSize:15.0];
    
    [self addSubview:_lineView];
    
    
    [self addSubview:_telText];
//
       //
    self.codeText = [[UITextField alloc]init];
    self.codeText.frame = CGRectMake(10, CGRectGetMaxY(self.telText.frame)+10, CGRectGetWidth(self.telText.frame)*0.6, CGRectGetHeight(self.telText.frame));
    self.codeText.placeholder = @"   请输入验证码";
    self.codeText.borderStyle = UITextBorderStyleNone;
    self.codeText.clearButtonMode = UITextFieldViewModeWhileEditing;
    self.codeImage = [[UIImageView alloc]init];
    self.codeImage.frame = CGRectMake(0, 0, 20, 20);
    self.codeImage.image = [UIImage imageNamed:@"Jw_yanzheng"];
    self.codeText.leftView = self.codeImage;
    self.codeText.leftViewMode = UITextFieldViewModeAlways;
    self.codeText.keyboardType = UIKeyboardTypeNumberPad;
    self.codeText.font = [UIFont systemFontOfSize:15.0];
    
    self.lineView2 = [[UIView alloc]init];
    self.lineView2.frame = CGRectMake(0, CGRectGetMaxY(self.codeText.frame), CGRectGetWidth(self.lineView.frame), 1);
    self.lineView2.backgroundColor = [UIColor colorWithRed:0.871 green:0.875 blue:0.878 alpha:1];

    [self addSubview:_lineView2];
    
    [self addSubview:_codeText];
    self.codeBut = [UIButton buttonWithType:(UIButtonTypeSystem)];
    self.codeBut.frame = CGRectMake(CGRectGetMaxX(self.codeText.frame)+5, CGRectGetMinY(self.codeText.frame)-2, CGRectGetWidth([UIScreen mainScreen].bounds)*0.3, CGRectGetHeight(self.telText.frame)-3);
    self.codeBut.layer.cornerRadius = 15;
    //  self.codeBut.backgroundColor = [UIColor colorWithRed:0.234 green:0.332 blue:0.996 alpha:1];
    [self.codeBut setTitle:@"获取验证码" forState:(UIControlStateNormal)];
    [self.codeBut  setTintColor:[UIColor blueColor]];
    
    [self addSubview:_codeBut];

    
    //
    
//    self.timeLaber = [[UILabel alloc]init];
//    self.timeLaber.frame = CGRectMake(CGRectGetMaxX(self.codeText.frame)+25, CGRectGetMinY(self.codeText.frame)-3, CGRectGetWidth(self.codeBut.frame), CGRectGetHeight(self.codeBut.frame));
//    self.timeLaber.text = @"60s";
//    self.timeLaber.textColor = [UIColor grayColor];
//    self.timeLaber.font = [UIFont systemFontOfSize:13.0];
//    self.timeLaber.layer.cornerRadius = 15.0;
//    self.timeLaber.layer.masksToBounds = YES;
//   // self.timeLaber.backgroundColor = [UIColor colorWithRed:0.871 green:0.875 blue:0.878 alpha:1];
//    [self addSubview:_timeLaber];

    //
    self.passWordText = [[UITextField alloc]init];
    self.passWordText.frame = CGRectMake(10, CGRectGetMaxY(self.codeText.frame)+10, CGRectGetWidth([UIScreen mainScreen].bounds)-20, CGRectGetHeight(self.telText.frame));
    self.passWordText.placeholder = @"   请输入密码(8-20位)";
    self.passWordText.borderStyle = UITextBorderStyleNone;
    self.passWordText.clearButtonMode = UITextFieldViewModeWhileEditing;
    self.passWordImage = [[UIImageView alloc]init];
    self.passWordImage.frame = CGRectMake(0, 0, 20, 20);
    self.passWordImage.image = [UIImage imageNamed:@"Jw_lock"];
    self.passWordText.leftView = self.passWordImage;
    self.passWordText.leftViewMode = UITextFieldViewModeAlways;
    self.passWordText.secureTextEntry = YES;
    self.lineView3 = [[UIView alloc]init];
    self.lineView3.frame = CGRectMake(0, CGRectGetMaxY(self.passWordText.frame), CGRectGetWidth(self.lineView.frame), 1);
    self.lineView3.backgroundColor = [UIColor colorWithRed:0.871 green:0.875 blue:0.878 alpha:1];
   
    self.passWordText.font = [UIFont systemFontOfSize:15.0];
    
    [self addSubview:_lineView3];
    
    [self addSubview:_passWordText];
    //
    self.truePassText = [[UITextField alloc]init];
    self.truePassText.frame = CGRectMake(10, CGRectGetMaxY(self.passWordText.frame)+10, CGRectGetWidth(self.passWordText.frame), CGRectGetHeight(self.passWordText.frame));
    
    self.truePassText.placeholder = @"   再次确认您的密码(8-20位)";
    self.truePassText.borderStyle = UITextBorderStyleNone;
    self.truePassText.clearButtonMode = UITextFieldViewModeWhileEditing;
    self.truePassImage = [[UIImageView alloc]init];
    self.truePassImage.frame = CGRectMake(0, 0, 20, 20);
    self.truePassImage.image = [UIImage imageNamed:@"Jw_passwd"];
    self.truePassText.leftView = self.truePassImage;
    self.truePassText.leftViewMode = UITextFieldViewModeAlways;
    self.truePassText.secureTextEntry = YES;
    
    self.truePassText.font = [UIFont systemFontOfSize:15.0];
    //
    self.lineView4 = [[UIView alloc]init];
    self.lineView4.frame = CGRectMake(0, CGRectGetMaxY(self.truePassText.frame), CGRectGetWidth(self.lineView.frame), 1);
    
    self.lineView4.backgroundColor = [UIColor colorWithRed:0.871 green:0.875 blue:0.878 alpha:1];
    
    [self addSubview:_lineView4];
    
    
    [self addSubview:_truePassText];

    //
    //
    
    self.nextBut = [UIButton buttonWithType:(UIButtonTypeSystem)];
    self.nextBut.frame = CGRectMake(30, CGRectGetMaxY(self.truePassText.frame)+30, CGRectGetWidth([UIScreen mainScreen].bounds)-60, CGRectGetHeight(self.telText.frame)*1.2);
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
