//
//  WHhistoryTableViewCell.m
//  whm_project
//
//  Created by 王义国 on 16/11/3.
//  Copyright © 2016年 chenJw. All rights reserved.
//

#import "WHhistoryTableViewCell.h"
#import <UIImageView+WebCache.h>

@implementation WHhistoryTableViewCell

-(UIImageView *)myImage
{
    if (_myImage == nil) {
        self.myImage = [[UIImageView alloc]init];
        self.myImage.frame = CGRectMake(10, 20, 40, 40);
        [self.contentView addSubview:_myImage];
        
    }
    return _myImage;
}

-(UILabel *)myLaber
{
    if (_myLaber == nil) {
        self.myLaber = [[UILabel alloc]init];
        self.myLaber.frame  = CGRectMake(CGRectGetMaxX(self.myImage.frame)+10, CGRectGetMinY(self.myImage.frame), CGRectGetWidth([UIScreen mainScreen].bounds)*0.7, 40);
        [self.contentView addSubview:_myLaber];
    }
    return _myLaber;
    
}

-(UIImageView *)mainImage
{
    if (_mainImage == nil) {
        self.mainImage = [[UIImageView alloc]init];
        self.mainImage.frame = CGRectMake(CGRectGetMaxX(self.myLaber.frame)+10, CGRectGetMinY(self.myLaber.frame), 20, 20);
        [self.contentView addSubview:_mainImage];
    }
    return _mainImage;
}

-(void)setModel:(WHgetproduct *)model
{
    _model = model;
    [self.myImage sd_setImageWithURL:[NSURL URLWithString:model.logo]];
    self.myLaber.text = model.name;
    NSInteger stateM = [model.is_main integerValue];
    switch (stateM) {
        case 1:
            self.mainImage.image =[UIImage imageNamed:@"p_zhu"];
            break;
        case 2:
            self.mainImage.image = [UIImage imageNamed:@"p_huangfu"];
            break;
        case 3:
            self.mainImage.image = [UIImage imageNamed:@"p_group"];
            break;
            
        default:
            break;
    }

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
