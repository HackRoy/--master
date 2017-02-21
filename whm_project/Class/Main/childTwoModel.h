//
//  childTwoModel.h
//  whm_project
//
//  Created by apple on 17/1/17.
//  Copyright © 2017年 chenJw. All rights reserved.
//

#import <JSONModel/JSONModel.h>
@protocol  childTwoModel<NSObject>
@end
@interface childTwoModel : JSONModel
@property(nonatomic,copy)NSString  * area_id;
@property(nonatomic,copy)NSString  * area_name;



@end
