//
//  WHjiluTableViewCell.m
//  whm_project
//
//  Created by 王义国 on 17/2/10.
//  Copyright © 2017年 chenJw. All rights reserved.
//

#import "WHjiluTableViewCell.h"
#import "MacroUtility.h"
#import "UIColor+Hex.h"


@implementation WHjiluTableViewCell
-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self creatMyview];
    }
    return self;
}

-(void)creatMyview
{
    CGFloat hh = self.bounds.size.height + 10;
    CGFloat hh1 = 5;
    CGFloat hh2 = hh - hh1 * 2;
    self.headImg = [[UIImageView alloc]init];
    self.headImg = [[UIImageView alloc]init];
    self.headImg.frame = CGRectMake(5, hh1, hh2 , hh2);
    self.headImg.layer.masksToBounds = YES;
    self.headImg.layer.cornerRadius = hh2/2;
    [self addSubview:_headImg];
    
    self.moneyLaber = [[UILabel alloc]init];
    self.moneyLaber.frame = CGRectMake(CGRectGetMaxX(self.headImg.frame)+10, CGRectGetMinY(self.headImg.frame), kScreenWitdh * 0.15, 20);
    self.moneyLaber.font = [UIFont systemFontOfSize:12.0];
    //self.moneyLaber.textAlignment = NSTextAlignmentRight;
    [self addSubview:_moneyLaber];
    
    self.typeLaber = [[UILabel alloc]init];
    self.typeLaber.frame = CGRectMake(CGRectGetMaxX(self.moneyLaber.frame)+2, CGRectGetMinY(self.moneyLaber.frame), 40, 20);
    self.typeLaber.textColor = [UIColor colorWithHex:0x666666];
    self.typeLaber.textAlignment = NSTextAlignmentLeft;
    self.typeLaber.font = [UIFont systemFontOfSize:10.0];
    [self addSubview:_typeLaber];
    
    
    self.myTitLaber = [[UILabel alloc]init];
    self.myTitLaber.frame = CGRectMake(CGRectGetMaxX(self.typeLaber.frame)+5, CGRectGetMinY(self.moneyLaber.frame), kScreenWitdh * 0.45, 20);
    self.myTitLaber.textColor = [UIColor colorWithHex:0x666666];
    self.myTitLaber.font = [UIFont systemFontOfSize:10.0];
    [self addSubview:_myTitLaber];
    
    self.daiLiLaber = [[UILabel alloc]init];
    self.daiLiLaber.frame = CGRectMake(CGRectGetMinX(self.moneyLaber.frame), CGRectGetMaxY(self.moneyLaber.frame)+3, kScreenWitdh * 0.3, 20);
    self.daiLiLaber.textColor = [UIColor colorWithHex:0x666666];
    self.daiLiLaber.font = [UIFont systemFontOfSize:10.0];
    [self addSubview:_daiLiLaber];
    
    self.timeLaber = [[UILabel alloc]init];
    self.timeLaber.frame = CGRectMake(CGRectGetMinX(self.myTitLaber.frame), CGRectGetMinY(self.daiLiLaber.frame), CGRectGetWidth(self.myTitLaber.frame)*0.8, CGRectGetHeight(self.myTitLaber.frame));
    self.timeLaber.textColor = [UIColor colorWithHex:0x666666];
    self.timeLaber.font = [UIFont systemFontOfSize:10.0];
    [self addSubview:_timeLaber];
    
    self.applyLaber = [[UILabel alloc]init];
    self.applyLaber.frame = CGRectMake(kScreenWitdh * 0.78, CGRectGetMidY(self.myTitLaber.frame)+2, kScreenWitdh * 0.2, 20);
    self.applyLaber.textColor = [UIColor orangeColor];
    self.applyLaber.font = [UIFont systemFontOfSize:10.0];
    [self addSubview:_applyLaber];
    
    self.line1 = [[UILabel alloc]init];
    self.line1.frame = CGRectMake(0, CGRectGetMaxY(self.timeLaber.frame)+10, kScreenWitdh , 1);
    self.line1.backgroundColor = [UIColor colorWithHex:0xD9D9D9];
    //[self addSubview:_line1];
    
    
    
    
    
    
    

    
    
    
    
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
