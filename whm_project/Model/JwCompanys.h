//
//  JwCompanys.h
//  whm_project
//
//  Created by chenJw on 16/10/21.
//  Copyright © 2016年 chenJw. All rights reserved.
//

#import "JwModelBase.h"

@interface JwCompanys : JwModelBase

@property (nonatomic, strong) NSString<Optional> *id;
@property (nonatomic, strong) NSString<Optional> *name;
@property (nonatomic, strong) NSString<Optional> *short_name;
@property (nonatomic, strong) NSString<Optional> *logo;

@end
