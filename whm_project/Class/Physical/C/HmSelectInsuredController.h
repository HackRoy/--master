//
//  HmSelectInsuredController.h
//  whm_project
//
//  Created by zhaoHm on 16/10/18.
//  Copyright © 2016年 chenJw. All rights reserved.
//

#import "JwBackBaseController.h"
#import "WHget_user_realtion.h"

@interface HmSelectInsuredController : JwBackBaseController

-(void)returnInsured:(void(^)(WHget_user_realtion *user))block;

@end
