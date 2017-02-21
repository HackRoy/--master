//
//  WHhot_pro.h
//  whm_project
//
//  Created by 王义国 on 16/11/17.
//  Copyright © 2016年 chenJw. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JwModelBase.h"

@protocol WHhot_pro <NSObject>

@end

@interface WHhot_pro : JwModelBase
@property(nonatomic,strong)NSString <Optional> * id;
@property(nonatomic,strong)NSString <Optional> * name;
@property(nonatomic,strong)NSString <Optional> * img;
@property(nonatomic,strong)NSString <Optional> * is_main;
@property(nonatomic,strong)NSString <Optional> * logo;
@property(nonatomic,strong)NSString <Optional> * limit_age;
@property(nonatomic,strong)NSString <Optional> * pro_type_code_name;


@end
