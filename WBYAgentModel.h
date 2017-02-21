//
//  WBYAgentModel.h
//  whm_project
//
//  Created by apple on 17/1/21.
//  Copyright © 2017年 chenJw. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@protocol WBYAgentModel <NSObject>


@end

@interface WBYAgentModel : JSONModel
@property(nonatomic,copy)NSString * age;
@property(nonatomic,copy)NSString * area_info;
@property(nonatomic,copy)NSString * avatar;
@property(nonatomic,copy)NSString * mobile;
@property(nonatomic,copy)NSString * sex;
@property(nonatomic,copy)NSString * status;





@end
