//
//  WHgetuseinfo.h
//  whm_project
//
//  Created by 王义国 on 16/10/23.
//  Copyright © 2016年 chenJw. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JwModelBase.h"
@interface WHgetuseinfo : JwModelBase
@property(nonatomic,strong)NSString<Optional> * id ;
@property(nonatomic,strong)NSString<Optional> * name;
@property(nonatomic,strong)NSString<Optional> * email;
@property(nonatomic,strong)NSString<Optional> * password;
@property(nonatomic,strong)NSString<Optional> * mobile ;
@property(nonatomic,strong)NSString<Optional> * contact_way;
@property(nonatomic,strong)NSString<Optional> * reg_ip;
@property(nonatomic,strong)NSString<Optional> * reg_time;
@property(nonatomic,strong)NSString<Optional> * last_login;
@property(nonatomic,strong)NSString<Optional> * last_ip;
@property(nonatomic,strong)NSString<Optional> * avatar;
@property(nonatomic,strong)NSString<Optional> * nickname;
@property(nonatomic,strong)NSString<Optional> * id_number;
@property(nonatomic,strong)NSString<Optional> * sex;
@property(nonatomic,strong)NSString<Optional> * birthday;
@property(nonatomic,strong)NSString<Optional> *star_signs;
@property(nonatomic,strong)NSString<Optional> * city;
@property(nonatomic,strong)NSString<Optional> * province ;
@property(nonatomic,strong)NSString<Optional> * country;
@property(nonatomic,strong)NSString<Optional> * area_info;
@property(nonatomic,strong)NSString<Optional> * address;
@property(nonatomic,strong)NSString<Optional> * openid;
@property(nonatomic,strong)NSString<Optional> * unionid;
@property(nonatomic,strong)NSString<Optional> * headimgurl;
@property(nonatomic,strong)NSString<Optional> * introduce;
@property(nonatomic,strong)NSString<Optional> * type;
@property(nonatomic,strong)NSString<Optional> * age;
@property(nonatomic,strong)NSString<Optional> * status;
@property(nonatomic,strong)NSString<Optional> * status_name;
@property(nonatomic,strong)NSString<Optional> * company;
@property (nonatomic, strong) NSString<Optional> *animal_signs;
@property (nonatomic, strong) NSString<Optional> *city_name;
@property (nonatomic, strong) NSString<Optional> *country_name;
@property (nonatomic, strong) NSString<Optional> *groupid;
@property (nonatomic, strong) NSString<Optional> *hire;
@property (nonatomic, strong) NSString<Optional> *is_follow;
@property (nonatomic, strong) NSString<Optional> *org_name;
@property (nonatomic, strong) NSString<Optional> *province_name;
@property (nonatomic, strong) NSString<Optional> *qq;
@property (nonatomic, strong) NSString<Optional> *specialize_in;
@property (nonatomic, strong) NSString<Optional> *uid;
@property (nonatomic, strong) NSString<Optional> *wechat;
@property (nonatomic, strong) NSString<Optional> *work_time;
//profession job_address org_name company_id org_id

@property (nonatomic, copy) NSString<Optional> *profession;
@property (nonatomic, copy) NSString<Optional> *job_address;
@property (nonatomic, copy) NSString<Optional> *company_type;
@property (nonatomic, copy) NSString<Optional> *company_type_name;
@property (nonatomic, copy) NSString<Optional> *company_id;

@property (nonatomic, copy) NSString<Optional> *org_id;




@end
