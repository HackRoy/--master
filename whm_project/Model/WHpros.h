//
//  WHpros.h
//  whm_project
//
//  Created by 王义国 on 16/11/12.
//  Copyright © 2016年 chenJw. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JwModelBase.h"

@protocol WHpros <NSObject>

@end

@interface WHpros : JwModelBase
@property(nonatomic,strong)NSString <Optional> * id;
@property(nonatomic,strong)NSString <Optional> * policy_id;
@property(nonatomic,strong)NSString <Optional> * has_param;
@property(nonatomic,strong)NSString <Optional> * main_id;
@property(nonatomic,strong)NSString <Optional> * is_main_must;
@property(nonatomic,strong)NSString <Optional> * age;
@property(nonatomic,strong)NSString <Optional> * insured_amount;
@property(nonatomic,strong)NSString <Optional> * rate;
@property(nonatomic,strong)NSString <Optional> * pay_period;
@property(nonatomic,strong)NSString <Optional> * period;
@property(nonatomic,strong)NSString <Optional> * payout;
@property(nonatomic,strong)NSString <Optional> * buy_count;
@property(nonatomic,strong)NSString <Optional> * name;
@property(nonatomic,strong)NSString <Optional> * short_name;

@end
