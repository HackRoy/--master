//
//  LYTestTwoTableViewCell.m
//  MYPage
//
//  Created by 赵良育 on 2016/11/11.
//  Copyright © 2016年 赵良育. All rights reserved.
//

#import "LYTestTwoTableViewCell.h"

@implementation LYTestTwoTableViewCell

-(void)setModel:(WHpros *)model
{
    _model = model;
    self.policyLaber.text = model.period;
    self.payLaber.text = model.pay_period;
    self.premLaber.text = model.rate;
    self.coverLaber.text = model.insured_amount;
    self.giveLaber.text = model.payout;
    self.nameLaber.text = model.short_name;
    NSInteger stateM = [model.is_main_must integerValue];
    switch (stateM) {
        case 1:
            self.headImg.image =[UIImage imageNamed:@"p_zhu"];
            break;
        case 2:
            self.headImg.image = [UIImage imageNamed:@"p_huangfu"];
            break;
        case 3:
            self.headImg.image = [UIImage imageNamed:@"p_group"];
            break;
            
        default:
            break;
    }

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
