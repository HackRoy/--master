//
//  WHnearagentdata.h
//  whm_project
//
//  Created by 王义国 on 16/11/28.
//  Copyright © 2016年 chenJw. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JwModelBase.h"

@protocol WHnearagentdata <NSObject>

@end
@interface WHnearagentdata : JwModelBase
@property(nonatomic,strong)NSString <Optional> * name;
@property(nonatomic,strong)NSString <Optional> * mobile ;
@property(nonatomic,strong)NSString <Optional> * sex;
@property(nonatomic,strong)NSString <Optional> * age;
@property(nonatomic,strong)NSString <Optional> * birthday;
@property(nonatomic,strong)NSString <Optional> * status ;
@property(nonatomic,strong)NSString <Optional> * address;
@property(nonatomic,strong)NSString <Optional> * service_area;
@property(nonatomic,strong)NSString <Optional> * work_time;
@property(nonatomic,strong)NSString <Optional> * profession;
@property(nonatomic,strong)NSString <Optional> * specialize_in;
@property(nonatomic,strong)NSString <Optional> * service_scope;
@property(nonatomic,strong)NSString <Optional> * job_address;
@property(nonatomic,strong)NSString <Optional> * avatar;
@property(nonatomic,strong)NSString <Optional> * com_id;
@property(nonatomic,strong)NSString <Optional> * com_name;
@property(nonatomic,strong)NSString <Optional> * org_id;
@property(nonatomic,strong)NSString <Optional> * org_name;
@property(nonatomic,strong)NSString <Optional> * province_name;
@property(nonatomic,strong)NSString <Optional> * city_name;
@property(nonatomic,strong)NSString <Optional> * county_name;
@property(nonatomic,strong)NSString <Optional> * province;
@property(nonatomic,strong)NSString <Optional> * city;
@property(nonatomic,strong)NSString <Optional> * county;

@end
