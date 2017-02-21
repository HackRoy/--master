//
//  WHrela.h
//  whm_project
//
//  Created by 王义国 on 16/11/12.
//  Copyright © 2016年 chenJw. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol  WHrela <NSObject>

@end

#import "JwModelBase.h"
@interface WHrela : JwModelBase
@property(nonatomic,strong)NSString <Optional> * id;
@property(nonatomic,strong)NSString <Optional> * user;
@property(nonatomic,strong)NSString <Optional> * name;
@property(nonatomic,strong)NSString <Optional> * sex;
@property(nonatomic,strong)NSString <Optional> * birthday;
@property(nonatomic,strong)NSString <Optional> * yearly_income;
@property(nonatomic,strong)NSString <Optional> * yearly_out;
@property(nonatomic,strong)NSString <Optional> * debt;
@property(nonatomic,strong)NSString <Optional> * coverage;
@property(nonatomic,strong)NSString <Optional> * insured_amount;
@property(nonatomic,strong)NSString <Optional> * rate;
@property(nonatomic,strong)NSString <Optional> * relation;
@property(nonatomic,strong)NSString <Optional> * type;
@property(nonatomic,strong)NSString <Optional> * avatar;
@property(nonatomic,strong)NSString <Optional> * relation_name;
@end
