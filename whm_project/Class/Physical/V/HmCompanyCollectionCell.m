//
//  HmCompanyCollectionCell.m
//  whm_project
//
//  Created by zhaoHm on 16/10/18.
//  Copyright © 2016年 chenJw. All rights reserved.
//

#import "HmCompanyCollectionCell.h"
#import <UIImageView+WebCache.h>

@implementation HmCompanyCollectionCell


-(void)setModel:(WHhotcompany *)model
{
    _model = model;
    
    [self.Myheadimage sd_setImageWithURL:[NSURL URLWithString:model.logo]];
    self.MytitLaber.text = model.short_name ;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

@end
