//
//  JwAreass.h
//  whm_project
//
//  Created by chenJw on 16/10/26.
//  Copyright © 2016年 chenJw. All rights reserved.
//

#import "JwModelBase.h"

@protocol JwAreass <NSObject>
@end

@interface JwAreass : JwModelBase

@property (nonatomic, strong) NSString<Optional> *area_id;
@property (nonatomic, strong) NSString<Optional> *parent_id;
@property (nonatomic, strong) NSString<Optional> *area_name;
@property (nonatomic, strong) NSString<Optional> *sort;
@property (nonatomic, strong) NSArray<JwAreass, Optional> *child;

@end
