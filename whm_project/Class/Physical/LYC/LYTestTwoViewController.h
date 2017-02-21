//
//  LYTestTwoViewController.h
//  MYPage
//
//  Created by 赵良育 on 2016/11/10.
//  Copyright © 2016年 赵良育. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "JwBackBaseController.h"
@interface LYTestTwoViewController :JwBackBaseController
@property(nonatomic,strong)NSString * rela_id;//被保人ID
@property(nonatomic,strong)NSString * pro_id; //险种ID
@property(nonatomic,strong)NSString * is_main_must;

@property(nonatomic,strong)NSString * rate; //保费
@property(nonatomic,strong)NSString * period; //保障期间
@property(nonatomic,strong)NSString * pay_period;//缴费期间
@property(nonatomic,strong)NSString * insured_amount;//保额
@property(nonatomic,strong)NSString * payout; //给付方式

@end
