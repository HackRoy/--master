//
//  JwUser.h
//  whm_project
//
//  Created by chenJw on 16/10/17.
//  Copyright © 2016年 chenJw. All rights reserved.
//

#import "JwModelBase.h"

@interface JwUser : JwModelBase

@property (nonatomic, strong) NSString *uid;
@property (nonatomic, strong) NSString *info;

@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *avatar;
@property (nonatomic, strong) NSString *type;
@property (nonatomic, strong) NSString<Optional> *status;
@property (nonatomic, strong) NSString<Optional> *company;
@property (nonatomic, strong) NSString<Optional> *city;
@property (nonatomic, strong) NSString *key;

@end
