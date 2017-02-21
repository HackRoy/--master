//
//  WHyearapp.h
//  whm_project
//
//  Created by 王义国 on 16/11/21.
//  Copyright © 2016年 chenJw. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JwModelBase.h"

@protocol WHyearapp <NSObject>


@end


@interface WHyearapp : JwModelBase
@property(nonatomic,strong)NSString <Optional> * value;
@property(nonatomic,strong)NSString <Optional> * name;


@end
