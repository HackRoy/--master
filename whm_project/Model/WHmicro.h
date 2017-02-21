//
//  WHmicro.h
//  whm_project
//
//  Created by 王义国 on 16/11/2.
//  Copyright © 2016年 chenJw. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JwModelBase.h"
#import "WHagentinfo.h"
#import "WHcount.h"
#import "WHmicpro.h"
#import "WHgethonor.h"
#import "WHgetmessage.h"
#import "WHnews.h"
@protocol WHmicro <NSObject>
@end

@interface WHmicro : JwModelBase
@property(nonatomic,strong) NSArray <WHagentinfo,Optional> * agent_info;
@property(nonatomic,strong) WHcount <Optional> * count;
@property(nonatomic,strong) NSArray <WHmicpro,Optional> * pro;
@property(nonatomic,strong) NSArray <WHgetmessage,Optional> * message;
@property(nonatomic,strong)NSArray <WHgethonor ,Optional > * honor;
@property(nonatomic,strong) NSArray <WHnews , Optional> * news;



@end
