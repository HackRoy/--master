//
//  JwPhysicalController.h
//  whm_project
//
//  Created by chenJw on 16/10/18.
//  Copyright © 2016年 chenJw. All rights reserved.
//

#import "JwMenuBaseController.h"
#import "WHgetproduct.h"


@interface JwPhysicalController : JwMenuBaseController
@property(nonatomic,strong)NSString * ids;
@property(nonatomic,strong)NSString * name;
@property(nonatomic,strong)NSString * is_main;
@property (nonatomic, strong) WHgetproduct *modelType;
// 组arr
@property (nonatomic, strong) NSMutableArray *groupMutableArr;
// content dict
@property (nonatomic, strong) NSMutableDictionary *contentMutableDict;
@property (nonatomic, strong) NSMutableDictionary *fuzhiDict;

// 判断是否选人
@property (nonatomic, assign) BOOL isSelectPersonName;

@property(nonatomic,strong)NSString * selectProID;


@end
