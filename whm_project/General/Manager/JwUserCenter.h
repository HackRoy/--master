//
//  JwUserCenter.h
//  e-bank
//
//  Created by chenJw on 16/9/23.
//  Copyright © 2016年 chenJw. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JwModelBase.h"
#import "JwUser.h"


@interface JwUserCenter : JwModelBase<NSCoding>

@property (nonatomic, strong) JwUser *user;
@property (nonatomic, strong) NSString *uid;
@property (nonatomic, strong) NSString *key;
@property (nonatomic, assign) BOOL isLogined;

+ (instancetype)load;
+ (instancetype)sharedCenter;

- (void)save;

@end
