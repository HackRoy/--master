//
//  WBYReqModel.h
//  KuiBuText
//
//  Created by Stephy_xue on 16/3/4.
//  Copyright © 2016年 Baoya. All rights reserved.
//

#import <JSONModel/JSONModel.h>
#import "DataModel.h"

@interface WBYReqModel : JSONModel

@property(nonatomic,copy)NSString * err;

@property(nonatomic,copy)NSString * info;

@property(nonatomic,strong)NSArray<DataModel > *data;

@end
