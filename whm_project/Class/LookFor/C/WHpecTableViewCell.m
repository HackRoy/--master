//
//  WHpecTableViewCell.m
//  whm_project
//
//  Created by 王义国 on 16/11/3.
//  Copyright © 2016年 chenJw. All rights reserved.
//

#import "WHpecTableViewCell.h"

@implementation WHpecTableViewCell

-(UILabel *)myLaber
{
    if (_myLaber == nil) {
        self.myLaber = [[UILabel alloc]init];
        self.myLaber.frame = CGRectMake(20, 20, CGRectGetWidth([UIScreen mainScreen].bounds)-40, 30);
        [self.contentView addSubview:_myLaber];
    }
    return _myLaber;
}

-(void)setModel:(JwPeriod *)model
{
    _model = model;
    self.myLaber.text = model.name;
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
