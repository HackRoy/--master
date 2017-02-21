//
//  WHKNetWorkUtils.h
//  whm_project
//
//  Created by 王义国 on 16/12/19.
//  Copyright © 2016年 chenJw. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef void(^netStateBlock)(NSInteger netState);
@interface WHKNetWorkUtils : NSObject

+(void)netWorkState:(netStateBlock)block;
@end
