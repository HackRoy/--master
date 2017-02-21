//
//  WHget_relation_detail.h
//  whm_project
//
//  Created by 王义国 on 16/10/25.
//  Copyright © 2016年 chenJw. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JwModelBase.h"
@interface WHget_relation_detail : JwModelBase
@property(nonatomic,strong)NSString * id;
@property(nonatomic,strong)NSString * user;
@property(nonatomic,strong)NSString * name;
@property(nonatomic,strong)NSString * sex;
@property(nonatomic,strong)NSString * birthday;
@property(nonatomic,strong)NSString * yearly_income;
@property(nonatomic,strong)NSString * yearly_out;
@property(nonatomic,strong)NSString * debt;
@property(nonatomic,strong)NSString * coverage;
@property(nonatomic,strong)NSString * insured_amount;
@property(nonatomic,strong)NSString * rate;
@property(nonatomic,strong)NSString * relation;
@property(nonatomic,strong)NSString * type;
@property(nonatomic,strong)NSString * relation_name;
@end
