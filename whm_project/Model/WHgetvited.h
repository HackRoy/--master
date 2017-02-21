//
//  WHgetvited.h
//  whm_project
//
//  Created by 王义国 on 17/2/9.
//  Copyright © 2017年 chenJw. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JwModelBase.h"
#import "WHzhanghu.h"

@protocol WHgetvited <NSObject>

@end
@interface WHgetvited : JwModelBase
@property(nonatomic,strong)NSString <Optional> * money;
@property(nonatomic,strong)NSString <Optional> * coin;
@property(nonatomic,strong)NSArray < WHzhanghu ,Optional > * invited;


@end
