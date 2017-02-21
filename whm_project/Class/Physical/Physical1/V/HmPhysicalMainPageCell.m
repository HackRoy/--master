//
//  HmPhysicalMainPageCell.m
//  whm_project
//
//  Created by zhaoHm on 16/10/24.
//  Copyright © 2016年 chenJw. All rights reserved.
//

#import "HmPhysicalMainPageCell.h"
#import <UIImageView+WebCache.h>

@implementation HmPhysicalMainPageCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setModel:(WHget_user_realtion *)model
{
    _model = model;
    
    //   self.imgHead.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:model.avatar]]];
    self.lblName.text = model.name;
    if ([model.sex isEqualToString:@"1"]) {
        // 男
        self.imgSex.image = [UIImage imageNamed:@"test_male"];
    }
    else
    {
        // 女
        self.imgSex.image = [UIImage imageNamed:@"test_famale"];
    }
    
    //时间戳处理
    
    NSDate *confromTimesp = [NSDate dateWithTimeIntervalSince1970:model.birthday.doubleValue];
    
    
    NSString * s1 = [NSString stringWithFormat:@"%@",confromTimesp];
    
    
    self.lblDate.text = [s1 substringToIndex:11];
    self.lblYearCost.text = model.yearly_income;
    self.lblOwe.text = model.policy_count;
    self.imgHead.layer.cornerRadius = 25;
    self.imgHead.layer.masksToBounds = YES;
    if (model.avatar.length < 1) {
        self.imgHead.image = [UIImage imageNamed:@"Jw_user"];
    }
    else
    {
    [self.imgHead sd_setImageWithURL:[NSURL URLWithString:model.avatar]];
    }
    
    //  self.lblPay.text = model.yearly_out;
    // 关系
    NSInteger stateM = [model.relation integerValue];
    switch (stateM) {
        case 0:
            self.lblMaritalStatus.text = @"本人";
            break;
        case 1:
            self.lblMaritalStatus.text = @"丈夫";
            break;
        case 2:
            self.lblMaritalStatus.text = @"妻子";
            break;
        case 3:
            self.lblMaritalStatus.text = @"父亲";
            break;
        case 4:
            self.lblMaritalStatus.text = @"母亲";
            break;
        case 5:
            self.lblMaritalStatus.text = @"儿子";
            break;
        case 6:
            self.lblMaritalStatus.text = @"女儿";
            break;
        case 7:
            self.lblMaritalStatus.text = @"祖父";
            break;
        case 8:
            self.lblMaritalStatus.text = @"祖母";
            break;
        case 9:
            self.lblMaritalStatus.text = @"外祖父";
            break;
        case 10:
            self.lblMaritalStatus.text = @"外祖母";
            break;
        case 11:
            self.lblMaritalStatus.text = @"其他";
            break;
        default:
            break;
    }
}

@end
