//
//  BaoXianXiangQingTableViewCell.m
//  whm_project
//
//  Created by apple on 17/1/11.
//  Copyright © 2017年 chenJw. All rights reserved.
//

#import "BaoXianXiangQingTableViewCell.h"

@implementation BaoXianXiangQingTableViewCell
-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self=[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        
        self.bounds = CGRectMake(0, 0, wScreenW, 80);
        [self creatMyView];
    }
    return self;
}

-(void)creatMyView
{
    CGFloat hh = self.bounds.size.height;
    CGFloat hh1 = 8;
    CGFloat hh2 = hh - hh1 * 2;
    CGFloat hh3 =hh2/3;
    CGFloat ww = 2 * wScreenW/3;
    
    
    self.lImg = [[UIImageView alloc] initWithFrame:CGRectMake(8, 8,wScreenW/5 , hh2)];
    
    [self addSubview:self.lImg];
    
    self.upLab = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.lImg.frame)+10, hh1, ww, hh3)];
    self.upLab.font = [UIFont systemFontOfSize:12];
    [self addSubview:self.upLab];
    
    self.midL = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.lImg.frame)+10, CGRectGetMaxY(self.upLab.frame), 100, hh3)];
    self.midL.textColor = wGrayColor2;
    self.midL.font = [UIFont systemFontOfSize:10];
    [self addSubview:self.midL];
    
    self.midR = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.midL.frame), CGRectGetMaxY(self.upLab.frame), 100, hh3)];
    self.midR.textColor = wGrayColor2;
    self.midR.font = [UIFont systemFontOfSize:10];

    [self addSubview:self.midR];
    
    self.downL = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.lImg.frame)+10, CGRectGetMaxY(self.midR.frame), 35, hh3)];
    self.downL.textColor = wGrayColor2;
    self.downL.text = @"关键词:";
    self.downL.font = [UIFont systemFontOfSize:10];
    [self addSubview:self.downL];
    
    self.downR = [UILabel new];
    self.downR.frame = CGRectMake(CGRectGetMaxX(self.downL.frame), CGRectGetMaxY(self.midR.frame), 50, hh3);
    self.downR.textColor = wBlue;
    self.downR.textAlignment = 1;
    self.downR.font = [UIFont systemFontOfSize:10];
    self.downR.layer.borderColor = wBlue.CGColor;
    self.downR.layer.borderWidth = 0.5;
    [self addSubview:self.downR];
    
    self.downR1=[UILabel new];
    self.downR1.frame = CGRectMake(CGRectGetMaxX(self.downL.frame) + (50 + 3), CGRectGetMaxY(self.midR.frame), 50,(80-16)/3);
    self.downR1.textColor = wBlue;
    self.downR1.textAlignment = 1;
    self.downR1.font = [UIFont systemFontOfSize:10];
    self.downR1.layer.borderColor = wBlue.CGColor;
    self.downR1.layer.borderWidth = 0.5;
    
    [self addSubview:self.downR1];

    
    
    
//     self.downR = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.downL.frame),  CGRectGetMaxY(self.midR.frame), 50, hh3)]
    
//    for (NSInteger i =0; i<self.myArr.count; i++)
//    {
//        self.downR = [UILabel new];
//        self.downR.frame = CGRectMake(CGRectGetMaxX(self.downL.frame) + (50 + 5)*i, CGRectGetMaxY(self.midR.frame), 50, hh3);
//        self.downR.textColor = wBlue;
//        self.downR.font = [UIFont systemFontOfSize:10];
//        self.downR.layer.borderColor = wBlue.CGColor;
//        self.downR.layer.borderWidth = 0.5;
//        [self addSubview:self.downR];
//        
//    }

       
    
    
    
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
