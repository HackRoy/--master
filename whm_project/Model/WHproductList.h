//
//  WHproductList.h
//  whm_project
//
//  Created by 王义国 on 16/12/5.
//  Copyright © 2016年 chenJw. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JwModelBase.h"
@interface WHproductList : JwModelBase
@property(nonatomic,strong)NSString <Optional> *id;
@property(nonatomic,strong)NSString <Optional> * name;
@property(nonatomic,strong)NSString <Optional> * short_name;
@property(nonatomic,strong)NSString <Optional> * company_id;
@property(nonatomic,strong)NSString <Optional> * limit_age;
@property(nonatomic,strong)NSString <Optional> * limit_age_name;
@property(nonatomic,strong)NSString <Optional> * ins_type;
@property(nonatomic,strong)NSString <Optional> * is_main;
@property(nonatomic,strong)NSString <Optional> * img;
@property(nonatomic,strong)NSString <Optional> * small_img;
@property(nonatomic,strong)NSString <Optional> * logo;
@property(nonatomic,strong)NSString <Optional> * create_time;


@end
