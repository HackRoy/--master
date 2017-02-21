//
//  ChooseTableViewCell.m
//  小胖的demo
//
//  Created by YiTu8 on 16/10/18.
//  Copyright © 2016年 shuaili. All rights reserved.
//

#import "ChooseTableViewCell.h"



#define kScreenW [[UIScreen mainScreen] bounds].size.width
@implementation ChooseTableViewCell



-(UILabel *)addressLab
{
    if (_addressLab == nil)
    {
        self.addressLab = [[UILabel alloc]initWithFrame:CGRectMake(20, 10, kScreenW - 40, 30)];
        self.addressLab.numberOfLines = 0;
        self.addressLab.font = [UIFont systemFontOfSize:12];
        
        
        [self.contentView addSubview:_addressLab];
    }
    return _addressLab;
}

- (void)awakeFromNib {
    // Initialization code
    [super awakeFromNib];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
