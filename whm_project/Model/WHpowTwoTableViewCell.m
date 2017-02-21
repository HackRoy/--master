//
//  WHpowTwoTableViewCell.m
//  whm_project
//
//  Created by 王义国 on 16/11/8.
//  Copyright © 2016年 chenJw. All rights reserved.
//

#import "WHpowTwoTableViewCell.h"

@implementation WHpowTwoTableViewCell

-(UIButton *)myBut
{
    if (_myBut == nil) {
        self.myBut = [UIButton buttonWithType:(UIButtonTypeSystem)];
        self.myBut.frame = CGRectMake(10, 10, 60, 40);
        [self.contentView addSubview:_myBut];
        
    }
    
    return _myBut;
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
