//
//  childModel.h
//  whm_project
//
//  Created by apple on 17/1/16.
//  Copyright © 2017年 chenJw. All rights reserved.
//

#import <JSONModel/JSONModel.h>
#import "childOneModel.h"
@protocol childModel<NSObject>
@end

@interface childModel : JSONModel
@property(nonatomic,copy)NSString  * area_id;
@property(nonatomic,copy)NSString  * area_name;

@property(nonatomic,strong)NSArray<childOneModel > *child;


@end
