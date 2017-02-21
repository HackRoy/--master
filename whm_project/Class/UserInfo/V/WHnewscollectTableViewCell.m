//
//  WHnewscollectTableViewCell.m
//  whm_project
//
//  Created by 王义国 on 16/12/4.
//  Copyright © 2016年 chenJw. All rights reserved.
//

#import "WHnewscollectTableViewCell.h"
#import "MacroUtility.h"
@implementation WHnewscollectTableViewCell

-(UIImageView *)myImg
{
    if (_myImg == nil) {
        self.myImg = [[UIImageView alloc]init];
        self.myImg.frame = CGRectMake(10, 10,kScreenWitdh * 0.3 , kScreenWitdh * 0.2);
        [self.contentView addSubview:_myImg];
    }
    return _myImg;
}
-(UILabel *)myTit
{
    if (_myTit == nil) {
        self.myTit =[[UILabel alloc]init];
        self.myTit.frame = CGRectMake(CGRectGetMaxX(self.myImg.frame)+3, CGRectGetMinY(self.myImg.frame), kScreenWitdh * 0.6, 40);
        self.myTit.font = [UIFont systemFontOfSize:13.0];
        self.myTit.numberOfLines = 2;
        [self.contentView addSubview:_myTit];
    }
    return _myTit;
}
-(UILabel *)readNum
{
    if (_readNum == nil) {
        self.readNum = [[UILabel alloc]init];
        self.readNum.frame = CGRectMake(CGRectGetMinX(self.myTit.frame), CGRectGetMaxY(self.myTit.frame)+5, kScreenWitdh * 0.15, 20);
        self.readNum.textColor = [UIColor grayColor];
        self.readNum.font = [UIFont systemFontOfSize:8.0];
        [self.contentView addSubview:_readNum];
    }
    return _readNum;
}
-(UILabel *)styLaber
{
    if (_styLaber == nil) {
        self.styLaber = [[UILabel alloc]init];
        self.styLaber.frame = CGRectMake(CGRectGetMaxX(self.readNum.frame), CGRectGetMinY(self.readNum.frame), kScreenWitdh * 0.2, 20);
        self.styLaber.textColor = [UIColor grayColor];
        self.styLaber.font = [UIFont systemFontOfSize:8.0];
        [self.contentView addSubview:_styLaber];
    }
    return _styLaber;
}

-(UILabel *)timeLaber
{
    if (_timeLaber == nil) {
        self.timeLaber = [[UILabel alloc]init];
        self.timeLaber.frame = CGRectMake(kScreenWitdh * 0.7, CGRectGetMinY(self.readNum.frame), kScreenWitdh*0.2, 20);
        self.timeLaber.font = [UIFont systemFontOfSize:8.0];
        self.timeLaber.textColor = [UIColor grayColor];
        [self.contentView addSubview:_timeLaber];
    }
    return _timeLaber;
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
