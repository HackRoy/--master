//
//  WHmessageListTableViewCell.m
//  whm_project
//
//  Created by 王义国 on 16/11/27.
//  Copyright © 2016年 chenJw. All rights reserved.
//

#import "WHmessageListTableViewCell.h"
#import "MacroUtility.h"
@implementation WHmessageListTableViewCell

-(UILabel *)myTit
{
    if (_myTit == nil) {
        self.myTit = [[UILabel alloc]init];
        self.myTit.frame = CGRectMake(10, 10,kScreenWitdh * 0.6 , 30);
        self.myTit.font = [UIFont systemFontOfSize:15.0];
        [self.contentView addSubview:_myTit];
    }
    return _myTit;
}

-(UILabel * )formLaber
{
    if (_formLaber == nil) {
        self.formLaber = [[UILabel alloc]init];
        self.formLaber.frame = CGRectMake(CGRectGetMinX(self.myTit.frame), CGRectGetMaxY(self.myTit.frame)+5, kScreenWitdh * 0.1, 20);
        self.formLaber.textColor = [UIColor grayColor];
        self.formLaber.text = @"来自";
        self.formLaber.font = [UIFont systemFontOfSize:13.0];
        [self.contentView addSubview:_formLaber];
    }
    return _formLaber;
}

-(UILabel *)addressLaber
{
    if (_addressLaber == nil) {
        self.addressLaber = [[UILabel alloc]init];
        self.addressLaber.frame = CGRectMake(CGRectGetMaxX(self.formLaber.frame), CGRectGetMinY(self.formLaber.frame),kScreenWitdh * 1.5, 20);
        self.addressLaber.textColor = [UIColor grayColor];
        self.addressLaber.font = [UIFont systemFontOfSize:13.0];
        [self.contentView addSubview:_addressLaber];
    }
    return _addressLaber;
}

-(UILabel *)timeLaber
{
    if (_timeLaber == nil) {
        self.timeLaber = [[UILabel alloc]init];
        self.timeLaber.frame = CGRectMake(kScreenWitdh * 0.7, CGRectGetMaxY(self.myTit.frame), kScreenWitdh*0.25, 20);
        self.timeLaber.textColor = [UIColor grayColor];
        self.timeLaber.font = [UIFont systemFontOfSize:13.0];
        [self.contentView addSubview:_timeLaber];
    }
    return _timeLaber;
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
