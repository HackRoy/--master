//
//  WBYrzxqTableViewCell.m
//  whm_project
//
//  Created by apple on 17/1/18.
//  Copyright © 2017年 chenJw. All rights reserved.
//

#import "WBYrzxqTableViewCell.h"

@implementation WBYrzxqTableViewCell
-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self=[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        self.bounds = CGRectMake(0, 0,wScreenW, 45);
        [self creatMyView];
    }
    return self;
}

-(void)creatMyView
{
    CGFloat hh = self.bounds.size.height;
    CGFloat hh1 = 5;
    CGFloat hh2 = hh - hh1 * 2;
    
//    self.rLab = [[UILabel alloc] initWithFrame:CGRectMake(5, 0, 45, hh-10)];
    
    self.rLab = [UILabel new];
    
    self.rLab.font = [UIFont systemFontOfSize:12];
    
    [self addSubview:self.rLab];
    
    self.llab = [[UILabel alloc] initWithFrame:CGRectMake(80, hh1, wScreenW -20-45-20 -5-5-25, hh2)];
    self.llab.font = [UIFont systemFontOfSize:14];
    
    self.llab.textAlignment = 2;
    [self addSubview:self.llab];
    
    _myBtn = [UIButton buttonWithType:UIButtonTypeCustom];    
    [self addSubview:_myBtn];
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
