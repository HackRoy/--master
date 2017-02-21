//
//  WHgetprofirst.h
//  whm_project
//
//  Created by 王义国 on 16/11/3.
//  Copyright © 2016年 chenJw. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JwModelBase.h"
#import "JwRela.h"
#import "JwPeriod.h"

@protocol WHgetprofirst  <NSObject>
@end

@interface WHgetprofirst : JwModelBase

@property(nonatomic,strong)NSArray <JwPeriod ,Optional>* period;
@property(nonatomic,strong)NSArray <JwPeriod ,Optional>* pay_period;
@property(nonatomic,strong)NSArray <JwRela ,Optional>* rela;




@end
