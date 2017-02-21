//
//  HmDetailsCell.m
//  whm_project
//
//  Created by zhaoHm on 16/10/25.
//  Copyright © 2016年 chenJw. All rights reserved.
//

#import "HmDetailsCell.h"

@implementation HmDetailsCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setModel:(HmMyModel *)model {
    _model = model;
    
    self.myLaber.text = model.nameS;
}

@end
