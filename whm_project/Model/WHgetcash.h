//
//  WHgetcash.h
//  whm_project
//
//  Created by 王义国 on 17/2/13.
//  Copyright © 2017年 chenJw. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JwModelBase.h"

@protocol WHgetcash <NSObject>

@end

@interface WHgetcash : JwModelBase

//获取提现信息
@property(nonatomic,copy)NSString <Optional >* finance_id;
@property(nonatomic,copy)NSString <Optional > * card_num;
@property(nonatomic,copy)NSString <Optional> * bank;
@property(nonatomic,copy)NSString <Optional> * uid;
@property(nonatomic,copy)NSString <Optional> * name;
@property(nonatomic,copy)NSString <Optional> * money;
@property(nonatomic,copy)NSString <Optional> * create_time;

@property(nonatomic,copy)NSString <Optional >* type;
@property(nonatomic,copy)NSString <Optional >* status;
@property(nonatomic,copy)NSString <Optional >* id;
@property(nonatomic,copy)NSString <Optional >* remark;






@end
