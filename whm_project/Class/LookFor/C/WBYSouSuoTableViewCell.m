//
//  WBYSouSuoTableViewCell.m
//  whm_project
//
//  Created by apple on 17/1/6.
//  Copyright © 2017年 chenJw. All rights reserved.
//

#import "WBYSouSuoTableViewCell.h"

@implementation WBYSouSuoTableViewCell
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
    CGFloat hh1 = 15;
    CGFloat hh2 = hh - hh1 * 2;
    self.lImg = [[UIImageView alloc] initWithFrame: CGRectMake(8, hh1, hh2, hh2)];
    
    [self addSubview:self.lImg];
    
    self.myLab = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.lImg.frame)+ 8, 0, wScreenW/2 + 50, hh)];
    self.myLab.textColor = wGrayColor2;
    self.myLab.font = [UIFont systemFontOfSize:12.0f];
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
