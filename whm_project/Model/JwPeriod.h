//
//  JwPeriod.h
//  whm_project
//
//  Created by chenJw on 16/11/3.
//  Copyright © 2016年 chenJw. All rights reserved.
//

#import "JwModelBase.h"

@protocol JwPeriod <NSObject>

@end

@interface JwPeriod : JwModelBase

@property (nonatomic, strong) NSString<Optional> *id;
@property (nonatomic, strong) NSString<Optional> *name;
@property (nonatomic, strong) NSString<Optional> *value;

@end
