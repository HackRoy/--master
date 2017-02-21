//
//  WHcredEntView.m
//  whm_project
//
//  Created by 王义国 on 16/12/15.
//  Copyright © 2016年 chenJw. All rights reserved.
//

#import "WHcredEntView.h"
#import "MacroUtility.h"
#import "UIColor+Hex.h"

@implementation WHcredEntView
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
    //姓名
    self.ProNumText = [[UITextField alloc]init];
    self.ProNumText.frame = CGRectMake(20, kScreenHeight* 0.035, kScreenWitdh - 40, 46);
    self.ProNumText.placeholder = @" 请输入你的真实姓名";
    self.ProNumText.borderStyle = UITextBorderStyleNone;
    self.ProNumText.clearButtonMode = UITextFieldViewModeWhileEditing;
    self.ProImg = [[UIImageView alloc]init];
    self.ProImg.frame = CGRectMake(0, 0, 20, 20);
    self.ProImg.image = [UIImage imageNamed:@"Hm_name"];
    self.ProNumText.leftView = self.ProImg;
    self.ProNumText.leftViewMode = UITextFieldViewModeAlways;
    //self.ProNumText.keyboardType = UIKeyboardTypeNumberPad;
    self.lineView = [[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(self.ProNumText.frame)    , CGRectGetWidth([UIScreen mainScreen].bounds), 1)];
    self.lineView.backgroundColor = [UIColor colorWithHex:0xD9D9D9];
    
    self.ProNumText.textColor = [UIColor lightGrayColor];
    [self addSubview:_lineView];
    [self addSubview:_ProNumText];
    //身份证号
    
        self.comNameText = [[UITextField alloc]init];
    self.comNameText.frame = CGRectMake(20, CGRectGetMaxY(self.lineView.frame)+10 , CGRectGetWidth(self.ProNumText.frame), 46);
    self.comNameText.placeholder = @" 你的身份证号";
    self.comNameText.borderStyle = UITextBorderStyleNone;
    self.comNameText.clearButtonMode = UITextFieldViewModeWhileEditing;
    self.comImg = [[UIImageView alloc]init];
    self.comImg.frame = CGRectMake(0, 0, 20, 20);
    self.comImg.image = [UIImage imageNamed:@"Hm_card"];
    self.comNameText.leftView = self.comImg;
    self.comNameText.leftViewMode = UITextFieldViewModeAlways;
     self.comNameText.keyboardType = UIKeyboardTypeNumberPad;
    self.lineView1 = [[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(self.comNameText.frame)    , CGRectGetWidth([UIScreen mainScreen].bounds), 1)];
    self.lineView1.backgroundColor = [UIColor colorWithHex:0xD9D9D9];
    self.comNameText.textColor = [UIColor lightGrayColor];

    [self addSubview:_lineView1];
    [self addSubview:_comNameText];
     
    
    //请选择公司
    self.peopText = [[UILabel alloc]init];
    self.peopText.frame = CGRectMake(46, CGRectGetMaxY(self.lineView1.frame)+10 , CGRectGetWidth(self.ProNumText.frame)*0.6, 46);
    self.peopText.text = @"  请选择保险公司";
    //self.peopText.placeholder = @" 选择保险公司";
    //self.peopText.borderStyle = UITextBorderStyleNone;
   // self.peopText.clearButtonMode = UITextFieldViewModeWhileEditing;
    self.peopText.textColor = [UIColor lightGrayColor];
    self.peopImg = [[UIImageView alloc]init];
    self.peopImg.frame = CGRectMake(20, CGRectGetMaxY(self.lineView1.frame)+20, 25, 25);
    self.peopImg.image = [UIImage imageNamed:@"Hm_peop"];
    //self.peopText.leftView = self.peopImg;
    //self.peopText.leftViewMode = UITextFieldViewModeAlways;
    // self.peopText.keyboardType = UIKeyboardTypeNumberPad;
    self.lineView2 = [[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(self.peopText.frame)    , CGRectGetWidth([UIScreen mainScreen].bounds), 1)];
    self.lineView2.backgroundColor = [UIColor colorWithHex:0xD9D9D9];
    self.cleckImg1 = [[UIImageView alloc]init];
    self.cleckImg1.frame = CGRectMake(CGRectGetWidth([UIScreen mainScreen].bounds)*0.9, CGRectGetMinY(self.peopImg.frame), 25, 25);
    //self.peopText.rightView = self.cleckImg1;
   // self.peopText.rightViewMode = UITextFieldViewModeAlways;
    self.cleckImg1.image = [UIImage imageNamed:@"p_arrowleft"];
    
    [self addSubview:_peopImg];
    [self addSubview:_cleckImg1];
    [self addSubview:_lineView2];
    [self addSubview:_peopText];
    //所在机构
    self.nameText = [[UILabel alloc]init];
    self.nameText.frame = CGRectMake(46, CGRectGetMaxY(self.lineView2.frame)+10 , CGRectGetWidth(self.ProNumText.frame)*0.6, 46);
    self.nameText.text = @" 所在机构";
    //self.nameText.borderStyle = UITextBorderStyleNone;
   // self.nameText.clearButtonMode = UITextFieldViewModeWhileEditing;
    self.nameText.textColor = [UIColor lightGrayColor];
    
    self.nameImg = [[UIImageView alloc]init];
    self.nameImg.frame = CGRectMake(20, CGRectGetMaxY(self.lineView2.frame)+20, 25, 25);
    self.nameImg.image = [UIImage imageNamed:@"Hm_org"];
    //self.nameText.leftView = self.nameImg;
   // self.nameText.leftViewMode = UITextFieldViewModeAlways;
    self.lineView3 = [[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(self.nameText.frame)    , CGRectGetWidth([UIScreen mainScreen].bounds), 1)];
    self.cleckImg = [[UIImageView alloc]init];
    self.cleckImg.frame = CGRectMake(CGRectGetWidth([UIScreen mainScreen].bounds)*0.9, CGRectGetMinY(self.nameImg.frame), 25, 25);
    //self.nameText.rightView = self.cleckImg;
    self.cleckImg.image = [UIImage imageNamed:@"p_arrowleft"];
    self.lineView3.backgroundColor = [UIColor colorWithHex:0xD9D9D9];
    //self.nameText.rightViewMode = UITextFieldViewModeAlways;
    [self addSubview:_cleckImg];
    [self addSubview:_nameImg];
    [self addSubview:_lineView3];
    [self addSubview:_nameText];
    //公司地址
    self.beneText = [[UITextField alloc]init];
    self.beneText.frame = CGRectMake(20, CGRectGetMaxY(self.lineView3.frame)+10 , CGRectGetWidth(self.ProNumText.frame), 46);
    self.beneText.placeholder = @" 公司地址";
    self.beneText.textColor = [UIColor lightGrayColor];
    self.beneText.borderStyle = UITextBorderStyleNone;
    self.beneText.clearButtonMode = UITextFieldViewModeWhileEditing;
    self.beneImg = [[UIImageView alloc]init];
    self.beneImg.frame = CGRectMake(0, 0, 20, 20);
    self.beneImg.image = [UIImage imageNamed:@"Hm_address"];
    self.beneText.leftView = self.beneImg;
    self.beneText.leftViewMode = UITextFieldViewModeAlways;
    self.lineView4 = [[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(self.beneText.frame)    , CGRectGetWidth([UIScreen mainScreen].bounds), 1)];
    self.lineView4.backgroundColor = [UIColor colorWithHex:0xD9D9D9];
    
    [self addSubview:_lineView4];
    [self addSubview:_beneText];
    
    //职务
    
    self.dateText = [[UITextField alloc]init];
    self.dateText.frame = CGRectMake(20, CGRectGetMaxY(self.lineView4.frame)+10 , CGRectGetWidth(self.ProNumText.frame), 46);
    self.dateText.placeholder = @" 请输入你的职务";
    self.dateText.borderStyle = UITextBorderStyleNone;
    self.dateText.clearButtonMode = UITextFieldViewModeWhileEditing;
    self.dateImg = [[UIImageView alloc]init];
    self.dateImg.frame = CGRectMake(0, 0, 20, 20);
    self.dateImg.image = [UIImage imageNamed:@"Hm_pefer"];
    self.dateText.leftView = self.dateImg;
    self.dateText.leftViewMode = UITextFieldViewModeAlways;
    self.lineView5 = [[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(self.dateText.frame)    , CGRectGetWidth([UIScreen mainScreen].bounds), 1)];
    self.lineView5.backgroundColor = [UIColor colorWithHex:0xD9D9D9];
    
    self.dateText.textColor = [UIColor lightGrayColor];
   
    
    [self addSubview:_lineView5];
    [self addSubview:_dateText];
    //你的擅长
    
    self.likeText = [[UITextField alloc]init];
    self.likeText.frame = CGRectMake(20, CGRectGetMaxY(self.lineView5.frame)+10, CGRectGetWidth(self.ProNumText.frame), 46);
    self.likeText.placeholder = @"  请输入你的擅长";
    self.likeText.borderStyle = UITextBorderStyleNone;
    self.likeText.clearButtonMode = UITextFieldViewModeWhileEditing;
    self.likeImg = [[UIImageView alloc]init];
    self.likeImg.frame = CGRectMake(0, 0, 20, 20);
    self.likeText.leftView = self.likeImg;
    self.likeImg.image = [UIImage imageNamed:@"Wh_like"];
    self.likeText.leftViewMode = UITextFieldViewModeAlways;
    self.lineView6 = [[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(self.likeText.frame), CGRectGetWidth([UIScreen mainScreen].bounds), 1)];
    self.lineView6.backgroundColor = [UIColor colorWithHex:0xD9D9D9];
    
    [self addSubview:_lineView6];
    [self addSubview:_likeText];
    
    self.likeText.textColor = [UIColor lightGrayColor];
    
    
    //确认按钮
    self.nextBut = [UIButton buttonWithType:(UIButtonTypeSystem)];
    self.nextBut.frame = CGRectMake(30, CGRectGetMaxY(self.lineView6.frame)+10, CGRectGetWidth([UIScreen mainScreen].bounds)-60, CGRectGetHeight(self.nameText.frame)*0.85);
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
