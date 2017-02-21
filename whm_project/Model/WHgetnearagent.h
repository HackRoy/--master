//
//  WHgetnearagent.h
//  whm_project
//
//  Created by 王义国 on 16/11/28.
//  Copyright © 2016年 chenJw. All rights reserved.
//

#import <Foundation/Foundation.h>
//#import "JwModelBase.h"
#import "WHnearagentdata.h"
#import "LocationModel.h"

//location
@protocol WHgetnearagent <NSObject>
@end
@interface WHgetnearagent : JwModelBase
@property(nonatomic,strong)NSString <Optional> * id;
@property(nonatomic,strong)NSString <Optional> * dist;
@property(nonatomic,strong)WHnearagentdata <Optional> * data;
@property(nonatomic,strong)LocationModel <Optional>* location;



@end
