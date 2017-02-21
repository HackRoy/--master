//
//  WBYOneDataModel.h
//  whm_project
//
//  Created by apple on 17/1/7.
//  Copyright © 2017年 chenJw. All rights reserved.
//

#import <JSONModel/JSONModel.h>


@protocol WBYOneDataModel <NSObject>

@end
@interface WBYOneDataModel : JSONModel
//job_address avatar age profession    work_time service_area

@property(nonatomic,copy)NSString * mobile;
@property(nonatomic,copy)NSString * name;
@property(nonatomic,copy)NSString * job_address;
@property(nonatomic,copy)NSString * avatar;
@property(nonatomic,copy)NSString * sex;
@property(nonatomic,copy)NSString * com_name;

@property(nonatomic,copy)NSString * age;
@property(nonatomic,copy)NSString * profession;

@property(nonatomic,copy)NSString * work_time;
@property(nonatomic,copy)NSString * service_area;
@end
