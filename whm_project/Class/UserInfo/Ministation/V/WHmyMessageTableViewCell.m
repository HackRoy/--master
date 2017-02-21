//
//  WHmyMessageTableViewCell.m
//  whm_project
//
//  Created by 王义国 on 16/10/28.
//  Copyright © 2016年 chenJw. All rights reserved.
//

#import "WHmyMessageTableViewCell.h"

#define kScreenW [[UIScreen mainScreen] bounds].size.width

@implementation WHmyMessageTableViewCell

-(UILabel *)titLaber
{
    if (_titLaber == nil) {
        self.titLaber = [[UILabel alloc]init];
        self.titLaber.frame = CGRectMake(10, 10, kScreenW-20, 30);
        [self.contentView addSubview:_titLaber];
    }
    return _titLaber;
}

-(UILabel *)nameLaber
{
    if (_nameLaber == nil) {
        self.nameLaber = [[UILabel alloc]init];
        self.nameLaber.frame = CGRectMake(CGRectGetMinX(self.titLaber.frame), CGRectGetMaxY(self.titLaber.frame)+5, kScreenW * 0.2, 20);
        self.nameLaber.font = [UIFont systemFontOfSize:15.0];
        self.nameLaber.textColor = [UIColor grayColor];
        [self.contentView addSubview:_nameLaber];
    }
    return _nameLaber;
}

-(UILabel *)addressLaber
{
    if (_addressLaber == nil) {
        self.addressLaber = [[UILabel alloc]init];
        self.addressLaber.frame = CGRectMake(CGRectGetMaxX(self.nameLaber.frame)+10, CGRectGetMinY(self.nameLaber.frame), kScreenW * 0.3, CGRectGetHeight(self.nameLaber.frame));
        self.addressLaber.font = [UIFont systemFontOfSize:15.0];
        [self.contentView addSubview:_addressLaber];
        self.addressLaber.textColor = [UIColor grayColor];
    }
    
    return _addressLaber;
    
}

-(UILabel *)statuLaber
{
    if (_statuLaber == nil) {
        self.statuLaber = [[UILabel alloc]init];
        self.statuLaber.frame = CGRectMake(CGRectGetMaxX(self.addressLaber.frame)+10, CGRectGetMinY(self.addressLaber.frame), kScreenW* 0.15, CGRectGetHeight(self.addressLaber.frame));
        self.statuLaber.font = [UIFont systemFontOfSize:14.0];
        [self.contentView addSubview:_statuLaber];
        //self.statuLaber.textColor = [UIColor grayColor];
        
    }
    return _statuLaber;
}


-(UILabel *)timeLaber
{
    if (_timeLaber == nil) {
        self.timeLaber = [[UILabel alloc]init];
        self.timeLaber.frame = CGRectMake(kScreenW * 0.75, CGRectGetMinY(self.statuLaber.frame), kScreenW* 0.3, CGRectGetHeight(self.statuLaber.frame));
        self.timeLaber.font = [UIFont systemFontOfSize:15.0];
        [self.contentView addSubview:_timeLaber];
        self.timeLaber.textColor = [UIColor grayColor];
        
    }
    
    return _timeLaber;
}

-(void)setModel:(WHgetmessage *)model
{
    _model = model;
    self.titLaber.text = model.message;
    self.nameLaber.text = model.req_name;
   // self.statuLaber.text = model.reply_status;
    
    NSString * s1 = @"来自 ";
    
    //时间戳处理
    
    NSDate *confromTimesp = [NSDate dateWithTimeIntervalSince1970:model.create_time.doubleValue];
    
    
    NSString * s2 = [NSString stringWithFormat:@"%@",confromTimesp];
    

        
    self.addressLaber.text = [s1 stringByAppendingString:model.city_name];
     NSString * s3 = [s2 stringByAppendingString: model.create_time];
    
    self.timeLaber.text = [s3 substringToIndex:11];
    //
    NSInteger stateM = [model.reply_status integerValue];
    switch (stateM) {
        case 0:
            self.statuLaber.text = @"未回复";
            self.statuLaber.textColor = [UIColor whiteColor];
            self.statuLaber.backgroundColor = [UIColor colorWithRed:0 green:0.875 blue:0.570 alpha:1];
            break;
            case 1:
            self.statuLaber.text = @"已回复";
            self.statuLaber.textColor = [UIColor whiteColor];
            self.statuLaber.backgroundColor = [UIColor grayColor];
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
