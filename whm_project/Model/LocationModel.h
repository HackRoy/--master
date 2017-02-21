//
//  LocationModel.h
//  whm_project
//
//  Created by apple on 17/1/3.
//  Copyright © 2017年 chenJw. All rights reserved.
//

#import <JSONModel/JSONModel.h>
#import "Coordinates.h"

@protocol LocationModel <NSObject>
@end

@interface LocationModel : JSONModel


@property(nonatomic,copy)NSString <Optional> * type;

@property(nonatomic,strong)NSArray <Optional> * coordinates;


@end
