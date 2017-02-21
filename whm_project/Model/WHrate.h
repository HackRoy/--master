//
//  WHrate.h
//  whm_project
//
//  Created by 王义国 on 16/11/10.
//  Copyright © 2016年 chenJw. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JwModelBase.h"
#import "WHpay_period.h"
@protocol WHrate  <NSObject>
@end

@interface WHrate : JwModelBase
@property(nonatomic,strong)NSString <Optional> * period;
@property(nonatomic,strong)NSString <Optional> * age;
@property(nonatomic,strong)NSString <Optional> * gender;
@property(nonatomic,strong)WHpay_period <Optional> * pay_period;
@property (nonatomic, strong) NSString <Optional> *payout;

@end
