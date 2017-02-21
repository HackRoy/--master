//
//  WHzhanghu.h
//  whm_project
//
//  Created by 王义国 on 17/2/9.
//  Copyright © 2017年 chenJw. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JwModelBase.h"
@protocol  WHzhanghu <NSObject>
@end
@interface WHzhanghu : JwModelBase
@property(nonatomic,copy)NSString  * id;
@property(nonatomic,copy)NSString  * name;
@property(nonatomic,copy)NSString  * sex;
@property(nonatomic,copy)NSString  * birthday;
@property(nonatomic,copy)NSString  * mobile;
@property(nonatomic,copy)NSString  * avatar;
@property(nonatomic,copy)NSString  * type;
@property(nonatomic,copy)NSString  * invited_count;

@end
