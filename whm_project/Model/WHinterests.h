//
//  WHinterests.h
//  whm_project
//
//  Created by 王义国 on 16/11/16.
//  Copyright © 2016年 chenJw. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JwModelBase.h"

@protocol WHinterests <NSObject>
@end

@interface WHinterests : JwModelBase
@property(nonatomic,strong)NSString <Optional> * iid;
@property(nonatomic,strong)NSString <Optional> * name;
@property(nonatomic,strong)NSString <Optional> * calculation;
@property(nonatomic,strong)NSString <Optional> * no_calculation;
@property(nonatomic,strong)NSString <Optional> * most;
@property(nonatomic,strong)NSString <Optional> * show;
@property(nonatomic,strong)NSString <Optional> * content;

@end
