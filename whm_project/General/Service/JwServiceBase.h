//
//  JwServiceBase.h
//  e-bank
//
//  Created by chenJw on 16/9/23.
//  Copyright © 2016年 chenJw. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JwHttpManager.h"

@interface JwServiceBase : NSObject<HttpManagerDelegate>

@property (nonatomic, strong) JwHttpManager *httpManager;

- (NSDictionary *)filterParam:(NSDictionary *)param interface:(NSString *)interface;

@end
