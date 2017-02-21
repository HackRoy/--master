//
//  MyRenZhengTableViewCell.m
//  whm_project
//
//  Created by apple on 17/1/5.
//  Copyright © 2017年 chenJw. All rights reserved.
//

#import "MyRenZhengTableViewCell.h"

@implementation MyRenZhengTableViewCell

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
    CGFloat hh1 = hh - 26;
    self.lImg = [[UIImageView alloc] initWithFrame:CGRectMake(10, 13, hh1, hh1)];
    [self addSubview:self.lImg];
    
    self.mText = [[UITextField alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.lImg.frame) + 10, 0,wScreenW - hh1 - 10 - 5 - 15 - 20, hh)];
    
    [self.mText setValue:[UIFont systemFontOfSize:12.f] forKeyPath:@"_placeholderLabel.font"];//修改字体
    [self addSubview:self.mText];
    
}
- (void)awakeFromNib
{
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
