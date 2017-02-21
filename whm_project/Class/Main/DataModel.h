//
//  DataModel.h
//  whm_project
//
//  Created by Stephy_xue on 16/12/24.
//  Copyright © 2016年 chenJw. All rights reserved.
//

#import <JSONModel/JSONModel.h>
#import "WHcompany.h"
#import "WBYOneDataModel.h"
#import "LocationModel.h"
#import "childModel.h"
#import "WBYAgentModel.h"
#import "WBYNewsModel.h"
#import "WBYtjrListModel.h"
@protocol DataModel
@end
@interface DataModel : JSONModel
//avatar sex
@property(nonatomic,copy)NSString * avatar;
@property(nonatomic,copy)NSString * sex;
@property(nonatomic,copy)NSString * birthday;
@property(nonatomic,copy)NSString * area_info;
@property(nonatomic,copy)NSString * address;
@property(nonatomic,copy)NSString * status_name;

@property(nonatomic,copy)NSString * id_number;
@property(nonatomic,copy)NSString * specialize_in;

@property(nonatomic,copy)NSString * profession;
@property(nonatomic,copy)NSString * status;

@property(nonatomic,copy)NSString * org_name;
@property(nonatomic,copy)NSString * org_id;
@property(nonatomic,copy)NSString * company_type;
@property(nonatomic,copy)NSString * company_type_name;
//@property(nonatomic,copy)NSString * company;
@property(nonatomic,copy)NSString * company_id;
//@property(nonatomic,copy)NSString * company_type;
//@property(nonatomic,copy)NSString * company_type_name;

@property(nonatomic,copy)NSString * job_address;
@property(nonatomic,copy)NSString * mongo_id;
@property(nonatomic,copy)NSString * ins_item_code;
@property(nonatomic,copy)NSString <Optional > * ins_type;
@property(nonatomic,copy)NSString * prod_type_code_name;
@property(nonatomic,copy)NSString * prod_desi_code_name;
@property(nonatomic,copy)NSString * special_attri_name;
@property(nonatomic,copy)NSString * insurance_period_name;
@property(nonatomic,copy)NSString * pay_period_name;
@property(nonatomic,copy)NSString * limit_age_name;
@property(nonatomic,strong)NSString<Optional> * id;
@property(nonatomic,strong)NSString<Optional> * name;
@property(nonatomic,strong)NSString<Optional> * short_name;
//其他信息
@property(nonatomic,strong)NSString <Optional> * clause;
@property(nonatomic,strong)NSString <Optional> * cases;
@property(nonatomic,strong)NSString <Optional> * rights;
@property(nonatomic,strong)NSString <Optional> * rule;
@property(nonatomic,strong)NSString <Optional> * pdf_path;
@property(nonatomic,strong)NSString <Optional> * company_logo;
@property(nonatomic,strong)NSString <Optional> * company_short_name;
@property(nonatomic,strong)NSString <Optional> * ins_type_name;
@property(nonatomic,strong)NSString <Optional> * sale_status_name;
@property(nonatomic,strong)NSString <Optional> * is_main;
@property(nonatomic,strong)WHcompany <Optional> * company;

@property(nonatomic,strong)WBYOneDataModel * data;
@property(nonatomic,copy)NSString  * dist;
@property(nonatomic,copy)NSString  * type;
@property(nonatomic,strong)LocationModel * location;

//@property(nonatomic,copy)NSString  * address;
@property(nonatomic,copy)NSString  * distance;
@property(nonatomic,copy)NSString  * latitude;
@property(nonatomic,copy)NSString  * longitude;
@property(nonatomic,copy)NSString  * tel;
@property(nonatomic,copy)NSString  * province_name;

//type_name
@property(nonatomic,copy)NSString  * out_trade_no;
@property(nonatomic,copy)NSString  * remark;
@property(nonatomic,copy)NSString  * title;
@property(nonatomic,copy)NSString  * total_fee;
@property(nonatomic,copy)NSString  * type_name;
@property(nonatomic,copy)NSString  * discount;
@property(nonatomic,copy)NSString  * minus;

@property(nonatomic,copy)NSString  * imit_age_name;
@property(nonatomic,copy)NSString  * prod_type_code;
@property(nonatomic,copy)NSString  * img;
@property(nonatomic,copy)NSString  * logo;
@property(nonatomic,copy)NSString  * pro_type_code_name;
@property(nonatomic,copy)NSString  * small_img;
@property(nonatomic,copy)NSString  * sign;
@property(nonatomic,copy)NSString  * p_id;
@property(nonatomic,copy)NSString  * area_id;
@property(nonatomic,copy)NSString  * area_name;
@property(nonatomic,strong)NSArray<childModel >* child;
@property(nonatomic,strong)NSArray<WBYAgentModel >* agent_info;
@property(nonatomic,strong)NSArray *  message;
@property(nonatomic,strong)NSArray *  pro;

//@property(nonatomic,strong)NSArray *  pro;
@property(nonatomic,copy)NSString  * money;
@property(nonatomic,copy)NSString  * coin;
@property(nonatomic,strong)NSArray<WBYtjrListModel >* invited;
//记录get_finance
@property(nonatomic,copy)NSString  * uid;
//@property(nonatomic,copy)NSString  * create_time;
//获取提现信息
@property(nonatomic,copy)NSString * finance_id;
@property(nonatomic,copy)NSString * card_num;
@property(nonatomic,copy)NSString * bank;

@end
