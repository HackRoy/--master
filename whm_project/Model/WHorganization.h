//
//  WHorganization.h
//  whm_project
//
//  Created by 王义国 on 16/10/22.
//  Copyright © 2016年 chenJw. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JwModelBase.h"

@interface WHorganization : JwModelBase
@property(nonatomic,strong)NSString <Optional>* id;
@property(nonatomic,strong)NSString <Optional>* name;
@property(nonatomic,strong)NSString <Optional>* tel;
@property(nonatomic,strong)NSString <Optional>* address;
@property(nonatomic,strong)NSString <Optional> *province_name;
@property(nonatomic,strong)NSString <Optional> *city_name;
@property(nonatomic,strong)NSString <Optional>* province;
@property(nonatomic,strong)NSString <Optional>* city;
@property(nonatomic,strong)NSString <Optional>* longitude;
@property(nonatomic,strong)NSString <Optional>* latitude;
@property(nonatomic,strong)NSString <Optional>* distance;


@end
