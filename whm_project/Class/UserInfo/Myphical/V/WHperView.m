//
//  WHperView.m
//  whm_project
//
//  Created by 王义国 on 16/11/23.
//  Copyright © 2016年 chenJw. All rights reserved.
//

#import "WHperView.h"
#import "MacroUtility.h"
#import "UIColor+Hex.h"
@implementation WHperView

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
    //保单号
    self.ProNumText = [[UITextField alloc]init];
    self.ProNumText.frame = CGRectMake(20, kScreenHeight* 0.055, kScreenWitdh - 40, 46);
    self.ProNumText.placeholder = @" 请输入你的保单号";
    self.ProNumText.borderStyle = UITextBorderStyleNone;
    self.ProNumText.clearButtonMode = UITextFieldViewModeWhileEditing;
    self.ProImg = [[UIImageView alloc]init];
    self.ProImg.frame = CGRectMake(0, 0, 20, 20);
    self.ProImg.image = [UIImage imageNamed:@"baonum"];
    self.ProNumText.leftView = self.ProImg;
    self.ProNumText.leftViewMode = UITextFieldViewModeAlways;
    self.ProNumText.keyboardType = UIKeyboardTypeNumberPad;
    self.lineView = [[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(self.ProNumText.frame)    , CGRectGetWidth([UIScreen mainScreen].bounds), 1)];
    self.lineView.backgroundColor = [UIColor colorWithHex:0xD9D9D9];
    
    [self addSubview:_lineView];
    [self addSubview:_ProNumText];
   //公司名字
    
    self.comNameText = [[UITextField alloc]init];
    self.comNameText.frame = CGRectMake(20, CGRectGetMaxY(self.lineView.frame)+10 , CGRectGetWidth(self.ProNumText.frame), 46);
    self.comNameText.placeholder = @" 你的公司不能修改";
    self.comNameText.borderStyle = UITextBorderStyleNone;
    //self.comNameText.clearButtonMode = UITextFieldViewModeWhileEditing;
    self.comImg = [[UIImageView alloc]init];
    self.comImg.frame = CGRectMake(0, 0, 20, 20);
    self.comImg.image = [UIImage imageNamed:@"comname"];
    self.comNameText.leftView = self.comImg;
    self.comNameText.leftViewMode = UITextFieldViewModeAlways;
   // self.comNameText.keyboardType = UIKeyboardTypeNumberPad;
    self.lineView1 = [[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(self.comNameText.frame)    , CGRectGetWidth([UIScreen mainScreen].bounds), 1)];
    self.lineView1.backgroundColor = [UIColor colorWithHex:0xD9D9D9];
    
    [self addSubview:_lineView1];
    [self addSubview:_comNameText];
     //投保人
    self.peopText = [[UITextField alloc]init];
    self.peopText.frame = CGRectMake(20, CGRectGetMaxY(self.lineView1.frame)+10 , CGRectGetWidth(self.ProNumText.frame), 46);
    self.peopText.placeholder = @" 请输入投保人";
    self.peopText.borderStyle = UITextBorderStyleNone;
    self.peopText.clearButtonMode = UITextFieldViewModeWhileEditing;
    self.peopImg = [[UIImageView alloc]init];
    self.peopImg.frame = CGRectMake(0, 0, 20, 20);
    self.peopImg.image = [UIImage imageNamed:@"toubaoren"];
    self.peopText.leftView = self.peopImg;
    self.peopText.leftViewMode = UITextFieldViewModeAlways;
   // self.peopText.keyboardType = UIKeyboardTypeNumberPad;
    self.lineView2 = [[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(self.peopText.frame)    , CGRectGetWidth([UIScreen mainScreen].bounds), 1)];
    self.lineView2.backgroundColor = [UIColor colorWithHex:0xD9D9D9];
    
    [self addSubview:_lineView2];
    [self addSubview:_peopText];
    //姓名
    self.nameText = [[UITextField alloc]init];
    self.nameText.frame = CGRectMake(20, CGRectGetMaxY(self.lineView2.frame)+10 , CGRectGetWidth(self.ProNumText.frame), 46);
    self.nameText.placeholder = @" 保人不可修改";
    self.nameText.borderStyle = UITextBorderStyleNone;
    self.nameText.clearButtonMode = UITextFieldViewModeWhileEditing;
    self.nameImg = [[UIImageView alloc]init];
    self.nameImg.frame = CGRectMake(0, 0, 20, 20);
    self.nameImg.image = [UIImage imageNamed:@"xingming"];
    self.nameText.leftView = self.nameImg;
    self.nameText.leftViewMode = UITextFieldViewModeAlways;
    self.lineView3 = [[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(self.nameText.frame)    , CGRectGetWidth([UIScreen mainScreen].bounds), 1)];
    self.lineView3.backgroundColor = [UIColor colorWithHex:0xD9D9D9];
    
    [self addSubview:_lineView3];
    [self addSubview:_nameText];
   //受益人
    self.beneText = [[UITextField alloc]init];
    self.beneText.frame = CGRectMake(20, CGRectGetMaxY(self.lineView3.frame)+10 , CGRectGetWidth(self.ProNumText.frame), 46);
    self.beneText.placeholder = @" 请输入受益人";
    self.beneText.borderStyle = UITextBorderStyleNone;
    self.beneText.clearButtonMode = UITextFieldViewModeWhileEditing;
    self.beneImg = [[UIImageView alloc]init];
    self.beneImg.frame = CGRectMake(0, 0, 20, 20);
    self.beneImg.image = [UIImage imageNamed:@"bene"];
    self.beneText.leftView = self.beneImg;
    self.beneText.leftViewMode = UITextFieldViewModeAlways;
    self.lineView4 = [[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(self.beneText.frame)    , CGRectGetWidth([UIScreen mainScreen].bounds), 1)];
    self.lineView4.backgroundColor = [UIColor colorWithHex:0xD9D9D9];
    
    [self addSubview:_lineView4];
    [self addSubview:_beneText];
    
    //生效日期
    
    self.dateText = [[UILabel  alloc]init];
    self.dateText.frame = CGRectMake(46, CGRectGetMaxY(self.lineView4.frame)+10 , CGRectGetWidth(self.ProNumText.frame)*0.6, 46);
    self.dateText.text = @" 选择生效日期";
//    self.dateText.borderStyle = UITextBorderStyleNone;
//    self.dateText.clearButtonMode = UITextFieldViewModeWhileEditing;
    self.dateText.textColor = [UIColor lightGrayColor];
    
    self.dateImg = [[UIImageView alloc]init];
    self.dateImg.frame = CGRectMake(20,CGRectGetMaxY(self.lineView4.frame)+20, 25, 25);
    self.dateImg.image = [UIImage imageNamed:@"riqi"];
   // self.dateText.leftView = self.dateImg;
    //self.dateText.leftViewMode = UITextFieldViewModeAlways;
    self.lineView5 = [[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(self.dateText.frame)    , CGRectGetWidth([UIScreen mainScreen].bounds), 1)];
    self.lineView5.backgroundColor = [UIColor colorWithHex:0xD9D9D9];
    self.cleckImg = [[UIImageView alloc]init];
    self.cleckImg.frame = CGRectMake(CGRectGetWidth([UIScreen mainScreen].bounds)*0.9, CGRectGetMinY(self.dateImg.frame), 25, 25);
  //  self.dateText.rightView = self.cleckImg;
    self.cleckImg.image = [UIImage imageNamed:@"p_arrowleft"];
   // self.dateText.rightViewMode = UITextFieldViewModeAlways;
    [self addSubview:_dateImg];
    [self addSubview:_cleckImg];
    
    [self addSubview:_lineView5];
    [self addSubview:_dateText];

    //确认按钮
    self.nextBut = [UIButton buttonWithType:(UIButtonTypeSystem)];
    self.nextBut.frame = CGRectMake(30, CGRectGetMaxY(self.lineView5.frame)+10, CGRectGetWidth([UIScreen mainScreen].bounds)-60, CGRectGetHeight(self.nameText.frame)*0.85);
    [self.nextBut setTitle:@"确认提交" forState:(UIControlStateNormal)];
    self.nextBut.backgroundColor = [UIColor colorWithHex:0x4367FF ];
    
    self.nextBut.layer.shadowOffset = CGSizeMake(1, 1);
    self.nextBut.layer.shadowOpacity = 0.8;
    self.nextBut.layer.shadowColor = [UIColor colorWithHex:0x4367FF ].CGColor;
    
    [self.nextBut setTintColor:[UIColor whiteColor]];
    self.nextBut.layer.cornerRadius = 20.0;
    [self addSubview:_nextBut];


    
    
}



@end
