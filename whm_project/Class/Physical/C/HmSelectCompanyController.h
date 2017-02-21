//
//  HmSelectCompanyController.h
//  whm_project
//
//  Created by zhaoHm on 16/10/18.
//  Copyright © 2016年 chenJw. All rights reserved.
//

#import "JwBackBaseController.h"

@interface HmSelectCompanyController : JwBackBaseController

@property (nonatomic, strong) NSMutableArray *groupArr;
@property (nonatomic, assign) BOOL isSelects;

@property (nonatomic, strong) NSMutableDictionary *contentDict;
@property (nonatomic, strong) NSMutableDictionary *fuzhiDict;



@end
