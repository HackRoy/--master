//
//  WHrecommentTableViewCell.m
//  whm_project
//
//  Created by 王义国 on 16/10/30.
//  Copyright © 2016年 chenJw. All rights reserved.
//

#import "WHrecommentTableViewCell.h"
#define kScreenW [[UIScreen mainScreen] bounds].size.width
#import <UIImageView+WebCache.h>


@implementation WHrecommentTableViewCell

-(UIImageView *)myImage
{
    if (_myImage == nil) {
        self.myImage = [[UIImageView alloc]init];
        self.myImage.frame = CGRectMake(10, 10, kScreenW * 0.2, kScreenW * 0.2);
        [self.contentView addSubview:_myImage];
    }
    
    return _myImage;
}

-(UILabel *)titLaber
{
    if (_titLaber == nil) {
        self.titLaber = [[UILabel alloc]init];
        self.titLaber.frame = CGRectMake(CGRectGetMaxX(self.myImage.frame)+10, CGRectGetMinY(self.myImage.frame), kScreenW * 0.6, 30);
        [self.contentView addSubview:_titLaber];
        
    }
    
    return _titLaber;
}

-(UIImageView *)mainImage
{
    if (_mainImage == nil) {
        self.mainImage = [[UIImageView alloc]init];
        self.mainImage.frame = CGRectMake(CGRectGetMaxX(self.titLaber.frame)+10, CGRectGetMinY(self.titLaber.frame), kScreenW *0.1, kScreenW *0.1);
        [self.contentView addSubview:_mainImage];
    }
    
    return _mainImage;
    
}
//
-(UILabel *)ageLaber
{
    if (_ageLaber == nil) {
        self.ageLaber = [[UILabel alloc]init];
        self.ageLaber.frame = CGRectMake(CGRectGetMinX(self.titLaber.frame), CGRectGetMaxY(self.titLaber.frame)+5, 60, 20);
        self.ageLaber.text = @"投保年龄:";
        self.ageLaber.textColor = [UIColor grayColor];
        self.ageLaber.font = [UIFont systemFontOfSize:10.0];
        [self.contentView addSubview:_ageLaber];
    }
    return _ageLaber;
}
//

-(UILabel *)yearLaber
{
    if (_yearLaber == nil) {
        self.yearLaber = [[UILabel alloc]init];
        self.yearLaber.frame = CGRectMake(CGRectGetMaxX(self.ageLaber.frame), CGRectGetMaxY(self.titLaber.frame)+5, kScreenW * 0.2, 20);
        self.yearLaber.font = [UIFont systemFontOfSize:10.0];
        self.yearLaber.textColor = [UIColor grayColor];
        [self.contentView addSubview:_yearLaber];
    }
    
    return _yearLaber;
}

//
-(UILabel *)statuLaber
{
    if (_statuLaber == nil) {
        self.statuLaber = [[UILabel alloc]init];
        self.statuLaber.frame = CGRectMake(CGRectGetMaxX(self.yearLaber.frame)+10, CGRectGetMinY(self.yearLaber.frame), kScreenW*0.3, CGRectGetHeight(self.yearLaber.frame));
        self.statuLaber.font = [UIFont systemFontOfSize:10.0];
        self.statuLaber.textColor = [UIColor grayColor];
        [self.contentView addSubview:_statuLaber];
        
    }
    
    return _statuLaber;
    
    
}

-(UILabel *)timeLaber
{
    if (_timeLaber == nil) {
        self.timeLaber = [[UILabel alloc]init];
        self.timeLaber.frame = CGRectMake(CGRectGetMinX(self.ageLaber.frame), CGRectGetMaxY(self.yearLaber.frame)+5, kScreenW * 0.4, CGRectGetHeight(self.yearLaber.frame));
        self.timeLaber.font = [UIFont systemFontOfSize:10.0];
        [self.contentView addSubview:_timeLaber];
        self.timeLaber.textColor = [UIColor grayColor];
    }
    
    return _timeLaber;
}

-(void)setModel:(WHgetrec *)model
{
    _model = model;
    [self.myImage sd_setImageWithURL:[NSURL URLWithString:model.logo]];
    self.titLaber.text = model.name;
    self.yearLaber.text = model.limit_age.length<1 ? @"暂无": model.limit_age;
    
    NSString * staLaber = @"";
    if (model.prod_type_code_name == nil) {
        model.prod_type_code_name = @"";
    }
    self.statuLaber.text = [staLaber stringByAppendingString: model.prod_type_code_name];
    
    //NSDate *confromTimesp = [NSDate dateWithTimeIntervalSince1970:model.update_time.doubleValue];
    
    
    //NSString * s2 = [NSString stringWithFormat:@"%@",confromTimesp];
   NSString * stime = [WBYRequest timeStr:model.update_time];
    
   self.timeLaber.text = stime;
    
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
