//
//  JwServiceDefine.h
//  e-bank
//
//  Created by chenJw on 16/9/23.
//  Copyright © 2016年 chenJw. All rights reserved.
//

#ifndef JwServiceDefine_h
#define JwServiceDefine_h

typedef enum : NSUInteger {
    kErrorCodeSuccess = 0,
    kErrorCodeRequestParam = 1007,
    kErrorCodeBackerData = 1004,
    kErrorCodeTokenData = 1304,
    kErrorCodeLost = 1620
    
} ErrorCode;

#define kServiceBaseURL @"https://www.kuaibao365.com/api/"

#endif /* JwServiceDefine_h */
