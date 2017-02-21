//
//  childOneModel.h
//  whm_project
//
//  Created by apple on 17/1/16.
//  Copyright © 2017年 chenJw. All rights reserved.
//

#import <JSONModel/JSONModel.h>
#import "childTwoModel.h"

@protocol childOneModel<NSObject>

@end
@interface childOneModel : JSONModel
@property(nonatomic,copy)NSString  * area_id;
@property(nonatomic,copy)NSString  * area_name;
@property(nonatomic,copy)NSString  * parent_id;
@property(nonatomic,copy)NSString  * sort;

@property(nonatomic,strong)NSArray<childTwoModel> * child;


@end
