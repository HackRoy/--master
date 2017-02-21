//
//  WHcompanyDetail.h
//  whm_project
//
//  Created by 王义国 on 16/10/23.
//  Copyright © 2016年 chenJw. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JwModelBase.h"
#import "WHhot_pro.h"
#import "WHagent.h"
#import "WHcount.h"
#import "WHcompanyCount.h"

@protocol WHcompanyDetail <NSObject>
@end

@interface WHcompanyDetail : JwModelBase
@property(nonatomic,strong)NSString <Optional>* id ;
@property(nonatomic,strong)NSString <Optional>* name;
@property(nonatomic,strong)NSString <Optional>* initial;
@property(nonatomic,strong)NSString <Optional>* pinyin;
@property(nonatomic,strong)NSString <Optional>* descriptionJw;
@property(nonatomic,strong)NSString <Optional>* logo;
@property(nonatomic,strong)NSString <Optional>* add;
@property(nonatomic,strong)NSString <Optional>* tel;
@property(nonatomic,strong)NSString <Optional>* ctype;
@property(nonatomic,strong)NSString <Optional>* type;
@property(nonatomic,strong)NSString <Optional>* area;
@property(nonatomic,strong)NSString <Optional>* website;
@property(nonatomic,strong)NSString <Optional>* is_quoted;
@property(nonatomic,strong)NSString <Optional>* is_beadhouse;
@property(nonatomic,strong)NSString <Optional>* specialtoes;
@property(nonatomic,strong)NSString <Optional>* short_name ;
@property(nonatomic,strong)NSString <Optional>* shortest;
@property(nonatomic,strong)NSString <Optional> * honor;
@property(nonatomic,strong)NSString <Optional> *history;
@property(nonatomic,strong)NSString * type_name;
@property(nonatomic,strong)NSArray <WHhot_pro ,Optional > *hot_pro;
@property(nonatomic,strong)NSArray <WHagent, Optional> * agent;
//@property(nonatomic,strong)WHcount <Optional> * count;

@property(nonatomic,strong)WHcompanyCount <Optional> * count;

@end
