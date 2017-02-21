//
//  WHagent.h
//  whm_project
//
//  Created by 王义国 on 16/11/18.
//  Copyright © 2016年 chenJw. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "JwModelBase.h"

@protocol  WHagent<NSObject>
@end
@interface WHagent : JwModelBase
@property(nonatomic,strong)NSString <Optional> * id;
@property(nonatomic,strong)NSString <Optional> * name;
@property(nonatomic,strong)NSString <Optional> * mobile;
@property(nonatomic,strong)NSString <Optional> * sex;
@property(nonatomic,strong)NSString <Optional> * age;
@property(nonatomic,strong)NSString <Optional> * avatar;
@property(nonatomic,strong)NSString <Optional> * profession;
@property(nonatomic,strong)NSString <Optional> * work_time;
@property(nonatomic,strong)NSString <Optional> * service_area;
@property(nonatomic,strong)NSString <Optional> * service_scope;
@property(nonatomic,strong)NSString <Optional> * cname;
//


@end
