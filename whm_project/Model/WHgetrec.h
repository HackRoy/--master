//
//  WHgetrec.h
//  whm_project
//
//  Created by 王义国 on 16/10/30.
//  Copyright © 2016年 chenJw. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JwModelBase.h"
@interface WHgetrec : JwModelBase
@property(nonatomic,strong)NSString <Optional>* id;
@property(nonatomic,strong)NSString <Optional> * name;
@property(nonatomic,strong)NSString <Optional>* short_name;
@property(nonatomic,strong)NSString <Optional>* img;
@property(nonatomic,strong)NSString <Optional>*small_img;
@property(nonatomic,strong)NSString <Optional>*limit_age;
@property(nonatomic,strong)NSString <Optional>* prod_type_code;
@property(nonatomic,strong)NSString <Optional> *prod_type_code_name;
@property(nonatomic,strong)NSString <Optional>* logo;
@property(nonatomic,strong)NSString <Optional>* update_time;
@property(nonatomic,strong)NSString <Optional>* is_main;

@end
