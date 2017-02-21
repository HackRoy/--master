//
//  WHloveagentTableViewCell.m
//  whm_project
//
//  Created by 王义国 on 16/11/18.
//  Copyright © 2016年 chenJw. All rights reserved.
//

#import "WHloveagentTableViewCell.h"
#import "MacroUtility.h"
#import <UIImageView+WebCache.h>

@implementation WHloveagentTableViewCell



-(UIImageView *)myImage
{
    if (_myImage == nil) {
        self.myImage = [[UIImageView alloc]init];
        self.myImage.frame = CGRectMake(10, 10,kScreenWitdh * 0.2 , kScreenWitdh * 0.2);
        self.myImage.layer.masksToBounds = YES;
        self.myImage.layer.cornerRadius = kScreenWitdh * 0.1;
        [self.contentView addSubview:_myImage];
    }
    return _myImage;
}

-(UILabel *)nameLaber
{
    if (_nameLaber == nil) {
        self.nameLaber = [[UILabel alloc]init];
        self.nameLaber.frame = CGRectMake(CGRectGetMaxX(self.myImage.frame)+10, 10, kScreenWitdh *0.2, 30);
        self.nameLaber.font = [UIFont systemFontOfSize:15.0];
        [self.contentView addSubview:_nameLaber];
    }
    return _nameLaber;
}

-(UIImageView * )sexImg
{
    if (_sexImg == nil) {
        self.sexImg = [[UIImageView alloc]init];
        self.sexImg.frame = CGRectMake(CGRectGetMaxX(self.nameLaber.frame)+5, CGRectGetMinY(self.nameLaber.frame)+3, 20, 20);
        [self.contentView addSubview:_sexImg];
    }
    return _sexImg;
}

-(UILabel*)ageLaber
{
    if (_ageLaber == nil) {
        self.ageLaber = [[UILabel alloc]init];
        self.ageLaber.frame = CGRectMake(CGRectGetMaxX(self.sexImg.frame)+5, CGRectGetMinY(self.sexImg.frame), 40, 20);
        self.ageLaber.font = [UIFont systemFontOfSize:13.0];
        self.ageLaber.textColor = [UIColor grayColor];
        [self.contentView addSubview:_ageLaber];
    }
    return _ageLaber;
}

-(UILabel *)professLaber
{
    if (_professLaber == nil) {
        self.professLaber = [[UILabel alloc]init];
        self.professLaber.frame = CGRectMake(CGRectGetMinX(self.nameLaber.frame), CGRectGetMaxY(self.nameLaber.frame)+10, kScreenWitdh * 0.6, 20);
        self.professLaber.textColor = [UIColor grayColor];
        self.professLaber.font = [UIFont systemFontOfSize:13.0];
        [self.contentView addSubview:_professLaber];
    }
    return _professLaber;
}


-(UIButton *)telBut
{
    if (_telBut == nil) {
        self.telBut = [UIButton buttonWithType:(UIButtonTypeSystem)];
        self.telBut.frame = CGRectMake(kScreenWitdh * 0.8, CGRectGetMidY(self.nameLaber.frame), 40, 40);
        [self.contentView addSubview:_telBut];
        
    }
    return _telBut;
}


-(void)setModel:(WHagent *)model
{
    _model = model;
    if (model.avatar.length <1) {
        self.myImage.image = [UIImage imageNamed:@"Jw_user"];
    }else
    {
    [self.myImage sd_setImageWithURL:[NSURL URLWithString:model.avatar]];
    }
    self.nameLaber.text = model.name;
    NSInteger sexM = [model.sex integerValue];
    switch (sexM) {
        case 1:
            self.sexImg.image = [UIImage imageNamed:@"test_male"];
            break;
            case 2 :
            self.sexImg.image = [UIImage imageNamed:@"test_famale"];
            break;
        default:
            break;
    }
    self.ageLaber.text = [model.age stringByAppendingString:@"岁"];
    NSString * s1 = model.cname?model.cname:@"";
    NSString * s2 = model.profession?model.profession:@"";
    NSString * s3 = model.work_time?model.work_time:@"";
    NSString * s4 = model.service_area?model.service_area:@"";
    NSString * s5 =[s1 stringByAppendingString:s2 ];
    NSString * s6 = [s5 stringByAppendingString:s3 ];
    NSString * s7 = [s6 stringByAppendingString:s4]; 
    
    
    
    self.professLaber.text = s7  ;
    
    
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
