//
//  WHget_pro_rate.h
//  whm_project
//
//  Created by 王义国 on 16/10/25.
//  Copyright © 2016年 chenJw. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JwModelBase.h"
#import "WHmongorate.h"

@protocol  WHget_pro_rate <NSObject>
@end

@interface WHget_pro_rate : JwModelBase
@property(nonatomic,strong)NSString <Optional> * id;
@property(nonatomic,strong)NSString <Optional> * name;
@property(nonatomic,strong)NSString <Optional> * is_main;
@property(nonatomic,strong)NSString <Optional> * insured;
@property(nonatomic,strong)NSString <Optional> * pid;
@property(nonatomic,strong)NSArray <WHmongorate ,Optional> * mongo_rate;



@end
