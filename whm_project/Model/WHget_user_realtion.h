//
//  WHget_user_realtion.h
//  whm_project
//
//  Created by 王义国 on 16/10/25.
//  Copyright © 2016年 chenJw. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JwModelBase.h"
@interface WHget_user_realtion : JwModelBase
@property(nonatomic,strong)NSString<Optional> * id ;
@property(nonatomic,strong)NSString<Optional> * user;
@property(nonatomic,strong)NSString<Optional> * name;
@property(nonatomic,strong)NSString<Optional> * sex;
@property(nonatomic,strong)NSString<Optional> * birthday;
@property(nonatomic,strong)NSString<Optional> * yearly_income;
@property(nonatomic,strong)NSString<Optional> * debt;
@property(nonatomic,strong)NSString<Optional> * relation;
@property(nonatomic,strong)NSString<Optional> * relation_name;
@property(nonatomic,strong)NSString<Optional> * type;
@property(nonatomic,strong)NSString<Optional> * year_out;
@property(nonatomic,strong)NSString<Optional> * avatar;
@property(nonatomic,strong)NSString<Optional> * policy_count;

@end
