//
//  WHmin.h
//  whm_project
//
//  Created by 王义国 on 16/11/30.
//  Copyright © 2016年 chenJw. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JwModelBase.h"
#import "WHcount.h"
#import "WHgethonor.h"
#import "WHgetmessage.h"
#import "WHnews.h"
#import "WHgentinfo.h"
#import "WHminpro.h"
@protocol WHmin <NSObject>


@end
@interface WHmin : JwModelBase
@property(nonatomic,strong) NSArray <WHgentinfo,Optional> * agent_info;
@property(nonatomic,strong) WHcount <Optional> * count;
@property(nonatomic,strong) NSArray <WHminpro,Optional> * pro;
@property(nonatomic,strong) NSArray <WHgetmessage,Optional> * message;
@property(nonatomic,strong)NSArray <WHgethonor ,Optional > * honor;
@property(nonatomic,strong) NSArray <WHnews , Optional> * news;


@end
