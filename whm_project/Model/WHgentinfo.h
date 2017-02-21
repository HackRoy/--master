//
//  WHgentinfo.h
//  whm_project
//
//  Created by 王义国 on 16/11/30.
//  Copyright © 2016年 chenJw. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JwModelBase.h"

@protocol WHgentinfo <NSObject>


@end
@interface WHgentinfo : JwModelBase
@property(nonatomic,strong)NSString <Optional> * id ;
@property(nonatomic,strong)NSString <Optional> * name;
@property(nonatomic,strong)NSString <Optional> * mobile;
@property(nonatomic,strong)NSString <Optional> * sex;
@property(nonatomic,strong)NSString <Optional> * avatar;
@property(nonatomic,strong)NSString <Optional> * age;
@property(nonatomic,strong)NSString <Optional> * introduce;
@property(nonatomic,strong)NSString <Optional> * exhibition_no;
@property(nonatomic,strong)NSString <Optional> * certificate_no;
@property(nonatomic,strong)NSString <Optional> * status;
@property(nonatomic,strong)NSString <Optional> * profession;
@property(nonatomic,strong)NSString <Optional> * work_time;
@property(nonatomic,strong)NSString <Optional> * service_area;
@property(nonatomic,strong)NSString <Optional> * area_info;
@property(nonatomic,strong)NSString <Optional> * cname;
@property(nonatomic,strong)NSString <Optional> * oname;
@property(nonatomic,strong)NSString <Optional> * job_address;
@property(nonatomic,strong)NSString <Optional> * is_follow;


@end
