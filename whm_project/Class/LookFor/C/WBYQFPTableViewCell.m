//
//  WBYQFPTableViewCell.m
//  whm_project
//
//  Created by apple on 17/1/19.
//  Copyright © 2017年 chenJw. All rights reserved.
//

#import "WBYQFPTableViewCell.h"

@implementation WBYQFPTableViewCell
-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self=[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        [self creatMyView];
    }
    return self;
}

-(void)creatMyView
{
    CGFloat hh = self.bounds.size.height;
    CGFloat hh1 = 8;
    CGFloat hh2 = hh - hh1 * 2;
    
    self.myImg = [[UIImageView alloc] initWithFrame:CGRectMake(5, hh1, hh2, hh2)];
    
    [self addSubview:self.myImg];

    self.myLab = [[UITextField alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.myImg.frame) +5, hh1, wScreenW - 100, hh2)];
    self.myLab.font = [UIFont systemFontOfSize:14];
    self.myLab.textColor = wGrayColor2;
     
    
    [self addSubview:self.myLab];
    
    
    
    
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
