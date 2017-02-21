//
//  registerTwoTableViewCell.m
//  小胖的demo
//
//  Created by YiTu8 on 16/10/18.
//  Copyright © 2016年 shuaili. All rights reserved.
//

#import "registerTwoTableViewCell.h"



#define kScreenW [[UIScreen mainScreen] bounds].size.width
@implementation registerTwoTableViewCell




-(UIImageView *)myImage
{
    if (_myImage == nil)
    {
        self.myImage = [[UIImageView alloc]initWithFrame:CGRectMake(15, 15, 20, 20)];
        //self.myImage.backgroundColor = [UIColor redColor];
        
        
        
        [self.contentView addSubview:_myImage];
    }
    return _myImage;
}


-(UIButton *)clickBtn
{
    if (_clickBtn == nil) {
        self.clickBtn = [UIButton buttonWithType:UIButtonTypeSystem];
        self.clickBtn.frame = CGRectMake(CGRectGetMaxX(_myImage.frame), CGRectGetMinY(_myImage.frame), kScreenW -125 , 20);
        [self.clickBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        self.clickBtn.titleLabel.font = [UIFont systemFontOfSize:14];
        //self.clickBtn.backgroundColor = [UIColor grayColor];
        [self.contentView addSubview:_clickBtn];
        
    }
    return _clickBtn;
}

-(UIImageView *)arrowImge
{
    if (_arrowImge == nil)
    {
        self.arrowImge = [[UIImageView alloc]initWithFrame:CGRectMake(kScreenW - 30, CGRectGetMinY(_myImage.frame), 10, 20)];
        //self.arrowImge.backgroundColor = [UIColor redColor];
        
        
        
        [self.contentView addSubview:_arrowImge];
    }
    return _arrowImge;
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
