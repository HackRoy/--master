//
//  WBYcaiwuTableViewCell.m
//  whm_project
//
//  Created by apple on 17/2/8.
//  Copyright © 2017年 chenJw. All rights reserved.
//

#import "WBYcaiwuTableViewCell.h"
#import "MacroUtility.h"
#import "UIColor+Hex.h"
@implementation WBYcaiwuTableViewCell
-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self=[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        [self creatMyView];
    }
    return self;
}

-(void)creatMyView
{
    CGFloat hh = self.bounds.size.height + 20;
    CGFloat hh1 = 5;
    CGFloat hh2 = hh - hh1 * 2;
    self.myView = [[UIView alloc]init];
    self.myView.frame = CGRectMake(20, 0,kScreenWitdh - 30, hh);
    
    self.myView.layer.cornerRadius = 8;
    self.myView.layer.masksToBounds = YES;
    self.myView.layer.borderWidth = 1 ;
    self.myView.layer.borderColor = [[UIColor colorWithHex:0xD9D9D9]CGColor];
    
    [self addSubview:_myView];
    
    self.headImg = [[UIImageView alloc]init];
    self.headImg.frame = CGRectMake(5, hh1, hh2, hh2);
    self.headImg.layer.masksToBounds = YES;
    self.headImg.layer.cornerRadius = hh2/2;
    [self.myView addSubview:_headImg];
    
    self.nameImg = [[UIImageView alloc]init];
    self.nameImg.frame = CGRectMake(CGRectGetMaxX(self.headImg.frame)+ 5, hh1+ 5, 20, 20);
    self.nameImg.image = [UIImage imageNamed:@"test_name"];
    [self.myView addSubview:_nameImg];
    
    self.nameLaber = [[UILabel alloc]init];
    self.nameLaber.frame = CGRectMake(CGRectGetMaxX(self.nameImg.frame)+5, CGRectGetMinY(self.nameImg.frame), 35, CGRectGetHeight(self.nameImg.frame));
    self.nameLaber.textColor = [UIColor colorWithHex:0x666666];
    self.nameLaber.font = [UIFont systemFontOfSize:10];
    [self.myView addSubview:_nameLaber];
    
    self.sexImg = [[UIImageView alloc]init];
    self.sexImg.frame = CGRectMake(CGRectGetMaxX(self.nameLaber.frame)+2, CGRectGetMinY(self.nameLaber.frame)+3, 15, 15);
    [self.myView addSubview:_sexImg];
    
    self.dataImg = [[UIImageView alloc]init];
    self.dataImg.frame = CGRectMake(CGRectGetMaxX(self.sexImg.frame)+5, CGRectGetMinY(self.nameImg.frame), 20, 20);
    self.dataImg.image = [UIImage imageNamed:@"test_date"];
    [self.myView addSubview:_dataImg];
    
    self.dateLaber = [[UILabel alloc]init];
    self.dateLaber.frame = CGRectMake(CGRectGetMaxX(self.dataImg.frame)+3, CGRectGetMinY(self.dataImg.frame), kScreenWitdh * 0.22, CGRectGetHeight(self.dataImg.frame));
    self.dateLaber.textColor = [UIColor colorWithHex:0x666666];
    self.dateLaber.font = [UIFont systemFontOfSize:10];
    [self.myView addSubview:_dateLaber];
    
    self.renzhengImg = [[UIImageView alloc]init];
    self.renzhengImg.frame = CGRectMake(CGRectGetMinX(self.nameImg.frame), CGRectGetMaxY(self.nameImg.frame)+10, 18, 18);
    self.renzhengImg.image = [UIImage imageNamed:@"renzh1"];
    [self.myView addSubview:_renzhengImg];
    
    self.renzhengLaber = [[UILabel alloc]init];
    self.renzhengLaber.frame = CGRectMake(CGRectGetMinX(self.nameLaber.frame), CGRectGetMinY(self.renzhengImg.frame), CGRectGetWidth(self.nameLaber.frame)*1.2, CGRectGetHeight(self.nameLaber.frame));
    self.renzhengLaber.textColor = [UIColor colorWithHex:0x666666];
    self.renzhengLaber.font = [UIFont systemFontOfSize:10.0];
    [self.myView addSubview:_renzhengLaber];
    
    self.telImg = [[UIImageView alloc]init];
    self.telImg.frame = CGRectMake(CGRectGetMinX(self.dataImg.frame), CGRectGetMinY(self.renzhengImg.frame), 18, 18);
    self.telImg.image = [UIImage imageNamed:@"dianhua1"];
    [self.myView addSubview:_telImg];
    
    self.telLaber = [[UILabel alloc]init];
    self.telLaber.frame = CGRectMake(CGRectGetMinX(self.dateLaber.frame), CGRectGetMinY(self.renzhengLaber.frame), CGRectGetWidth(self.dateLaber.frame), CGRectGetHeight(self.dateLaber.frame));
    self.telLaber.textColor = [UIColor colorWithHex:0x666666];
    self.telLaber.font = [UIFont systemFontOfSize:10.0];
    //self.telLaber.text = @"18337163965";
    [self.myView addSubview:_telLaber];
    
    self.viewBack = [[UIView alloc]init];
    self.viewBack.frame = CGRectMake(CGRectGetMaxX(self.dateLaber.frame)+3, CGRectGetMinY(self.dateLaber.frame), 35, 35);
    self.viewBack.backgroundColor = [UIColor colorWithHex:0x4367FF];
    self.viewBack.layer.masksToBounds = YES;
    self.viewBack.layer.cornerRadius = 17.5;
    [self.myView addSubview:_viewBack];
    
    self.tuiJianLaber = [[UILabel alloc]init];
    self.tuiJianLaber.frame = CGRectMake(5, 3, 25, 15);
    self.tuiJianLaber.textColor = [UIColor whiteColor];
    self.tuiJianLaber.text = @"推荐";
    self.tuiJianLaber.font = [UIFont systemFontOfSize:10.0];
    self.tuiJianLaber.textAlignment = NSTextAlignmentCenter;
    [self.viewBack addSubview:_tuiJianLaber];
    
    self.tuiJianNum = [[UILabel alloc]init];
    self.tuiJianNum.frame = CGRectMake(5, CGRectGetMaxY(self.tuiJianLaber.frame), 25, 15);
    self.tuiJianNum.textColor = [UIColor whiteColor];
    self.tuiJianNum.textAlignment = NSTextAlignmentCenter;
    self.tuiJianNum.font = [UIFont systemFontOfSize:10.0];
    [self.viewBack addSubview:_tuiJianNum];
    
    self.ceImage = [[UIImageView alloc]init];
    self.ceImage.frame = CGRectMake(10, hh/2, 5, hh+10);
    self.ceImage.image = [UIImage imageNamed:@"cebian1"];
    [self addSubview:_ceImage];
    
    
    
    
    
}


- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
