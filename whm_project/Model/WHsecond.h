//
//  WHsecond.h
//  whm_project
//
//  Created by 王义国 on 16/11/16.
//  Copyright © 2016年 chenJw. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JwModelBase.h"
#import "WHinterests.h"

@protocol WHsecond <NSObject>


@end

@interface WHsecond : JwModelBase
@property(nonatomic,strong)NSString <Optional> * name;
@property(nonatomic,strong)NSString <Optional> * short_name;
@property(nonatomic,strong)NSString <Optional> * is_main;
@property(nonatomic,strong)NSString <Optional> * pid;
@property(nonatomic,strong)NSArray <WHinterests,Optional> * interests;

@end
