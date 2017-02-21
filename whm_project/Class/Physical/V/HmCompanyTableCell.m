//
//  HmCompanyTableCell.m
//  whm_project
//
//  Created by zhaoHm on 16/10/18.
//  Copyright © 2016年 chenJw. All rights reserved.
//

#import "HmCompanyTableCell.h"

#import <UIImageView+WebCache.h>

@implementation HmCompanyTableCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

-(void)setModel:(JwCompanys *)model
{
    
    _model = model;
    self.nameLaber.text = model.name;
    [self.headImage sd_setImageWithURL:[NSURL URLWithString:model.logo]];
    
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
