//
//  HmPhySicalMainView.m
//  whm_project
//
//  Created by zhaoHm on 16/11/23.
//  Copyright © 2016年 chenJw. All rights reserved.
//

#import "HmPhySicalMainView.h"
#import "MacroUtility.h"
#import <UIImageView+WebCache.h>

@implementation HmPhySicalMainView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
//         imgHead;
        self.imgHead = [[UIImageView alloc] init];
        [self addSubview:_imgHead];
//        
//         layerLine;
        self.layerLine = [CALayer layer];
        [self.layer addSublayer:_layerLine];
//        
//         imgName;
        self.imgName = [[UIImageView alloc] init];
        [self addSubview:_imgName];
//         lblName;
        self.lblName = [[UILabel alloc] init];
        [self addSubview:_lblName];
//        
//         imgSex;
        self.imgSex = [[UIImageView alloc] init];
        [self addSubview:_imgSex];
//        
//         imgRelationship;
        self.imgRelationship = [[UIImageView alloc] init];
        [self addSubview:_imgRelationship];
//         lblRelationship;
        self.lblRelationship = [[UILabel alloc] init];
        [self addSubview:_lblRelationship];
//        
//         imgDate;
        self.imgDate = [[UIImageView alloc] init];
        [self addSubview:_imgDate];
//         lblDate;
        self.lblDate = [[UILabel alloc] init];
        [self addSubview:_lblDate];
//        
//         imgYearCost;
        self.imgYearCost = [[UIImageView alloc] init];
        [self addSubview:_imgYearCost];
//         lblYearCost;
        self.lblYearCost = [[UILabel alloc] init];
        [self addSubview:_lblYearCost];
//        
//         imgPay;
        self.imgPay = [[UIImageView alloc] init];
        [self addSubview:_imgPay];
//         lblPay;
        self.lblPay = [[UILabel alloc] init];
        [self addSubview:_lblPay];
//        
//         imgOwn;
        self.imgOwn = [[UIImageView alloc] init];
        [self addSubview:_imgOwn];
//         lblOwn;
        self.lblOwn = [[UILabel alloc] init];
        [self addSubview:_lblOwn];
        
       // [self setupUI];
    }
    return self;
}

- (void)setupUI {
    //         imgHead;
    _imgHead.frame = CGRectMake(0, 0, 50, 50);
    _imgHead.center = CGPointMake(28, self.center.y);
    _imgHead.image = [UIImage imageNamed:@"test_head"];
    _imgHead.layer.cornerRadius = 25;
    _imgHead.layer.masksToBounds = YES;
    //
    //         layerLine;
    _layerLine.frame = CGRectMake(CGRectGetMaxX(_imgHead.frame) + 3, self.center.y - 1, kScreenWitdh - CGRectGetMaxX(_imgHead.frame) - 13, 2);
    _layerLine.backgroundColor = [UIColor colorWithRed:218 / 255.0 green:218 / 255.0 blue:218 / 255.0 alpha:1].CGColor;
    
 
    self.imgName.frame = CGRectMake(CGRectGetMaxX(self.imgHead.frame)+5, CGRectGetMinY(_layerLine.frame) - 23, 20, 20);
    self.imgName.image = [UIImage imageNamed:@"test_name"];
    self.lblName.frame = CGRectMake(CGRectGetMaxX(self.imgName.frame)+3, CGRectGetMinY(self.imgName.frame), kScreenWitdh*0.15, 20);
    self.lblName.font = [UIFont systemFontOfSize:11.0];
    self.imgSex.frame = CGRectMake(CGRectGetMaxX(self.lblName.frame), CGRectGetMinY(self.lblName.frame), 20, 20);
    _imgSex.image = [UIImage imageNamed:@"test_famale"];
    
    self.imgRelationship.frame = CGRectMake(CGRectGetMaxX(self.imgSex.frame)+3, CGRectGetMinY(self.lblName.frame), 20, 20);
    self.imgRelationship.image = [UIImage imageNamed:@"test_spouse"];
    
    self.lblRelationship.frame = CGRectMake(CGRectGetMaxX(self.imgRelationship.frame)+3, CGRectGetMinY(self.lblName.frame), kScreenWitdh * 0.15, CGRectGetHeight(self.imgRelationship.frame));
    _lblRelationship.font = [UIFont systemFontOfSize:11];
    
    self.imgDate.frame = CGRectMake(CGRectGetMaxX(self.lblRelationship.frame), CGRectGetMinY(self.lblName.frame), 20, 20);
    self.imgDate.image = [UIImage imageNamed:@"test_date"];
    
    self.lblDate.frame = CGRectMake(CGRectGetMaxX(self.imgDate.frame)+5, CGRectGetMinY(self.lblName.frame), kScreenWitdh * 0.3, CGRectGetHeight(self.lblName.frame));
    self.lblDate.font = [UIFont systemFontOfSize:11.0];
    
    self.imgYearCost.frame = CGRectMake(CGRectGetMinX(self.imgName.frame), CGRectGetMaxY(_layerLine.frame) + 3, 20, 20);
    self.imgYearCost.image = [UIImage imageNamed:@"test_year"];
    self.lblYearCost.frame = CGRectMake(CGRectGetMinX(self.lblName.frame), CGRectGetMinY(self.imgYearCost.frame), kScreenWitdh* 0.15, CGRectGetHeight(self.imgYearCost.frame));
    self.lblYearCost.font = [UIFont systemFontOfSize:10.0];
    
    self.imgPay.frame = CGRectMake(CGRectGetMinX(self.imgRelationship.frame), CGRectGetMinY(self.imgYearCost.frame), 20, 20);
    self.imgPay.image = [UIImage imageNamed:@"test_money"];
    self.lblPay.frame = CGRectMake(CGRectGetMinX(self.lblRelationship.frame), CGRectGetMinY(self.lblYearCost.frame), CGRectGetWidth(self.lblRelationship.frame), CGRectGetHeight(self.lblRelationship.frame));
    self.lblPay.font = [UIFont systemFontOfSize:10.0];
    
    //self.lblPay.backgroundColor = [UIColor redColor];
    self.imgOwn.frame = CGRectMake(CGRectGetMinX(self.imgDate.frame), CGRectGetMinY(self.imgPay.frame), 20, 20);
    self.imgOwn.image = [UIImage imageNamed:@"policyNum"];
    self.lblOwn.frame = CGRectMake(CGRectGetMinX(self.lblDate.frame), CGRectGetMinY(self.lblPay.frame), CGRectGetWidth(self.lblDate.frame), CGRectGetHeight(self.lblDate.frame));
    _lblOwn.text = @"哈哈";
    _lblPay.text = @"哈哈";
    _lblOwn.font = [UIFont systemFontOfSize:10];
    
    
    
    //         imgName;
    //         lblName;
    //
    //         imgSex;
    //
    //         imgRelationship;
    //         lblRelationship;
    //
    //         imgDate;
    //         lblDate;
    //
    //         imgYearCost;
    //         lblYearCost;
    //
    //         imgPay;
    //         lblPay;
    //
    //         imgOwn;
    //         lblOwn;
}

- (void)setModel:(WHget_user_realtion *)model {
   
    
    
       _model = model;
    
    self.lblName.text = model.name;
       
       if ([model.sex isEqualToString:@"1"])
       {
        // 男
        self.imgSex.image = [UIImage imageNamed:@"test_male"];
    }
    else
    {
        // 女
        self.imgSex.image = [UIImage imageNamed:@"test_famale"];
    }
    
    //时间戳处理
    
    NSDate *confromTimesp = [NSDate dateWithTimeIntervalSince1970:model.birthday.doubleValue];
    
    
    NSString * s1 = [NSString stringWithFormat:@"%@",confromTimesp];
    
    
    self.lblDate.text = [s1 substringToIndex:11];
    self.lblYearCost.text = model.yearly_income;
    self.lblOwn.text = model.policy_count;
    self.imgHead.layer.cornerRadius = 25;
    self.imgHead.layer.masksToBounds = YES;
    self.lblPay.text = model.debt;
    if (model.avatar.length <1) {
        self.imgHead.image = [UIImage imageNamed:@"Jw_user"];
    }else
    {
    [self.imgHead sd_setImageWithURL:[NSURL URLWithString:model.avatar]];
    }
    
        // 关系
    NSInteger stateM = [model.relation integerValue];
    switch (stateM) {
        case 0:
            self.lblRelationship.text = @"本人";
            break;
        case 1:
            self.lblRelationship.text = @"丈夫";
            break;
        case 2:
            self.lblRelationship.text = @"妻子";
            break;
        case 3:
            self.lblRelationship.text = @"父亲";
            break;
        case 4:
            self.lblRelationship.text = @"母亲";
            break;
        case 5:
            self.lblRelationship.text = @"儿子";
            break;
        case 6:
            self.lblRelationship.text = @"女儿";
            break;
        case 7:
            self.lblRelationship.text = @"祖父";
            break;
        case 8:
            self.lblRelationship.text = @"祖母";
            break;
        case 9:
            self.lblRelationship.text = @"外祖父";
            break;
        case 10:
            self.lblRelationship.text = @"外祖母";
            break;
        case 11:
            self.lblRelationship.text = @"其他";
            break;
        default:
            break;
    }
        
    
}

@end
