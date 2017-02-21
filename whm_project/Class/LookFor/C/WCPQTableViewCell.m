//
//  WCPQTableViewCell.m
//  whm_project
//
//  Created by Stephy_xue on 16/12/27.
//  Copyright © 2016年 chenJw. All rights reserved.
//

#import "WCPQTableViewCell.h"

@implementation WCPQTableViewCell
-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self=[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        self.bounds = CGRectMake(0, 0, wScreenW, 50);
        [self creatMyView];
    }
    return self;
}
-(void)creatMyView
{
    CGFloat ww = wScreenW;
    CGFloat hh = self.bounds.size.height;
    
    self.myImg = [[UIImageView alloc] initWithFrame:CGRectMake(10, 15, hh - 30, hh - 30)];
    self.myImg.layer.masksToBounds = YES;
    self.myImg.layer.cornerRadius = 10;
    
    [self addSubview:self.myImg];
    
    self.lefLab = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.myImg.frame)+10, 10, ww/3, hh - 20)];
    self.lefLab.font = [UIFont systemFontOfSize:10.f];
    self.lefLab.textColor = wGrayColor2;
    self.lefLab.textAlignment = 0;
    [self addSubview:self.lefLab];
    
    self.rigLab = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.lefLab.frame), 10, ww - ww/3 - 20 - 10 - 30 - 5, hh - 20)];
    self.rigLab.textAlignment = 2;
    self.rigLab.textColor = wGrayColor2;
    self.rigLab.numberOfLines = 0;
    self.rigLab.font = [UIFont systemFontOfSize:10.f];
    [self addSubview:self.rigLab];
    
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
